package com.example.web;

import com.example.model.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;


public class item extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    
        String c = request.getParameter("selectionid");
        List list = (List)getServletContext().getAttribute("SAVED_DATA");
        request.setAttribute("selectionid", c);
        request.setAttribute("list", list);
        
        RequestDispatcher view = request.getRequestDispatcher("item.jsp");
        view.forward(request, response); 
    
    }
    
}
