<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,recite18th.library.Db,application.config.Config,recite18th.library.Pagination,application.models.*,java.text.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<%
	String message="";
	int pagenum;
	pagenum = request.getParameter("pagenum")==null ?0:Integer.parseInt(request.getParameter("pagenum")+"");
	
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
	    <h1 id="Startinguptheproject"><!-- InstanceBeginEditable name="judul_modul" -->Laporan Hasil Ujian Peserta Tes Keseluruhan Menggunakan Model Rasch <!-- InstanceEndEditable --></h1>
	    <!-- InstanceBeginEditable name="isi_modul" -->
	    <c:forEach items="${domain}" var="item" varStatus="status" >
	    <p id="aIntroductiona">&nbsp;</p>
	    <table width="50%" border="0" >
          <tr>
            <td>Inisialisasi</td>
            <td>:</td>
            <td>Tiga Soal </td>
          </tr>
          <tr>
            <td>Domain</td>
            <td>:</td>
            <td><strong>${item.domain}</strong></td>
          </tr>
          <tr>
            <td>Penyajian Soal </td>
            <td>:</td>
            <td>Proporsional</td>
          </tr>
        </table>
		<%
			DomainModel domainModel = ((DomainModel) pageContext.getAttribute("item"));
			String sql = " SELECT metode FROM peserta_test where metode<>'Tidak Ada' group by metode";
			String metode[][] = Db.getDataSet(sql);
			for(int i = 0; i < metode.length; i++)
			{
		%>
		<table width="100%" border="0" id="rounded-corner">
		<thead>
		<tr>
		<th scope="col" class="rounded-company">No.</th>
		<th scope="col" class="rounded-q1">Nomor Peserta </th>
		<th scope="col" class="rounded-q1">Nama Peserta </th>
		<th scope="col" class="rounded-q1">Waktu</th>
		<th scope="col" class="rounded-q1">ID Soal Benar </th>
		<th scope="col" class="rounded-q1">ID Soal Salah </th>
		<th scope="col" class="rounded-q4">Skor Akhir </th>
		</tr>
		</thead>
	    <p>Metode <%=metode[i][0]%></p>
		<%
			String sql2 = "select p.nomor_peserta,p.username,p.id FROM peserta_test p where  metode='"+metode[i][0]+"' and model_logistik='Rasch'";
			String peserta[][] = Db.getDataSet(sql2);
			String soalBenar[][], soalSalah[][];
			for(int ii= 0; ii < peserta.length; ii++)
			{
				soalBenar = Db.getDataSet("SELECT s.idsoal,skl.nama_skl FROM skl,peserta_test_jawaban_dengan_model pm, peserta_test p, soal s, domain d where s.idskl = skl.idskl and pm.idsoal=s.idsoal and d.iddomain=s.iddomain and d.iddomain=" + domainModel.getIddomain()  + " and p.id = pm.idpeserta_test and pm.nilai=1 and p.id = " + peserta[ii][2] + " order by idsoal");
				
				soalSalah = Db.getDataSet("SELECT s.idsoal,skl.nama_skl FROM skl,peserta_test_jawaban_dengan_model pm, peserta_test p, soal s, domain d where s.idskl = skl.idskl and pm.idsoal=s.idsoal and d.iddomain=s.iddomain and d.iddomain=" + domainModel.getIddomain()  + " and p.id = pm.idpeserta_test and pm.nilai=0 and p.id = " + peserta[ii][2] + " order by idsoal");
								
				String sBenar="0", sSalah ="0";
				
				String skorAkhir[][] =Db.getDataSet("SELECT skor,skl.nama_skl FROM skl,peserta_test_jawaban_dengan_model pm, peserta_test p, soal s, domain d where s.idskl = skl.idskl and p.id = pm.idpeserta_test and pm.idsoal=s.idsoal and d.iddomain=s.iddomain and d.iddomain=" + domainModel.getIddomain()  + " and p.id = " + peserta[ii][2] + " order by pm.idpeserta_test_jawaban_dengan_model desc limit 0,1");

				String sAkhir = "";
				if(skorAkhir.length>0) sAkhir = skorAkhir[0][0];
				for(int j=0;j<soalBenar.length;j++) 
				{
					if(j==0) sBenar=/*soalBenar.length+", yaitu : " + */  soalBenar[j][0] + "(" + soalBenar[j][1] + ")";
					else sBenar = sBenar + "<br/>" +soalBenar[j][0] + "(" + soalBenar[j][1] + ")";;
				}
				
				for(int j=0;j<soalSalah.length;j++) 
				{
					if(j==0) sSalah =/* soalSalah.length+", yaitu : "+ */  soalSalah[j][0] + "(" + soalSalah[j][1] + ")";
					else sSalah = sSalah + "<br/>" + soalSalah[j][0] + "(" + soalSalah[j][1] + ")";
				}
		%>
		
  <tr>
    <td><%=ii%></td>
    <td><%=peserta[ii][0]%></td>
    <td><%=peserta[ii][1]%></td>
    <td>Waktu</td>
    <td><%=sBenar%></td>
    <td><%=sSalah%></td>
    <td><%=sAkhir%></td>
  </tr>


		<%
				}
		%>
		</table>
		<%
			}
		%>
	    </c:forEach>
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
