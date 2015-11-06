package facebook;

import facebook4j.Facebook;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import facebook4j.conf.ConfigurationBuilder;

public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 5357658337449255998L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        ConfigurationBuilder cb = new ConfigurationBuilder();
        cb.setDebugEnabled(true)
        .setOAuthAppId("1525347151068036")
        .setOAuthAppSecret("7527d74ad80508018822917751138f95")
        .setOAuthAccessToken("1525347151068036|bhMElCdYNInOHIijD_8PuG2rT0Y")
        .setOAuthPermissions("email,publish_stream");
        Facebook facebook = (Facebook) request.getSession().getAttribute("facebook");
        String accessToken = "";
        try {
        	accessToken = facebook.getOAuthAccessToken().getToken();
        } catch (Exception e) {
            throw new ServletException(e);
        }
        request.getSession().invalidate();

        // Log Out of the Facebook
        StringBuffer next = request.getRequestURL();
        int index = next.lastIndexOf("/");
        next.replace(index+1, next.length(), "");
        response.sendRedirect("http://www.facebook.com/logout.php?next=" + next.toString() + "&access_token=" + accessToken);
    }
}