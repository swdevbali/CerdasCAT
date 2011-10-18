/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package application.controllers;

import application.models.AdminModel;
import recite18th.controller.Controller;

/**
 *
 * @author Eko SW
 */
public class Admin extends Controller{
    public Admin(){
        modelForm = new AdminModel();
        controllerName = "admin";
        viewPage = "admin/daftar_admin.jsp";
        formPage = "admin/form_admin.jsp";
        sqlViewDataPerPage = "select * from admin order by username";
    
        //validation
        validationAddRule("username", "required");
        validationAddRule("password", "required");
    }
}
