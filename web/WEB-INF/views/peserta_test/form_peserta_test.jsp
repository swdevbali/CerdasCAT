<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,recite18th.library.Db,application.config.Config,recite18th.library.Pagination" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<%
	String message="";
	int pagenum;
	pagenum = request.getParameter("pagenum")==null ?0:Integer.parseInt(request.getParameter("pagenum")+"");
%>
<!DOCTYPE HTML>
<html><!-- InstanceBegin template="../../../Templates/home.dwt" codeOutsideHTMLIsLocked="false" -->
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
	    <h1 id="Startinguptheproject"><!-- InstanceBeginEditable name="judul_modul" -->Form Peserta Test <!-- InstanceEndEditable --></h1>
	    <!-- InstanceBeginEditable name="isi_modul" -->
	    <h1></h1>
		
	    <table border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#E8EDFF">
          <tr>
            <td><form name="form2" method="post" action="<%=Config.base_url%>index/PesertaTest/save" enctype="multipart/form-data">
                <table id="hor-zebra" summary="Employee Pay Sheet">
                  <thead>
                    <tr>
                      <th colspan="2" class="odd" scope="col"> Input Peserta Test </th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr >
                      <td width="173">Username</td>
                      <td width="362"><label>
                        <input name="username" type="text" id="username" value="${model.username}">
                        ${username_error}
                        <input name="id" type="hidden" id="id" value="${model.id}">
                      </label></td>
                    </tr>
                    <tr >
                      <td>Password</td>
                      <td><label>
                        <input name="password" type="password" id="password" value="${model.password}">
                      ${password_error}</label></td>
                    </tr>
                    <tr >
                      <td>Metode</td>
                      <td><label>
                        <select name="metode" id="metode">
                          <option value="-1">-- Pilih Metode --</option>
                          <option value="Tidak Ada" <c:if test="${model.metode=='Tidak Ada'}"> selected="selected" </c:if>>Tidak Ada</option>                          <option value="Fumahilow" <c:if test="${model.metode=='Fumahilow'}"> selected="selected" </c:if>>Fuzzy Mamdani High Low</option>
                          <option value="Fusuhilow" <c:if test="${model.metode=='Fusuhilow'}"> selected="selected" </c:if>>Fuzzy Sugeno High Low</option>
                          <option value="Futsuhilow" <c:if test="${model.metode=='Futsuhilow'}"> selected="selected" </c:if>>Fuzzy Tsukamoto High Low</option>
                        </select>
                      ${metode_error}</label></td>
                    </tr>
                    <tr >
                      <td>Model</td>
                      <td><select name="model_logistik" id="model_logistik">
                        <option value="-1">-- Pilih Model --</option>
                        <option value="Tidak Ada" <c:if test="${model.metode=='Tidak Ada'}"> selected="selected" </c:if>>Tidak Ada</option>
                        <option value="1PL" <c:if test="${model.model_logistik=='1PL'}"> selected="selected" </c:if>>Model Logistik 1 Parameter</option>
                        <option value="2PL" <c:if test="${model.model_logistik=='2PL'}"> selected="selected" </c:if>>Model Logistik 2 Parameter</option>
                        <option value="3PL" <c:if test="${model.model_logistik=='3PL'}"> selected="selected" </c:if>>Model Logistik 3 Parameter</option>
                        <option value="Rasch" <c:if test="${model.model_logistik=='Rasch'}"> selected="selected" </c:if>>Model Rasch</option>
                                            </select>
                        ${model_error}</td>
                    </tr>
                    <tr >
                      <td>Inisialisasi Kemampuan </td>
                      <td><select name="inisialisasi_kemampuan" id="inisialisasi_kemampuan">
                        <option value="-1">-- Pilih Inisialisasi Kemampuan --</option>
                        <option value="Tidak Ada" <c:if test="${model.inisialisasi_kemampuan=='Tidak Ada'}"> selected="selected" </c:if>>Tidak Ada</option>						
                        <option value="Theta=0" <c:if test="${model.inisialisasi_kemampuan=='Theta=0'}"> selected="selected" </c:if>>Theta = 0</option>
                        <option value="Tiga Butir" <c:if test="${model.inisialisasi_kemampuan=='Tiga Butir'}"> selected="selected" </c:if>>Tiga Butir</option>

                                                                  </select>
                        ${inisialisasi_kemampuan}</td>
                    </tr>
                    <tr >
                      <td>Penyajian Soal </td>
                      <td><select name="penyajian_soal" id="penyajian_soal">
                        <option value="-1">-- Pilih Penyajian Soal --</option>
                        <option value="Tetap" <c:if test="${model.penyajian_soal=='Tetap'}"> selected="selected" </c:if>>Tetap</option>						
                        <option value="Acak" <c:if test="${model.penyajian_soal=='Acak'}"> selected="selected" </c:if>>Acak</option>
                        <option value="Proporsional" <c:if test="${model.penyajian_soal=='Proporsional'}"> selected="selected" </c:if>>Proporsional</option>

                                            </select>
                        ${penyajian_soal_error}</td>
                    </tr>
                    <tr >
                      <td><blockquote>
                        <p>Paket Soal Tetap </p>
                      </blockquote></td>
                      <td><select name="idpaket_soal" id="idpaket_soal">
                          <option value="-1">--Pilih Paket Soal--</option>
						<c:forEach items="${row_paket_soal}" var="item" varStatus="status">
                          <option value="${item.idpaket_soal}" <c:if test="${model.idpaket_soal==item.idpaket_soal}"> selected="selected" </c:if> >${item.keterangan}</option>
						 </c:forEach>
                                                </select></td>
                    </tr>
                    <tr >
                      <td><blockquote>Paket Soal Tiga Butir </blockquote></td>
                      <td><select name="idpaket_soal_tiga_butir" id="idpaket_soal_tiga_butir">
                        <option value="-1">--Pilih Paket Soal--</option>
                        <c:forEach items="${row_paket_soal_tiga_butir}" var="item" varStatus="status"> <option value="${item.idpaket_soal_tiga_butir}" 
                            <c:if test="${model.idpaket_soal_tiga_butir==item.idpaket_soal_tiga_butir}"> selected="selected" </c:if>
                            >${item.keterangan}
                          </option>
                        </c:forEach>
                      </select></td>
                    </tr>
                    <tr >
                      <td>Nomor Peserta </td>
                      <td><label>
                        <input name="nomor_peserta" type="text" id="nomor_peserta" value="${model.nomor_peserta}" size="35">
                      ${nomor_peserta_error}</label></td>
                    </tr>
                    <tr >
                      <td>Nama Lengkap </td>
                      <td><input name="nama_lengkap" type="text" id="nama_lengkap" value="${model.nama_lengkap}" size="36">
                        ${nama_lengkap_error}</td>
                    </tr>
                    <tr >
                      <td>Asal</td>
                      <td><input name="asal" type="text" id="asal" value="${model.asal}">
                        ${asal_error}</td>
                    </tr>
                    <tr >
                      <td>Tempat Lahir </td>
                      <td><input name="tempat_lahir" type="text" id="tempat_lahir" value="${model.tempat_lahir}">
                        ${tempat_lahir_error}</td>
                    </tr>
                    <tr >
                      <td>Tanggal Lahir </td>
                      <td><input name="tanggal_lahir" type="text" id="tanggal_lahir" value="${model.tanggal_lahir}">
                        ${tanggal_lahir_error}</td>
                    </tr>
                    <tr >
                      <td>Jenis Kelamin </td>
                      <td><select name="jenis_kelamin" id="jenis_kelamin">
                        <option value="-1">--- Pilih Jenis Kelamin ---</option>
                        <option value="Pria" <c:if test="${model.jenis_kelamin=='Pria'}"> selected="selected" </c:if>>Pria</option>
                        <option value="Wanita" <c:if test="${model.jenis_kelamin=='Wanita'}"> selected="selected" </c:if>>Wanita</option>
                      </select>
		${jenis_kelamin_error}</td>
                    </tr>
                    <tr >
                      <td>Foto</td>
                      <td><input name="foto" type="file" id="foto"></td>
                    </tr>
                    <tr >
                      <td>&nbsp;</td>
                      <td valign="top"><label>
                        <input type="image" name="imageField">
                      </label></td>
                    </tr>
                    <tr class="odd">
                      <td>&nbsp;</td>
                      <td><input type="submit" name="Submit2" value="Simpan">
                          <input name="Button" type="button" id="Submit" value="Batal" onClick="javascript:history.back(-1);"></td>
                    </tr>
                  </tbody>
                </table>
            </form></td>
          </tr>
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
