/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package application.controllers;

import application.models.PesertaTestModel;
import application.models.WaliPesertaTestModel;
import recite18th.controller.Controller;

/**
 *
 * @author Eko SW
 */
public class WaliPesertaTest extends Controller{
    public WaliPesertaTest(){
        modelForm = new WaliPesertaTestModel();
        controllerName = "WaliPesertaTest";
        viewPage = "wali_peserta_test/daftar_wali_peserta_test.jsp";
        formPage = "wali_peserta_test/form_wali_peserta_test.jsp";
        sqlViewDataPerPage = "select * from wali_peserta_test order by username";    
 	  validationAddRule("username","required");
        validationAddRule("password","required");
	  validationAddRule("idpeserta_test","!=-1");


    }
    
    @Override
    public void input(String id){
        request.setAttribute("row_peserta_test", (new PesertaTestModel()).getAllData());
        super.input(id);
    }
}
