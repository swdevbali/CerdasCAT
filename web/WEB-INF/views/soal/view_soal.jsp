<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,recite18th.library.Db,application.config.Config,recite18th.library.Pagination" %><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% int pagenum = 0; %>
<a href="<%=Config.base_url%>index/Soal/input/-1">Tambah Data</a>
<table width="100%" id="rounded-corner">
<thead>
  <tr>
  <th scope="col" class="rounded-company">No.</th>
  <th scope="col" class="rounded-q1">Idsoal</th>
  <th scope="col" class="rounded-q1">Iddomain</th>
  <th scope="col" class="rounded-q1">Soal</th>
  <th scope="col" class="rounded-q1">Gambar</th>
  <th scope="col" class="rounded-q1">Jawaban</th>
  <th scope="col" class="rounded-q1">Lg1 B</th>
  <th scope="col" class="rounded-q1">Lg2 A</th>
  <th scope="col" class="rounded-q1">Lg2 B</th>
  <th scope="col" class="rounded-q1">Lg3 A</th>
  <th scope="col" class="rounded-q1">Lg3 B</th>
  <th scope="col" class="rounded-q1">Lg3 C</th>
  <th scope="col" class="rounded-q1">Rasch B</th>
  <th scope="col" class="rounded-q1">Idskl</th>
  <th scope="col" class="rounded-q4">Aksi</th>
  </tr>
</thead>
<tfoot>
  <tr>
    <td colspan="14" class="rounded-foot-left"><%=Pagination.createLinks(pagenum)%></td>
    <td class="rounded-foot-right">&nbsp;</td>
  </tr>
</tfoot>
<tbody>
  <c:forEach items="${row}" var="item" varStatus="status" >
    <tr>
      <td>${status.count}</td>
      <td>${item.idsoal}</td>
      <td>${item.iddomain}</td>
      <td>${item.soal}</td>
      <td>${item.gambar}</td>
      <td>${item.jawaban}</td>
      <td>${item.lg1_b}</td>
      <td>${item.lg2_a}</td>
      <td>${item.lg2_b}</td>
      <td>${item.lg3_a}</td>
      <td>${item.lg3_b}</td>
      <td>${item.lg3_c}</td>
      <td>${item.rasch_b}</td>
      <td>${item.idskl}</td>
      <td>
         <a href="<%=Config.base_url%>index/Soal/input/${item.idsoal}">Ubah</a>
         <a href="<%=Config.base_url%>index/Soal/delete/${item.idsoal}" onClick="return confirm('Apakah Anda yakin?');">Hapus</a>
      </td>
    </tr>
  </c:forEach>
</tbody>
</table>
