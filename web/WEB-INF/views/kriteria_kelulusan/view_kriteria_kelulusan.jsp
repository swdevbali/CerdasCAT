<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,recite18th.library.Db,application.config.Config,recite18th.library.Pagination" %><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% int pagenum = 0; %>
<a href="<%=Config.base_url%>index/KriteriaKelulusan/input/-1">Tambah Data</a>
<table width="100%" id="rounded-corner">
<thead>
  <tr>
  <th scope="col" class="rounded-company">No.</th>
  <th scope="col" class="rounded-q1">Idkriteria Kelulusan</th>
  <th scope="col" class="rounded-q1">Kriteria Kelulusan</th>
  <th scope="col" class="rounded-q4">Aksi</th>
  </tr>
</thead>
<tfoot>
  <tr>
    <td colspan="3" class="rounded-foot-left"><%=Pagination.createLinks(pagenum)%></td>
    <td class="rounded-foot-right">&nbsp;</td>
  </tr>
</tfoot>
<tbody>
  <c:forEach items="${row}" var="item" varStatus="status" >
    <tr>
      <td>${status.count}</td>
      <td>${item.idkriteria_kelulusan}</td>
      <td>${item.kriteria_kelulusan}</td>
      <td>
         <a href="<%=Config.base_url%>index/KriteriaKelulusan/input/${item.idkriteria_kelulusan}">Ubah</a>
         <a href="<%=Config.base_url%>index/KriteriaKelulusan/delete/${item.idkriteria_kelulusan}" onClick="return confirm('Apakah Anda yakin?');">Hapus</a>
      </td>
    </tr>
  </c:forEach>
</tbody>
</table>
