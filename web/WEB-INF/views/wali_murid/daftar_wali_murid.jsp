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
	    <h1 id="Startinguptheproject"><!-- InstanceBeginEditable name="judul_modul" -->Daftar Wali Murid <!-- InstanceEndEditable --></h1>
	    <!-- InstanceBeginEditable name="isi_modul" -->
	    <h1></h1>
	    <a href="<%=Config.base_url%>index/WaliMurid/input/-1">Tambah Data</a>
		<table width="100%" id="rounded-corner" summary="2007 Major IT Companies' Profit">
          <thead>
            <tr>
              <th scope="col" class="rounded-company">No.</th>
              <th scope="col" class="rounded-q1">Username</th>
              <th scope="col" class="rounded-q1">Peran</th>
              <th scope="col" class="rounded-q4">Aksi</th>
            </tr>
          </thead>
          <tfoot>
            <tr>
              <td colspan="3" class="rounded-foot-left"><%=Pagination.createLinks(pagenum)%></td>
              <td class="rounded-foot-right">&nbsp;</td>
            </tr>
          </tfoot>
          <tbody>
            <c:forEach items="${row}" var="item" varStatus="status" >
              <tr>
                <td>${status.count}</td>
                <td>${item.username}</td>
                <td>${item.peran}</td>
                <td><a href="<%=Config.base_url%>index/WaliMurid/input/${item.id}">Ubah</a> <a href="<%=Config.base_url%>index/WaliMurid/delete/${item.id}"
				  onClick="return confirm('Apakah Anda yakin?');">Hapus</a> </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
	    <p id="aIntroductiona">&nbsp;</p>
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
