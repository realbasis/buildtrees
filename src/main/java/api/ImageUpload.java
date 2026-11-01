package api;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Locale;

/**
 * Reads an uploaded photo using the standard Servlet multipart API.
 *
 * Replaces the javazoom UploadBean / MultipartFormDataRequest library used by
 * control/doImg.jsp and control/doImg2.jsp. The JSPs that call this must be
 * declared with a {@code <multipart-config>} in web.xml.
 */
public final class ImageUpload {

    /** Same limit as the original code. */
    public static final long MAX_BYTES = 250_000;

    private String errors;
    private String fileName;
    private byte[] data;

    private ImageUpload() {
    }

    public static ImageUpload read(HttpServletRequest request, String field) {
        ImageUpload up = new ImageUpload();
        String ct = request.getContentType();
        if (ct == null || !ct.toLowerCase(Locale.ROOT).startsWith("multipart/form-data")) {
            up.errors = "Invalid image format! File upload failed.";
            return up;
        }
        try {
            Part part = request.getPart(field);
            if (part == null) {
                up.errors = "Please select file";
                return up;
            }
            String name = part.getSubmittedFileName();
            long size = part.getSize();
            if (name == null || name.isBlank() || size <= 0) {
                up.errors = "File is not found!";
            } else if (size > MAX_BYTES) {
                up.errors = "File is too large!";
            } else {
                // strip any path a browser may send (old IE)
                name = name.substring(Math.max(name.lastIndexOf('/'), name.lastIndexOf('\\')) + 1);
                String lower = name.toLowerCase(Locale.ROOT);
                if (!(lower.endsWith(".png") || lower.endsWith(".gif")
                        || lower.endsWith(".jpg") || lower.endsWith(".jpeg"))) {
                    up.errors = "Invalid image format! File upload failed.";
                } else {
                    try (InputStream in = part.getInputStream()) {
                        up.data = in.readAllBytes();
                    }
                    up.fileName = name;
                }
            }
        } catch (IllegalStateException e) {
            // thrown when the request exceeds <multipart-config> limits
            up.errors = "File is too large!";
        } catch (IOException | ServletException e) {
            up.errors = "Invalid image format! File upload failed.";
        }
        return up;
    }

    public boolean isOk() {
        return errors == null;
    }

    public String getErrors() {
        return errors;
    }

    public String getFileName() {
        return fileName;
    }

    public int getLength() {
        return data == null ? 0 : data.length;
    }

    /** A fresh in-memory stream, safe to keep in the session after the request ends. */
    public InputStream getInputStream() {
        return data == null ? null : new ByteArrayInputStream(data);
    }
}
