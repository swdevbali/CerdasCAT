<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,recite18th.library.Db,application.config.Config,recite18th.library.Pagination" %><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% int pagenum = 0; %>
<a href="<%=Config.base_url%>index/PesertaTestJawabanDenganModel/input/-1">Tambah Data</a>
<table width="100%" id="rounded-corner">
<thead>
  <tr>
  <th scope="col" class="rounded-company">No.</th>
  <th scope="col" class="rounded-q1">Idpeserta Test Jawaban Dengan Model</th>
  <th scope="col" class="rounded-q1">Idpeserta Test</th>
  <th scope="col" class="rounded-q1">Idsoal</th>
  <th scope="col" class="rounded-q1">Jawaban</th>
  <th scope="col" class="rounded-q1">Nilai</th>
  <th scope="col" class="rounded-q1">ThetaAwal</th>
  <th scope="col" class="rounded-q1">B</th>
  <th scope="col" class="rounded-q1">P</th>
  <th scope="col" class="rounded-q1">Q</th>
  <th scope="col" class="rounded-q1">PQ</th>
  <th scope="col" class="rounded-q1">SE</th>
  <th scope="col" class="rounded-q1">SelisihSE</th>
  <th scope="col" class="rounded-q1">Skor</th>
  <th scope="col" class="rounded-q1">ThetaAkhir</th>
  <th scope="col" class="rounded-q1">Waktu</th>
  <th scope="col" class="rounded-q4">Aksi</th>
  </tr>
</thead>
<tfoot>
  <tr>
    <td colspan="16" class="rounded-foot-left"><%=Pagination.createLinks(pagenum)%></td>
    <td class="rounded-foot-right">&nbsp;</td>
  </tr>
</tfoot>
<tbody>
  <c:forEach items="${row}" var="item" varStatus="status" >
    <tr>
      <td>${status.count}</td>
      <td>${item.idpeserta_test_jawaban_dengan_model}</td>
      <td>${item.idpeserta_test}</td>
      <td>${item.idsoal}</td>
      <td>${item.jawaban}</td>
      <td>${item.nilai}</td>
      <td>${item.thetaAwal}</td>
      <td>${item.b}</td>
      <td>${item.P}</td>
      <td>${item.Q}</td>
      <td>${item.PQ}</td>
      <td>${item.SE}</td>
      <td>${item.selisihSE}</td>
      <td>${item.skor}</td>
      <td>${item.thetaAkhir}</td>
      <td>${item.waktu}</td>
      <td>
         <a href="<%=Config.base_url%>index/PesertaTestJawabanDenganModel/input/${item.idpeserta_test_jawaban_dengan_model}">Ubah</a>
         <a href="<%=Config.base_url%>index/PesertaTestJawabanDenganModel/delete/${item.idpeserta_test_jawaban_dengan_model}" onClick="return confirm('Apakah Anda yakin?');">Hapus</a>
      </td>
    </tr>
  </c:forEach>
</tbody>
</table>
