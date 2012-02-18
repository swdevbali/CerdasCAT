package application.controllers;

import application.models.PengajarModel;
import recite18th.controller.Controller;
import recite18th.library.Db;

/**
 *
 * @author Eko SW
 */
public class Pengajar extends Controller {

    public Pengajar() {
        modelForm = new PengajarModel();
        controllerName = "pengajar";
        viewPage = "pengajar/daftar_pengajar.jsp";
        formPage = "pengajar/form_pengajar.jsp";
        sqlViewDataPerPage = "select * from pengajar order by username";
        validationAddRule("username", "required");
        validationAddRule("password", "required");
    }

    public void daftarSoal() {
        index("pengajar/daftar_soal.jsp");
    }

    public void formSoal(String idsoal) {
        index("pengajar/form_soal.jsp");
    }

    public void bukaViewInputPenilaian(String idpeserta_test) {
        request.setAttribute("selectedPeserta", idpeserta_test);
        index("pengajar/view_input_penilaian.jsp");
    }

    public void savePenilaian() {
        String idpeserta_test = request.getParameter("idpeserta_test");
        request.setAttribute("message", "Data penilaian sudah berhasil disimpan");
        request.setAttribute("selectedPeserta", idpeserta_test);

        if (!idpeserta_test.equals("-1")) {
            Db.executeQuery("delete from penilaian_peserta where idpeserta_test=" + idpeserta_test);

        }

        String dataPenilaian[][] = Db.getDataSet("SELECT idpenilaian,nama_penilaian FROM penilaian where idpenilaian<>1");
        for (int i = 0; i < dataPenilaian.length; i++) {
            String nilai = request.getParameter("txtDataNilai_" + dataPenilaian[i][0]);
            Db.executeQuery("insert into penilaian_peserta(idpeserta_test,idpenilaian,nilai) values(" + idpeserta_test + "," + dataPenilaian[i][0] + "," + nilai + ")");
        }
        index("pengajar/view_input_penilaian.jsp");
    }
}
