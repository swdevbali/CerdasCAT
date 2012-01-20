<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,recite18th.library.Db,application.config.Config,recite18th.library.Pagination,recite18th.model.*, application.models.*,java.text.*" %>
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
	Model model = (Model) session.getAttribute("user_credential");
	PesertaTestModel p = null;
	
	if(model instanceof PesertaTestModel)
	{
		PesertaTestModel userCredential = (PesertaTestModel) model;
		p = (PesertaTestModel) session.getAttribute("user_credential");
	} else if(model instanceof WaliPesertaTestModel) {
		WaliPesertaTestModel userCredential = (WaliPesertaTestModel) model;
		p = new PesertaTestModel();
		p.addCriteria("id", userCredential.getIdpeserta_test());
		p.get();
	}
	

	NumberFormat format = DecimalFormat.getInstance();
%>

<style type="text/css">
<!--
.style2 {
	font-size: large;
	font-weight: bold;
}
-->
</style>
<script language="Javascript1.2">
  <!--
  function printpage() {
  	window.print();
  }
  //-->
</script>
</head>
<body class="" onLoad="printpage()">
	
	<div id="pageContent">
		
	  <div class="wikistyle">
	    <h1 align="center" id="Startinguptheproject">Hasil Ujian</h1>
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
	    <a href="<%=Config.base_url%>index/LihatHasilTest?cetak=true" target="_blank"></a>
	    <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#000000" id="rounded-corner">
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
            <td><%=i+1%>
            <div align="right"></div></td>
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
		<div align="center">
		  <p>&nbsp;</p>
		  <p><img src="http://localhost/ruklis3/index.php?idpeserta_test=<%=p.getId()%>&iddomain=${item.iddomain}">	
	      </p>
		</div>
		</c:forEach>
</div>
		
		<div id="comments"></div>
</div>
        </div>
		<div id="footer">
			<div class="wrapper">
				<p align="center">Hak Cipta (C) Rukli 2011 <a href="http://www.playapps.net/"></a>				</p>
		  </div>
		</div>
   </body>
</html>
