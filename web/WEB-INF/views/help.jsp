<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,recite18th.library.Db,application.config.Config,recite18th.library.Pagination" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<%
	String message="";
	int pagenum;
	pagenum = request.getParameter("pagenum")==null ?0:Integer.parseInt(request.getParameter("pagenum")+"");
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
	var root = $("#scroller").scrollable({circular: true}).autoscroll({ autoplay: true });
	window.api = root.data("scrollable");
	$("#scroller").play();
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
                                       
									   
									    <div class="scrollable" id="scroller"align="center">   
   
   
   <div class="items">
      <div align="center">
         <div align="center">
           <div align="center">
		     <img src="<%=Config.base_url%>res/img/1.jpg" />
             <img src="<%=Config.base_url%>res/img/2.jpg" />
             <img src="<%=Config.base_url%>res/img/3.jpg" />
             <img src="<%=Config.base_url%>res/img/4.jpg" />
             <img src="<%=Config.base_url%>res/img/5.jpg" />
           </div>
        </div>
      </div>
   </div>
</div>

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
           <li><a href="<%=Config.base_url%>index/LihatHasilTest/laporanPenerimaan">Laporan Kelulusan</a></li>
			 <li><a href="<%=Config.base_url%>index/login/logout">Logout</a></li> 
	    </c:if>
		<c:if test="${user_credential.peran=='Pengajar'}" >        
			 <li><a href="<%=Config.base_url%>index/soal/index">Kelola Soal</a></li>
			 <li><a href="<%=Config.base_url%>index/pengajar/bukaViewInputPenilaian/-1">Input Penilaian</a></li> 
			 <li><a href="<%=Config.base_url%>index/LihatHasilTest/laporanPengajarRasch">Laporan Hasil Ujian Model Rasch</a></li>
			 <li><a href="<%=Config.base_url%>index/LihatHasilTest/laporanPenerimaan">Laporan Kelulusan</a></li>		
			 <li><a href="<%=Config.base_url%>index/login/logout">Logout</a></li> 
	    </c:if>		
		<c:if test="${user_credential.peran=='Peserta Test'}" >        
        <c:if test="${user_credential.verified==0}" >
			 <li><a href="<%=Config.base_url%>index/SignUp/index">Verifikasi</a></li>
         </c:if>
         <c:if test="${user_credential.verified==1}"> 	
			 <li><a href="<%=Config.base_url%>index/AmbilUjian/index">Ambil Ujian</a></li> 				 	
			 <li><a href="<%=Config.base_url%>index/LihatHasilTest">Lihat Hasil Ujianku</a></li> 				 		</c:if>
			 <li><a href="<%=Config.base_url%>index/LihatHasilTest/laporanPenerimaan">Laporan Kelulusan</a></li>
			 <li><a href="<%=Config.base_url%>index/login/logout">Logout</a></li> 
	    </c:if>		 
		<c:if test="${user_credential.peran=='Wali Peserta Test'}" >        
		 <li><a href="<%=Config.base_url%>index/LihatHasilTest">Lihat Hasil Ujian Peserta Test</a></li>
		<li><a href="<%=Config.base_url%>index/LihatHasilTest/laporanPenerimaan">Laporan Kelulusan </a></li>
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
	    <h1 id="Startinguptheproject"><!-- InstanceBeginEditable name="judul_modul" -->Bantuan Penggunaaan Aplikasi <!-- InstanceEndEditable --></h1>
	    <!-- InstanceBeginEditable name="isi_modul" -->
	    <p id="aIntroductiona">Untuk menggunakan aplikasi ini, Anda harus terlebih dahulu mendaftarkan diri melalui menu SignUp. Peserta test yang mendaftarkan diri, sebelumnya telah ditambahkan oleh Admin informasinya ke basis data. Sehingga, hanya peserta test yang telah didaftarkan oleh Admin yang dapat mendaftarkan diri. Setelah itu, peseta test masih harus memverifikasi proses signup dengan mengetikkan kembali nomor peserta yang didapatkan saat pendaftaran sebagai siswa baru.</p>
	    <p>Keseluruhan aplikasi memiliki fungsi-fungsi yang disesuaikan berdasarkan peran pengguna yang masuk ke dalam sistem, meliputi :</p>
	    <ol>
	      <li>Administrator<br>
	      Merupakan pengelola sistem yang bertanggung jawab penuh terhadap proses kelancaran jalannya sistem. Admin berhak menghapus data, menambah dan mengubah data yang menjadi bagian dari sistem. </li>
          <li>Pimpinan<br>
          Pimpinan bertugas utamanya untuk menentukam syarat kelulusan yang meliputi kuota dan nilai skor minimal. Pimpinan dapat mengakses semua laporan yang dihasilkan dalam sistem, namun utamanya mengakses laporan kelulusan. </li>
	      <li>Guru<br>
	      Tugas utama guru adalah menambahkan soal yang akan diujikan, termasuk kelengkapan informasi tentang gambar soal, jawaban dan juga SKL soal tersebut. Guru dapat juga mengakses laporan kelulusan. </li>
	      <li>Peserta Test<br>
	      Aplikasi ini menyediakan fungsi khusus berupa ujian online berbasikan Computer Adaptive Testing, yang akan menyaring siswa berdasarkan kemampuan realnya dalam menjawab soal. Pada setiap akhir ujian, kemampuan siswa akan dapat langsung diukur menggunakan metode CAT yang telah diuji. </li>
	      <li>Wali Peserta Test<br>
          Berperan sebagai wali, maka wali peserta test dapat masuk ke dalam sistem dan menampilkan laporan ujian peserta test yang berkaitan dengannya dan juga menampilkan laporan kelulusan</li>
        </ol>
	    <p align="justify">Aplikasi ini dikembangkan dengan menggunakan Java EE dan MySQL. Untuk dapat menjalankan aplikasi ini, klien hanya membutuhkan browser internet (Google Chrome, Mozilla FireFox, Opera, Internet Explore dan lain sebagainya) dan koneksi ke internet/intranet yang stabil dan dapat dihandalkan. </p>
	    <p align="justify">Adapun untuk menjalankan aplikasi ini sebagai server, maka aplikasi ini membutuhkan persyaratan berikut ini :</p>
	    <ol>
	      <li>Processor dengan kecepatan minimal 2GHz </li>
          <li>Komputer dengan memori minimal 4Gigabyte  </li>
	      <li>Media penyimpanan harddisk dengan ukuran kosong 2Gigabyte</li>
	      <li>Koneksi ke private VPN untuk IP pribadi atau koneksi ke jaringan intranet</li>
	      <li>Router yang akan mengatur skema komunikasi di dalam jaringan intranet</li>
        </ol>
	    <p>&nbsp;</p>
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
