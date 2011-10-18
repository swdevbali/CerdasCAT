package application.controllers;


import application.models.PengajarModel;
import recite18th.controller.Controller;

/**
 *
 * @author Eko SW
 */
public class Pengajar extends Controller
{
    public Pengajar()
    {
        modelForm = new PengajarModel();
        controllerName = "pengajar";
        viewPage = "pengajar/daftar_pengajar.jsp";
        formPage = "pengajar/form_pengajar.jsp";
        sqlViewDataPerPage = "select * from pengajar order by username";    
        validationAddRule("username","required");
        validationAddRule("password","required");
    }
    
    public void daftarSoal()
    {
        index("pengajar/daftar_soal.jsp");
    }
    
    public void formSoal(String idsoal){
        index("pengajar/form_soal.jsp");
    }
}
