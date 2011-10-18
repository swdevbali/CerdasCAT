package application.controllers;

import application.models.PesertaTestModel;
import application.models.SoalModel;
import java.util.Iterator;
import recite18th.controller.Controller;
import java.io.*;
import recite18th.library.Db;
import application.config.Config;
import application.models.DomainModel;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import recite18th.util.LoginUtil;

/**
 * @author Rukli
 * Kelas ini untuk membuka halaman About.jsp
 */
public class AmbilUjian extends Controller {

    private static final String page0 = "peserta_test/mulai_ujian_tanpa_model_tanpa_metode_penyajian_tetap.jsp";
    private static final String page1 = "peserta_test/mulai_ujian_rasch_futsuhilow_penyajian_proporsional.jsp";
    private double D = 1;
    double pengali = 12.5;

    public AmbilUjian() {
        //TODO : I have and Idea to check the security here... 
        controllerName = "AmbilUjian";
    }

    public void mulaiUjianDomain(String iddomain) {
        PesertaTestModel userCredential = (PesertaTestModel) LoginUtil.getLogin(request);

        request.getSession().setAttribute("iddomain", iddomain);
        request.getSession().removeAttribute("skl");
        if ("Tidak Ada".equals(userCredential.getMetode())) //KASUS PENYAJIAN SOAL TETAP
        {
            request.setAttribute("row_idsoal", (new SoalModel()).getSoalUntukSiswa(userCredential.getId(), iddomain));
            index(page0);
        } else if ("Futsuhilow".equals(userCredential.getMetode())) {
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
    public void jawabSoal(String idsoal, String jawaban) {
        PesertaTestModel userCredential = (PesertaTestModel) LoginUtil.getLogin(request);
        String idpaket_soal = "" + userCredential.getIdpaket_soal();
        String idpeserta_test = "" + userCredential.getId();
        //hapus dulu jawaban yang lama
        boolean isSukses = Db.executeQuery("delete from paket_soal_jawaban where idpaket_soal='" + idpaket_soal + "' and idsoal='" + idsoal + "' and idpeserta_test='" + idpeserta_test + "'");

        isSukses = isSukses && Db.executeQuery("insert into paket_soal_jawaban(idpaket_soal,idsoal,idpeserta_test,jawaban) values ('" + idpaket_soal + "','" + idsoal + "','" + idpeserta_test + "','" + jawaban + "')");

        PrintWriter out = null;
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
        }
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

        //hitung tingkat kesukaran
        String tingkat_kesukaran;
        if (isSoal1Benar && isSoal2Benar && isSoal3Benar) {
            tingkat_kesukaran = "Sangat Tinggi";
        } else if ((isSoal1Benar && isSoal2Benar) || isSoal1Benar || (isSoal1Benar && isSoal3Benar)) {
            tingkat_kesukaran = "Tinggi";
        } else if ((isSoal2Benar && isSoal3Benar) || isSoal2Benar) {
            tingkat_kesukaran = "Sedang";
        } else if (isSoal3Benar) {
            tingkat_kesukaran = "Rendah";
        } else {
            tingkat_kesukaran = "Sangat Rendah";
        }

        //simpan ke basisdata
        Db.executeQuery("update peserta_test set tingkat_kesukaran='" + tingkat_kesukaran + "' where id ='" + userCredential.getId() + "'");

        //forward
        //pilih soal pertama berdasarkan tingkat kesukaran, urut berdasarkan b (rasch_b) menurun, yg paling atas adalah calon soal berikutnya....
        //SELECT idsoal,rasch_b FROM soal where rasch_b <=2 and idsoal<>9 and idsoal<>10 and idsoal<>8 order by rasch_b desc

        //jawab soal pertama

        SoalModel soalPertama = new SoalModel();
        soalPertama.getSoalPertama(tingkat_kesukaran, userCredential.getId(), iddomain);
        request.getSession().setAttribute("skl", soalPertama.getIdskl());
        request.getSession().setAttribute("theta_awal_tiga_soal", (Double.parseDouble(soalPertama.getRasch_b())));
        request.getSession().setAttribute("soal_ke", 1);
        request.getSession().removeAttribute("iterasi_ke");
        request.getSession().removeAttribute("theta_awal");
        request.setAttribute("item", soalPertama);
        
        //hapus jawaban yg sudah ada 
        Db.executeQuery("delete from peserta_test_jawaban_dengan_model where idpeserta_test="+userCredential.getId());
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
        String idpaket_soal = "" + userCredential.getIdpaket_soal();
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
                Double tingkat_kesukaran = Double.parseDouble(soal.getRasch_b());
                String hasil_tingkat_kesukaran = "", hasil_theta = "";
                Double u_sangat_rendah, u_rendah, u_sedang = null, u_tinggi = null, u_sangat_tinggi = null;

                double alpha = 0.0;
                double theta = 0.0;
                double theta_akhir = 0.0;
                double sum_alpha = 0.0;
                double sum_theta_x_alpha = 0.0;

                //sangat tinggi
                if (tingkat_kesukaran >= 2 && tingkat_kesukaran <= 4) {
                    hasil_tingkat_kesukaran = "sangat tinggi";
                    if (tingkat_kesukaran <= 2) {
                        u_sangat_tinggi = 0.0;
                        alpha = u_sangat_tinggi;
                        theta = u_sangat_tinggi;

                        sum_alpha += alpha;
                        sum_theta_x_alpha += alpha * theta;

                    } else if (tingkat_kesukaran >= 2 && tingkat_kesukaran <= 4) {
                        u_sangat_tinggi = (tingkat_kesukaran - 2.0) / (4.0 - 2.0);
                        alpha = u_sangat_tinggi;
                        theta = (alpha * 2) + 2;

                        sum_alpha += alpha;
                        sum_theta_x_alpha += alpha * theta;
                    } else if (tingkat_kesukaran >= 4) {
                        u_sangat_tinggi = 1.0;
                        alpha = u_sangat_tinggi;
                        theta = 1.0;

                        sum_alpha += alpha;
                        sum_theta_x_alpha += alpha * theta;
                    }

                }

                //tinggi
                //if (tingkat_kesukaran >= 0 && tingkat_kesukaran <= 4) {
                //  hasil_tingkat_kesukaran = "tinggi";
                if (tingkat_kesukaran >= 4) {
                    u_tinggi = 0.0;
                    alpha = u_tinggi;
                    theta = u_tinggi;

                    sum_alpha += alpha;
                    sum_theta_x_alpha += alpha * theta;

                }
                if (tingkat_kesukaran >= 2.0 && tingkat_kesukaran <= 4.0) {
                    u_tinggi = (4.0 - tingkat_kesukaran) / (4.0 - 2.0);
                    alpha = u_tinggi;
                    theta = 4.0 - (alpha * 2.0);

                    sum_alpha += alpha;
                    sum_theta_x_alpha += alpha * theta;
                }
                if (tingkat_kesukaran >= 0 && tingkat_kesukaran <= 2) {
                    u_tinggi = tingkat_kesukaran / 2.0;
                    alpha = u_tinggi;
                    theta = alpha * 2.0;

                    sum_alpha += alpha;
                    sum_theta_x_alpha += alpha * theta;

                }
                if (tingkat_kesukaran <= 0.0) {
                    u_tinggi = 0.0;
                    alpha = u_tinggi;
                    theta = u_tinggi;

                    sum_alpha += alpha;
                    sum_theta_x_alpha += alpha * theta;
                }
                //}

                // sedang
                // if (tingkat_kesukaran >= -2 && tingkat_kesukaran <= 2) {
                //   hasil_tingkat_kesukaran = "sedang";
                if (tingkat_kesukaran >= 2.0) {
                    u_sedang = 0.0;
                    alpha = u_sedang;
                    theta = u_sedang;

                    sum_alpha += alpha;
                    sum_theta_x_alpha += alpha * theta;
                }
                if (tingkat_kesukaran >= 0.0 && tingkat_kesukaran <= 2.0) {
                    u_sedang = (2.0 - tingkat_kesukaran) / 2.0;
                    alpha = u_sedang;
                    theta = 2.0 * (1.0 - alpha);

                    sum_alpha += alpha;
                    sum_theta_x_alpha += alpha * theta;
                }
                if (tingkat_kesukaran >= -2.0 && tingkat_kesukaran <= 0.0) {
                    u_sedang = (tingkat_kesukaran - (-2.0)) / (0.0 - (-2.0));
                    alpha = u_sedang;
                    theta = 2.0 * (alpha - 1.0);

                    sum_alpha += alpha;
                    sum_theta_x_alpha += alpha * theta;
                }
                if (tingkat_kesukaran <= -2) {
                    u_sedang = 0.0;
                    alpha = u_sedang;
                    theta = u_sedang;

                    sum_alpha += alpha;
                    sum_theta_x_alpha += alpha * theta;
                }
                //}

                //rendah
                //if (tingkat_kesukaran >= -4 && tingkat_kesukaran <= 0) {
                //  hasil_tingkat_kesukaran = "rendah";
                if (tingkat_kesukaran >= 0.0) {
                    u_rendah = 0.0;
                    alpha = u_rendah;

                    sum_alpha += alpha;
                    sum_theta_x_alpha += alpha * theta;
                }
                if (tingkat_kesukaran > -2.0 && tingkat_kesukaran <= 0.0) {
                    u_rendah = (0.0 - tingkat_kesukaran) / (0.0 - (-2.0));
                    alpha = u_rendah;
                    theta = -2.0 * alpha;


                    sum_alpha += alpha;
                    sum_theta_x_alpha += alpha * theta;
                }
                if (tingkat_kesukaran >= -4 && tingkat_kesukaran <= -2) {

                    u_rendah = (tingkat_kesukaran - (-4.0)) / (-2.0 - (-4.0));
                    alpha = u_rendah;
                    theta = 2.0 * (alpha - 2.0);

                    sum_alpha += alpha;
                    sum_theta_x_alpha += alpha * theta;
                }
                if (tingkat_kesukaran <= -4.0) {
                    u_rendah = 0.0;
                    alpha = u_rendah;
                    theta = u_rendah;

                    sum_alpha += alpha;
                    sum_theta_x_alpha += alpha * theta;
                }
                //}

                //sangat rendah
                //if (tingkat_kesukaran >= -4 && tingkat_kesukaran <= -2) {
                //  hasil_tingkat_kesukaran = "sangat rendah";
                if (tingkat_kesukaran >= -2.0) {
                    u_sangat_rendah = 0.0;
                    alpha = u_sangat_rendah;
                    theta = 0.0;

                    sum_alpha += alpha;
                    sum_theta_x_alpha += alpha * theta;
                }
                if (tingkat_kesukaran >= -4.0 && tingkat_kesukaran <= -2.0) {
                    u_sangat_rendah = (-2.0 - tingkat_kesukaran) / (-2 - (-4));
                    alpha = u_sangat_rendah;
                    theta = -2 * (1 + alpha);

                    sum_alpha += alpha;
                    sum_theta_x_alpha += alpha * theta;
                }
                if (tingkat_kesukaran <= -4) {
                    u_sangat_rendah = 1.0;
                    alpha = u_sangat_rendah;
                    theta = alpha;

                    sum_alpha += alpha;
                    sum_theta_x_alpha += alpha * theta;
                }
                //}

                //hasil perhitungan fuzzy lho ini
                theta_akhir = sum_theta_x_alpha / sum_alpha;

                //cari soal selanjutnya
                int soal_ke = Integer.parseInt(request.getSession().getAttribute("soal_ke") + "");

                boolean jawaban_benar = soal.getJawaban().equals(jawaban);
                if (!jawaban_benar) {
                    tingkat_kesukaran -= 0.2;
                } else {
                    tingkat_kesukaran += 0.1;
                }

                //ambil soal selanjutnya

                String iddomain = request.getSession().getAttribute("iddomain") + "";
                request.getSession().setAttribute("soal_terpakai", request.getSession().getAttribute("soal_terpakai") + " and idsoal <> " + soal.getIdsoal());
                SoalModel soalSelanjutnya = new SoalModel();
                if (userCredential.getPenyajian_soal().equals("Acak")) {
                    System.out.println("acak");
                    soalSelanjutnya.getSoalSelanjutnya(tingkat_kesukaran, userCredential.getId(), request.getSession().getAttribute("soal_terpakai") + "", jawaban_benar, iddomain, null);
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
                    do {
                        soalSelanjutnya.getSoalSelanjutnya(tingkat_kesukaran, userCredential.getId(), request.getSession().getAttribute("soal_terpakai") + "", jawaban_benar, iddomain, skl_aktif);
                        iSkl_Counter++;
                        
                        

                        if (soalSelanjutnya == null) {
                            skl_aktif = getNextIdSkl(skl_aktif, iddomain);
                            System.out.println("proporsional skl aktif ga ada, dimajukan ke = " + skl_aktif);
                        }
                        
                    } while (soalSelanjutnya == null || iSkl_Counter < iSkl_maks);
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
                double P = 0; // e^(theta - b)/(1+e^(theta-b)
                double Q = 0;
                //double uMinusP = 0;
                double PQ = 0;
                double SE = 0;
                double sumPQ = 0;
                double sumUminusP = 0;
                double selisihSE = 0;
                double SEsebelumnya = 0;

                if (jawaban_benar) {
                    u = 1;
                }
                P = Math.pow(Math.E, D * (theta_akhir - b)) / (1 + Math.pow(Math.E, D * (theta_akhir - b)));
                //P = Math.pow(Math.E,D*(theta - b)) / (1 + Math.pow(Math.E,D*(theta - b)));
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
                        if (selisihSE <= 0.01) {
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
                thetaBaru = theta_akhir + (sumUminusP / D * sumPQ); // theta + 
                System.out.println("xtheta + (sumUminusP /D*sumPQ) = " + theta_akhir + "(" + sumUminusP + "/" + D * sumPQ + ")");
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
                    theta_sebelumnya = 0;//Double.parseDouble(theta_awal_tiga_soal);
                    System.out.println("theta awal tiga soal = " + theta);
                    request.getSession().setAttribute("theta_sebelumnya", thetaBaru);
                } else {
                    theta_sebelumnya = Double.parseDouble(request.getSession().getAttribute("theta_sebelumnya") + "");
                    request.getSession().setAttribute("theta_sebelumnya", thetaBaru);
                }

                
                String waktu = request.getParameter("waktu");
                selisihSE = Math.abs(SE - SEsebelumnya);
                isSukses = isSukses && Db.executeQuery(
                        "insert into peserta_test_jawaban_dengan_model (" +
                        "idsoal,idpeserta_test,jawaban,nilai," +
                        "thetaAwal,b,P,Q," +
                        "PQ,SE," +
                        "SelisihSE,ThetaAkhir,Skor,waktu" +
                        ") " +
                        "values ('" + idsoal + "','" + idpeserta_test + "','" + jawaban + "'," +
                        u + "," +
                        theta_sebelumnya + "," + b + "," + P + "," + Q + "," +
                        +PQ + "," + SE + "," +
                        selisihSE + "," + thetaBaru + "," + skor + ",'" + waktu + "'" +
                        ")");

                System.out.println("eko SEsebelumnya = " + request.getSession().getAttribute("SEsebelumnya") + ", SE = " + SE);
                request.getSession().setAttribute("SEsebelumnya", SE);
                if (selisihSE <= 0.01) {
                    //simpan hasil jawaban disini
                    System.out.println("selisihSE selesai... = " + selisihSE + ", SE = " + SE + ", SESeblumnya = ");
                    //selesai satu domain, ada link ke menu domaain
                    index("peserta_test/pengerjaan_soal_selesai.jsp");
                } else {
                    index("peserta_test/pengerjaan_soal.jsp");
                }

                Logger.getLogger(Db.class.getName()).log(Level.SEVERE, "Soal " + soal.getSoal() + ", rasch_b = " + soal.getRasch_b() + ", theta =" + theta_akhir + ", kunci = " + soal.getJawaban() + ", jawaban= " + jawaban + "  jawaban_benar = " + jawaban_benar + ",  soal selanjutnya idsoal = " + (soalSelanjutnya == null ? "KOSONG" : soalSelanjutnya.getIdsoal()) + ", rasch_b = " + (soalSelanjutnya == null ? "KOSONG" : soalSelanjutnya.getRasch_b()));
            } else {
                System.out.print("<result>false</result>");
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            out.flush();
            out.close();
        }
    }

    private String getNextIdSkl(String skl_aktif, String iddomain) throws NumberFormatException {
        if (request.getSession().getAttribute("skl") == null) {
            //ambil skl pertama
            String[][] skl_pertama = Db.getDataSet("select idskl from skl where iddomain = " + iddomain + " and prioritas=1");
            skl_aktif = skl_pertama[0][0];
            request.getSession().setAttribute("skl", skl_aktif);
        } else {
            skl_aktif = "" + request.getSession().getAttribute("skl") + "";
            String prioritas_skl_aktif[][] = Db.getDataSet("select prioritas from skl where idskl="+skl_aktif);
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
