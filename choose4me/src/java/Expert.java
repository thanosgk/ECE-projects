package com.example.model;

import java.util.*;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import java.net.URLEncoder;
import java.net.URLDecoder;

public class Expert {
    
    String title;
    String title2;
    String url,url2,url3,url4;
    Elements links,links2,links3,links4,links5,links6;
    Integer counter;
   public List getTypes(String type,String search) {

    List types = new ArrayList();
    String google2= "https://www.themoviedb.org/search?query=";
    String google3= "http://www.strandbooks.com/index.cfm?fuseaction=search.results&includeOutOfStock=0&searchString=";
    String google4= "http://www.emusic.com/search/album/?s=";
    String charset = "UTF-8";
    String userAgent = "AppEngine-Google; (+http://code.google.com/appengine; appid: unblock4myspace)";

    try{

        if (type.equals("movie")) {
        links = Jsoup.connect(google2+ URLEncoder.encode(search, "UTF-8")).userAgent(userAgent).timeout(30000).get().select("div.info>h3");
        links2 = Jsoup.connect(google2+ URLEncoder.encode(search, "UTF-8")).userAgent(userAgent).timeout(30000).get().select("*>ul>li>div>a>img");
        }
        
        if (type.equals("book")) {
        links3 = Jsoup.connect(google3+ URLEncoder.encode(search, "UTF-8")).userAgent(userAgent).get().select("*>div>div>a>img");
        links4 = Jsoup.connect(google3+ URLEncoder.encode(search, "UTF-8")).userAgent(userAgent).get().select("*>div>div>h3>a");
        }
        
        if (type.equals("music")) {
        links5 = Jsoup.connect(google4+ URLEncoder.encode(search, "UTF-8")).userAgent(userAgent).timeout(30000).get().select("*>ul.grid>li>div>div>h4>a");
        links6 = Jsoup.connect(google4+ URLEncoder.encode(search, "UTF-8")).userAgent(userAgent).timeout(30000).get().select("*>ul.grid>li>div>a>img");
        
        }
        
        counter=0;
        if (type.equals("movie")) {
            int size = links.size();
            
            for (Element link : links) {
                counter=counter+1;
                title = link.text();
                types.add(title);
                if ((counter == 3) || (counter >size)) {
                    break;
                }
                }
            if (size==2){
            title="";
            types.add(title);
            }
            if (size==1){
            title="";
            types.add(title);
            title="";
            types.add(title);
            }
           
            counter=0;
            for (Element link2 : links2) {
                
                url2 = link2.absUrl("src");
                if (!url2.startsWith("http")) {
                    continue; // Ads/news/etc.
                }
                counter=counter+1;
                types.add(url2);
                if ((counter == 3)|| (counter >=size)) {
                    break;
                }
                }
        }
               
        if (type.equals("music")) {
           
            for (Element link5 : links5) {
                counter=counter+1;
                title = link5.text();           
                types.add(title);
                if (counter == 3) {
                    counter=0;
                    break;
                }
                
            }
            for (Element link6 : links6) {
                counter=counter+1;
                url2 = link6.absUrl("src");           
                types.add(url2);
                if (counter == 3) {
                    counter=0;
                    break;
                }
            }
       
        }
        
        if (type.equals("book")) {
            for (Element link4 : links4) {
                title = link4.text();
                types.add(title);    
            }
            for (Element link3 : links3) {
            
                url3 = link3.absUrl("src");
                types.add(url3);   
            }
        }
        
    } catch(Exception e){
        return null; 
    }   
     
     return(types);
   }
}
