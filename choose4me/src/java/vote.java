package com.example.web;

import com.example.model.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;


public class vote extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    
        String c = request.getParameter("voteid");
        request.setAttribute("voteid", c);
        
        RequestDispatcher view = request.getRequestDispatcher("vote.jsp");
        view.forward(request, response); 
    
    }
    
}