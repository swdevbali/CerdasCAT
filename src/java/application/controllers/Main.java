/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package application.controllers;


import application.config.Config;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import recite18th.controller.Controller;
import recite18th.util.ServletUtil;

/**
 *
 * @author rukli
 */
public class Main extends Controller{
    public Main(){
        this.controllerName="biro";
        this.viewPage="index.jsp";
    }
    
    @Override
    public void index() 
    {

            Object user_credential = request.getSession().getAttribute("user_credential");
            if (user_credential == null) {
                ServletUtil.dispatch("/WEB-INF/views/"+viewPage, request, response);
            } else {
                ServletUtil.redirect(Config.base_url + "index/home", request, response);
            }

        
    }
}
