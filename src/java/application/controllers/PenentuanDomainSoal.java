/*
Recite18th is a simple, easy to use and straightforward Java Database 
Web Application Framework. See http://code.google.com/p/recite18th
Copyright (C) 2011  Eko Suprapto Wibowo (swdev.bali@gmail.com)
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program.  If not, see http://www.gnu.org/licenses/.
 */
package application.controllers;

import application.models.DomainModel;
import application.models.PesertaTestModel;
import java.util.List;
import recite18th.controller.Controller;
import recite18th.library.Db;

/**
 *
 * @author rukli
 */
public class PenentuanDomainSoal extends Controller {

    public PenentuanDomainSoal() {
        modelForm = new PesertaTestModel();
        controllerName = "PenentuanDomainSoal";
        viewPage = "penentuan_domain/penentuan_domain.jsp";
        formPage = "penentuan_domain/penentuan_domain_form.jsp";
        sqlViewDataPerPage = "select id,username from peserta_test";

    //validation
    //validationAddRule("domain", "required");
    }

    @Override
    public void input(String pkFieldValue) {
        List row_soal = Db.get("SELECT d.* FROM domain d", DomainModel.class.getName());//, peserta_test_domain ptd where ptd.idpeserta_test = 1 and ptd.iddomain=d.iddomain
        request.setAttribute("row_soal", row_soal);
        request.getSession().setAttribute("idpeserta_test", pkFieldValue);
        super.input(pkFieldValue);
    }

    @Override
    public void save() {

        String idpeserta_test = request.getSession().getAttribute("idpeserta_test")+"";
        //TOFIX : ada cara lebih cerdas kah?
        List row_domain = Db.get("select * from domain", DomainModel.class.getName());
        Db.executeQuery("delete from peserta_test_domain where idpeserta_test=" + idpeserta_test);
        for (int i = 0; i < row_domain.size(); i++) {
            DomainModel domain = (DomainModel) row_domain.get(i);
            if (getFormFieldValue("chk_soal_" + domain.getIddomain()) != null) {
                //TOFIX : this is messy, can we elminate SQL command from controller???
                //Say, we can use PaketSoalTigaButirDetailModel m = new PaketSoalTigaButirDetailModel(); m.set*(*); m.insert();...???
                Db.executeQuery("insert into peserta_test_domain(idpeserta_test,iddomain) values(" + idpeserta_test + "," + domain.getIddomain() + ")");
            }
        }
        super.goAfterSave();
    }
}
