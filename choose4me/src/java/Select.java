package com.example.web;

import com.example.model.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

public class Select extends HttpServlet {

  public void doPost( HttpServletRequest request, 
                      HttpServletResponse response) 
                      throws IOException, ServletException {

    String c = request.getParameter("type");
    String d = request.getParameter("q");

     
    Expert ce = new Expert();

    List result = ce.getTypes(c,d);
    
    getServletContext().setAttribute("SAVED_DATA", result);
    request.setAttribute("styles", result);
    
    RequestDispatcher view = request.getRequestDispatcher("result.jsp");
    view.forward(request, response); 
  }
}
