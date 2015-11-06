package com.example.web;

import com.example.model.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;


public class poll extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    
        String c = request.getParameter("userid");
        String d = request.getParameter("delete");
        if (d.equals("1")){
           request.setAttribute("delete", d);
           RequestDispatcher view = request.getRequestDispatcher("poll.jsp");
            view.forward(request, response);
            
            
        }
        else{
            
        request.setAttribute("userid", c);
        request.setAttribute("delete", d);
        RequestDispatcher view = request.getRequestDispatcher("poll.jsp");
        view.forward(request, response); 
        }
    }
    
}
