<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,recite18th.library.Db,application.config.Config,recite18th.library.Pagination,java.util.*" %>
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
	    <h1 id="Startinguptheproject"><!-- InstanceBeginEditable name="judul_modul" -->Konfigurasi Kelulusan <!-- InstanceEndEditable --></h1>
	    <!-- InstanceBeginEditable name="isi_modul" -->
		<%
		String data[][]=Db.getDataSet("select skor_minimum,kuota,inisialisasi_kemampuan,model_logistik,metode,penyajian_soal from konfigurasi");
		/*String isiDomain[] = data[0][2].split(">>");
		Hashtable hashDomain = new Hashtable();
		for(int i=0;i<isiDomain.length;i++)
		{
			hashDomain.put(isiDomain[i],i+"");
		}*/
		%>
	    <form name="form1" method="post" action="<%=Config.base_url%>index/pimpinan/saveKonfigurasi">
	      ${message}
	        <table width="100%" border="0">
            <tr>
              <td>Skor Minimum </td>
              <td><label>
                <input name="skor_minimum" type="text" id="skor_minimum" value="<%=data[0][0]%>">
              </label></td>
            </tr>
            <tr>
              <td>Kuota</td>
              <td><label>
                <input name="kuota" type="text" id="kuota" value="<%=data[0][1]%>">
              </label></td>
            </tr>
            <tr>
              <td>Inisialisasi</td>
              <td><label>
                <select name="inisialisasi_kemampuan" id="inisialisasi_kemampuan">
                  <option value="Theta=0" <% if(data[0][2].equals("Theta=0")) { %> selected="selected" <% } %>>Theta=0</option>
                  <option value="Tiga Butir" <% if(data[0][2].equals("Tiga Butir")) { %> selected="selected" <% } %>>Tiga Butir</option>
                  <option value="Tidak Ada" <% if(data[0][2].equals("Tidak Ada")) { %> selected="selected" <% } %>>Tidak Ada</option>
                </select>
              </label></td>
            </tr>
            <tr>
              <td>Model</td>
              <td><label>
                <select name="model_logistik" id="model_logistik">
                  <option value="Tidak Ada" <% if(data[0][3].equals("Tidak Ada")) { %> selected="selected" <% } %>>Tidak Ada</option>
                  <option value="1PL" <% if(data[0][3].equals("1PL")) { %> selected="selected" <% } %>>1PL</option>
                  <option value="2PL" <% if(data[0][3].equals("2PL")) { %> selected="selected" <% } %>>2PL</option>
                  <option value="3PL" <% if(data[0][3].equals("3PL")) { %> selected="selected" <% } %>>3PL</option>
                  <option value="Rasch" <% if(data[0][3].equals("Rasch")) { %> selected="selected" <% } %>>Rasch</option>
                </select>
              </label></td>
            </tr>
            <tr>
              <td>Metode</td>
              <td><label>
                <select name="metode" id="metode">
                  <option value="Tidak Ada" <% if(data[0][4].equals("Tidak Ada")) { %> selected="selected" <% } %>>Tidak Ada</option>
                  <option value="Fumahilow"  <% if(data[0][4].equals("Fumahilow")) { %> selected="selected" <% } %>>Fumahilow</option>
                  <option value="Futsuhilow"  <% if(data[0][4].equals("Futsuhilow")) { %> selected="selected" <% } %>>Futsuhilow</option>
                  <option value="Fusuhilow"  <% if(data[0][4].equals("Fusuhilow")) { %> selected="selected" <% } %>>Fusuhilow</option>
                </select>
              </label></td>
            </tr>
            <tr>
              <td>Penyajian Soal </td>
              <td><label>
                <select name="penyajian_soal" id="penyajian_soal">
                  <option value="Acak"  <% if(data[0][5].equals("Acak")) { %> selected="selected" <% } %>>Acak</option>
                  <option value="Proporsional"  <% if(data[0][5].equals("Proporsional")) { %> selected="selected" <% } %>>Proporsional</option>
                  <option value="Tetap"  <% if(data[0][5].equals("Tetap")) { %> selected="selected" <% } %>>Tetap</option>
                </select>
              </label></td>
            </tr>
            <tr>
              <td>Domain</td>
              <td><label>
			  <%
			  	String domain[][] = Db.getDataSet("select iddomain,domain from domain order by domain");
				for(int i =0; i < domain.length; i++)
				{
			   %>
                <input name="domain_<%=domain[i][0]%>" type="checkbox" id="domain_<%=domain[i][0]%>" value="<%=domain[i][0]%>"  <% 
				String cekDomain[][] = Db.getDataSet("select * from konfigurasi_domain where iddomain="+domain[i][0]);
				if(cekDomain.length>0) { %> checked<% } %>>
                <%=domain[i][1]%></label><br/>
			  <% }
			  %>			  </td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td><label>
                <input type="submit" name="Submit" value="Simpan">
              </label></td>
            </tr>
          </table>
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
