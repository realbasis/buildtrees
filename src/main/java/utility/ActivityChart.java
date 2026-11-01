package utility;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;

/**
 * Cumulative "records created per day" time series, rendered as inline SVG.
 *
 * Replaces the Cewolf/JFreeChart DatasetProducer used by admin.jsp
 * (Cewolf only runs on javax.servlet and is unmaintained).
 */
public abstract class ActivityChart implements Serializable {

    private static final long serialVersionUID = 1L;

    private final String title;
    private final String dateColumn;
    private final TreeMap<String, Integer> series = new TreeMap<>();
    private String errors;

    protected ActivityChart(String title, String dateColumn) {
        this.title = title;
        this.dateColumn = dateColumn;
    }

    /** Same contract as the former Cewolf producer: one row per record, ordered by creation date. */
    public boolean createDataset(SortedMap[] rows) {
        series.clear();
        if (rows == null) {
            return true;
        }
        SimpleDateFormat day = new SimpleDateFormat("yyyy-MM-dd");
        int count = 0;
        for (SortedMap row : rows) {
            Object ts = row.get(dateColumn);
            count++;
            if (ts instanceof Date) {
                series.put(day.format((Date) ts), count);
            }
        }
        return true;
    }

    public String getTitle() {
        return title;
    }

    public Map<String, Integer> getSeries() {
        return series;
    }

    public String getErrors() {
        return errors;
    }

    /** Simple responsive SVG line chart (600x400 like the old Cewolf image). */
    public String getSvg() {
        final int w = 600, h = 400, left = 50, right = 20, top = 30, bottom = 50;
        StringBuilder sb = new StringBuilder();
        sb.append("<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 ").append(w).append(' ').append(h)
          .append("\" width=\"").append(w).append("\" height=\"").append(h)
          .append("\" role=\"img\" style=\"font-family:Arial,Helvetica,sans-serif;font-size:11px;background:#fff\">");
        sb.append("<text x=\"").append(w / 2).append("\" y=\"18\" text-anchor=\"middle\" font-size=\"14\" font-weight=\"bold\">")
          .append(escape(title)).append("</text>");
        if (series.isEmpty()) {
            sb.append("<text x=\"").append(w / 2).append("\" y=\"").append(h / 2)
              .append("\" text-anchor=\"middle\" fill=\"#888\">No data</text></svg>");
            return sb.toString();
        }
        List<String> days = new ArrayList<>(series.keySet());
        int max = 1;
        for (int v : series.values()) {
            max = Math.max(max, v);
        }
        double plotW = w - left - right, plotH = h - top - bottom;
        // axes
        sb.append("<line x1=\"").append(left).append("\" y1=\"").append(h - bottom).append("\" x2=\"").append(w - right)
          .append("\" y2=\"").append(h - bottom).append("\" stroke=\"#666\"/>");
        sb.append("<line x1=\"").append(left).append("\" y1=\"").append(top).append("\" x2=\"").append(left)
          .append("\" y2=\"").append(h - bottom).append("\" stroke=\"#666\"/>");
        // y ticks
        for (int i = 0; i <= 4; i++) {
            int v = (int) Math.round(max * i / 4.0);
            double y = h - bottom - plotH * i / 4.0;
            sb.append("<line x1=\"").append(left).append("\" x2=\"").append(w - right).append("\" y1=\"").append(fmt(y))
              .append("\" y2=\"").append(fmt(y)).append("\" stroke=\"#eee\"/>");
            sb.append("<text x=\"").append(left - 6).append("\" y=\"").append(fmt(y + 4))
              .append("\" text-anchor=\"end\">").append(v).append("</text>");
        }
        // x labels: first, middle, last
        int n = days.size();
        int[] idx = n == 1 ? new int[]{0} : new int[]{0, (n - 1) / 2, n - 1};
        for (int i : idx) {
            double x = n == 1 ? left + plotW / 2 : left + plotW * i / (n - 1);
            sb.append("<text x=\"").append(fmt(x)).append("\" y=\"").append(h - bottom + 18)
              .append("\" text-anchor=\"middle\">").append(days.get(i)).append("</text>");
        }
        sb.append("<text x=\"14\" y=\"").append(top + (int) plotH / 2)
          .append("\" transform=\"rotate(-90 14 ").append(top + (int) plotH / 2).append(")\" text-anchor=\"middle\">count</text>");
        // line
        sb.append("<polyline fill=\"none\" stroke=\"#4472b0\" stroke-width=\"2\" points=\"");
        for (int i = 0; i < n; i++) {
            double x = n == 1 ? left + plotW / 2 : left + plotW * i / (n - 1);
            double y = h - bottom - plotH * series.get(days.get(i)) / max;
            sb.append(fmt(x)).append(',').append(fmt(y)).append(' ');
        }
        sb.append("\"/>");
        sb.append("<text x=\"").append(w - right).append("\" y=\"").append(h - 12)
          .append("\" text-anchor=\"end\" fill=\"#4472b0\">").append(escape(title)).append(": ").append(max).append("</text>");
        sb.append("</svg>");
        return sb.toString();
    }

    private static String fmt(double d) {
        return String.valueOf(Math.round(d * 10) / 10.0);
    }

    private static String escape(String s) {
        return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;");
    }
}
