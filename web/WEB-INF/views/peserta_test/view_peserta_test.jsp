<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,recite18th.library.Db,application.config.Config,recite18th.library.Pagination" %><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% int pagenum = 0; %>
<a href="<%=Config.base_url%>index/PesertaTest/input/-1">Tambah Data</a>
<table width="100%" id="rounded-corner">
<thead>
  <tr>
  <th scope="col" class="rounded-company">No.</th>
  <th scope="col" class="rounded-q1">Id</th>
  <th scope="col" class="rounded-q1">Username</th>
  <th scope="col" class="rounded-q1">Password</th>
  <th scope="col" class="rounded-q1">Peran</th>
  <th scope="col" class="rounded-q1">Nomor Peserta</th>
  <th scope="col" class="rounded-q1">Metode</th>
  <th scope="col" class="rounded-q1">Model Logistik</th>
  <th scope="col" class="rounded-q1">Penyajian Soal</th>
  <th scope="col" class="rounded-q1">Inisialisasi Kemampuan</th>
  <th scope="col" class="rounded-q1">Nama Lengkap</th>
  <th scope="col" class="rounded-q1">Asal</th>
  <th scope="col" class="rounded-q1">Tempat Lahir</th>
  <th scope="col" class="rounded-q1">Tanggal Lahir</th>
  <th scope="col" class="rounded-q1">Jenis Kelamin</th>
  <th scope="col" class="rounded-q1">Foto</th>
  <th scope="col" class="rounded-q1">Idpaket Soal</th>
  <th scope="col" class="rounded-q1">Skor Akhir</th>
  <th scope="col" class="rounded-q1">Idpaket Soal Tiga Butir</th>
  <th scope="col" class="rounded-q1">Tingkat Kesukaran</th>
  <th scope="col" class="rounded-q4">Aksi</th>
  </tr>
</thead>
<tfoot>
  <tr>
    <td colspan="20" class="rounded-foot-left"><%=Pagination.createLinks(pagenum)%></td>
    <td class="rounded-foot-right">&nbsp;</td>
  </tr>
</tfoot>
<tbody>
  <c:forEach items="${row}" var="item" varStatus="status" >
    <tr>
      <td>${status.count}</td>
      <td>${item.id}</td>
      <td>${item.username}</td>
      <td>${item.password}</td>
      <td>${item.peran}</td>
      <td>${item.nomor_peserta}</td>
      <td>${item.metode}</td>
      <td>${item.model_logistik}</td>
      <td>${item.penyajian_soal}</td>
      <td>${item.inisialisasi_kemampuan}</td>
      <td>${item.nama_lengkap}</td>
      <td>${item.asal}</td>
      <td>${item.tempat_lahir}</td>
      <td>${item.tanggal_lahir}</td>
      <td>${item.jenis_kelamin}</td>
      <td>${item.foto}</td>
      <td>${item.idpaket_soal}</td>
      <td>${item.skor_akhir}</td>
      <td>${item.idpaket_soal_tiga_butir}</td>
      <td>${item.tingkat_kesukaran}</td>
      <td>
         <a href="<%=Config.base_url%>index/PesertaTest/input/${item.id}">Ubah</a>
         <a href="<%=Config.base_url%>index/PesertaTest/delete/${item.id}" onClick="return confirm('Apakah Anda yakin?');">Hapus</a>
      </td>
    </tr>
  </c:forEach>
</tbody>
</table>
