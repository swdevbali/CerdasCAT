package application.controllers;

import application.models.PesertaTestModel;
import application.models.SoalModel;
import java.util.Iterator;
import recite18th.controller.Controller;
import java.io.*;
import recite18th.library.Db;
import application.config.Config;
import application.models.DomainModel;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import recite18th.util.LoginUtil;
import recite18th.util.ServletUtil;

/**
 * @author Rukli
 * Kelas ini untuk membuka halaman About.jsp
 */
public class AmbilUjian extends Controller {

    private static final String page0 = "peserta_test/mulai_ujian_tanpa_model_tanpa_metode_penyajian_tetap.jsp";
    private static final String page1 = "peserta_test/mulai_ujian_rasch_futsuhilow_penyajian_proporsional.jsp";
    private double D = 1;
    double pengali = 12.5;
    double A = 2.71828182845904;

    public AmbilUjian() {
        //TODO : I have and Idea to check the security here... 
        controllerName = "AmbilUjian";
    }

    public void ambilSoalTanpaModel(String idsoal) {
        //request.getSession().removeAttribute("message");
        PesertaTestModel userCredential = (PesertaTestModel) LoginUtil.getLogin(request);
        String iddomain = request.getSession().getAttribute("iddomain") + "";
        request.setAttribute("row_idsoal", (new SoalModel()).getSoalUntukSiswa(userCredential.getId(), iddomain));
        SoalModel soal = new SoalModel();
        soal.addCriteria("idsoal", idsoal);
        soal.get();
        request.setAttribute("soal", soal);
        request.getSession().setAttribute("idsoal_tanpa_model", idsoal);
        index(page0);
    }

    public void mulaiUjianDomain(String iddomain) {
        PesertaTestModel userCredential = (PesertaTestModel) LoginUtil.getLogin(request);

        request.getSession().setAttribute("iddomain", iddomain);
        request.getSession().removeAttribute("skl");
        if ("Tidak Ada".equals(userCredential.getMetode())) //KASUS PENYAJIAN SOAL TETAP
        {
            request.getSession().removeAttribute("message");
            List x = (new SoalModel()).getSoalUntukSiswa(userCredential.getId(), iddomain);
            ServletUtil.redirect(Config.base_url + "index/AmbilUjian/ambilSoalTanpaModel/" + ((SoalModel) x.get(0)).getIdsoal(), request, response);
            //index(page0);
        } else if ("Futsuhilow".equals(userCredential.getMetode()) || "Fusuhilow".equals(userCredential.getMetode()) || "Fumahilow".equals(userCredential.getMetode())) {
            List tigaSoal = (new SoalModel()).getTigaButirSoal(userCredential.getId(), iddomain);
            request.getSession().setAttribute("soal_terpakai", "");
            for (int i = 0; i < tigaSoal.size(); i++) {
                SoalModel soal = (SoalModel) tigaSoal.get(i);
                request.getSession().setAttribute("soal_terpakai",
                        request.getSession().getAttribute("soal_terpakai") + " and idsoal <> " + soal.getIdsoal());

            }
            request.setAttribute("row_soal_tiga_butir", tigaSoal);
            index(page1);
        }
    }

    @Override
    public void index() {
        //cleanup session
        request.getSession().removeAttribute("soal_terpakai");
        request.getSession().removeAttribute("soal_terpakai");
        PesertaTestModel userCredential = (PesertaTestModel) LoginUtil.getLogin(request);

        //ups, domain dulu
        List row = Db.get("select d.* from domain d,peserta_test_domain p where p.iddomain=d.iddomain and p.idpeserta_test=" + userCredential.getId(), DomainModel.class.getName());
        request.setAttribute("row", row);

        //hapus jawaban yg lama disini
        //hapus jawaban yg sudah ada 
        Db.executeQuery("delete from peserta_test_jawaban_dengan_model where idpeserta_test=" + userCredential.getId());
        Db.executeQuery("delete from paket_soal_tiga_butir_jawaban where idpeserta_test=" + userCredential.getId());
        Db.executeQuery("delete from paket_soal_jawaban where idpeserta_test=" + userCredential.getId());

        index("peserta_test/pilih_domain.jsp");
    }

    //kembali ke menu pemilihan domain, tanpa menghapus jawaban yang sudah ada
    public void indexOnProgress() {
        //cleanup session
        request.getSession().removeAttribute("soal_terpakai");
        request.getSession().removeAttribute("theta_awal_tiga_soal");
        request.getSession().removeAttribute("SEsebelumnya");
        request.getSession().removeAttribute("theta");
        request.getSession().removeAttribute("iterasi_ke");
        request.getSession().removeAttribute("skl");
        request.getSession().removeAttribute("iddomain");
        request.getSession().removeAttribute("soal_terpakai");
        request.getSession().removeAttribute("theta_awal");
        request.getSession().removeAttribute("soal_ke");
        request.getSession().removeAttribute("sumPQ");
        request.getSession().removeAttribute("sumUminusP");

        PesertaTestModel userCredential = (PesertaTestModel) LoginUtil.getLogin(request);

        //ups, domain dulu
        List row = Db.get("select d.* from domain d,peserta_test_domain p where p.iddomain=d.iddomain and p.idpeserta_test=" + userCredential.getId(), DomainModel.class.getName());
        request.setAttribute("row", row);

        index("peserta_test/pilih_domain.jsp");

    }

