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

<!-- InstanceBeginEditable name="head" -->
<style type="text/css">
@import "<%=Config.base_url%>res/css/jquery.countdown.css";.style2 {color: #FF0000}
</style> 
<script type="text/javascript" src="<%=Config.base_url%>res/js/jquery.countdown.js"></script>
<script type="text/javascript"> 

$(function () {
	var endTime = new Date();
	endTime.setMinutes(endTime.getMinutes() + 9);
	$('#timer').countdown({until: endTime,format: 'MS',onExpiry: timeUp,onTick: watchCountdown});
});

function timeUp() { 
   $("form:first").submit();
} 
function watchCountdown(periods) { 
	if(periods[5]=="0")
	{
    	$('#sisa').text('Waktu tersisa kurang dari 1 menit lagi'); 
	}
	$('#waktu').val(periods[5] + ":" + periods[6]);
}
</script>
<!-- InstanceEndEditable -->
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
	    <h1 id="Startinguptheproject"><!-- InstanceBeginEditable name="judul_modul" -->Pelaksanaan Ujian<!-- InstanceEndEditable --></h1>
	    <!-- InstanceBeginEditable name="isi_modul" -->
 <br/>
 <div id="timer"></div>
 <p>&nbsp;</p>
 <div id="sisa" class="style2" align="center"></div>
 <form name="formJawaban" method="post" action="<%=Config.base_url%>index/AmbilUjian/selesaiJawabTigaButir">
      <table width="80%" border="0">
          <tr>
            <td width="5%">No.</td>
            <td width="95%">Soal</td>
          </tr>
		  <c:forEach items="${row_soal_tiga_butir}" var="item" varStatus="status">
          <tr>
            <td valign="top">${status.count}</td>
            <td valign="top"><img src="<%=Config.base_url%>upload/${item.gambar}" alt="s" id="gambar"/><br>
                <select name="optJawaban_${item.idsoal}" id="optJawaban_${item.idsoal}">
                  <option value="A">A</option>
                  <option value="B">B</option>
                  <option value="C">C</option>
                  <option value="D">D</option>
                </select>
                <input name="waktu" type="hidden" id="waktu">
              <br/>
            <br/></td>
            </tr>
	    </c:forEach>
      </table>
	   
        <label>
        <input name="Submit" type="submit" id="Submit" value="Jawab Soal">
        </label>
 </form>
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
