<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,recite18th.library.Db,application.config.Config,recite18th.library.Pagination,application.models.*,java.text.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<%
	String message="";
	int pagenum;
	pagenum = request.getParameter("pagenum")==null ?0:Integer.parseInt(request.getParameter("pagenum")+"");
	PesertaTestModel p = (PesertaTestModel) session.getAttribute("user_credential");
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
	    <h1 id="Startinguptheproject"><!-- InstanceBeginEditable name="judul_modul" -->Hasil Ujian <!-- InstanceEndEditable --></h1>
	    <!-- InstanceBeginEditable name="isi_modul" -->
	    <table width="81%" border="0">
          <tr>
            <td width="31%" valign="top">Nomor Peserta </td>
            <td width="2%" valign="top">:</td>
            <td width="38%" valign="top">${user_credential.nomor_peserta}</td>
            <td width="29%" rowspan="7" valign="top"><img src="<%=Config.base_url%>upload/${user_credential.foto}" width="198" height="155"></td>
          </tr>
          <tr valign="top">
            <td>Nama Peserta Test </td>
            <td>:</td>
            <td>${user_credential.username}</td>
          </tr>
          <tr valign="top">
            <td>Metode</td>
            <td>:</td>
            <td>${user_credential.metode}</td>
          </tr>
          <tr valign="top">
            <td>Inisialisasi</td>
            <td>:</td>
            <td>${user_credential.inisialisasi_kemampuan}</td>
          </tr>
          <tr valign="top">
            <td>Model</td>
            <td>:</td>
            <td>${user_credential.model_logistik}</td>
          </tr>
          <tr valign="top">
            <td>Penyajian Soal </td>
            <td>:</td>
            <td>${user_credential.penyajian_soal}</td>
          </tr>
          <tr valign="top">
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
        </table>
		<c:forEach items="${domain}" var="item" varStatus="status" >
	    <p id="aIntroductiona"><strong>${item.domain}</strong></p>
		<%
			String checked="";
			
			
			DomainModel domainModel = ((DomainModel) pageContext.getAttribute("item"));
			String sql = " SELECT s.idsoal,p.thetaAwal,b,p.nilai as u,se,selisihSE,thetaAkhir,skor,waktu FROM " +
						  " peserta_test_jawaban_dengan_model p, soal s, domain d " +
						  " where p.idsoal=s.idsoal and s.iddomain = d.iddomain and p.idpeserta_test = '" + 	
						    p.getId() + "' and d.iddomain='"+ domainModel.getIddomain() +
							"' order by p.idpeserta_test_jawaban_dengan_model";
			String data[][] = Db.getDataSet(sql);
		%>
	    <table width="100%" border="0" id="rounded-corner">
		<thead>
			<tr>
			<th scope="col" class="rounded-company">No.</th>
			<th scope="col" class="rounded-q1">ID Soal </th>
			<th align="right" class="rounded-q1" scope="col">Theta Awal </th>
			<% if(!p.getModel_logistik().equals("Rasch")) { %>
			<th align="right" class="rounded-q1" scope="col">a</th>
			<% } %>
			<th align="right" class="rounded-q1" scope="col">b</th>
			<% if(!p.getModel_logistik().equals("Rasch")) { %>
			<th align="right" class="rounded-q1" scope="col">c</th>
			<% } %>
			<th align="right" class="rounded-q1" scope="col">u</th>
			<th align="right" class="rounded-q1" scope="col">SE</th>
			<th align="right" class="rounded-q1" scope="col">Selisih SE </th>
			<th align="right" class="rounded-q1" scope="col">Theta Akhir </th>
			<th align="right" class="rounded-q1" scope="col">Skor</th>
			<th align="right" class="rounded-q4" scope="col">Waktu</th>
			</tr>
		</thead>
		<%
			for(int i = 0; i < data.length; i++)
			{
				
		%>
          <tr>
            <td><%=i+1%></td>
            <td><%=data[i][0]%></td>
            <td align="right"><%=format.format(Double.parseDouble(data[i][1]))%></td>
			<% if(!p.getModel_logistik().equals("Rasch")) { %>
            <td align="right">&nbsp;</td>
			<% } %>
            <td align="right"><%=format.format(Double.parseDouble(data[i][2]))%></td>
			<% if(!p.getModel_logistik().equals("Rasch")) { %>
            <td align="right">&nbsp;</td>
			<% } %>
            <td align="right"><%=data[i][3]%></td>
            <td align="right"><%=format.format(Double.parseDouble(data[i][4]))%></td>
            <td align="right"><%=format.format(Double.parseDouble(data[i][5]))%></td>
            <td align="right"><%=format.format(Double.parseDouble(data[i][6]))%></td>
            <td align="right"><%=format.format(Double.parseDouble(data[i][7]))%></td>
            <td align="right"><%=data[i][8]%></td>
          </tr>
		 <% } %>
        </table>
		<img src="http://localhost/ruklis3/index.php?idpeserta_test=<%=p.getId()%>&iddomain=${item.iddomain}">	
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
