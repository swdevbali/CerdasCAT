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
		<c:if test="${user_credential.peran=='Pimpinan'}" >        
			 <li><a href="<%=Config.base_url%>index/login/logout">Logout</a></li> 
	    </c:if>
		<c:if test="${user_credential.peran=='Pengajar'}" >        
			 <li><a href="<%=Config.base_url%>index/soal/index">Kelola Soal</a></li> 
			 <li><a href="<%=Config.base_url%>index/LihatHasilTest/laporanPengajarRasch">Laporan Hasil Ujian Model Rasch </a></li>		
			 <li><a href="<%=Config.base_url%>index/login/logout">Logout</a></li> 
	    </c:if>		
		<c:if test="${user_credential.peran=='Peserta Test'}" >        
			 <li><a href="<%=Config.base_url%>index/SignUp/index">Sign Up</a></li> 	
			 <li><a href="<%=Config.base_url%>index/AmbilUjian/index">Ambil Ujian</a></li> 				 	
			 <li><a href="<%=Config.base_url%>index/AmbilUjian/lihatHasilUjian">Lihat Hasil Ujian</a></li> 				 				 
			 <li><a href="<%=Config.base_url%>index/login/logout">Logout</a></li> 
	    </c:if>		 
		<c:if test="${user_credential.peran=='Wali Peserta Test'}" >        
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
	    <h1 id="Startinguptheproject"><!-- InstanceBeginEditable name="judul_modul" -->Sign Up Peserta Test <!-- InstanceEndEditable --></h1>
	    <!-- InstanceBeginEditable name="isi_modul" -->
	    <h2 id="aIntroductiona">Formulir Pendaftaran Peserta Test </h2>
<form action="<%=Config.base_url%>index/SignUp/save" method="post" enctype="multipart/form-data" name="form2">
                <table width="50%" align="center" id="hor-zebra" summary="Employee Pay Sheet">
                  <thead>
                    <tr>
                      <th colspan="2" class="odd" scope="col">Form Sign Up </th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr >
                      <td width="33%">Username</td>
                      <td width="67%"><label>${model.username}</label></td>
                    </tr>
                    <tr >
                      <td>Password</td>
                      <td><label>*************</label></td>
                    </tr>
                    <tr >
                      <td>Metode</td>
                      <td><label>${model.metode}</label></td>
                    </tr>
                    <tr >
                      <td>Model</td>
                      <td>${model.model_logistik}</td>
                    </tr>
                    <tr >
                      <td>Inisialisasi Kemampuan </td>
                      <td>${model.inisialisasi_kemampuan} </td>
                    </tr>
                    <tr >
                      <td>Penyajian Soal </td>
                      <td>${model.penyajian_soal}</td>
                    </tr>
                    <tr >
                      <td>Nomor Peserta </td>
                      <td><label>
                        <input name="nomor_peserta" type="text" id="nomor_peserta" value="${model.nomor_peserta}">
                        <input name="id" type="hidden" id="id" value="${model.id}">
                      </label></td>
                    </tr>
                    <tr >
                      <td>Nama Lengkap </td>
                      <td><label>
                        <input name="nama_lengkap" type="text" id="nama_lengkap" value="${model.nama_lengkap}">
                      </label></td>
                    </tr>
                    <tr >
                      <td>Asal</td>
                      <td><a href="SD 1 Bantul">
                        <label>
                        <input name="asal" type="text" id="asal" value="${model.asal}">
                        </label>
                      </a></td>
                    </tr>
                    <tr >
                      <td>Tempat Lahir </td>
                      <td><label>
                        <input name="tempat_lahir" type="text" id="tempat_lahir" value="${model.tempat_lahir}">
                      </label></td>
                    </tr>
                    <tr >
                      <td>Tanggal Lahir </td>
                      <td><label>
                        <input name="tanggal_lahir" type="text" id="tanggal_lahir" value="${model.tanggal_lahir}">
                      </label></td>
                    </tr>
                    <tr >
                      <td>Jenis Kelamin </td>
                      <td><label>
                        <select name="jenis_kelamin" id="jenis_kelamin">
                          <option value="-1">--- Pilih Jenis Kelamin ---</option>
                          <option value="Pria" <c:if test="${model.jenis_kelamin=='Pria'}">selected="selected"</c:if>>Pria</option>
                          <option value="Wanita" <c:if test="${model.jenis_kelamin=='Wanita'}">selected="selected"</c:if>>Wanita</option>
                      </select>
                      </label></td>
                    </tr>
                    <tr >
                      <td>Foto</td>
                      <td><label>
                        <input name="foto" type="file" id="foto">
                      </label></td>
                    </tr>
                    <tr >
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                    </tr>
                    <tr class="odd">
                      <td>&nbsp;</td>
                      <td><input type="submit" name="Submit2" value="Simpan">
                          <input name="Button" type="button" id="Submit" value="Batal" onClick="javascript:history.back(-1);"></td>
                    </tr>
                  </tbody>
      </table>
        </form>
	    <p>&nbsp; </p>
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
