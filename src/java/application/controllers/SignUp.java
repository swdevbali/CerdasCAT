package application.controllers;

import application.models.PesertaTestModel;
import java.io.IOException;
import recite18th.controller.Controller;
import recite18th.library.Db;

/**
 * TODO : access level to controller, until its method level, not just controller level 
 * e.g PesertaTest will be accessible all to Admin, but signup can be accessed by PesertaTest
 *
 * @author Eko SW
 */
public class SignUp extends Controller
{
    public SignUp()
    {
        modelForm = new PesertaTestModel();
        controllerName = "SignUp";
        viewPage = "peserta_test/signup.jsp";

        
        //todo remove this unnecessary free input validation.
        validationAddRule("nomor_peserta","required");//actually, what we search is required. But because it's any, so it's not required :)
        validationAddRule("nama_lengkap","required");
        validationAddRule("asal","required");
        validationAddRule("tempat_lahir","required");
        validationAddRule("tanggal_lahir","required");

    }

    public void index()
    {
        String id = ((PesertaTestModel) request.getSession().getAttribute("user_credential")).getId();
        PesertaTestModel model = (PesertaTestModel) Db.getById("peserta_test","id",PesertaTestModel.class.getName(),id);
        request.setAttribute("model",model);
        index(viewPage);
    }
    
    

}
