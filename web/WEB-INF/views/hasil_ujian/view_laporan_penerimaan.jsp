<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,recite18th.library.Db,application.config.Config,recite18th.library.Pagination,java.text.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<%
    String message = "";
    int pagenum;
    pagenum = request.getParameter("pagenum") == null ? 0 : Integer.parseInt(request.getParameter("pagenum") + "");
    NumberFormat format = DecimalFormat.getInstance();
%>
<!DOCTYPE HTML>
<html><!-- InstanceBegin template="/Templates/home.dwt" codeOutsideHTMLIsLocked="false" -->
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- InstanceBeginEditable name="doctitle" -->
        <title>Aplikasi Cerdas CAT</title>
        <!-- InstanceEndEditable -->
        <link rel="shortcut icon" type="image/png" href="<%=Config.base_url%>_desain/favicon.png">
        <script src="<%=Config.base_url%>res/js/jquery-1.5.1.js"></script>
        <script src="<%=Config.base_url%>res/js/jquery.tools.min.js"></script>
        <link rel="stylesheet" type="text/css" href="<%=Config.base_url%>_desain/index.css" media="all">

        <!-- InstanceBeginEditable name="head" --><!-- InstanceEndEditable -->
        <script>
            // What is $(document).ready ? See: http://flowplayer.org/tools/documentation/basics.html#document_ready
            $(document).ready(function() {

                // initialize scrollable together with the autoscroll plugin
                var root = $("#scroller").scrollable({circular: true}).autoscroll({ autoplay: true });

                // provide scrollable API for the action buttons
                window.api = root.data("scrollable");

	
            });
        </script>


        <style type="text/css">
            <!--
            .style1 {
                color: #FFFFFF;
                font-weight: bold;
                font-family: Verdana, Arial, Helvetica, sans-serif;
            }
            -->
        </style>
    </head>
    <body class="">

        <div id="header">
            <div class="wrapper">	
                <h2 id="logo">&nbsp;</h2>
                <ul id="menu">
                    <li class="">
                        <a href="<%=Config.base_url%>index/main">Home</a><span>&gt;</span>
                    </li>
                    <li class="">
                        <a href="<%=Config.base_url%>index/help">Help</a><span>&gt;</span>
                    </li>
                    <li class="">
                        <a href="<%=Config.base_url%>index/about">About</a><span>&gt;</span>
                    </li>
                </ul>
            </div>		
        </div>

        <div id="top">
            <p align="left" class="category">Computerized Adaptive Testing Cerdas
                <c:if test="${user_credential==null}" >  
                    <img src="<%=Config.base_url%>/_desain/header.jpg" width="943" height="303"> </p>
                <!--<div class="scrollable" id="scroller"align="center">   


