/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package application.controllers;

import application.models.PimpinanModel;
import recite18th.controller.Controller;

/**
 *
 * @author Eko SW
 */
public class Pimpinan extends Controller{
    public Pimpinan(){
        modelForm = new PimpinanModel();
        controllerName = "Pimpinan";
        viewPage = "pimpinan/daftar_pimpinan.jsp";
        formPage = "pimpinan/form_pimpinan.jsp";
        sqlViewDataPerPage = "select * from Pimpinan order by username";
    
        //validation
        validationAddRule("username", "required");
        validationAddRule("password", "required");
    }
}
