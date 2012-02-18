-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.1.37


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema ruklis3
--

CREATE DATABASE IF NOT EXISTS ruklis3;
USE ruklis3;

--
-- Definition of table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `peran` enum('Admin') NOT NULL DEFAULT 'Admin',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` (`id`,`username`,`password`,`peran`) VALUES 
 (1,'admin','admin','Admin'),
 (3,'admin2','admin2','Admin'),
 (4,'Guntur','guntur','Admin');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;


--
-- Definition of table `domain`
--

DROP TABLE IF EXISTS `domain`;
CREATE TABLE `domain` (
  `iddomain` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `domain` varchar(45) NOT NULL,
  PRIMARY KEY (`iddomain`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `domain`
--

/*!40000 ALTER TABLE `domain` DISABLE KEYS */;
INSERT INTO `domain` (`iddomain`,`domain`) VALUES 
 (1,'Bahasa Indonesia'),
 (10,'Matematika'),
 (11,'IPA');
/*!40000 ALTER TABLE `domain` ENABLE KEYS */;


--
-- Definition of table `kelulusan`
--

DROP TABLE IF EXISTS `kelulusan`;
CREATE TABLE `kelulusan` (
  `idkelulusan` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nama_kelulusan` varchar(45) NOT NULL,
  PRIMARY KEY (`idkelulusan`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `kelulusan`
--

/*!40000 ALTER TABLE `kelulusan` DISABLE KEYS */;
INSERT INTO `kelulusan` (`idkelulusan`,`nama_kelulusan`) VALUES 
 (1,'Kelulusan UASBN 2010');
/*!40000 ALTER TABLE `kelulusan` ENABLE KEYS */;


--
-- Definition of table `kelulusan_bobot`
--

DROP TABLE IF EXISTS `kelulusan_bobot`;
CREATE TABLE `kelulusan_bobot` (
  `idkelulusan_bobot` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idkelulusan` int(10) unsigned NOT NULL,
  `idkriteria_kelulusan` int(10) unsigned NOT NULL,
  `bobot` double NOT NULL,
  PRIMARY KEY (`idkelulusan_bobot`),
  KEY `FK_kelulusan_bobot_1` (`idkelulusan`),
  KEY `FK_kelulusan_bobot_2` (`idkriteria_kelulusan`),
  CONSTRAINT `FK_kelulusan_bobot_1` FOREIGN KEY (`idkelulusan`) REFERENCES `kelulusan` (`idkelulusan`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_kelulusan_bobot_2` FOREIGN KEY (`idkriteria_kelulusan`) REFERENCES `kriteria_kelulusan` (`idkriteria_kelulusan`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `kelulusan_bobot`
--

/*!40000 ALTER TABLE `kelulusan_bobot` DISABLE KEYS */;
INSERT INTO `kelulusan_bobot` (`idkelulusan_bobot`,`idkelulusan`,`idkriteria_kelulusan`,`bobot`) VALUES 
 (11,1,1,40),
 (12,1,2,20),
 (13,1,3,5),
 (14,1,4,30),
 (15,1,5,5);
/*!40000 ALTER TABLE `kelulusan_bobot` ENABLE KEYS */;


--
-- Definition of table `konfigurasi`
--

DROP TABLE IF EXISTS `konfigurasi`;
CREATE TABLE `konfigurasi` (
  `idkonfigurasi` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `kuota` int(10) unsigned NOT NULL,
  `skor_minimum` double NOT NULL,
  PRIMARY KEY (`idkonfigurasi`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `konfigurasi`
--

/*!40000 ALTER TABLE `konfigurasi` DISABLE KEYS */;
INSERT INTO `konfigurasi` (`idkonfigurasi`,`kuota`,`skor_minimum`) VALUES 
 (1,3,70.12);
/*!40000 ALTER TABLE `konfigurasi` ENABLE KEYS */;


--
-- Definition of table `kriteria_kelulusan`
--

DROP TABLE IF EXISTS `kriteria_kelulusan`;
CREATE TABLE `kriteria_kelulusan` (
  `idkriteria_kelulusan` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `kriteria_kelulusan` varchar(45) NOT NULL,
  PRIMARY KEY (`idkriteria_kelulusan`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `kriteria_kelulusan`
--

/*!40000 ALTER TABLE `kriteria_kelulusan` DISABLE KEYS */;
INSERT INTO `kriteria_kelulusan` (`idkriteria_kelulusan`,`kriteria_kelulusan`) VALUES 
 (1,'Nilai Pembobotan'),
 (2,'Ujian Sekolah'),
 (3,'Pengamatan'),
 (4,'Stakeholder'),
 (5,'Lain-Lain');
/*!40000 ALTER TABLE `kriteria_kelulusan` ENABLE KEYS */;


--
-- Definition of table `laporan_kelulusan`
--

DROP TABLE IF EXISTS `laporan_kelulusan`;
CREATE TABLE `laporan_kelulusan` (
  `idlaporan_kelulusan` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idpeserta_test` int(10) unsigned NOT NULL,
  `nilai_pembobotan` double NOT NULL,
  `nilai_kriteria` double NOT NULL,
  PRIMARY KEY (`idlaporan_kelulusan`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `laporan_kelulusan`
--

/*!40000 ALTER TABLE `laporan_kelulusan` DISABLE KEYS */;
INSERT INTO `laporan_kelulusan` (`idlaporan_kelulusan`,`idpeserta_test`,`nilai_pembobotan`,`nilai_kriteria`) VALUES 
 (97,1,0,0),
 (98,3,32.42,61.018),
 (99,4,0,0),
 (100,6,0,0),
 (101,7,0,0),
 (102,8,0,0),
 (103,9,0,0),
 (104,10,0,0),
 (105,11,0,0),
 (106,12,0,0),
 (107,13,0,0),
 (108,14,0,0),
 (109,15,23.2675,49.207),
 (110,16,0,0),
 (111,17,0,0),
 (112,18,18.23,38.842);
/*!40000 ALTER TABLE `laporan_kelulusan` ENABLE KEYS */;


--
-- Definition of table `paket_soal`
--

DROP TABLE IF EXISTS `paket_soal`;
CREATE TABLE `paket_soal` (
  `idpaket_soal` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tanggal` date NOT NULL,
  `keterangan` text NOT NULL,
  `waktu_maksimal` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idpaket_soal`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `paket_soal`
--

/*!40000 ALTER TABLE `paket_soal` DISABLE KEYS */;
INSERT INTO `paket_soal` (`idpaket_soal`,`tanggal`,`keterangan`,`waktu_maksimal`) VALUES 
 (1,'2011-03-28','Paket Soal Bahasa Indonesia',120);
/*!40000 ALTER TABLE `paket_soal` ENABLE KEYS */;


--
-- Definition of table `paket_soal_detail`
--

DROP TABLE IF EXISTS `paket_soal_detail`;
CREATE TABLE `paket_soal_detail` (
  `idpaket_soal_detail` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idpaket_soal` int(10) unsigned NOT NULL,
  `idsoal` int(10) unsigned NOT NULL,
  `bobot` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idpaket_soal_detail`),
  UNIQUE KEY `Index_4_unique` (`idpaket_soal`,`idsoal`),
  KEY `FK_paket_soal_detail_2` (`idsoal`),
  CONSTRAINT `FK_paket_soal_detail_1` FOREIGN KEY (`idpaket_soal`) REFERENCES `paket_soal` (`idpaket_soal`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_paket_soal_detail_2` FOREIGN KEY (`idsoal`) REFERENCES `soal` (`idsoal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `paket_soal_detail`
--

/*!40000 ALTER TABLE `paket_soal_detail` DISABLE KEYS */;
INSERT INTO `paket_soal_detail` (`idpaket_soal_detail`,`idpaket_soal`,`idsoal`,`bobot`) VALUES 
 (73,1,49,0),
 (74,1,50,12),
 (75,1,51,4),
 (76,1,52,1),
 (77,1,53,2),
 (78,1,5,2),
 (79,1,7,2),
 (80,1,8,3),
 (81,1,9,2),
 (82,1,10,2),
 (83,1,11,0);
/*!40000 ALTER TABLE `paket_soal_detail` ENABLE KEYS */;


--
-- Definition of table `paket_soal_jawaban`
--

DROP TABLE IF EXISTS `paket_soal_jawaban`;
CREATE TABLE `paket_soal_jawaban` (
  `idpaket_soal_jawaban` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idpaket_soal` int(10) unsigned NOT NULL,
  `idsoal` int(10) unsigned NOT NULL,
  `idpeserta_test` int(10) unsigned NOT NULL,
  `jawaban` enum('A','B','C','D') NOT NULL,
  PRIMARY KEY (`idpaket_soal_jawaban`),
  KEY `FK_paket_soal_jawaban_1` (`idpaket_soal`),
  KEY `FK_paket_soal_jawaban_2` (`idsoal`),
  KEY `FK_paket_soal_jawaban_3` (`idpeserta_test`),
  CONSTRAINT `FK_paket_soal_jawaban_1` FOREIGN KEY (`idpaket_soal`) REFERENCES `paket_soal` (`idpaket_soal`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_paket_soal_jawaban_2` FOREIGN KEY (`idsoal`) REFERENCES `soal` (`idsoal`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_paket_soal_jawaban_3` FOREIGN KEY (`idpeserta_test`) REFERENCES `peserta_test` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `paket_soal_jawaban`
--

/*!40000 ALTER TABLE `paket_soal_jawaban` DISABLE KEYS */;
INSERT INTO `paket_soal_jawaban` (`idpaket_soal_jawaban`,`idpaket_soal`,`idsoal`,`idpeserta_test`,`jawaban`) VALUES 
 (46,1,8,1,'C'),
 (47,1,10,1,'C'),
 (48,1,11,1,'C'),
 (50,1,49,1,'A'),
 (51,1,50,1,'A'),
 (52,1,51,1,'A'),
 (53,1,52,1,'A'),
 (54,1,53,1,'A'),
 (55,1,5,1,'B'),
 (56,1,9,1,'B'),
 (57,1,7,1,'B');
/*!40000 ALTER TABLE `paket_soal_jawaban` ENABLE KEYS */;


--
-- Definition of table `paket_soal_tiga_butir`
--

DROP TABLE IF EXISTS `paket_soal_tiga_butir`;
CREATE TABLE `paket_soal_tiga_butir` (
  `idpaket_soal_tiga_butir` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tanggal` date NOT NULL,
  `keterangan` text NOT NULL,
  `waktu_maksimal` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idpaket_soal_tiga_butir`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `paket_soal_tiga_butir`
--

/*!40000 ALTER TABLE `paket_soal_tiga_butir` DISABLE KEYS */;
INSERT INTO `paket_soal_tiga_butir` (`idpaket_soal_tiga_butir`,`tanggal`,`keterangan`,`waktu_maksimal`) VALUES 
 (1,'2009-01-01','Bahasa Indonesia dan Matematika',12),
 (2,'2010-12-12','Domain IPA, Mat, dan Bahasa Indo',12),
 (3,'2011-11-12','Tiga Paket Lho',9),
 (4,'2011-05-16','Matematika',180);
/*!40000 ALTER TABLE `paket_soal_tiga_butir` ENABLE KEYS */;


--
-- Definition of table `paket_soal_tiga_butir_detail`
--

DROP TABLE IF EXISTS `paket_soal_tiga_butir_detail`;
CREATE TABLE `paket_soal_tiga_butir_detail` (
  `idpaket_soal_tiga_butir_detail` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idpaket_soal_tiga_butir` int(10) unsigned NOT NULL,
  `idsoal` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idpaket_soal_tiga_butir_detail`),
  UNIQUE KEY `Index_5_unique` (`idpaket_soal_tiga_butir`,`idsoal`),
  KEY `FK_paket_soal_tiga_butir_detail_1` (`idsoal`),
  CONSTRAINT `FK_paket_soal_tiga_butir_detail_1` FOREIGN KEY (`idsoal`) REFERENCES `soal` (`idsoal`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_paket_soal_tiga_butir_detail_2` FOREIGN KEY (`idpaket_soal_tiga_butir`) REFERENCES `paket_soal_tiga_butir` (`idpaket_soal_tiga_butir`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `paket_soal_tiga_butir_detail`
--

/*!40000 ALTER TABLE `paket_soal_tiga_butir_detail` DISABLE KEYS */;
INSERT INTO `paket_soal_tiga_butir_detail` (`idpaket_soal_tiga_butir_detail`,`idpaket_soal_tiga_butir`,`idsoal`) VALUES 
 (45,1,9),
 (46,1,23),
 (42,1,60),
 (43,1,65),
 (44,1,68),
 (47,1,124),
 (33,2,5),
 (34,2,7),
 (35,2,11),
 (30,2,49),
 (31,2,50),
 (32,2,53),
 (76,3,5),
 (77,3,21),
 (73,3,56),
 (74,3,64),
 (75,3,69),
 (78,3,118),
 (79,3,135),
 (80,3,136),
 (81,3,139),
 (85,4,12),
 (86,4,17),
 (87,4,28);
/*!40000 ALTER TABLE `paket_soal_tiga_butir_detail` ENABLE KEYS */;


--
-- Definition of table `paket_soal_tiga_butir_jawaban`
--

DROP TABLE IF EXISTS `paket_soal_tiga_butir_jawaban`;
CREATE TABLE `paket_soal_tiga_butir_jawaban` (
  `idpaket_soal_tiga_butir_jawaban` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idpaket_soal_tiga_butir` int(10) unsigned NOT NULL,
  `idsoal` int(10) unsigned NOT NULL,
  `idpeserta_test` int(10) unsigned NOT NULL,
  `jawaban` enum('A','B','C','D') NOT NULL,
  PRIMARY KEY (`idpaket_soal_tiga_butir_jawaban`),
  KEY `FK_paket_soal_tiga_butir_jawaban_1` (`idsoal`),
  KEY `FK_paket_soal_tiga_butir_jawaban_2` (`idpaket_soal_tiga_butir`),
  KEY `FK_paket_soal_tiga_butir_jawaban_3` (`idpeserta_test`),
  CONSTRAINT `FK_paket_soal_tiga_butir_jawaban_1` FOREIGN KEY (`idsoal`) REFERENCES `soal` (`idsoal`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_paket_soal_tiga_butir_jawaban_2` FOREIGN KEY (`idpaket_soal_tiga_butir`) REFERENCES `paket_soal_tiga_butir` (`idpaket_soal_tiga_butir`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_paket_soal_tiga_butir_jawaban_3` FOREIGN KEY (`idpeserta_test`) REFERENCES `peserta_test` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=847 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `paket_soal_tiga_butir_jawaban`
--

/*!40000 ALTER TABLE `paket_soal_tiga_butir_jawaban` DISABLE KEYS */;
INSERT INTO `paket_soal_tiga_butir_jawaban` (`idpaket_soal_tiga_butir_jawaban`,`idpaket_soal_tiga_butir`,`idsoal`,`idpeserta_test`,`jawaban`) VALUES 
 (790,2,50,6,'A'),
 (791,2,49,6,'B'),
 (792,2,53,6,'B'),
 (793,2,11,6,'B'),
 (794,2,5,6,'B'),
 (795,2,7,6,'A'),
 (796,4,28,6,'A'),
 (797,4,12,6,'A'),
 (798,4,17,6,'B'),
 (799,3,64,3,'A'),
 (800,3,69,3,'A'),
 (801,3,56,3,'B'),
 (844,3,5,3,'A'),
 (845,3,118,3,'A'),
 (846,3,21,3,'A');
/*!40000 ALTER TABLE `paket_soal_tiga_butir_jawaban` ENABLE KEYS */;


--
-- Definition of table `pembobotan`
--

DROP TABLE IF EXISTS `pembobotan`;
CREATE TABLE `pembobotan` (
  `idpembobotan` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nama_pembobotan` varchar(45) NOT NULL,
  PRIMARY KEY (`idpembobotan`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pembobotan`
--

/*!40000 ALTER TABLE `pembobotan` DISABLE KEYS */;
INSERT INTO `pembobotan` (`idpembobotan`,`nama_pembobotan`) VALUES 
 (1,'Pembobotan UASBN 2011');
/*!40000 ALTER TABLE `pembobotan` ENABLE KEYS */;


--
-- Definition of table `pembobotan_domain`
--

DROP TABLE IF EXISTS `pembobotan_domain`;
CREATE TABLE `pembobotan_domain` (
  `idpembobotan_domain` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idpembobotan` int(10) unsigned NOT NULL,
  `iddomain` int(10) unsigned NOT NULL,
  `bobot` double NOT NULL,
  PRIMARY KEY (`idpembobotan_domain`),
  KEY `FK_pembobotan_domain_1` (`idpembobotan`),
  KEY `FK_pembobotan_domain_2` (`iddomain`),
  CONSTRAINT `FK_pembobotan_domain_1` FOREIGN KEY (`idpembobotan`) REFERENCES `pembobotan` (`idpembobotan`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pembobotan_domain_2` FOREIGN KEY (`iddomain`) REFERENCES `domain` (`iddomain`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pembobotan_domain`
--

/*!40000 ALTER TABLE `pembobotan_domain` DISABLE KEYS */;
INSERT INTO `pembobotan_domain` (`idpembobotan_domain`,`idpembobotan`,`iddomain`,`bobot`) VALUES 
 (13,1,1,20),
 (14,1,11,20),
 (15,1,10,60);
/*!40000 ALTER TABLE `pembobotan_domain` ENABLE KEYS */;


--
-- Definition of table `pengajar`
--

DROP TABLE IF EXISTS `pengajar`;
CREATE TABLE `pengajar` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `peran` enum('Pengajar') NOT NULL DEFAULT 'Pengajar',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pengajar`
--

/*!40000 ALTER TABLE `pengajar` DISABLE KEYS */;
INSERT INTO `pengajar` (`id`,`username`,`password`,`peran`) VALUES 
 (1,'pengajar','pengajar','Pengajar'),
 (2,'Erni','erni','Pengajar');
/*!40000 ALTER TABLE `pengajar` ENABLE KEYS */;


--
-- Definition of table `peserta_test`
--

DROP TABLE IF EXISTS `peserta_test`;
CREATE TABLE `peserta_test` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `peran` enum('Peserta Test') NOT NULL,
  `nomor_peserta` varchar(45) NOT NULL,
  `metode` enum('Tidak Ada','Fumahilow','Fusuhilow','Futsuhilow') NOT NULL,
  `model_logistik` enum('Tidak Ada','1PL','2PL','3PL','Rasch') NOT NULL,
  `penyajian_soal` enum('Acak','Proporsional','Tetap') NOT NULL,
  `inisialisasi_kemampuan` enum('Theta=0','Tiga Butir','Tidak Ada') NOT NULL,
  `nama_lengkap` varchar(45) NOT NULL,
  `asal` varchar(45) NOT NULL,
  `tempat_lahir` varchar(45) NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `jenis_kelamin` enum('Pria','Wanita') NOT NULL,
  `foto` varchar(45) DEFAULT NULL,
  `idpaket_soal` int(10) unsigned DEFAULT NULL,
  `skor_akhir` int(10) unsigned DEFAULT NULL,
  `idpaket_soal_tiga_butir` int(10) unsigned DEFAULT NULL,
  `tingkat_kesukaran` enum('Sangat Tinggi','Tinggi','Sedang','Rendah','Sangat Rendah') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_peserta_test_1` (`idpaket_soal`),
  KEY `FK_peserta_test_2` (`idpaket_soal_tiga_butir`),
  CONSTRAINT `FK_peserta_test_1` FOREIGN KEY (`idpaket_soal`) REFERENCES `paket_soal` (`idpaket_soal`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_peserta_test_2` FOREIGN KEY (`idpaket_soal_tiga_butir`) REFERENCES `paket_soal_tiga_butir` (`idpaket_soal_tiga_butir`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `peserta_test`
--

/*!40000 ALTER TABLE `peserta_test` DISABLE KEYS */;
INSERT INTO `peserta_test` (`id`,`username`,`password`,`peran`,`nomor_peserta`,`metode`,`model_logistik`,`penyajian_soal`,`inisialisasi_kemampuan`,`nama_lengkap`,`asal`,`tempat_lahir`,`tanggal_lahir`,`jenis_kelamin`,`foto`,`idpaket_soal`,`skor_akhir`,`idpaket_soal_tiga_butir`,`tingkat_kesukaran`) VALUES 
 (1,'eko','eko','Peserta Test','20101010','Tidak Ada','Tidak Ada','Tetap','Tidak Ada','Eko Suprapto Wibowo','SDN 2 Tamanan','Denpasar','1979-06-27','Pria','19022011(005).jpg',1,17,NULL,'Sangat Tinggi'),
 (3,'joko','joko','Peserta Test','0001_010_2001','Futsuhilow','Rasch','Proporsional','Tiga Butir','Mr Joko','SD 1 Semarang','Bulak','1975-02-22','Pria','Winter.jpg',NULL,0,3,'Tinggi'),
 (4,'nisa','nisa','Peserta Test','','Fumahilow','1PL','Acak','Theta=0','','','','2007-09-13','Pria','',NULL,0,NULL,'Sangat Tinggi'),
 (5,'99','99','Peserta Test','99','Tidak Ada','Tidak Ada','Acak','Tidak Ada','99','99','99','2003-01-01','Pria',NULL,NULL,NULL,NULL,NULL),
 (6,'rukli_OK','rukli','Peserta Test','680302-01010102-001','Futsuhilow','Rasch','Acak','Tiga Butir','rukli','SD 1 Lamappoloware','Lajoa','1968-03-02','Pria',NULL,NULL,NULL,4,'Sangat Rendah'),
 (7,'ulhaq','ulhaq','Peserta Test','020610-10110101-101','Fumahilow','Rasch','Proporsional','Tiga Butir','Muh. Dliyaul Haq','Bandung','Makassar','2002-01-01','Pria',NULL,NULL,NULL,NULL,NULL),
 (8,'ila','ila','Peserta Test','040101-02030109-019','Fusuhilow','Rasch','Proporsional','Tiga Butir','Ilahiyah Ina','Cacaleppeng','Cacaleppeng','2004-01-03','Wanita',NULL,NULL,NULL,NULL,NULL),
 (9,'ati','ati','Peserta Test','680915-20101032-086','Futsuhilow','Rasch','Proporsional','Tiga Butir','Ati Dwi Septawati','Bandung','Bandung','1968-09-15','Wanita','sayang.jpg',NULL,NULL,2,'Sangat Tinggi'),
 (10,'adli','adli','Peserta Test','960512-10191410-087','Fusuhilow','Rasch','Proporsional','Tiga Butir','Moh. Adli Akbar','Makassar','Makassar','1996-04-06','Pria',NULL,NULL,NULL,NULL,NULL),
 (11,'habibi','habibi','Peserta Test','000103-10131016-009','Fusuhilow','Rasch','Proporsional','Tiga Butir','Moh. Habibi Akbar','SD Makassar','Makassar','2000-03-01','Pria',NULL,NULL,NULL,NULL,NULL),
 (12,'arham','arham','Peserta Test','010914-10191716-012','Fumahilow','Rasch','Proporsional','Tiga Butir','Arham','SD 175 Jennae','Cacaleppeng','2001-09-14','Pria',NULL,NULL,NULL,NULL,NULL),
 (13,'adnan','adnan','Peserta Test','010914-10191716-012','Fumahilow','Rasch','Proporsional','Tiga Butir','Adnan','Lajoa','Lajoa','2001-09-14','Pria',NULL,NULL,NULL,NULL,NULL),
 (14,'akbar','akbar','Peserta Test','060101-10101014-129','Fumahilow','Rasch','Proporsional','Tiga Butir','Akbar','Cacaleppeng','Cacaleppeng','2006-01-15','Pria',NULL,NULL,NULL,NULL,NULL),
 (15,'budi','budi','Peserta Test','020901-10111213-002','Futsuhilow','Rasch','Proporsional','Tiga Butir','Budianto','Yogya','Yogya','2002-09-01','Pria',NULL,NULL,NULL,1,'Sangat Rendah');
/*!40000 ALTER TABLE `peserta_test` ENABLE KEYS */;


--
-- Definition of table `peserta_test_domain`
--

DROP TABLE IF EXISTS `peserta_test_domain`;
CREATE TABLE `peserta_test_domain` (
  `idpeserta_test_domain` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idpeserta_test` int(10) unsigned NOT NULL,
  `iddomain` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idpeserta_test_domain`),
  KEY `FK_peserta_test_domain_1` (`idpeserta_test`),
  KEY `FK_peserta_test_domain_2` (`iddomain`),
  CONSTRAINT `FK_peserta_test_domain_1` FOREIGN KEY (`idpeserta_test`) REFERENCES `peserta_test` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_peserta_test_domain_2` FOREIGN KEY (`iddomain`) REFERENCES `domain` (`iddomain`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `peserta_test_domain`
--

/*!40000 ALTER TABLE `peserta_test_domain` DISABLE KEYS */;
INSERT INTO `peserta_test_domain` (`idpeserta_test_domain`,`idpeserta_test`,`iddomain`) VALUES 
 (7,4,1),
 (8,4,10),
 (13,1,1),
 (14,1,10),
 (29,15,1),
 (30,15,10),
 (31,9,1),
 (32,9,10),
 (33,9,11),
 (41,6,10),
 (42,3,10);
/*!40000 ALTER TABLE `peserta_test_domain` ENABLE KEYS */;


--
-- Definition of table `peserta_test_jawaban_dengan_model`
--

DROP TABLE IF EXISTS `peserta_test_jawaban_dengan_model`;
CREATE TABLE `peserta_test_jawaban_dengan_model` (
  `idpeserta_test_jawaban_dengan_model` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idpeserta_test` int(10) unsigned NOT NULL,
  `idsoal` int(10) unsigned NOT NULL,
  `jawaban` enum('A','B','C','D') NOT NULL,
  `nilai` int(10) unsigned NOT NULL,
  `thetaAwal` double NOT NULL,
  `b` double NOT NULL,
  `P` double NOT NULL,
  `Q` double NOT NULL,
  `PQ` double NOT NULL,
  `SE` double NOT NULL,
  `selisihSE` double NOT NULL,
  `skor` double NOT NULL,
  `thetaAkhir` double NOT NULL,
  `waktu` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`idpeserta_test_jawaban_dengan_model`),
  KEY `FK_peserta_test_jawaban_dengan_model_1` (`idpeserta_test`),
  KEY `FK_peserta_test_jawaban_dengan_model_2` (`idsoal`),
  CONSTRAINT `FK_peserta_test_jawaban_dengan_model_1` FOREIGN KEY (`idpeserta_test`) REFERENCES `peserta_test` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_peserta_test_jawaban_dengan_model_2` FOREIGN KEY (`idsoal`) REFERENCES `soal` (`idsoal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=887 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `peserta_test_jawaban_dengan_model`
--

/*!40000 ALTER TABLE `peserta_test_jawaban_dengan_model` DISABLE KEYS */;
INSERT INTO `peserta_test_jawaban_dengan_model` (`idpeserta_test_jawaban_dengan_model`,`idpeserta_test`,`idsoal`,`jawaban`,`nilai`,`thetaAwal`,`b`,`P`,`Q`,`PQ`,`SE`,`selisihSE`,`skor`,`thetaAkhir`,`waktu`) VALUES 
 (884,3,171,'A',0,0,1.952,0.5,0.5,0.25,2,2,74.4,1.952,'2:57'),
 (885,3,193,'A',0,1.952,1.316,0.5,0.5,0.25,1.41421356237309,1.41421356237309,66.45,1.316,'3:0'),
 (886,3,180,'A',0,1.316,1.094,0.5,0.5,0.25,1.15470053837925,0.259513023993843,63.675,1.094,'2:55');
/*!40000 ALTER TABLE `peserta_test_jawaban_dengan_model` ENABLE KEYS */;


--
-- Definition of table `peserta_test_kriteria_kelulusan`
--

DROP TABLE IF EXISTS `peserta_test_kriteria_kelulusan`;
CREATE TABLE `peserta_test_kriteria_kelulusan` (
  `idpeserta_test_kriteria_kelulusan` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idpeserta_test` int(10) unsigned NOT NULL,
  `idkriteria_kelulusan` int(10) unsigned NOT NULL,
  `nilai` double NOT NULL,
  PRIMARY KEY (`idpeserta_test_kriteria_kelulusan`),
  KEY `FK_peserta_test_kriteria_kelulusan_1` (`idpeserta_test`),
  KEY `FK_peserta_test_kriteria_kelulusan_2` (`idkriteria_kelulusan`),
  CONSTRAINT `FK_peserta_test_kriteria_kelulusan_1` FOREIGN KEY (`idpeserta_test`) REFERENCES `peserta_test` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_peserta_test_kriteria_kelulusan_2` FOREIGN KEY (`idkriteria_kelulusan`) REFERENCES `kriteria_kelulusan` (`idkriteria_kelulusan`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `peserta_test_kriteria_kelulusan`
--

/*!40000 ALTER TABLE `peserta_test_kriteria_kelulusan` DISABLE KEYS */;
INSERT INTO `peserta_test_kriteria_kelulusan` (`idpeserta_test_kriteria_kelulusan`,`idpeserta_test`,`idkriteria_kelulusan`,`nilai`) VALUES 
 (6,3,2,90),
 (7,3,3,89),
 (8,3,4,70),
 (9,3,5,92),
 (10,15,2,90),
 (11,15,3,76),
 (12,15,4,55),
 (13,15,5,32),
 (14,18,2,87),
 (15,18,3,65),
 (16,18,4,33),
 (17,18,5,20);
/*!40000 ALTER TABLE `peserta_test_kriteria_kelulusan` ENABLE KEYS */;


--
-- Definition of table `pimpinan`
--

DROP TABLE IF EXISTS `pimpinan`;
CREATE TABLE `pimpinan` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `peran` enum('Kepala Sekolah') NOT NULL DEFAULT 'Kepala Sekolah',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pimpinan`
--

/*!40000 ALTER TABLE `pimpinan` DISABLE KEYS */;
INSERT INTO `pimpinan` (`id`,`username`,`password`,`peran`) VALUES 
 (1,'kepala sekolah','kepala sekolah','Kepala Sekolah'),
 (3,'guru bp','guru bp','Kepala Sekolah'),
 (4,'Bakri','bakri','Kepala Sekolah');
/*!40000 ALTER TABLE `pimpinan` ENABLE KEYS */;


--
-- Definition of table `skl`
--

DROP TABLE IF EXISTS `skl`;
CREATE TABLE `skl` (
  `idskl` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nama_skl` varchar(45) NOT NULL,
  `iddomain` int(10) unsigned DEFAULT NULL,
  `prioritas` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`idskl`),
  KEY `FK_skl_1` (`iddomain`),
  CONSTRAINT `FK_skl_1` FOREIGN KEY (`iddomain`) REFERENCES `domain` (`iddomain`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `skl`
--

/*!40000 ALTER TABLE `skl` DISABLE KEYS */;
INSERT INTO `skl` (`idskl`,`nama_skl`,`iddomain`,`prioritas`) VALUES 
 (1,'Baca',1,1),
 (2,'Wacana',1,3),
 (5,'Hewan',11,NULL),
 (6,'Tumbuhan',11,NULL),
 (7,'Bilangan dan Penerapan',10,1),
 (8,'Bangun dan Penerapan',10,3),
 (9,'Ukuran dan Penerapan',10,2),
 (10,'Koordinat dan Penerapan',10,4),
 (11,'Data dan Penerapan',10,5),
 (12,'Tulis',1,2);
/*!40000 ALTER TABLE `skl` ENABLE KEYS */;


--
-- Definition of table `soal`
--

DROP TABLE IF EXISTS `soal`;
CREATE TABLE `soal` (
  `idsoal` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `iddomain` int(10) unsigned NOT NULL,
  `soal` text COLLATE latin1_general_ci NOT NULL,
  `gambar` text COLLATE latin1_general_ci,
  `jawaban` enum('A','B','C','D','E') CHARACTER SET latin1 NOT NULL,
  `lg1_b` double NOT NULL,
  `lg2_a` double NOT NULL,
  `lg2_b` double NOT NULL,
  `lg3_a` double NOT NULL,
  `lg3_b` double NOT NULL,
  `lg3_c` double NOT NULL,
  `rasch_b` double NOT NULL,
  `idskl` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`idsoal`),
  KEY `FK_soal_1` (`iddomain`),
  KEY `FK_soal_2` (`idskl`),
  CONSTRAINT `FK_soal_1` FOREIGN KEY (`iddomain`) REFERENCES `domain` (`iddomain`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_soal_2` FOREIGN KEY (`idskl`) REFERENCES `skl` (`idskl`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=195 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `soal`
--

/*!40000 ALTER TABLE `soal` DISABLE KEYS */;
INSERT INTO `soal` (`idsoal`,`iddomain`,`soal`,`gambar`,`jawaban`,`lg1_b`,`lg2_a`,`lg2_b`,`lg3_a`,`lg3_b`,`lg3_c`,`rasch_b`,`idskl`) VALUES 
 (5,10,'','2MAT1_2010.jpg','A',0,0,0,0,0,0,-2.098,7),
 (7,10,'eee','21MAT1_2010.jpg','D',0,0,0,0,0,0,0.161,1),
 (8,10,'','3MAT1_2010.png','C',0,0,0,0,0,0,1.24,1),
 (9,10,'','18MAT1_2010.jpg','C',0,0,0,0,0,0,-0.976,1),
 (10,10,'','9MAT1_2009.gif','C',0,0,0,0,0,0,-0.976,1),
 (11,10,'','9MAT1_2009.gif','C',0,0,0,0,0,0,-1.05,1),
 (12,10,'','15MAT1_2010.jpg','B',0,0,0,0,0,0,1.247,1),
 (13,10,'','12MAT1_2009.jpg','B',0,0,0,0,0,0,-1.94,1),
 (14,10,'','33MAT1_2010.jpg','C',0,0,0,0,0,0,0.146,1),
 (15,10,'','14MAT1_2009.jpg','D',0,0,0,0,0,0,3.452,1),
 (16,10,'','15MAT1_2009.jpg','C',0,0,0,0,0,0,0.786,1),
 (17,10,'','2MAT1_2010.jpg','D',0,0,0,0,0,0,-2.098,1),
 (18,10,'','39MAT1_2010.jpg','C',0,0,0,0,0,0,0,1),
 (19,10,'','19MAT1_2010.jpg','A',0,0,0,0,0,0,-2.356,1),
 (20,10,'','36MAT1_2010.jpg','B',0,0,0,0,0,0,-1.953,7),
 (21,10,'','38MAT1_2010.jpg','D',0,0,0,0,0,0,2.578,1),
 (22,10,'','19MAT1_2010.jpg','D',0,0,0,0,0,0,0.304,1),
 (23,10,'','36MAT1_2010.jpg','D',0,0,0,0,0,0,0.009,1),
 (24,10,'','32MAT1_2010.jpg','B',0,0,0,0,0,0,-3.987,1),
 (25,10,'','30MAT1_2010.jpg','D',0,0,0,0,0,0,0.954,1),
 (26,10,'','3MAT1_2010.jpg','B',0,0,0,0,0,0,2.457,1),
 (27,10,'','10MAT1_2010.jpg','B',0,0,0,0,0,0,0.485,7),
 (28,10,'','39MAT1_2010.jpg','C',0,0,0,0,0,0,0.982,1),
 (29,10,'','34MAT1_2010.jpg','B',0,0,0,0,0,0,0,1),
 (30,10,'','16MAT1_2010.jpg','D',0,0,0,0,0,0,0.001,1),
 (31,10,'','20MAT1_2010.jpg','C',0,0,0,0,0,0,-0.002,1),
 (32,10,'','26MAT1_2010.jpg','B',0,0,0,0,0,0,0.567,1),
 (33,10,'','5MAT1_2010.jpg','D',0,0,0,0,0,0,-2.186,7),
 (34,10,'','12MAT1_2010.jpg','C',0,0,0,0,0,0,-1.134,1),
 (35,10,'','10MAT1_2010.jpg','B',0,0,0,0,0,0,0.485,7),
 (36,10,'','1MAT1_2010.png','C',0,0,0,0,0,0,-1.2,1),
 (37,10,'','3MAT1_2010.png','D',0,0,0,0,0,0,-3.101,1),
 (38,10,'','7MAT1_2010.jpg','D',0,0,0,0,0,0,-1.956,1),
 (49,1,'','soal2.JPG','D',0,0,0,0,0,0,-3.123,1),
 (50,1,'','soal1.JPG','A',0,0,0,0,0,0,-3.987,1),
 (51,1,'','soal3.JPG','D',0,0,0,0,0,0,-1.098,1),
 (52,1,'','soal4.JPG','D',0,0,0,0,0,0,0.001,1),
 (53,1,'','soal5.JPG','C',0,0,0,0,0,0,1.103,1),
 (54,1,'','soal6.JPG','A',0,0,0,0,0,0,3.569,1),
 (56,1,'','soal8.JPG','D',0,0,0,0,0,0,3.109,1),
 (57,1,'','soal9.JPG','A',0,0,0,0,0,0,2.985,1),
 (58,1,'','soal10.JPG','A',0,0,0,0,0,0,2.201,1),
 (59,1,'','soal11.JPG','D',0,0,0,0,0,0,2.109,1),
 (60,1,'','soal12.JPG','C',0,0,0,0,0,0,1.236,1),
 (61,1,'','soal13.JPG','B',0,0,0,0,0,0,0.009,1),
 (62,1,'','soal14.JPG','C',0,0,0,0,0,0,-1.065,1),
 (63,1,'','soal15.JPG','D',0,0,0,0,0,0,-1.907,1),
 (64,1,'','soal16.JPG','A',0,0,0,0,0,0,-2.539,1),
 (65,1,'','soal17.JPG','C',0,0,0,0,0,0,-3.864,1),
 (66,1,'','soal18.JPG','C',0,0,0,0,0,0,2.098,1),
 (67,1,'','soal19.JPG','D',0,0,0,0,0,0,0.198,1),
 (68,1,'','soal20.JPG','A',0,0,0,0,0,0,1.009,1),
 (69,1,'','soal21.JPG','A',0,0,0,0,0,0,-1.009,1),
 (70,1,'','soal22.JPG','D',0,0,0,0,0,0,2.902,1),
 (71,1,'','soal24.JPG','A',0,0,0,0,0,0,2.198,1),
 (72,1,'','soal24.JPG','C',0,0,0,0,0,0,2.543,1),
 (73,1,'','soal26.JPG','B',0,0,0,0,0,0,2.932,1),
 (74,1,'','soal27.JPG','B',0,0,0,0,0,0,-2.389,1),
 (75,1,'','soal28.JPG','B',0,0,0,0,0,0,0.987,1),
 (76,1,'','soal29.JPG','B',0,0,0,0,0,0,-3.546,1),
 (77,1,'','soal30.JPG','C',0,0,0,0,0,0,1.368,1),
 (78,1,'','soal31.JPG','A',0,0,0,0,0,0,2.956,1),
 (79,1,'','soal32.JPG','B',0,0,0,0,0,0,2.198,1),
 (80,1,'','soal33.JPG','C',0,0,0,0,0,0,0.986,1),
 (81,1,'','soal34.JPG','C',0,0,0,0,0,0,1.098,1),
 (82,1,'','soal35.JPG','B',0,0,0,0,0,0,1.765,1),
 (83,1,'','soal36.JPG','A',0,0,0,0,0,0,-1.269,1),
 (84,1,'','soal37.JPG','A',0,0,0,0,0,0,0.087,1),
 (85,1,'','soal38.JPG','B',0,0,0,0,0,0,0.764,1),
 (86,1,'','soal39.JPG','C',0,0,0,0,0,0,2.654,1),
 (87,1,'','soal40.JPG','A',0,0,0,0,0,0,1.321,1),
 (117,10,'','16MAT1_2009.jpg','C',0,0,0,0,0,0,-2.356,1),
 (118,10,'','31MAT1_2009.jpg','C',0,0,0,0,0,0,0.091,1),
 (119,10,'','38MAT1_2009.jpg','D',0,0,0,0,0,0,3.931,1),
 (120,10,'','22MAT1_2009.jpg','A',0,0,0,0,0,0,-1.295,1),
 (121,10,'','21MAT1_2009.jpg','B',0,0,0,0,0,0,-2.368,1),
 (122,10,'','7MAT1_2009.gif','D',0,0,0,0,0,0,-3.091,1),
 (123,10,'','20MAT1_2009.jpg','C',0,0,0,0,0,0,-2.943,1),
 (124,10,'','10MAT1_2009.gif','D',0,0,0,0,0,0,3.009,1),
 (125,10,'','40MAT1_2009.jpg','D',0,0,0,0,0,0,1.087,1),
 (126,10,'','39MAT1_2009.jpg','A',0,0,0,0,0,0,2.209,1),
 (127,10,'','37MAT1_2009.jpg','C',0,0,0,0,0,0,1.297,1),
 (128,10,'','23MAT1_2009.jpg','C',0,0,0,0,0,0,0.092,1),
 (129,10,'','21MAT1_2009.jpg','C',0,0,0,0,0,0,-1.085,1),
 (130,10,'','6MAT1_2009.gif','B',0,0,0,0,0,0,-2.003,1),
 (131,10,'','32MAT1_2009.jpg','D',0,0,0,0,0,0,-0.086,1),
 (132,10,'','32MAT1_2009.jpg','B',0,0,0,0,0,0,0.953,1),
 (133,10,'','23MAT1_2009.jpg','B',0,0,0,0,0,0,-1.254,1),
 (134,10,'','17MAT1_2009.jpg','D',0,0,0,0,0,0,0.005,1),
 (135,11,'','IPA1.JPG','A',0,0,0,0,0,0,-3.975,1),
 (136,11,'','IPA2.JPG','B',0,0,0,0,0,0,-2.456,1),
 (137,11,'','IPA3.JPG','C',0,0,0,0,0,0,1.546,1),
 (138,11,'','IPA4.JPG','A',0,0,0,0,0,0,-2.986,1),
 (139,11,'','IPA5.JPG','B',0,0,0,0,0,0,-1.543,1),
 (140,11,'','IPA6.JPG','A',0,0,0,0,0,0,1.942,1),
 (141,11,'','IPA7.JPG','B',0,0,0,0,0,0,2.087,1),
 (142,11,'','IPA8.JPG','D',0,0,0,0,0,0,1.349,1),
 (143,11,'','IPA9.JPG','C',0,0,0,0,0,0,2.378,1),
 (144,11,'','IPA10.JPG','A',0,0,0,0,0,0,0.024,1),
 (145,11,'','IPA11.JPG','B',0,0,0,0,0,0,1.675,1),
 (146,11,'','IPA12.JPG','C',0,0,0,0,0,0,-1.359,1),
 (147,11,'','IPA13.JPG','C',0,0,0,0,0,0,0.209,1),
 (148,11,'','IPA14.JPG','C',0,0,0,0,0,0,2.197,1),
 (149,11,'','IPA18.JPG','B',0,0,0,0,0,0,1.965,1),
 (150,11,'','IPA19.JPG','D',0,0,0,0,0,0,0.569,1),
 (151,11,'','IPA20.JPG','B',0,0,0,0,0,0,-1.589,1),
 (152,11,'','IPA21.JPG','B',0,0,0,0,0,0,1.683,1),
 (153,11,'','IPA22.JPG','B',0,0,0,0,0,0,0.268,1),
 (154,11,'','IPA23.JPG','B',0,0,0,0,0,0,1.936,1),
 (155,11,'','IPA24.JPG','A',0,0,0,0,0,0,2.589,1),
 (156,11,'','IPA25.JPG','A',0,0,0,0,0,0,-2.674,1),
 (157,11,'','IPA27.JPG','B',0,0,0,0,0,0,3.579,1),
 (158,11,'','IPA28.JPG','B',0,0,0,0,0,0,2.369,1),
 (159,11,'','IPA29.JPG','B',0,0,0,0,0,0,2.571,1),
 (160,11,'','IPA30.JPG','C',0,0,0,0,0,0,0.597,1),
 (161,11,'','IPA31.JPG','B',0,0,0,0,0,0,2.691,1),
 (162,11,'','IPA33.JPG','A',0,0,0,0,0,0,-0.583,1),
 (163,11,'','IPA34.JPG','A',0,0,0,0,0,0,-1.935,1),
 (164,11,'','IPA35.JPG','B',0,0,0,0,0,0,-2.681,1),
 (165,11,'','IPA36.JPG','D',0,0,0,0,0,0,1.692,1),
 (166,11,'','IPA37.JPG','A',0,0,0,0,0,0,1.243,1),
 (167,10,'','1MAT1_2010.jpg','C',0,0,0,0,0,0,-3.978,7),
 (168,10,'','2MAT1_2010.jpg','D',0,0,0,0,0,0,-3.471,7),
 (169,10,'','3MAT1_2010.jpg','C',0,0,0,0,0,0,-3.091,7),
 (170,10,'','4MAT1_2010.jpg','A',0,0,0,0,0,0,0.54,7),
 (171,10,'','5MAT1_2010.jpg','D',0,0,0,0,0,0,1.952,7),
 (172,10,'','6MAT1_2010.jpg','A',0,0,0,0,0,0,-2.186,7),
 (173,10,'','8MAT1_2010.jpg','C',0,0,0,0,0,0,-1.514,7),
 (174,10,'','9MAT1_2010.jpg','B',0,0,0,0,0,0,-0.728,7),
 (175,10,'','25MAT1_2010.jpg','C',0,0,0,0,0,0,1.654,8),
 (176,10,'','26MAT1_2010.jpg','A',0,0,0,0,0,0,-1.255,8),
 (177,10,'','27MAT1_2010.jpg','C',0,0,0,0,0,0,0.628,9),
 (178,10,'','28MAT1_2010.jpg','B',0,0,0,0,0,0,3.218,8),
 (179,10,'','29MAT1_2010.jpg','C',0,0,0,0,0,0,3.821,8),
 (180,10,'','29MAT1_2010.jpg','C',0,0,0,0,0,0,1.094,8),
 (181,10,'','30MAT1_2010.jpg','A',0,0,0,0,0,0,3.641,8),
 (182,10,'','36MAT1_2010.jpg','B',0,0,0,0,0,0,1.025,10),
 (183,10,'','37MAT1_2010.jpg','B',0,0,0,0,0,0,1.766,11),
 (184,10,'','38MAT1_2010.jpg','B',0,0,0,0,0,0,3.091,11),
 (185,10,'','39MAT1_2010.jpg','C',0,0,0,0,0,0,2.695,11),
 (186,10,'','40MAT1_2010.jpg','C',0,0,0,0,0,0,2.749,11),
 (187,10,'','16MAT1_2010.jpg','B',0,0,0,0,0,0,3.618,9),
 (188,10,'','19MAT1_2010.jpg','B',0,0,0,0,0,0,2.819,9),
 (189,10,'','20MAT1_2010.jpg','A',0,0,0,0,0,0,3.671,9),
 (190,10,'','21MAT1_2010.jpg','C',0,0,0,0,0,0,2.105,9),
 (191,10,'','22MAT1_2010.jpg','D',0,0,0,0,0,0,2.812,9),
 (192,10,'','23MAT1_2010.jpg','A',0,0,0,0,0,0,3.689,9),
 (193,10,'','24MAT1_2010.jpg','D',0,0,0,0,0,0,1.316,9),
 (194,10,'','1MAT1_2010.jpg','D',0,0,0,0,0,0,-2.864,7);
/*!40000 ALTER TABLE `soal` ENABLE KEYS */;


--
-- Definition of table `wali_peserta_test`
--

DROP TABLE IF EXISTS `wali_peserta_test`;
CREATE TABLE `wali_peserta_test` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `peran` enum('Wali Murid') NOT NULL DEFAULT 'Wali Murid',
  `idpeserta_test` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_wali_murid_1` (`idpeserta_test`),
  CONSTRAINT `FK_wali_murid_1` FOREIGN KEY (`idpeserta_test`) REFERENCES `peserta_test` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `wali_peserta_test`
--

/*!40000 ALTER TABLE `wali_peserta_test` DISABLE KEYS */;
INSERT INTO `wali_peserta_test` (`id`,`username`,`password`,`peran`,`idpeserta_test`) VALUES 
 (3,'ambo','ambo','Wali Murid',6),
 (4,'Dawi','dawi','Wali Murid',6);
/*!40000 ALTER TABLE `wali_peserta_test` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