<div class="items">
<div>
<div>
<div align="center"><img src="http://farm1.static.flickr.com/143/321464099_a7cfcb95cf_t.jpg" />
<img src="http://farm4.static.flickr.com/3089/2796719087_c3ee89a730_t.jpg" />
<img src="http://farm1.static.flickr.com/79/244441862_08ec9b6b49_t.jpg" />
<img src="http://farm1.static.flickr.com/28/66523124_b468cf4978_t.jpg" />
<img src="http://farm1.static.flickr.com/164/399223606_b875ddf797_t.jpg" />
</div>
</div>
</div>
</div>
</div>-->

            </div>
        </c:if>

        <div class="wrapper">
            <c:if test="${user_credential!=null}" >
                <div id="docSidebar">
                    <h2>${user_credential.username}</h2>
                    <p>&nbsp;</p>
                    <div id="toc">
                        <ul>
                            <c:if test="${user_credential.peran=='Admin'}" >         
                                <li>Kelola Pengguna
                                    <ul>
                                        <li><a href="<%=Config.base_url%>index/admin/index">Admin</a></li>
                                        <li><a href="<%=Config.base_url%>index/Pimpinan/index">Pimpinan</a></li>
                                        <li><a href="<%=Config.base_url%>index/pengajar/index">Pengajar</a></li>
                                        <li><a href="<%=Config.base_url%>index/PesertaTest/index">Peserta Test</a></li>
                                        <li><a href="<%=Config.base_url%>index/WaliPesertaTest/index">Wali Peserta Test </a>   </li>   			             		
                                    </ul>
                                </li>
                                <li><a href="<%=Config.base_url%>index/Domain/index">Kelola Domain</a></li>
                                <li><a href="<%=Config.base_url%>index/Skl/index">Standar Kompetensi Lulus</a></li>
                                <li>Paket Soal
                                    <ul>
                                        <li><a href="<%=Config.base_url%>index/PaketSoal/index">Penyajian Tetap</a></li>		
                                        <li><a href="<%=Config.base_url%>index/PaketSoalTigaButir/index">Paket Tiga Butir Soal</a></li>						
                                        <li><a href="<%=Config.base_url%>index/PenentuanDomainSoal/index">Penentuan Domain Soal bagi Siswa</a></li>									
                                    </ul>
                                </li>
                                <li><a href="<%=Config.base_url%>index/login/logout">Logout</a></li> 
                            </c:if>
                            <c:if test="${user_credential.peran=='Kepala Sekolah'}" >
                                <li><a href="<%=Config.base_url%>index/pimpinan/bukaFormInputKonfigurasi">Konfigurasi Penerimaan</a></li>
                                <li><a href="<%=Config.base_url%>index/pimpinan/pembobotan_skl">Pembobotan SKL</a></li> 
                                <li><a href="<%=Config.base_url%>index/pimpinan/pembobotan_domain">Pembobotan Domain</a></li> 
                                <li><a href="<%=Config.base_url%>index/pimpinan/pembobotan_kriteria">Pembobotan Kriteria Penilaian</a></li> 
                                <li><a href="<%=Config.base_url%>index/LihatHasilTest/laporanPenerimaan">Laporan Penerimaan </a></li>
                                <li><a href="<%=Config.base_url%>index/login/logout">Logout</a></li> 
                            </c:if>
                            <c:if test="${user_credential.peran=='Pengajar'}" >        
                                <li><a href="<%=Config.base_url%>index/soal/index">Kelola Soal</a></li>
                                <li><a href="<%=Config.base_url%>index/pengajar/bukaViewInputPenilaian/-1">Input Penilaian</a></li> 
                                <li><a href="<%=Config.base_url%>index/LihatHasilTest/laporanPengajarRasch">Laporan Hasil Ujian Model Rasch</a></li>
                                <li><a href="<%=Config.base_url%>index/LihatHasilTest/laporanPenerimaan">Laporan Penerimaan </a></li>		
                                <li><a href="<%=Config.base_url%>index/login/logout">Logout</a></li> 
                            </c:if>		
                            <c:if test="${user_credential.peran=='Peserta Test'}" >        
                                <c:if test="${user_credential.verified==0}" >
                                    <li><a href="<%=Config.base_url%>index/SignUp/index">Verifikasi</a></li>
                                </c:if>
                                <c:if test="${user_credential.verified==1}"> 	
                                    <li><a href="<%=Config.base_url%>index/AmbilUjian/index">Ambil Ujian</a></li> 				 	
                                    <li><a href="<%=Config.base_url%>index/LihatHasilTest">Lihat Hasil Ujianku</a></li> 				 		</c:if>
                                <li><a href="<%=Config.base_url%>index/LihatHasilTest/laporanPenerimaan">Laporan Penerimaan </a></li>
                                <li><a href="<%=Config.base_url%>index/login/logout">Logout</a></li> 
                            </c:if>		 
                            <c:if test="${user_credential.peran=='Wali Peserta Test'}" >        
                                <li><a href="<%=Config.base_url%>index/LihatHasilTest/laporanPenerimaan">Laporan Penerimaan </a></li>
                                <li><a href="<%=Config.base_url%>index/login/logout">Logout</a></li> 
                            </c:if>

                    </div>

                    <h2>&nbsp;</h2>
                    <h2>&nbsp;</h2>
                    <div id="searchBox"></div>

                </div><!-- docsidebar -->
            </c:if>	
            <div id="pageContent">

                <div class="wikistyle">
                    <h1 id="Startinguptheproject"><!-- InstanceBeginEditable name="judul_modul" -->Laporan Penerimaan <!-- InstanceEndEditable --></h1>
                    <!-- InstanceBeginEditable name="isi_modul" -->
                    <% //this is all the code that need to be done
                        String peserta[][] = Db.getDataSet("SELECT id, nomor_peserta, nama_lengkap,asal,inisialisasi_kemampuan,model_logistik,metode,penyajian_soal FROM peserta_test p where inisialisasi_kemampuan='Tiga Butir' and model_logistik='Rasch' and metode='Futsuhilow' and penyajian_soal='Proporsional' order by nomor_peserta");
                    %>
                    <% if (peserta.length == 0) {%>
                    Tidak ada data laporan yang bisa ditampilkan
                    <%                } else {
                        double skor_minimum = 0;
                        int kuota_maksimum = 0;
                        String data[][] = Db.getDataSet("select skor_minimum,kuota from konfigurasi");
                        skor_minimum = Double.parseDouble(data[0][0]);
                        kuota_maksimum = Integer.parseInt(data[0][1]);
                    %>
                    <p id="aIntroductiona">&nbsp;</p>
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" bordercolor="#666666">
                        <tr>
                            <td colspan="2"><div align="center"><strong>LAPORAN PENERIMAAN </strong></div></td>
                        </tr>
                        <tr>
                            <td width="49%">Inisialisasi</td>
                            <td width="51%"><%=peserta[0][4]%></td>
                        </tr>
                        <tr>
                            <td>Model</td>
                            <td><%=peserta[0][5]%></td>
                        </tr>
                        <tr>
                            <td>Metode</td>
                            <td><%=peserta[0][6]%></td>
                        </tr>
                        <tr>
                            <td>Penyajian Soal </td>
                            <td><%=peserta[0][7]%></td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>Skor Minimum</td>
                            <td><%=skor_minimum%></td>
                        </tr>
                        <tr>
                            <td>Kuota Maksimum</td>
                            <td><%=kuota_maksimum%></td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                    <br/>

                    <%

                            //tabel bobot penilaian
                            String bobotKriteria[][] = Db.getDataSet("SELECT idpenilaian,bobot FROM penilaian");
                            int i = 0;
                            int jumlah_peserta = 0;
                            double totalNilaiDomain = 0;
                            double totalSkorDomain = 0;
                            for (i = 0; i < peserta.length; i++) {
                                //hitung Nilai Pembobotan
                                //ambil domain yang dipakai pada soal peserta ini
                                String sql = "SELECT d.iddomain,d.domain FROM peserta_test_jawaban_dengan_model p,soal s,domain d where p.idpeserta_test=" + peserta[i][0] + " and p.idsoal=s.idsoal and s.iddomain = d.iddomain and d.iddomain  in (select iddomain from konfigurasi_domain) group by d.iddomain";
                                String domain[][] = Db.getDataSet(sql);
                                //if(domain.length<3) continue;/* quick fix */
                                jumlah_peserta++;
                                totalNilaiDomain = 0;
                                totalSkorDomain = 0;
                                for (int idomain = 0; idomain < domain.length; idomain++) {
                                    //ambil bobot domain 
                                    String bobotDomain[][] = Db.getDataSet("select bobot from pembobotan_domain where iddomain=" + domain[idomain][0]);
                                    int iBobotDomain = Integer.parseInt(bobotDomain[0][0]);
                                    //ambil skl tiap domain
                                    String skl[][] = Db.getDataSet("select nama_skl from skl where iddomain = " + domain[idomain][0]);
                                    double bobot_skl = 0;

                                    /* quick fix */
                                    int jum_domain = 0;
                                    double nilaiDomain = 0;
                                    for (int iskl = 0; iskl < skl.length; iskl++) {
                                        String query_bobot_skl = "SELECT skl.nama_skl, sum(p.skor) as total_skor,ps.bobot  FROM peserta_test_jawaban_dengan_model p,soal s, domain d, skl,pembobotan_skl ps  where skl.idskl=ps.idskl and skl.nama_skl='" + skl[iskl][0] + "'  and s.idskl=skl.idskl and p.idsoal = s.idsoal and s.iddomain = d.iddomain and d.iddomain=" + domain[idomain][0] + " and idpeserta_test=" + peserta[i][0] + " group by skl.nama_skl  order by idpeserta_test_jawaban_dengan_model";
                                        //out.print(query_bobot_skl+"<br/>");
                                        String bskl[][] = Db.getDataSet(query_bobot_skl);
                                        if (bskl.length > 0) {
                                            bobot_skl += Double.parseDouble(bskl[0][1]) * Double.parseDouble(bskl[0][2]) / 100;
                                            jum_domain++;
                                        }
                                    }

                                    nilaiDomain = iBobotDomain * bobot_skl / 100;
                                    //out.print(i + ": " + peserta[i][2] + " : Nilai bobot SKL untuk domain " + domain[idomain][1] + " : " +  bobot_skl+", Nilai Domainnya = " +nilaiDomain+ "<hr/>");
                                    String sSkorAkhirPadaDomainIni[][] = Db.getDataSet("SELECT p.skor FROM peserta_test_jawaban_dengan_model p,soal s, domain d where p.idsoal = s.idsoal and s.iddomain = d.iddomain and d.iddomain=" + domain[idomain][0] + " and idpeserta_test=" + peserta[i][0] + " order by idpeserta_test_jawaban_dengan_model desc limit 0,1");
                                    double skorAkhirPadaDomainIni = Double.parseDouble(sSkorAkhirPadaDomainIni[0][0]);
                                    totalSkorDomain += skorAkhirPadaDomainIni;
                                    totalNilaiDomain += nilaiDomain;

                                }

                                //masukkan nilai domain

                                //nilai kriteria
                                double nilaiKriteria = 0, totalNilaiKriteria = 0;
                                for (int ikriteria = 0; ikriteria < bobotKriteria.length; ikriteria++) {
                                    String sqlPenilaian = "select idpenilaian_peserta,nilai,nama_penilaian from penilaian_peserta p,penilaian pe where p.idpenilaian = pe.idpenilaian and idpeserta_test=" + peserta[i][0] + " and pe.idpenilaian=" + bobotKriteria[ikriteria][0];
                                    //out.print(sqlPenilaian);
                                    String dataNilai[][] = Db.getDataSet(sqlPenilaian);
                                    //ambil skor terakhir u/ domain ini
                                    double totalNilaiDomainDanSkorAkhir;
                                    if (dataNilai.length > 0) {

                                        //update nilai total domain
                                        if (bobotKriteria[ikriteria][0].equals("1")) {
                                            totalNilaiDomainDanSkorAkhir = (totalNilaiDomain * 0.4 + totalSkorDomain * 0.6) * Double.parseDouble(bobotKriteria[ikriteria][1]) / 100;
                                            Db.executeQuery("update penilaian_peserta set nilai=" + totalNilaiDomainDanSkorAkhir + " where idpenilaian=1 and idpeserta_test=" + peserta[i][0]);
                                            totalNilaiKriteria += totalNilaiDomainDanSkorAkhir;
                                        } else {
                                            nilaiKriteria = Double.parseDouble(bobotKriteria[ikriteria][1]) * Double.parseDouble(dataNilai[0][1]) / 100;
                                            totalNilaiKriteria += nilaiKriteria;
                                        }

                                    } else {
                                        if (bobotKriteria[ikriteria][0].equals("1")) {
                                            totalNilaiDomainDanSkorAkhir = (totalNilaiDomain * 0.4 + totalSkorDomain * 0.6) * Double.parseDouble(bobotKriteria[ikriteria][1]) / 100;
                                            Db.executeQuery("insert into penilaian_peserta(idpenilaian,idpeserta_test,nilai) values(1," + peserta[i][0] + "," + totalNilaiDomainDanSkorAkhir + ")");
                                            totalNilaiKriteria += totalNilaiDomainDanSkorAkhir;
                                        } else {
                                            nilaiKriteria = Double.parseDouble(bobotKriteria[ikriteria][1]) * totalNilaiDomain / 100;
                                            totalNilaiKriteria += nilaiKriteria;
                                        }

                                    }
                                    if (dataNilai.length > 0) {
                                        //out.print(ikriteria + ": " + peserta[i][2] + " : Nilai kriteria untuk " + dataNilai[0][2] + " : " + nilaiKriteria + ", Total nila kriteria= " + totalNilaiKriteria + "<hr/>");
                                    }
                                }

                                Db.executeQuery("update peserta_test set skor_akhir = " + totalNilaiKriteria + ",skor_domain=" + totalNilaiDomain + " where id=" + peserta[i][0]);
                            }
                        }
                    %>
                    <a href="<%=Config.base_url%>index/LihatHasilTest/laporanPenerimaan?cetak=true" target="_blank">Cetak</a>
                    <table width="100%" id="rounded-corner" border="0">
                        <thead>

                            <tr>
                                <td scope="col" class="rounded-company">No.</td>
                                <td scope="col" class="rounded-q1">Nomor Peserta </td>
                                <td scope="col" class="rounded-q1">Nama Lengkap </td>
                                <td scope="col" class="rounded-q1">Asal SD </td>
                                <td scope="col" class="rounded-q1">Nilai Domain </td>
                                <td scope="col" class="rounded-q1">Skor Penerimaan  </td>
                            </tr>
                        </thead>
                        <%
                            String konfigurasi[][] = Db.getDataSet("select kuota, skor_minimum from konfigurasi");
                            peserta = Db.getDataSet("SELECT id, nomor_peserta, nama_lengkap,asal,skor_domain,skor_akhir FROM peserta_test p where inisialisasi_kemampuan='Tiga Butir' and model_logistik='Rasch' and metode='Futsuhilow' and penyajian_soal='Proporsional' and skor_akhir>" + konfigurasi[0][1] + " order by skor_akhir desc limit 0," + konfigurasi[0][0]);

                            for (int i = 0; i < peserta.length; i++) {
                        %>
                        <tr>
                            <td><%=i + 1%></td>
                            <td><%=peserta[i][1]%></td>
                            <td><%=peserta[i][2]%></td>
                            <td><%=peserta[i][3]%></td>
                            <td><%=format.format(Double.parseDouble(peserta[i][4]))%></td>
                            <td><%=format.format(Double.parseDouble(peserta[i][5]))%></td>
                        </tr>
                        <% }%>
                    </table>
                    <!-- InstanceEndEditable --></div>

                <div id="comments"></div>
            </div>
        </div>
        <div id="footer">
            <div class="wrapper">
                <p align="center">Hak Cipta (C) Rukli 2011 <a href="http://www.playapps.net/"></a>				</p>
            </div>
        </div>
    </body>
    <!-- InstanceEnd --></html>
