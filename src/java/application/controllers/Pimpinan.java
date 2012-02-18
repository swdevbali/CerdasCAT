/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package application.controllers;

import application.models.PimpinanModel;
import recite18th.controller.Controller;
import recite18th.library.Db;

/**
 *
 * @author Eko SW
 */
public class Pimpinan extends Controller {

    public Pimpinan() {
        modelForm = new PimpinanModel();
        controllerName = "Pimpinan";
        viewPage = "pimpinan/daftar_pimpinan.jsp";
        formPage = "pimpinan/form_pimpinan.jsp";
        sqlViewDataPerPage = "select * from Pimpinan order by username";

        //validation
        validationAddRule("username", "required");
        validationAddRule("password", "required");
    }

    public void pembobotan_skl() {
        index("pimpinan/pembobotan_skl.jsp");
    }

    public void pembobotan_domain() {
        index("pimpinan/pembobotan_domain.jsp");
    }

    public void pembobotan_kriteria() {
        index("pimpinan/pembobotan_kriteria.jsp");
    }

    public void save_pembobotan_skl() {
        //delete existing data
        Db.executeQuery("delete from pembobotan_skl");
        String flashMessage = "";
        //insert new one
        String domain[][] = Db.getDataSet("select iddomain,domain from domain where iddomain in (select iddomain from konfigurasi_domain) order by domain");
        for (int id = 0; id < domain.length; id++) {
            String skl[][] = Db.getDataSet("select idskl from skl where iddomain=" + domain[id][0]);
            float total_bobot = 0, fbobot = 0;
            for (int i = 0; i < skl.length; i++) {
                String bobot = request.getParameter("skl_" + skl[i][0]);
                fbobot = (float) Double.parseDouble(bobot);
                total_bobot += fbobot;
                Db.executeQuery("insert into pembobotan_skl(idskl,bobot) values(" + skl[i][0] + "," + bobot + ")");
            }
            if (total_bobot != 100.0) {
                flashMessage = "Domain " + domain[id][1] + " tidak sama dengan 100<br/>" + flashMessage;
            }
        }
        if (flashMessage.equals("")) {
            flashMessage = "Penyimpanan bobot SKL berhasil";
        }
        request.setAttribute("flash_message", flashMessage);
        index("pimpinan/pembobotan_skl.jsp");
    }

    public void save_pembobotan_domain() {
        //delete existing data
        Db.executeQuery("delete from pembobotan_domain");
        String flashMessage = "";
        //insert new one
        String domain[][] = Db.getDataSet("select iddomain,domain from domain where iddomain in (select iddomain from konfigurasi_domain) order by domain");
        float total_bobot = 0;
        for (int id = 0; id < domain.length; id++) {

            float fbobot = 0;
            String bobot = request.getParameter("domain_" + domain[id][0]);
            fbobot = (float) Double.parseDouble(bobot);
            total_bobot += fbobot;
            Db.executeQuery("insert into pembobotan_domain(iddomain,bobot) values(" + domain[id][0] + "," + bobot + ")");
        }

        if (total_bobot != 100.0) {
            flashMessage = "Total bobot domain tidak sama dengan 100<br/>" + flashMessage;
        } else {
            flashMessage = "Penyimpanan bobot domain berhasil";
        }
        request.setAttribute("flash_message", flashMessage);
        index("pimpinan/pembobotan_domain.jsp");
    }

    public void save_pembobotan_kriteria() {
        //delete existing data
        //Db.executeQuery("delete from pe");
        String flashMessage = "";
        //insert new one
        String penilaian[][] = Db.getDataSet("select idpenilaian from penilaian order by idpenilaian");
        float total_bobot = 0;
        for (int id = 0; id < penilaian.length; id++) {

            float fbobot = 0;
            String bobot = request.getParameter("penilaian_" + penilaian[id][0]);
            fbobot = (float) Double.parseDouble(bobot);
            total_bobot += fbobot;
            Db.executeQuery("update penilaian set bobot=" + bobot + " where idpenilaian=" + penilaian[id][0]);
        }

        if (total_bobot != 100.0) {
            flashMessage = "Total bobot penilaian tidak sama dengan 100<br/>" + flashMessage;
        } else {
            flashMessage = "Penyimpanan bobot penilaian berhasil";
        }
        request.setAttribute("flash_message", flashMessage);
        index("pimpinan/pembobotan_kriteria.jsp");
    }

    public void bukaFormInputKonfigurasi() {
        request.removeAttribute("message");
        index("pimpinan/form_konfigurasi.jsp");
    }

    public void saveKonfigurasi() {
        String skor_minimum = request.getParameter("skor_minimum");
        String kuota = request.getParameter("kuota");
        String domain[][] = Db.getDataSet("select iddomain,domain from domain order by domain");
        Db.executeQuery("delete from konfigurasi_domain");
        for (int i = 0; i < domain.length; i++) {
            String nilaiDomain = request.getParameter("domain_" + domain[i][0]);
            if(nilaiDomain!=null) {
                Db.executeQuery("insert into konfigurasi_domain values("+domain[i][0]+")");
            }
           
        }
        Db.executeQuery("update konfigurasi set skor_minimum = " + skor_minimum + ", kuota=" + kuota);
        request.setAttribute("message", "Konfigurasi sudah tersimpan");
        index("pimpinan/form_konfigurasi.jsp");
    }
}
