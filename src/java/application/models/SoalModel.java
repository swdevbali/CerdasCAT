/** 
 * 
 */
package application.models;

import java.util.List;
import recite18th.library.Db;

public class SoalModel extends _SoalModel {

    public String domain;
    public String nama_skl;

    public String getNama_skl() {
        return nama_skl;
    }

    public void setNama_skl(String nama_skl) {
        this.nama_skl = nama_skl;
    }

    public SoalModel() {
        super();
        rasch_b = "0.0";
        lg1_b = "0.0";
        lg2_a = "0.0";
        lg2_b = "0.0";
        lg3_a = "0.0";
        lg3_b = "0.0";
        lg3_c = "0.0";
    }

    //CATATAN PENTING : (semua catatan itu penting), cek disini kalau soal langsung habis saat di test
    public void getSoalSelanjutnya(double theta, String idpeserta_test, String soal_terpakai, boolean jawaban_benar, String iddomain, java.lang.String idskl) {
        PesertaTestModel pesertaTestModel = new PesertaTestModel();
        pesertaTestModel.addCriteria("id", idpeserta_test);
        pesertaTestModel.get();

        String operator_pencarian = "";
        String kenaikan = "";
        if ("Rasch".equals(pesertaTestModel.getModel_logistik())) {
            if (jawaban_benar) {
                operator_pencarian = ">=";
                kenaikan = "asc";
            } else {
                operator_pencarian = "<=";
                kenaikan = "desc";
            }
            String sql;
            if (idskl == null)
            { //penyajian acak
                sql = "SELECT * FROM soal s where s.idsoal not in (select idsoal from paket_soal_tiga_butir_jawaban p where  p.idpeserta_test=" + idpeserta_test + ") and rasch_b " + operator_pencarian + " " + theta + " " + soal_terpakai + " and s.iddomain = " + iddomain + "  order by rasch_b " + kenaikan + " limit 0,1";
            } else {//penyajian proporsional
                sql = "SELECT * FROM soal s where s.idsoal not in (select idsoal from paket_soal_tiga_butir_jawaban p where  p.idpeserta_test=" + idpeserta_test + ") and rasch_b " + operator_pencarian + " " + theta + " " + soal_terpakai + " and s.iddomain = " + iddomain + " and s.idskl=" + idskl + "  order by rasch_b " + kenaikan + " limit 0,1";
            }
            setQuery(sql);

        }
        get();
    }

    public void setDomain(String domain) {
        this.domain = domain;
    }

    public String getDomain() {
        return domain;
    }

    //penyajian soal tetap
    public List getSoalUntukSiswa(String idpeserta_test, String iddomain) {
        return Db.get("SELECT s.idsoal FROM paket_soal ps, paket_soal_detail psd,soal s,peserta_test pt where ps.idpaket_soal = psd.idpaket_soal and s.idsoal = psd.idsoal and pt.idpaket_soal = ps.idpaket_soal and s.iddomain = " + iddomain + " and pt.id=" + idpeserta_test, SoalModel.class.getName());
    }


    //tiga butir soal pendahulu
    public List getTigaButirSoal(String idpeserta_test, String iddomain) {
        PesertaTestModel pesertaTestModel = new PesertaTestModel();
        pesertaTestModel.addCriteria("id", idpeserta_test);
        pesertaTestModel.get();
        if ("Rasch".equals(pesertaTestModel.getModel_logistik())) {
            return Db.get("SELECT s.idsoal,s.gambar,s.jawaban FROM paket_soal_tiga_butir ps, paket_soal_tiga_butir_detail psd,soal s,peserta_test pt where ps.idpaket_soal_tiga_butir = psd.idpaket_soal_tiga_butir and s.idsoal = psd.idsoal and pt.idpaket_soal_tiga_butir = ps.idpaket_soal_tiga_butir and s.iddomain = " + iddomain + " and  pt.id=" + idpeserta_test + " order by s.rasch_b asc", SoalModel.class.getName());
        }

        return null;

    }

    //setelah selesai menjawab tiga butir soal, maka peserta akan mulai menjawab soal berikutnya...
    public void getSoalPertama(String tingkat_kesukaran, String idpeserta_test, String iddomain) {
        PesertaTestModel pesertaTestModel = new PesertaTestModel();
        pesertaTestModel.addCriteria("id", idpeserta_test);
        pesertaTestModel.get();

        //TODO : dimana sebaiknya kode ini?
        String b = "";
        if (tingkat_kesukaran.equals("Sangat Tinggi")) {
            b = "3";
        } else if (tingkat_kesukaran.equals("Tinggi")) {
            b = "2";
        } else if (tingkat_kesukaran.equals("Sedang")) {
            b = "0";
        } else if (tingkat_kesukaran.equals("Rendah")) {
            b = "-2";
        } else if (tingkat_kesukaran.equals("Sangat Rendah")) {
            b = "-3";
        }


        if ("Rasch".equals(pesertaTestModel.getModel_logistik())) {
            setQuery("SELECT * FROM soal s where s.idsoal not in (select idsoal from paket_soal_tiga_butir_jawaban p where p.idpeserta_test=" + idpeserta_test + ") and rasch_b<=" + b + " and iddomain=" + iddomain + " order by rasch_b desc limit 0,1");
        }

        
        get();
    }
}
