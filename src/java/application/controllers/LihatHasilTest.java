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
import application.models.PengajarModel;
import application.models.PesertaTestModel;
import application.models.WaliPesertaTestModel;
import java.util.List;
import recite18th.controller.Controller;
import recite18th.library.Db;
import recite18th.model.Model;
import recite18th.util.LoginUtil;

/**
 *
 * @author rukli
 */
public class LihatHasilTest extends Controller {

    public LihatHasilTest() {
        controllerName = "LihatHasilUjian";
        viewPage = "hasil_ujian/view_hasil_ujian.jsp";
    }

    @Override
    public void index() {
        String cetak = request.getParameter("cetak");
        if (cetak != null && cetak.equals("true")) {
            viewPage = "hasil_ujian/view_hasil_ujian_cetak.jsp";
        } else {
            viewPage = "hasil_ujian/view_hasil_ujian.jsp";
        }
        
        Model model = LoginUtil.getLogin(request);
        String idpeserta_test="";
        if(model instanceof PesertaTestModel)
        {
            PesertaTestModel userCredential = (PesertaTestModel) model;
            idpeserta_test = userCredential.getId();
        } else if(model instanceof WaliPesertaTestModel) {
            WaliPesertaTestModel userCredential = (WaliPesertaTestModel) model;
            idpeserta_test = userCredential.getIdpeserta_test();
        }
        
        //PesertaTestModel userCredential = (PesertaTestModel) LoginUtil.getLogin(request);
        List domain = Db.get("select d.* from domain d,peserta_test_domain p where p.iddomain=d.iddomain and p.idpeserta_test=" + idpeserta_test, DomainModel.class.getName());
        request.setAttribute("domain", domain);
        super.index();
    }

    public void laporanPengajarRasch() {
        PengajarModel userCredential = (PengajarModel) LoginUtil.getLogin(request);
        List domain = Db.get("select * from domain", DomainModel.class.getName());
        request.setAttribute("domain", domain);
        viewPage = "hasil_ujian/view_laporan_pengajar_rasch.jsp";
        super.index();
    }

    public void laporanPenerimaan() {
        String cetak = request.getParameter("cetak");
        if (cetak != null && cetak.equals("true")) {
            viewPage = "hasil_ujian/view_laporan_penerimaan_cetak.jsp";
        } else {
            viewPage = "hasil_ujian/view_laporan_penerimaan.jsp";
        }
        super.index();
    }
}
