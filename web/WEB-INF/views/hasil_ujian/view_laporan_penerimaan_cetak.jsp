<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,recite18th.library.Db,application.config.Config,recite18th.library.Pagination,java.text.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  

<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Aplikasi Cerdas CAT</title>
<link rel="shortcut icon" type="image/png" href="<%=Config.base_url%>_desain/favicon.png">
<%
	String message="";
	int pagenum;
	pagenum = request.getParameter("pagenum")==null ?0:Integer.parseInt(request.getParameter("pagenum")+"");
	NumberFormat format = DecimalFormat.getInstance();
%>
<script language="Javascript1.2">
  <!--
  function printpage() {
  	window.print();
  }
  //-->
</script>
<style type="text/css">
<!--
.style1 {
	font-size: 24px;
	font-weight: bold;
}
-->
</style>
</head>
<body class="" onLoad="printpage()">

	<div id="pageContent">
		
	  <div class="wikistyle">
	    <h1 align="center" id="Startinguptheproject">Aplikasi Cerdas CAT </h1>
	    
		    <% //this is all the code that need to be done
                        String data[][] = Db.getDataSet("select  skor_minimum,kuota,inisialisasi_kemampuan,model_logistik,metode,penyajian_soal from konfigurasi");
                        String peserta[][];
                        String sqlX = "";
                        if (data[0][3].equals("Tidak Ada")) {
                            sqlX = "SELECT id, nomor_peserta,nama_lengkap,asal,inisialisasi_kemampuan,model_logistik,metode,penyajian_soal FROM peserta_test p where model_logistik='Tidak Ada' and metode='Tidak Ada' order by nomor_peserta";
                            peserta = Db.getDataSet(sqlX);
                        } else {
                            peserta = Db.getDataSet("SELECT id, nomor_peserta, nama_lengkap,asal,inisialisasi_kemampuan,model_logistik,metode,penyajian_soal FROM peserta_test p where inisialisasi_kemampuan='Tiga Butir' and model_logistik='Rasch' and metode='Futsuhilow' and penyajian_soal='Proporsional' order by nomor_peserta");
                        }
                    %>

                    <% if (peserta.length == 0) {%>
                    Tidak ada data laporan yang bisa ditampilkan
                    <%                } else {
                        double skor_minimum = 0;
                        int kuota_maksimum = 0;

                        skor_minimum = Double.parseDouble(data[0][0]);
                        kuota_maksimum = Integer.parseInt(data[0][1]);
                    %>
                    <p id="aIntroductiona">&nbsp;</p>
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" bordercolor="#666666">
                        <tr>
                            <td colspan="2"><div align="center"><strong>LAPORAN KELULUSAN </strong></div></td>
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
                                String sql = "";
                                if (data[0][3].equals("Tidak Ada")) {
                                    sql = "SELECT d.iddomain,d.domain FROM paket_soal_jawaban p,soal s,domain d where p.idpeserta_test=" + peserta[i][0] + " and p.idsoal=s.idsoal and s.iddomain = d.iddomain and d.iddomain  in (select iddomain from konfigurasi_domain) group by d.iddomain";
                                } else {
                                    sql = "SELECT d.iddomain,d.domain FROM peserta_test_jawaban_dengan_model p,soal s,domain d where p.idpeserta_test=" + peserta[i][0] + " and p.idsoal=s.idsoal and s.iddomain = d.iddomain and d.iddomain  in (select iddomain from konfigurasi_domain) group by d.iddomain";

                                }
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
                                        String query_bobot_skl = "";
                                        if (data[0][3].equals("Tidak Ada")) {
                                            query_bobot_skl = "SELECT skl.nama_skl, sum(p.nilai) as total_skor,ps.bobot  FROM paket_soal_jawaban p,soal s, domain d, skl,pembobotan_skl ps  where skl.idskl=ps.idskl and skl.nama_skl='" + skl[iskl][0] + "'  and s.idskl=skl.idskl and p.idsoal = s.idsoal and s.iddomain = d.iddomain and d.iddomain=" + domain[idomain][0] + " and idpeserta_test=" + peserta[i][0] + " group by skl.nama_skl  order by idpaket_soal_jawaban";
                                        } else {
                                            query_bobot_skl = "SELECT skl.nama_skl, sum(p.skor) as total_skor,ps.bobot  FROM peserta_test_jawaban_dengan_model p,soal s, domain d, skl,pembobotan_skl ps  where skl.idskl=ps.idskl and skl.nama_skl='" + skl[iskl][0] + "'  and s.idskl=skl.idskl and p.idsoal = s.idsoal and s.iddomain = d.iddomain and d.iddomain=" + domain[idomain][0] + " and idpeserta_test=" + peserta[i][0] + " group by skl.nama_skl  order by idpeserta_test_jawaban_dengan_model";
                                        }

                                        //out.print(query_bobot_skl+"<br/>");
                                        String bskl[][] = Db.getDataSet(query_bobot_skl);
                                        if (bskl.length > 0) {
                                            bobot_skl += Double.parseDouble(bskl[0][1]) * Double.parseDouble(bskl[0][2]) / 100;
                                            jum_domain++;
                                        }
                                    }

                                    nilaiDomain = iBobotDomain * bobot_skl / 100;
                                    //out.print(i + ": " + peserta[i][2] + " : Nilai bobot SKL untuk domain " + domain[idomain][1] + " : " +  bobot_skl+", Nilai Domainnya = " +nilaiDomain+ "<hr/>");
                                    String sSkorAkhirPadaDomainIni[][] = null;
                                    if (data[0][3].equals("Tidak Ada")) {
                                        sSkorAkhirPadaDomainIni = Db.getDataSet("SELECT p.nilai FROM paket_soal_jawaban p,soal s, domain d where p.idsoal = s.idsoal and s.iddomain = d.iddomain and d.iddomain=" + domain[idomain][0] + " and idpeserta_test=" + peserta[i][0] + " order by idpaket_soal_jawaban desc limit 0,1");
                                    } else {
                                        sSkorAkhirPadaDomainIni = Db.getDataSet("SELECT p.skor FROM peserta_test_jawaban_dengan_model p,soal s, domain d where p.idsoal = s.idsoal and s.iddomain = d.iddomain and d.iddomain=" + domain[idomain][0] + " and idpeserta_test=" + peserta[i][0] + " order by idpeserta_test_jawaban_dengan_model desc limit 0,1");
                                    }
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
                    <a href="<%=Config.base_url%>index/LihatHasilTest/laporanPenerimaan?cetak=true" target="_blank"></a>

                    <%
                        if (data[0][3].equals("Tidak Ada")) {
                    %>
                    <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#000000" id="rounded-corner">
                        <thead>

                            <tr>
                                <td scope="col" class="rounded-company">No.</td>
                                <td scope="col" class="rounded-q1">Nomor Peserta </td>
                                <td scope="col" class="rounded-q1">Nama Lengkap </td>
                                <td scope="col" class="rounded-q1">Asal SD </td>
                                <td scope="col" class="rounded-q1">Skor Ujian </td>
                                <td scope="col" class="rounded-q1">Skor Kelulusan  </td>
                            </tr>
                        </thead>
                        <%
                            data = Db.getDataSet("select skor_minimum,kuota,inisialisasi_kemampuan,model_logistik,metode,penyajian_soal from konfigurasi");
                            peserta = Db.getDataSet("SELECT id,nomor_peserta,nama_lengkap,asal,skor_domain,skor_akhir FROM peserta_test p where model_logistik='Tidak Ada' and metode='Tidak Ada' and skor_akhir>" + data[0][0] + " order by skor_akhir desc limit 0," + data[0][1]);
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
                    <%
                    } else {
                    %>					 
                    <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#000000" id="rounded-corner">
                        <thead>

                            <tr>
                                <td scope="col" class="rounded-company">No.</td>
                                <td scope="col" class="rounded-q1">Nomor Peserta </td>
                                <td scope="col" class="rounded-q1">Nama Lengkap </td>
                                <td scope="col" class="rounded-q1">Asal SD </td>
                                <td scope="col" class="rounded-q1">Nilai Domain </td>
                                <td scope="col" class="rounded-q1">Skor  </td>
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
                    <% }%>
                    <br/>

                
</div>
		
		<div id="comments"></div>
</div>
        </div>
		<div id="footer">
			<div class="wrapper">
				<p align="center">Hak Cipta (C) Rukli 2011 <a href="http://www.playapps.net/"></a>				</p>
		  </div>
		</div>
</body></html>
