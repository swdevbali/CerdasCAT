package application.controllers;

import recite18th.controller.Controller;
import application.models.SoalModel;
import application.models.DomainModel;
import application.models.SklModel;

/**
 *
 * @author Eko SW
 */
public class Soal extends Controller {

    public Soal() {
        controllerName = "Soal";//mandatory, for the form page to be able to go back to main view
        viewPage = "soal\\daftar_soal.jsp";
        formPage = "soal\\form_soal.jsp";
        modelForm = new SoalModel();
        sqlViewDataPerPage = "select s.*,d.domain,nama_skl from soal s, domain d,skl where skl.idskl = s.idskl and s.iddomain = d.iddomain order by domain,soal";
    }

    public void input(String pkFieldValue) {
        request.setAttribute("row_iddomain", (new DomainModel()).getAllData());
        request.setAttribute("row_idskl", (new SklModel()).getAllData());
        super.input(pkFieldValue);
    }
}
