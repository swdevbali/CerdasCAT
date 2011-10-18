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

import application.models.PaketSoalModel;
import application.models.SoalModel;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import recite18th.controller.Controller;
import recite18th.library.Db;

/**
 *
 * @author Eko SW
 */
public class PaketSoal extends Controller {

    public PaketSoal() {
        modelForm = new PaketSoalModel();
        controllerName = "PaketSoal";
        viewPage = "paket_soal/view_page.jsp";
        formPage = "paket_soal/form_page.jsp";
        sqlViewDataPerPage = "select * from paket_soal order by tanggal";
    }

    @Override
    public void input(String pkFieldValue) {
        List row_soal = Db.get("select s.*,d.domain from soal s,domain d where s.iddomain = d.iddomain", SoalModel.class.getName());
        request.setAttribute("row_soal", row_soal);
        //work around u/ belum bs ambil model...
        request.getSession().setAttribute("idpaket_soal", pkFieldValue);
        super.input(pkFieldValue);
    }

    @Override
    public void save() {
        //TODO : please, make master detail to be part of the framework..
        super.doSave();//save master
        String idpaket_soal;
        if (super.isNewData()) {//data baru, langsung inputkan detail soal            
            idpaket_soal = Db.getLastInsertId() + "";
            Logger.getLogger(Controller.class.getName()).log(Level.INFO, "lastInsertId" + idpaket_soal);
        } else {   //data lama, harus mengupdate         
            idpaket_soal = super.getFormFieldValue(modelForm.getPkFieldName());
        }

        List row_soal = Db.get("select s.*,d.domain from soal s,domain d where s.iddomain = d.iddomain", SoalModel.class.getName());
        
        //TOFIX : ada cara lebih cerdas kah?
        Db.executeQuery("delete from paket_soal_detail where idpaket_soal="+idpaket_soal);
        for (int i = 0; i < row_soal.size(); i++) {
            SoalModel soal = (SoalModel) row_soal.get(i);
            if (getFormFieldValue("chk_soal_" + soal.getIdsoal()) != null) {
                String bobot=getFormFieldValue("bobot_soal_" + soal.getIdsoal());
                Db.executeQuery("insert into paket_soal_detail(idpaket_soal,idsoal,bobot) values(" + idpaket_soal + "," + soal.getIdsoal() + "," + bobot + ")");
            }
        }
        super.goAfterSave();
    }
}
