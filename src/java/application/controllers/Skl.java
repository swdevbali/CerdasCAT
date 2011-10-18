/** 
 * 
 */
package application.controllers;

import application.models.DomainModel;
import recite18th.controller.Controller;
import application.models.SklModel;

public class Skl extends Controller {

    public Skl() {
        modelForm = new SklModel();
        controllerName = "Skl";
        viewPage = "skl/daftar_skl.jsp";
        formPage = "skl/form_skl.jsp";
        sqlViewDataPerPage = "select skl.*,domain.domain from skl,domain where skl.iddomain = domain.iddomain order by domain.iddomain, prioritas, nama_skl";

        validationAddRule("nama_skl", "required");
        validationAddRule("iddomain", "!=-1");
        validationAddRule("prioritas", "!=-1");
    }

    @Override
    public void input(String pkFieldValue) {
        request.setAttribute("row_iddomain", (new DomainModel()).getAllData());

        super.input(pkFieldValue);
    }
}
