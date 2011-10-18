/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package application.config;

/**
 * This class is the main configuration of your application
 * @author Eko SW
 */
public class Config {
    public static final String firstController = "main";//first controller open by framework
    public static final String homeController = "home";//if user login, this will be called..
    public static final String loginController = "login"; // if login is in main page, use this loginController = firstController;
    public static final String mainPage = "index.jsp";
    public static final String page404 =  "page404.jsp";
    public static final String base_url = "http://localhost:8084/CerdasCAT/";
    public static final String base_path = "D:\\work\\konsultan_ta\\rukli\\work\\CerdasCAT\\build\\web\\";
    public static final String application_title = "Aplikasi Cerdas CAT";
    public static final String production_year = "2011";
    public static final String author = "Rukli";
    public static final String application_context = "/CerdasCAT";
    

}