    public void ambilSoal(String idsoal) {
        response.setContentType("text/xml");
        try {
            PrintWriter out = response.getWriter();
            SoalModel soalModel = (SoalModel) Db.getById("soal", "idsoal", SoalModel.class.getName(), idsoal);
            out.println("<soal><gambar>" + Config.base_url + "upload/" + soalModel.getGambar() + "</gambar></soal>");
            out.flush();
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    //TANPA METODE
    public void jawabSoal() {
        String idsoal, jawaban;
        idsoal = request.getParameter("idsoal");
        jawaban = request.getParameter("optJawaban");
        PesertaTestModel userCredential = (PesertaTestModel) LoginUtil.getLogin(request);
        String idpaket_soal = "" + userCredential.getIdpaket_soal();
        String idpeserta_test = "" + userCredential.getId();
        //hapus dulu jawaban yang lama
        boolean isSukses = Db.executeQuery("delete from paket_soal_jawaban where idpaket_soal='" + idpaket_soal + "' and idsoal='" + idsoal + "' and idpeserta_test='" + idpeserta_test + "'");

        isSukses = isSukses && Db.executeQuery("insert into paket_soal_jawaban(idpaket_soal,idsoal,idpeserta_test,jawaban) values ('" + idpaket_soal + "','" + idsoal + "','" + idpeserta_test + "','" + jawaban + "')");
        String iddomain = request.getSession().getAttribute("iddomain") + "";
        List x = (new SoalModel()).getSoalUntukSiswa(userCredential.getId(), iddomain);
        int nextSoal=0;
        for(int i = 0; i < x.size();i++)
        {
            SoalModel soal = (SoalModel) x.get(i);
            if(soal.getIdsoal().equals(idsoal)) {
                nextSoal=i+1;
                break;
            }
        }if(nextSoal>=x.size()) nextSoal=0;
        ServletUtil.redirect(Config.base_url + "index/AmbilUjian/ambilSoalTanpaModel/" + ((SoalModel) x.get(nextSoal)).getIdsoal(), request, response);


        /*PrintWriter out = null;
        response.setContentType("text/xml");
        try {
        out = response.getWriter();
        if (isSukses) {
        out.println("<result>true</result>");
        } else {
        out.println("<result>false</result>");
        }
        } catch (IOException e) {
        e.printStackTrace();
        } finally {
        out.flush();
        out.close();
        }*/
    }

    //TANPA METODE
    public void selesaiJawabSoal() {
        PesertaTestModel userCredential = (PesertaTestModel) LoginUtil.getLogin(request);
        //hitung nilai jawaban siswa
        String data[][] = Db.getDataSet("select sum(pd.bobot) from paket_soal_jawaban pj, paket_soal_detail pd, soal s,peserta_test pt where pj.idsoal = s.idsoal and pd.idsoal = s.idsoal and pj.jawaban = s.jawaban and pd.idpaket_soal = pj.idpaket_soal and pt.idpaket_soal=pd.idpaket_soal and pt.id=" + userCredential.getId());

        //simpan hasil jawaban
        String hasilAkhir = data[0][0];
        Db.executeQuery("update peserta_test set skor_akhir=" + hasilAkhir + " where id=" + userCredential.getId());
        request.setAttribute("hasilAkhir", hasilAkhir);
        index("peserta_test\\selesai_ambil_ujian.jsp");
    }

    public void lihatHasilUjian() {
        index("peserta_test\\lihat_hasil_ujian.jsp");
    }

    public void selesaiJawabTigaButir() {
        PesertaTestModel userCredential = (PesertaTestModel) LoginUtil.getLogin(request);
        String idpaket_soal_tiga_butir = "" + userCredential.getIdpaket_soal_tiga_butir();
        String idpeserta_test = "" + userCredential.getId();
        //hapus dulu jawaban yang lama



        //get all the tiga butir soal for current user
        String iddomain = request.getSession().getAttribute("iddomain") + "";
        List listSoal = (new SoalModel()).getTigaButirSoal(idpeserta_test, iddomain);
        Iterator it = listSoal.iterator();
        SoalModel soal;
        boolean isSukses = true;

        boolean isSoal1Benar = true, isSoal2Benar = true, isSoal3Benar = true;
        int i = 0;
        while (it.hasNext()) {
            //save to DB
            soal = (SoalModel) it.next();
            isSukses = Db.executeQuery("delete from paket_soal_tiga_butir_jawaban where idpaket_soal_tiga_butir='" + idpaket_soal_tiga_butir + "' and idsoal='" + soal.getIdsoal() + "' and idpeserta_test='" + idpeserta_test + "'");
            String jawaban = getFormFieldValue("optJawaban_" + soal.getIdsoal());
            isSukses = isSukses && Db.executeQuery("insert into paket_soal_tiga_butir_jawaban(idpaket_soal_tiga_butir,idsoal,idpeserta_test,jawaban) values ('" + idpaket_soal_tiga_butir + "','" + soal.getIdsoal() + "','" + idpeserta_test + "','" + jawaban + "')");

            //nilai hasilnya
            if (i == 0) {
                isSoal1Benar = jawaban.equals(soal.getJawaban());
            } else if (i == 1) {
                isSoal2Benar = jawaban.equals(soal.getJawaban());
            } else if (i == 2) {
                isSoal3Benar = jawaban.equals(soal.getJawaban());
            }
            i++;
        }

        //hitung theta awal (Inisialisasi kemampuan)
        String tingkat_kesukaran;
        double thetaAwal = 0;
        if (isSoal1Benar && isSoal2Benar && isSoal3Benar) {
            tingkat_kesukaran = "Sangat Tinggi";
            thetaAwal = 3;
        } else if ((isSoal1Benar && isSoal3Benar) || isSoal3Benar || (isSoal2Benar && isSoal3Benar)) {
            tingkat_kesukaran = "Tinggi";
            thetaAwal = 2;
        } else if ((isSoal1Benar && isSoal2Benar) || isSoal2Benar) {
            tingkat_kesukaran = "Sedang";
            thetaAwal = 0;
        } else if (isSoal1Benar) {
            tingkat_kesukaran = "Rendah";
            thetaAwal = -2;
        } else {
            tingkat_kesukaran = "Sangat Rendah";
            thetaAwal = -3;
        }
        request.getSession().setAttribute("theta_awal_tiga_soal", thetaAwal);

        //simpan ke basisdata
        Db.executeQuery("update peserta_test set tingkat_kesukaran='" + tingkat_kesukaran + "' where id ='" + userCredential.getId() + "'");

        //forward
        //pilih soal pertama berdasarkan tingkat kesukaran, urut berdasarkan b (rasch_b) menurun, yg paling atas adalah calon soal berikutnya....
        //SELECT idsoal,rasch_b FROM soal where rasch_b <=2 and idsoal<>9 and idsoal<>10 and idsoal<>8 order by rasch_b desc

        //jawab soal pertama

        SoalModel soalPertama = new SoalModel();
        soalPertama.getSoalPertama(tingkat_kesukaran, userCredential.getId(), iddomain);
        request.getSession().setAttribute("skl", soalPertama.getIdskl());
        //request.getSession().setAttribute("theta_awal_tiga_soal", (Double.parseDouble(soalPertama.getRasch_b())));
        request.getSession().setAttribute("soal_ke", 1);
        request.getSession().removeAttribute("iterasi_ke");
        request.getSession().removeAttribute("theta_awal");
        request.setAttribute("item", soalPertama);

        index("peserta_test/pengerjaan_soal.jsp");

        /* ini waktu mengetest hasil dari menjawab tiga butir soal
        //forward
        PrintWriter out = null;
        response.setContentType("text/xml");
        try 
        {
        out = response.getWriter();
        if(isSukses)
        {
        out.println("<return><result>true</result><tingkat_kesukaran>"+tingkat_kesukaran+"</tingkat_kesukaran></return>");
        }else 
        {
        out.println("<return><result>false</result></return>");
        }
        }catch(IOException e)
        {
        e.printStackTrace();
        }finally
        {
        out.flush();
        out.close();
        }*/
    }

    /*
     * Simpan ke tabel peserta_test_jawaban_dengan_model
     */
    public void jawabSoalDenganModel() {
        //String idsoal, String jawaban
        String idsoal = request.getParameter("idsoal");
        String jawaban = request.getParameter("optJawaban");
        PesertaTestModel userCredential = (PesertaTestModel) LoginUtil.getLogin(request);
        //String idpaket_soal = "" + userCredential.getIdpaket_soal();
        String idpeserta_test = "" + userCredential.getId();
        //hapus dulu jawaban yang lama

        boolean isSukses = Db.executeQuery("delete from peserta_test_jawaban_dengan_model where idsoal='" + idsoal + "' and idpeserta_test='" + idpeserta_test + "'");
        //isSukses = isSukses && Db.executeQuery("insert into peserta_test_jawaban_dengan_model (idsoal,idpeserta_test,jawaban) values ('" + idsoal + "','" + idpeserta_test + "','" + jawaban + "')");

        SoalModel soal = new SoalModel();
        soal = (SoalModel) soal.getModelById(idsoal);

        PrintWriter out = null;
        response.setContentType("text/xml");
        boolean soalHabis = false;
        int iterasi_ke = 0;
        Object skor;
        double b = Double.parseDouble(soal.getRasch_b());
        try {
            out = response.getWriter();
            if (isSukses) {
                // selesaikan perhitungan model yg dipakai disini
                Double thetaSoal = Double.parseDouble(soal.getRasch_b());
                double thetaAwalTigaSoal = 0.0;
                double thetaHasilPerhitunganModel = 0.0;

                if ("Futsuhilow".equals(userCredential.getMetode())) {
                    Double u_sangat_rendah, u_rendah, u_sedang = null, u_tinggi = null, u_sangat_tinggi = null;
                    double alpha = 0.0;
                    double sum_alpha = 0.0;
                    double sum_theta_x_alpha = 0.0;

                    //sangat tinggi
                    if (thetaSoal >= 2 && thetaSoal <= 4) {
                        if (thetaSoal <= 2) {
                            u_sangat_tinggi = 0.0;
                            alpha = u_sangat_tinggi;
                            thetaAwalTigaSoal = u_sangat_tinggi;

                            sum_alpha += alpha;
                            sum_theta_x_alpha += alpha * thetaAwalTigaSoal;

                        } else if (thetaSoal >= 2 && thetaSoal <= 4) {
                            u_sangat_tinggi = (thetaSoal - 2.0) / (4.0 - 2.0);
                            alpha = u_sangat_tinggi;
                            thetaAwalTigaSoal = (alpha * 2) + 2;

                            sum_alpha += alpha;
                            sum_theta_x_alpha += alpha * thetaAwalTigaSoal;
                        } else if (thetaSoal >= 4) {
                            u_sangat_tinggi = 1.0;
                            alpha = u_sangat_tinggi;
                            thetaAwalTigaSoal = 1.0;

                            sum_alpha += alpha;
                            sum_theta_x_alpha += alpha * thetaAwalTigaSoal;
                        }

                    }

                    //tinggi
                    //if (tingkat_kesukaran >= 0 && tingkat_kesukaran <= 4) {
                    //  hasil_tingkat_kesukaran = "tinggi";
                    if (thetaSoal >= 4) {
                        u_tinggi = 0.0;
                        alpha = u_tinggi;
                        thetaAwalTigaSoal = u_tinggi;

                        sum_alpha += alpha;
                        sum_theta_x_alpha += alpha * thetaAwalTigaSoal;

                    }
                    if (thetaSoal >= 2.0 && thetaSoal <= 4.0) {
                        u_tinggi = (4.0 - thetaSoal) / (4.0 - 2.0);
                        alpha = u_tinggi;
                        thetaAwalTigaSoal = 4.0 - (alpha * 2.0);

                        sum_alpha += alpha;
                        sum_theta_x_alpha += alpha * thetaAwalTigaSoal;
                    }
                    if (thetaSoal >= 0 && thetaSoal <= 2) {
                        u_tinggi = thetaSoal / 2.0;
                        alpha = u_tinggi;
                        thetaAwalTigaSoal = alpha * 2.0;

                        sum_alpha += alpha;
                        sum_theta_x_alpha += alpha * thetaAwalTigaSoal;

                    }
                    if (thetaSoal <= 0.0) {
                        u_tinggi = 0.0;
                        alpha = u_tinggi;
                        thetaAwalTigaSoal = u_tinggi;

                        sum_alpha += alpha;
                        sum_theta_x_alpha += alpha * thetaAwalTigaSoal;
                    }
                    //}

                    // sedang
                    // if (tingkat_kesukaran >= -2 && tingkat_kesukaran <= 2) {
                    //   hasil_tingkat_kesukaran = "sedang";
                    if (thetaSoal >= 2.0) {
                        u_sedang = 0.0;
                        alpha = u_sedang;
                        thetaAwalTigaSoal = u_sedang;

                        sum_alpha += alpha;
                        sum_theta_x_alpha += alpha * thetaAwalTigaSoal;
                    }
                    if (thetaSoal >= 0.0 && thetaSoal <= 2.0) {
                        u_sedang = (2.0 - thetaSoal) / 2.0;
                        alpha = u_sedang;
                        thetaAwalTigaSoal = 2.0 * (1.0 - alpha);

                        sum_alpha += alpha;
                        sum_theta_x_alpha += alpha * thetaAwalTigaSoal;
                    }
                    if (thetaSoal >= -2.0 && thetaSoal <= 0.0) {
                        u_sedang = (thetaSoal - (-2.0)) / (0.0 - (-2.0));
                        alpha = u_sedang;
                        thetaAwalTigaSoal = 2.0 * (alpha - 1.0);

                        sum_alpha += alpha;
                        sum_theta_x_alpha += alpha * thetaAwalTigaSoal;
                    }
                    if (thetaSoal <= -2) {
                        u_sedang = 0.0;
                        alpha = u_sedang;
                        thetaAwalTigaSoal = u_sedang;

                        sum_alpha += alpha;
                        sum_theta_x_alpha += alpha * thetaAwalTigaSoal;
                    }
                    //}

                    //rendah
                    //if (tingkat_kesukaran >= -4 && tingkat_kesukaran <= 0) {
                    //  hasil_tingkat_kesukaran = "rendah";
                    if (thetaSoal >= 0.0) {
                        u_rendah = 0.0;
                        alpha = u_rendah;

                        sum_alpha += alpha;
                        sum_theta_x_alpha += alpha * thetaAwalTigaSoal;
                    }
                    if (thetaSoal > -2.0 && thetaSoal <= 0.0) {
                        u_rendah = (0.0 - thetaSoal) / (0.0 - (-2.0));
                        alpha = u_rendah;
                        thetaAwalTigaSoal = -2.0 * alpha;


                        sum_alpha += alpha;
                        sum_theta_x_alpha += alpha * thetaAwalTigaSoal;
                    }
                    if (thetaSoal >= -4 && thetaSoal <= -2) {

                        u_rendah = (thetaSoal - (-4.0)) / (-2.0 - (-4.0));
                        alpha = u_rendah;
                        thetaAwalTigaSoal = 2.0 * (alpha - 2.0);

                        sum_alpha += alpha;
                        sum_theta_x_alpha += alpha * thetaAwalTigaSoal;
                    }
                    if (thetaSoal <= -4.0) {
                        u_rendah = 0.0;
                        alpha = u_rendah;
                        thetaAwalTigaSoal = u_rendah;

                        sum_alpha += alpha;
                        sum_theta_x_alpha += alpha * thetaAwalTigaSoal;
                    }
                    //}

                    //sangat rendah
                    //if (tingkat_kesukaran >= -4 && tingkat_kesukaran <= -2) {
                    //  hasil_tingkat_kesukaran = "sangat rendah";
                    if (thetaSoal >= -2.0) {
                        u_sangat_rendah = 0.0;
                        alpha = u_sangat_rendah;
                        thetaAwalTigaSoal = 0.0;

                        sum_alpha += alpha;
                        sum_theta_x_alpha += alpha * thetaAwalTigaSoal;
                    }
                    if (thetaSoal >= -4.0 && thetaSoal <= -2.0) {
                        u_sangat_rendah = (-2.0 - thetaSoal) / (-2 - (-4));
                        alpha = u_sangat_rendah;
                        thetaAwalTigaSoal = -2 * (1 + alpha);

                        sum_alpha += alpha;
                        sum_theta_x_alpha += alpha * thetaAwalTigaSoal;
                    }
                    if (thetaSoal <= -4) {
                        u_sangat_rendah = 1.0;
                        alpha = u_sangat_rendah;
                        thetaAwalTigaSoal = alpha;

                        sum_alpha += alpha;
                        sum_theta_x_alpha += alpha * thetaAwalTigaSoal;
                    }
                    //}

                    //hasil perhitungan fuzzy lho ini
                    thetaHasilPerhitunganModel = sum_theta_x_alpha / sum_alpha; //===>HASIL AKHIR FUTSUHILOW
                } else if ("Fusuhilow".equals(userCredential.getMetode())) {
                    //<== MULAI PENCARIAN NILAI THETA UNTUK FUSUHILOW
                    //Sangat Tinggi
                    double st_a = 0, st_b = 0, st_c = 0;

                    if (thetaSoal >= 2 && thetaSoal <= 4) {
                        st_b = (thetaSoal - 2) / (4 - 2);
                    }

                    if (thetaSoal >= 4) {
                        st_b = 1;
                    }

                    //Tinggi
                    double t_a = 0, t_b = 0, t_c = 0, t_d = 0;
                    if (thetaSoal >= 2 && thetaSoal <= 4) {
                        t_b = (4 - thetaSoal) / (4 - 2);
                    }

                    if (thetaSoal >= 0 && thetaSoal <= 2) {
                        t_c = thetaSoal / 2;
                    }

                    //Sedang
                    double s_a = 0, s_b = 0, s_c = 0;
                    if (thetaSoal >= 0 && thetaSoal <= 2) {
                        s_b = (2 - thetaSoal) / 2;
                    }
                    if (thetaSoal >= -2 && thetaSoal <= 0) {
                        s_c = (thetaSoal + 2) / 2;
                    }

                    //Rendah
                    double r_a = 0, r_b = 0, r_c = 0;
                    if (thetaSoal >= -4 && thetaSoal <= -2) {
                        r_b = (thetaSoal + 4) / 2;
                    }
                    if (thetaSoal >= -2 && thetaSoal <= 0) {
                        r_c = -thetaSoal / 2;
                    }


                    //Sangat Rendah
                    double sr_a = 0, sr_b = 0, sr_c = 0;
                    if (thetaSoal >= -4 && thetaSoal <= -2) {
                        sr_b = (-2 - thetaSoal) / 2;
                    }

                    if (thetaSoal <= -4) {
                        sr_c = 1;
                    }

                    double sumU = 0, sumUxtheta = 0;
                    sumU = (st_a + st_b + st_c) + (t_a + t_b + t_c) + (s_a + s_b + s_c) + (r_a + r_b + r_c) + (sr_a + sr_b + sr_c);
                    sumUxtheta = (st_a + st_b + st_c) * 4.001 + (t_a + t_b + t_c) * 2.001 + (s_a + s_b + s_c) * 0.001 + (r_a + r_b + r_c) * -1.999 + (sr_a + sr_b + sr_c) * -3.999;
                    thetaHasilPerhitunganModel = sumUxtheta / sumU; //theta fusuhilow lho
                } else if ("Fumahilow".equals(userCredential.getMetode())) {
                    double st_b = 0, st_c = 0, t_b = 0, t_c = 0, s_b = 0, s_c = 0, r_b = 0, r_c = 0, sr_b = 0, sr_c = 0;

                    //sangat tinggi
                    if (thetaSoal >= 2 && thetaSoal <= 4) {
                        st_b = (thetaSoal - 2) / 2;
                    }
                    if (thetaSoal >= 4) {
                        st_c = 1;
                    }
                    //tinggi
                    if (thetaSoal >= 2 && thetaSoal <= 4) {
                        t_b = (4 - thetaSoal) / 2;
                    }
                    if (thetaSoal >= 0 && thetaSoal <= 2) {
                        t_c = thetaSoal / 2;
                    }
                    //sedang
                    if (thetaSoal >= 0 && thetaSoal <= 2) {
                        s_b = (2 - thetaSoal) / 2;
                    }
                    if (thetaSoal >= -2 && thetaSoal <= 0) {
                        s_c = (thetaSoal + 2) / 2;
                    }
                    //rendah
                    if (thetaSoal >= -4 && thetaSoal <= -2) {
                        r_b = (thetaSoal + 4) / 2;
                    }
                    if (thetaSoal >= -2 && thetaSoal <= 0) {
                        r_c = (-thetaSoal) / 2;
                    }

                    //sangat rendah
                    if (thetaSoal >= -4 && thetaSoal <= -2) {
                        sr_b = (-2 - thetaSoal) / 2;
                    }
                    if (thetaSoal <= -4) {
                        sr_c = 1;
                    }

                    //NEXT process
                    double theta_st_b = 0, theta_st_c = 0, theta_t_b = 0, theta_t_c = 0, theta_s_b = 0, theta_s_c = 0, theta_r_b = 0, theta_r_c = 0, theta_sr_b = 0, theta_sr_c = 0;
                    theta_st_b = 4 * st_b;
                    theta_st_c = 4 * st_c;
                    theta_t_b = 5 * t_b;
                    theta_t_c = 5 * t_c;
                    theta_s_b = s_b;
                    theta_s_c = s_c;
                    theta_r_b = -3 * r_b;
                    theta_r_c = -3 * r_c;
                    theta_sr_b = -7 * sr_b;
                    theta_sr_c = -7 * sr_c;

                    double sumTheta = theta_st_b + theta_st_c + theta_t_b + theta_t_c + theta_s_b + theta_s_c + theta_r_b + theta_r_c + theta_sr_b + theta_sr_c;
                    double sumU = (st_b + st_c) * 1 + (t_b + t_c) * 2 + (s_b + s_c) * 2 + (r_b + r_c) * 2 + (sr_b + sr_c) * 2;
                    thetaHasilPerhitunganModel = sumTheta / sumU; //theta hasil metode fumahilow lho
                }
                //cari soal selanjutnya
                //int soal_ke = Integer.parseInt(request.getSession().getAttribute("soal_ke") + "");

                boolean jawaban_benar = soal.getJawaban().equals(jawaban);
                if (!jawaban_benar) {
                    thetaSoal -= 0.2;
                } else {
                    thetaSoal += 0.1;
                }

                //ambil soal selanjutnya

                String iddomain = request.getSession().getAttribute("iddomain") + "";
                request.getSession().setAttribute("soal_terpakai", request.getSession().getAttribute("soal_terpakai") + " and idsoal <> " + soal.getIdsoal());
                SoalModel soalSelanjutnya = new SoalModel();
                if (userCredential.getPenyajian_soal().equals("Acak")) {
                    System.out.println("acak");
                    soalSelanjutnya.getSoalSelanjutnya(thetaSoal, userCredential.getId(), request.getSession().getAttribute("soal_terpakai") + "", jawaban_benar, iddomain, null);
                } else if (userCredential.getPenyajian_soal().equals("Proporsional")) {
                    System.out.println("proporsional");
                    //rotasi skl berdasarkan prioritas
                    String skl_aktif = "";
                    skl_aktif = getNextIdSkl(skl_aktif, iddomain);
                    System.out.println("proporsional skl_aktif #1 = " + skl_aktif);
                    String skl_maks[][] = Db.getDataSet("select count(*) from skl where iddomain=" + iddomain);
                    int iSkl_maks = 0, iSkl_Counter = 0;
                    iSkl_maks = Integer.parseInt(skl_maks[0][0]);
                    System.out.println("proporsional skl_maks #1 = " + iSkl_maks);
                    boolean isAlreadyCycle = false;
                    int iCounterSKLdimajukan = 0;
                    do {
                        soalSelanjutnya.getSoalSelanjutnya(thetaSoal, userCredential.getId(), request.getSession().getAttribute("soal_terpakai") + "", jawaban_benar, iddomain, skl_aktif);

                        iSkl_Counter++;
                        if (soalSelanjutnya == null) {
                            skl_aktif = getNextIdSkl(skl_aktif, iddomain);
                            //iCounterSKLdimajukan++;
                            System.out.println("proporsional skl aktif ga ada, dimajukan ke = " + skl_aktif);
                        }

                        //SOLUTION : test with Mr. Ruk's 
                        //cyclic this : solusi agar pemilhan soal selanjutnya jika skl tidak memenuhi, diulang dari pertama
                        if (iSkl_Counter == iSkl_maks && soalSelanjutnya == null) //&& !isAlreadyCycle                           
                        {
                            System.out.println("cyclic skl : solusi u/ skl sudah habis, ulang dari awal");
                            isAlreadyCycle = true;
                            iSkl_Counter = 0;
                            iCounterSKLdimajukan++;
                        }

                    } while (soalSelanjutnya == null && iCounterSKLdimajukan < 5);//||iSkl_Counter < iSkl_maks);&& iCounterSKLdimajukan<iSkl_maks
                    //NEXT : 
                    /*
                     * ini kasusnya, soalselanjutnya habis, karena dia ngotot berusaha mencari di soal dengan skl tersebut
                     * padahal harusnya mencari di soal tersebut, namun skl direstart dari 1 lagi. karena ada kemungkinan
                     * pada skl yg lain, masih ada...
                     * 
                     */
                    System.out.println("proporsional akhir = " + skl_aktif);
                }
                if (soalSelanjutnya.getIdsoal() == null) {
                    soalSelanjutnya = null;
                }
                //System.out.printlnln("<result>true|"+soalSelanjutnya.getIdsoal()+"</result>");                
                //munculkan berhasil/tidak disini. tapi pasti berhasilll :)
                request.setAttribute("item", soalSelanjutnya);


                //Hitung SE : dari UNIVERSI CAT
                int u = 0;
                double P = 0.0; // e^(theta - b)/(1+e^(theta-b)
                double Q = 0.0;
                //double uMinusP = 0;
                double PQ = 0.0;
                double SE = 0.0;
                double sumPQ = 0.0;
                double sumUminusP = 0.0;
                double selisihSE = 0.0;
                double SEsebelumnya = 0.0;

                if (jawaban_benar) {
                    u = 1;
                }
                //thetaBaru
                //P = Math.pow(Math.E, D * (theta_akhir - b)) / (1 + Math.pow(Math.E, D * (theta_akhir - b)));
                //P = Math.pow(Math.E, D * (thetaBaru - b)) / (1 + Math.pow(Math.E, D * (thetaBaru - b)));

                //patch of perhitungan P

                if (request.getSession().getAttribute("iterasi_ke") == null) {
                    double tigaButir = Double.parseDouble("" + request.getSession().getAttribute("theta_awal_tiga_soal"));
                    P = Math.pow(Math.E, D * (tigaButir - b)) / (1 + Math.pow(Math.E, D * (tigaButir - b)));

                } else {
                    double thetaSebelumnya = Double.parseDouble(request.getSession().getAttribute("theta_sebelumnya") + "");
                    P = Math.pow(Math.E, D * (thetaSebelumnya - b)) / (1 + Math.pow(Math.E, D * (thetaSebelumnya - b)));
                }
                Q = 1 - P;
                //uMinusP = u - P;
                PQ = P * Q;

                if (soalSelanjutnya == null) {
                    System.out.println("Soal habis??");
                    soalHabis = true;
                }
                // nilai yg di-sum : u-P dan PQ
                if (request.getSession().getAttribute("sumPQ") == null) {
                    sumPQ = PQ;
                } else {
                    sumPQ = PQ + Double.parseDouble(request.getSession().getAttribute("sumPQ") + "");
                }

                /*if (request.getSession().getAttribute("sumUminusP") == null) {
                sumUminusP = uMinusP;
                } else {
                sumUminusP = uMinusP + Double.parseDouble(request.getSession().getAttribute("sumUminusP") + "");
                }*/


                request.getSession().setAttribute("sumPQ", sumPQ);
                request.getSession().setAttribute("sumUminusP", sumUminusP);


                SE = 1 / (D * (Math.sqrt(sumPQ)));

                if (request.getSession().getAttribute("iterasi_ke") != null) {
                    iterasi_ke = Integer.parseInt(request.getSession().getAttribute("iterasi_ke") + "");
                }
                if (iterasi_ke == 1 && !soalHabis) {
                    System.out.println("soal berikutnya;" + soalSelanjutnya.getIdsoal());
                } else {
                    if (!soalHabis) {

                        System.out.println("SEsebelumnya = " + SEsebelumnya);
                        if (request.getSession().getAttribute("SEsebelumnya") != null) {
                            System.out.println("SEnya ada = " + SEsebelumnya);
                            SEsebelumnya = Double.parseDouble(request.getSession().getAttribute("SEsebelumnya") + "");
                        }

                        selisihSE = Math.abs(SE - SEsebelumnya);
                        System.out.println("selisih SE " + selisihSE);

                        DecimalFormat twoDForm = new DecimalFormat("#.##");
                        double selisihSE2digit = Double.valueOf(twoDForm.format(selisihSE));

                        if (selisihSE2digit <= 0.01) {//selisihSE
                            System.out.println("selesai ujian, penaksiran konvergen;");
                        } else {
                            System.out.println("soal berikutnya;" + soalSelanjutnya.getIdsoal());
                        }
                    } else {
                        if (iterasi_ke > 1) {
                            SEsebelumnya = Double.parseDouble(request.getSession().getAttribute("SEsebelumnya") + "");
                            selisihSE = Math.abs(SE - SEsebelumnya);
                            System.out.println("SEnya ada = " + SEsebelumnya);
                            System.out.println("Soal habis");
                            System.out.println("soal habis;");
                        } else {
                            System.out.println("soal habis;");
                        }
                    }
                }

                if (soalSelanjutnya != null) {
                    System.out.println("soal selanjutnya = " + soalSelanjutnya.getIdsoal());
                } else {
                    System.out.println("soal habis");
                }

                //menghitung theta yg baru :
                double thetaBaru;
                thetaBaru = thetaHasilPerhitunganModel + (sumUminusP / D * sumPQ);

                System.out.println("xtheta + (sumUminusP /D*sumPQ) = " + thetaHasilPerhitunganModel + "(" + sumUminusP + "/" + D * sumPQ + ")");
                request.getSession().setAttribute("theta", thetaBaru);
                System.out.println("xtheta(" + iterasi_ke + ")=" + thetaBaru);

                iterasi_ke++;

                request.getSession().setAttribute("iterasi_ke", iterasi_ke);
                System.out.println("100 / 8=" + 100 / 8);


                skor = (pengali * thetaBaru) + 50;//=((100/8)*L13)+50
                System.out.println("skor = ((100 / 8) * " + thetaBaru + ") + 50=" + skor);//=((100/8)*L13)+50
                System.out.println("skor = " + skor);
                System.out.println();

                /*
                 * String sql = "insert into test_soal(" +
                "idtest,idsoal,nilai," +
                "thetaAwal,b,P,Q," +
                "uMinusP,PQ,SE," +
                "SelisihSE,ThetaAkhir,Skor" +
                ") values(" +
                idtest + "," + idsoal + "," + u + "," +
                theta + "," + b + "," + P + "," + Q + "," +
                uMinusP + "," + PQ + "," + SE + "," +
                selisihSE + "," + thetaBaru + "," + skor +
                ")";
                 */
                String theta_awal_tiga_soal;
                double theta_sebelumnya;
                System.out.println("iterasi_ke = " + iterasi_ke);
                if (iterasi_ke == 1) {
                    theta_awal_tiga_soal = request.getSession().getAttribute("theta_awal_tiga_soal") + "";
                    theta_sebelumnya = Double.parseDouble(theta_awal_tiga_soal);//0
                    System.out.println("theta awal tiga soal = " + thetaAwalTigaSoal);
                    request.getSession().setAttribute("theta_sebelumnya", thetaBaru);
                } else {
                    theta_sebelumnya = Double.parseDouble(request.getSession().getAttribute("theta_sebelumnya") + "");
                    request.getSession().setAttribute("theta_sebelumnya", thetaBaru);
                }


                String waktu = request.getParameter("waktu");
                //hitung sisa waktu 3menit - waktu
                //borrowed from http://en.allexperts.com/q/Java-1046/substract-time-values-java.htm
                DateFormat df = new SimpleDateFormat("mm:ss");
                Date date2 = df.parse("03:00");
                Date date1 = df.parse(waktu);
                long remainder = date2.getTime() - date1.getTime();
                if (request.getSession().getAttribute("SEsebelumnya") != null) {
                    SEsebelumnya = Double.parseDouble(request.getSession().getAttribute("SEsebelumnya") + "");
                } else {
                    SEsebelumnya = 0;
                }

                String sselisihSE;
                selisihSE = Math.abs(SE - SEsebelumnya);
                //request.getSession().setAttribute("SEsebelumnya",SE);
                if (iterasi_ke == 1) {
                    sselisihSE = "0";
                } else {
                    sselisihSE = selisihSE + "";
                }
                DecimalFormat twoDForm = new DecimalFormat("#.##");
                double selisihSE2digit = Double.valueOf(twoDForm.format(selisihSE));

                isSukses = isSukses && Db.executeQuery(
                        "insert into peserta_test_jawaban_dengan_model ("
                        + "idsoal,idpeserta_test,jawaban,nilai,"
                        + "thetaAwal,b,P,Q,"
                        + "PQ,SE,"
                        + "SelisihSE,ThetaAkhir,Skor,waktu"
                        + ") "
                        + "values ('" + idsoal + "','" + idpeserta_test + "','" + jawaban + "',"
                        + u + ","
                        + theta_sebelumnya + "," + b + "," + P + "," + Q + ","
                        + +PQ + "," + SE + ","
                        + selisihSE2digit + "," + thetaBaru + "," + skor + ",'" + df.format(remainder) + "'"
                        + ")");

                System.out.println("eko SEsebelumnya = " + request.getSession().getAttribute("SEsebelumnya") + ", SE = " + SE);
                request.getSession().setAttribute("SEsebelumnya", SE);



                if (selisihSE2digit <= 0.01) {
                    //simpan hasil jawaban disini
                    System.out.println("selisihSE selesai... = " + selisihSE + ", SE = " + SE + ", SESeblumnya = ");
                    //selesai satu domain, ada link ke menu domaain
                    index("peserta_test/pengerjaan_soal_selesai.jsp");
                } else {
                    index("peserta_test/pengerjaan_soal.jsp");
                }

                Logger.getLogger(Db.class.getName()).log(Level.SEVERE, "Soal " + soal.getSoal() + ", rasch_b = " + soal.getRasch_b() + ", theta =" + thetaHasilPerhitunganModel + ", kunci = " + soal.getJawaban() + ", jawaban= " + jawaban + "  jawaban_benar = " + jawaban_benar + ",  soal selanjutnya idsoal = " + (soalSelanjutnya == null ? "KOSONG" : soalSelanjutnya.getIdsoal()) + ", rasch_b = " + (soalSelanjutnya == null ? "KOSONG" : soalSelanjutnya.getRasch_b()));
            } else {
                System.out.print("<result>false</result>");
            }
        } catch (ParseException ex) {
            Logger.getLogger(AmbilUjian.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            out.flush();
            out.close();
        }
    }

    private String getNextIdSkl(String skl_aktif, String iddomain) throws NumberFormatException {
        if (request.getSession().getAttribute("skl") == null) {
            String[][] skl_pertama = Db.getDataSet("select idskl from skl where iddomain = " + iddomain + " and prioritas=1");
            skl_aktif = skl_pertama[0][0];
            request.getSession().setAttribute("skl", skl_aktif);
        } else {
            skl_aktif = "" + request.getSession().getAttribute("skl") + "";
            String prioritas_skl_aktif[][] = Db.getDataSet("select prioritas from skl where idskl=" + skl_aktif);
            int iSkl_selanjutnya = Integer.parseInt(prioritas_skl_aktif[0][0]) + 1;
            //roling skl
            String[][] skl_selanjutnya = Db.getDataSet("select idskl from skl where iddomain = " + iddomain + " and prioritas=" + iSkl_selanjutnya);
            if (skl_selanjutnya.length > 0) {
                skl_aktif = skl_selanjutnya[0][0];
                request.getSession().setAttribute("skl", skl_aktif);
            } else {
                //kalau tidak ada nilai selanjutnya, maka kembali ke SKL pertama kali
                String[][] skl_pertama = Db.getDataSet("select idskl from skl where iddomain = " + iddomain + " and prioritas=1");
                skl_aktif = skl_pertama[0][0];
                request.getSession().setAttribute("skl", skl_aktif);
            }
        }

        return skl_aktif;
    }
}
