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

import application.models.PaketSoalTigaButirModel;
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
public class PaketSoalTigaButir extends Controller {

    public PaketSoalTigaButir() {
        modelForm = new PaketSoalTigaButirModel();
        controllerName = "PaketSoalTigaButir";
        viewPage = "paket_soal_tiga_butir/view_page.jsp";
        formPage = "paket_soal_tiga_butir/form_page.jsp";
        sqlViewDataPerPage = "select * from paket_soal_tiga_butir order by tanggal";
    }

    @Override
    public void input(String pkFieldValue) {
        List row_soal = Db.get("select s.*,d.domain from soal s,domain d where s.iddomain = d.iddomain", SoalModel.class.getName());
        request.setAttribute("row_soal", row_soal);
        //work around u/ belum bs ambil model...
        request.getSession().setAttribute("idpaket_soal_tiga_butir", pkFieldValue);
        super.input(pkFieldValue);
    }

    @Override
    public void save() {
        //TODO : please, make master detail to be part of the framework..
        super.doSave();//save master
        String idpaket_soal_tiga_butir;
        if (super.isNewData()) {//data baru, langsung inputkan detail soal            
            idpaket_soal_tiga_butir = Db.getLastInsertId() + "";
            Logger.getLogger(Controller.class.getName()).log(Level.INFO, "lastInsertId" + idpaket_soal_tiga_butir);
        } else {   //data lama, harus mengupdate         
            idpaket_soal_tiga_butir = super.getFormFieldValue(modelForm.getPkFieldName());//reminder, pk field is automatically defined by its autoincrement value
        }

        List row_soal = Db.get("select s.*,d.domain from soal s,domain d where s.iddomain = d.iddomain", SoalModel.class.getName());
        
        //TOFIX : ada cara lebih cerdas kah?
        Db.executeQuery("delete from paket_soal_tiga_butir_detail where idpaket_soal_tiga_butir="+idpaket_soal_tiga_butir);
        for (int i = 0; i < row_soal.size(); i++) {
            SoalModel soal = (SoalModel) row_soal.get(i);
            if (getFormFieldValue("chk_soal_" + soal.getIdsoal()) != null) {
                //TOFIX : this is messy, can we elminate SQL command from controller???
                //Say, we can use PaketSoalTigaButirDetailModel m = new PaketSoalTigaButirDetailModel(); m.set*(*); m.insert();...???
                Db.executeQuery("insert into paket_soal_tiga_butir_detail(idpaket_soal_tiga_butir,idsoal) values(" + idpaket_soal_tiga_butir + "," + soal.getIdsoal()+")");
            }
        }
        super.goAfterSave();
    }
}
