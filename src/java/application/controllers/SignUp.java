package application.controllers;

import application.models.PesertaTestModel;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import recite18th.controller.Controller;
import recite18th.library.Db;

/**
 * TODO : access level to controller, until its method level, not just controller level 
 * e.g PesertaTest will be accessible all to Admin, but signup can be accessed by PesertaTest
 *
 * @author Eko SW
 */
public class SignUp extends Controller {

    public SignUp() {
        modelForm = new PesertaTestModel();
        controllerName = "SignUp";
        viewPage = "peserta_test/signup.jsp";


        //todo remove this unnecessary free input validation.
        validationAddRule("nomor_peserta", "required");//actually, what we search is required. But because it's any, so it's not required :)
        validationAddRule("nama_lengkap", "required");
        validationAddRule("asal", "required");
        validationAddRule("tempat_lahir", "required");
        validationAddRule("tanggal_lahir", "required");

    }

    public void index() {
        String id = ((PesertaTestModel) request.getSession().getAttribute("user_credential")).getId();
        PesertaTestModel model = (PesertaTestModel) Db.getById("peserta_test", "id", PesertaTestModel.class.getName(), id);
        request.setAttribute("model", model);
        index(viewPage);
    }

    public void verifikasi() {
        PrintWriter out = null;
        try {
            
            out = response.getWriter();
            
            String nomorPeserta = (String) request.getParameter("txtNomorPeserta");
            PesertaTestModel user_credential;// = session.
            user_credential = (PesertaTestModel) request.getSession().getAttribute("user_credential");
            if (user_credential.getNomor_peserta().equals(nomorPeserta)) {
                //out.print("verified");
                Db.executeQuery("update peserta_test set verified=1 where id="+user_credential.getId());
                user_credential.setVerified("1");
                request.getSession().removeAttribute("user_credential");
                request.getSession().setAttribute("user_credential", user_credential);
                 request.setAttribute("verification_error", "Verifikasi nomor peserta berhasil!");
                index();
            }else{
                //out.print("unverified");
                request.setAttribute("verification_error", "Verifikasi nomor peserta salah");
                index();
            }
            out.print(nomorPeserta + " = " + user_credential.getNomor_peserta());
        } catch (IOException ex) {
            Logger.getLogger(SignUp.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            out.close();
        }
    }
}
