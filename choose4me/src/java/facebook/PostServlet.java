package facebook;

import java.io.IOException;
import java.net.URL;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import facebook4j.Facebook;
import facebook4j.FacebookException;
import facebook4j.conf.ConfigurationBuilder;
import facebook4j.PostUpdate;

public class PostServlet extends HttpServlet {
    private static final long serialVersionUID = 4179545353414298791L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        ConfigurationBuilder cb = new ConfigurationBuilder();
        cb.setDebugEnabled(true)
        .setOAuthAppId("1525347151068036")
        .setOAuthAppSecret("7527d74ad80508018822917751138f95")
        .setOAuthAccessToken("1525347151068036|bhMElCdYNInOHIijD_8PuG2rT0Y")
        .setOAuthPermissions("email,publish_stream,publish_actions");
        String message = request.getParameter("message");
        
        Facebook facebook = (Facebook) request.getSession().getAttribute("facebook");
        try {
            PostUpdate post = new PostUpdate(new URL(message))
                    .picture(new URL("http://cdn.sstatic.net/askubuntu/img/apple-touch-icon.png"))
                    .name("Choose 4 me")
                    .caption("choose4me")
                    .description("Help me choose the best");
            facebook.postFeed(post);
        } catch (FacebookException e) {
            throw new ServletException(e);
        }
        response.sendRedirect(request.getContextPath()+ "/");
    }
    
}