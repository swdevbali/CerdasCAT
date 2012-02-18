<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,recite18th.library.Db,application.config.Config,recite18th.library.Pagination" %><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% int pagenum = 0; %>
<a href="<%=Config.base_url%>index/LaporanKelulusan/input/-1">Tambah Data</a>
<table width="100%" id="rounded-corner">
<thead>
  <tr>
  <th scope="col" class="rounded-company">No.</th>
  <th scope="col" class="rounded-q1">Idlaporan Kelulusan</th>
  <th scope="col" class="rounded-q1">Idpeserta Test</th>
  <th scope="col" class="rounded-q1">Nilai Pembobotan</th>
  <th scope="col" class="rounded-q1">Nilai Kriteria</th>
  <th scope="col" class="rounded-q4">Aksi</th>
  </tr>
</thead>
<tfoot>
  <tr>
    <td colspan="5" class="rounded-foot-left"><%=Pagination.createLinks(pagenum)%></td>
    <td class="rounded-foot-right">&nbsp;</td>
  </tr>
</tfoot>
<tbody>
  <c:forEach items="${row}" var="item" varStatus="status" >
    <tr>
      <td>${status.count}</td>
      <td>${item.idlaporan_kelulusan}</td>
      <td>${item.idpeserta_test}</td>
      <td>${item.nilai_pembobotan}</td>
      <td>${item.nilai_kriteria}</td>
      <td>
         <a href="<%=Config.base_url%>index/LaporanKelulusan/input/${item.idlaporan_kelulusan}">Ubah</a>
         <a href="<%=Config.base_url%>index/LaporanKelulusan/delete/${item.idlaporan_kelulusan}" onClick="return confirm('Apakah Anda yakin?');">Hapus</a>
      </td>
    </tr>
  </c:forEach>
</tbody>
</table>
