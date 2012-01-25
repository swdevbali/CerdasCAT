<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,recite18th.library.Db,application.config.Config,recite18th.library.Pagination,recite18th.model.*, application.models.*,java.text.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<%
	String message="";
	int pagenum;
	pagenum = request.getParameter("pagenum")==null ?0:Integer.parseInt(request.getParameter("pagenum")+"");
	Model model = (Model) session.getAttribute("user_credential");
	PesertaTestModel p = null;
	
	if(model instanceof PesertaTestModel)
	{
		PesertaTestModel userCredential = (PesertaTestModel) model;
		p = new PesertaTestModel();
		p.addCriteria("id", userCredential.getId());
		p.get();		
	} else if(model instanceof WaliPesertaTestModel) {
		WaliPesertaTestModel userCredential = (WaliPesertaTestModel) model;
		p = new PesertaTestModel();
		p.addCriteria("id", userCredential.getIdpeserta_test());
		p.get();
	}
	

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
	    <h1 id="Startinguptheproject"><!-- InstanceBeginEditable name="judul_modul" -->Hasil Ujian <!-- InstanceEndEditable --></h1>
	    <!-- InstanceBeginEditable name="isi_modul" -->
	    <table width="81%" border="0">
          <tr>
            <td width="31%" valign="top">Nomor Peserta </td>
            <td width="2%" valign="top">:</td>
            <td width="38%" valign="top"><%=p.getNomor_peserta()%></td>
            <td width="29%" rowspan="7" valign="top"><img src="<%=Config.base_url%>upload/<%=p.getFoto()%>" width="198" height="155"></td>
          </tr>
          <tr valign="top">
            <td>Nama Peserta Test </td>
            <td>:</td>
            <td><%=p.getNama_lengkap()%></td>
          </tr>
          <tr valign="top">
            <td>Metode</td>
            <td>:</td>
            <td><%=p.getMetode()%></td>
          </tr>
          <tr valign="top">
            <td>Inisialisasi</td>
            <td>:</td>
            <td><%=p.getInisialisasi_kemampuan()%></td>
          </tr>
          <tr valign="top">
            <td>Model</td>
            <td>:</td>
            <td><%=p.getModel_logistik()%></td>
          </tr>
          <tr valign="top">
            <td>Penyajian Soal </td>
            <td>:</td>
            <td><%=p.getPenyajian_soal()%></td>
          </tr>
          <tr valign="top">
            <td>Nama Sekolah</td>
            <td>&nbsp;</td>
            <td><%=p.getAsal()%></td>
          </tr>
        </table>
		<c:forEach items="${domain}" var="item" varStatus="status" >
	    <p id="aIntroductiona"><strong>${item.domain}</strong></p>
		
		<% if(p.getMetode().equals("Tidak Ada")) { %>
		
		<%
			String checked="";
			
			
			DomainModel domainModel = ((DomainModel) pageContext.getAttribute("item"));
			String sql = "SELECT s.idsoal,skl.nama_skl,s.rasch_b,p.jawaban,s.jawaban as kunci,if(s.jawaban=p.jawaban,1,0) as nilai,psd.bobot, nilai* bobot as skor " +
" FROM paket_soal_jawaban p, soal s, domain d,skl,paket_soal_detail psd " +
" where s.idskl=skl.idskl and p.idsoal=s.idsoal and s.iddomain = d.iddomain and psd.idsoal=s.idsoal  and p.idpeserta_test =" + p.getId() +
" and d.iddomain=" + domainModel.getIddomain() +" order by p.idpaket_soal_jawaban";
			String data[][] = Db.getDataSet(sql);
		%>
	    <a href="<%=Config.base_url%>index/LihatHasilTest?cetak=true" target="_blank">Cetak</a>
	    <table width="100%" border="0" id="rounded-corner">
		<thead>
			<tr>
			<th scope="col" class="rounded-company">No.</th>
			<th scope="col" class="rounded-q1">ID Soal </th>
			<th scope="col" class="rounded-q1">SKL</th>
			<th align="right" class="rounded-q1" scope="col">b</th>
			<th align="right" class="rounded-q1" scope="col">Jawaban</th>
			<th align="right" class="rounded-q1" scope="col">Kunci</th>
			<th align="right" class="rounded-q1" scope="col">Nilai</th>
			<th align="right" class="rounded-q1" scope="col">Bobot</th>
			<th align="right" class="rounded-q4" scope="col">Skor</th>
			</tr>
		</thead>
		<%
			for(int i = 0; i < data.length; i++)
			{
				
		%>
          <tr>
            <td><%=i+1%></td>
            <td><%=data[i][0]%></td>
            <td><%=data[i][1]%></td>
            <td align="right"><%=format.format(Double.parseDouble(data[i][2]))%></td>
            <td align="right"><%=data[i][3]%></td>
            <td align="right"><%=data[i][4]%></td>
            <td align="right"><%=data[i][5]%></td>
			 <td align="right"><%=data[i][6]%></td>
			 <td align="right"><%=data[i][7]%></td> 			
          </tr>
		 <% } %>
        </table><br>
        <table width="180" border="0">
          <tr>
            <td>Total skor</td>
            <td><%=p.getSkor_akhir()%></td>
          </tr>
          <tr>
            <td>Waktu tempuh</td>
            <td><% 
				String sql2 = "select waktu_tempuh from waktu_tempuh where idpeserta_test=" + p.getId() + " and iddomain = " + domainModel.getIddomain();
				String waktu[][] = Db.getDataSet(sql2);
out.print(waktu[0][0]);
%></td>
          </tr>
        </table>
        <br/> 
		<% } else { %>
		
		
		
		
		<%
			 String checked="";
			
			
			 DomainModel domainModel = ((DomainModel) pageContext.getAttribute("item"));
			 String sql = " SELECT s.idsoal,p.thetaAwal,b,p.nilai as u,se,selisihSE,thetaAkhir,skor,waktu,skl.nama_skl FROM " +
						  " peserta_test_jawaban_dengan_model p, soal s, domain d,skl " +
						  " where s.idskl=skl.idskl and p.idsoal=s.idsoal and s.iddomain = d.iddomain and p.idpeserta_test = '" + 	
						    p.getId() + "' and d.iddomain='"+ domainModel.getIddomain() +
							"' order by p.idpeserta_test_jawaban_dengan_model";
			 String data[][] = Db.getDataSet(sql);
		%>
	    <a href="<%=Config.base_url%>index/LihatHasilTest?cetak=true" target="_blank">Cetak</a>
	    <table width="100%" border="0" id="rounded-corner">
		<thead>
			<tr>
			<th scope="col" class="rounded-company">No.</th>
			<th scope="col" class="rounded-q1">ID Soal </th>
			<th scope="col" class="rounded-q1">SKL</th>
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
            <td><%=data[i][9]%></td>
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
		
		<% } %>
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
