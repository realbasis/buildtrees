package servlet;

import appconfig.Db;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Streams a person's photo from {@code Zpeople.Image}.
 *
 * Mapped to {@code /control/doGetImg.jsp} (see web.xml) so the many existing
 * {@code <img src="control/doGetImg.jsp?id=...">} references keep working.
 * Replaces the old JSP that used the unmaintained "sqlx" taglib (taglib48).
 * When a person has no photo, {@code images/nophoto.png} is returned.
 */
public class PeopleImageServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger LOG = Logger.getLogger(PeopleImageServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException | NullPointerException e) {
            sendPlaceholder(request, response);
            return;
        }

        try (Connection conn = Db.getConnection();
             PreparedStatement ps = conn.prepareStatement("select Image from Zpeople where PeopleID=?")) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                byte[] data = rs.next() ? rs.getBytes(1) : null;
                if (data == null || data.length == 0) {
                    sendPlaceholder(request, response);
                    return;
                }
                response.setContentType(sniffContentType(data));
                response.setContentLength(data.length);
                response.setHeader("Cache-Control", "private, max-age=300");
                response.getOutputStream().write(data);
            }
        } catch (SQLException e) {
            LOG.log(Level.WARNING, "Could not load image for PeopleID=" + id, e);
            sendPlaceholder(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    private void sendPlaceholder(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("image/png");
        try (InputStream in = getServletContext().getResourceAsStream("/images/nophoto.png")) {
            if (in == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
            OutputStream out = response.getOutputStream();
            in.transferTo(out);
        }
    }

    static String sniffContentType(byte[] d) {
        if (d.length > 3 && (d[0] & 0xff) == 0x89 && d[1] == 'P' && d[2] == 'N' && d[3] == 'G') {
            return "image/png";
        }
        if (d.length > 2 && d[0] == 'G' && d[1] == 'I' && d[2] == 'F') {
            return "image/gif";
        }
        return "image/jpeg";
    }
}
