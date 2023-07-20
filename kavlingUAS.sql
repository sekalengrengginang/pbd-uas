-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Waktu pembuatan: 20 Jul 2023 pada 14.49
-- Versi server: 10.4.28-MariaDB
-- Versi PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kavling`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_bayar` (IN `besar_bayar` INT(11), OUT `jenis_bayar` VARCHAR(20))   BEGIN
	DECLARE bayar INT;
    SELECT *
    FROM pembayaran_kredit WHERE jumlah_angsuran = besar_bayar;
    IF bayar <= 75000000 THEN
    SET jenis_bayar = 'Bayar Kecil';
    ELSEIF bayar >=120000000 THEN
    SET jenis_bayar = 'Bayar Besar';
    END IF;
	
END$$

--
-- Fungsi
--
CREATE DEFINER=`root`@`localhost` FUNCTION `get_total_pembayaran` (`pembeli_id` INT) RETURNS INT(11)  BEGIN
    DECLARE total_bayar INT;
    
    -- Hitung total pembayaran dalam bentuk cash
    SELECT SUM(total_bayar) INTO total_bayar
    FROM pembayaran_cash
    WHERE pembeli_id = pembeli_id;
    
    -- Hitung total pembayaran dalam bentuk kredit
    SELECT SUM(jumlah_angsuran) INTO total_bayar
    FROM pembayaran_kredit
    WHERE pembeli_id = pembeli_id;
    
    -- Jumlahkan total pembayaran dari cash dan kredit
    RETURN total_bayar;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `distributor`
--

CREATE TABLE `distributor` (
  `distributor_id` int(11) NOT NULL,
  `nama_distributor` varchar(50) DEFAULT NULL,
  `alamat` varchar(50) DEFAULT NULL,
  `tlp` char(12) DEFAULT NULL,
  `kota` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `distributor`
--

INSERT INTO `distributor` (`distributor_id`, `nama_distributor`, `alamat`, `tlp`, `kota`) VALUES
(1, 'Semen Tiga Roda', 'Jl. Sudirman No. 20', '081234882304', 'Jakarta'),
(2, 'PT Citra Sukma', 'Jl. Taman Katapang No.14', '082347892345', 'Bandung'),
(3, 'Tekad Makmur', 'Jl. Indah Raya No. 23', '082279812965', 'Bandung'),
(4, 'Findo Karya Utama', 'Jl Mandar Perum Bappenas No.7', '082385342953', 'Bekasi'),
(5, 'PT Pava Mandiri', 'Jl Gading Serpong Boulovard No.10', '081344259856', 'Tangerang Selatan');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pembayaran_cash`
--

CREATE TABLE `pembayaran_cash` (
  `transaksi_id` int(11) NOT NULL,
  `tanggal_transaksi` date DEFAULT NULL,
  `total_bayar` int(11) DEFAULT NULL,
  `pembeli_id` int(11) DEFAULT NULL,
  `rumah_id` int(11) DEFAULT NULL,
  `distributor_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `pembayaran_cash`
--

INSERT INTO `pembayaran_cash` (`transaksi_id`, `tanggal_transaksi`, `total_bayar`, `pembeli_id`, `rumah_id`, `distributor_id`) VALUES
(1, '2022-01-10', 300000000, 2, 2, 4),
(2, '2022-03-17', 200000000, 9, 1, 2),
(3, '2022-07-02', 400000000, 4, 3, 1),
(4, '2022-05-30', 600000000, 7, 5, 3),
(5, '2022-10-12', 500000000, 6, 4, 5);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pembayaran_kredit`
--

CREATE TABLE `pembayaran_kredit` (
  `transaksi_id` int(11) NOT NULL,
  `tanggal_transaksi` date DEFAULT NULL,
  `pembeli_id` int(11) DEFAULT NULL,
  `rumah_id` int(11) DEFAULT NULL,
  `distributor_id` int(11) DEFAULT NULL,
  `jumlah_angsuran` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `pembayaran_kredit`
--

INSERT INTO `pembayaran_kredit` (`transaksi_id`, `tanggal_transaksi`, `pembeli_id`, `rumah_id`, `distributor_id`, `jumlah_angsuran`) VALUES
(1, '2022-10-21', 8, 4, 3, 150000000),
(2, '2022-05-06', 10, 1, 1, 50000000),
(3, '2022-02-13', 5, 5, 5, 250000000),
(4, '2022-06-25', 3, 2, 2, 75000000),
(5, '2022-12-09', 1, 3, 4, 120000000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pembeli`
--

CREATE TABLE `pembeli` (
  `pembeli_id` int(11) NOT NULL,
  `nama_pembeli` varchar(30) DEFAULT NULL,
  `alamat` varchar(50) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `tlp` char(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `pembeli`
--

INSERT INTO `pembeli` (`pembeli_id`, `nama_pembeli`, `alamat`, `email`, `tlp`) VALUES
(1, 'Sabrina Haryanti', 'Jl. Kalimas Baru No.2', 'sabrina@gmail.com', '082236017630'),
(2, 'Cakrabirawa Hidayanto', 'Jl. Tanah Rendah No.3', 'hidayat@gmail.com', '082137220178'),
(3, 'Karma Mahendra', 'Jl. Tunjung No.13', 'mahendra@gmail.com', '082156884965'),
(4, 'Daniswara Sitompul', 'Jl. Citandui No.4', 'swara@gmail.com', '083156880935'),
(5, 'Calista Andriani', 'Jl. Wijaya Timur Raya No.11', 'andriani@gmail.com', '082172788583'),
(6, 'Rini Andriani', 'Jl. Jend Gatot Subroto 289', 'rini@gmail.com', '082291001365'),
(7, 'Widya Permata', 'Jl. Imam Bonjol 80', 'widya@gmail.com', '082131661894'),
(8, 'Taswir Latupono', 'Jl. Merdeka 866', 'taswir@gmail.com', '083871115127'),
(9, 'Tina Handayani', 'Jl. Pasar Baru', 'handayani@gmail.com', '082157119295'),
(10, 'Rudi Anwar', 'Jl. Asia Afrika 90', 'anwar@gmail.com', '082242339098');

--
-- Trigger `pembeli`
--
DELIMITER $$
CREATE TRIGGER `add_pembeli` BEFORE INSERT ON `pembeli` FOR EACH ROW INSERT INTO pembeli_log(pembeli_id,nama_pembeli,status_pembeli,tanggal)
 VALUES(new.pembeli_id,new.nama_pembeli,'Pembeli ditambahkan!',NOW())
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pembeli_log`
--

CREATE TABLE `pembeli_log` (
  `pembeli_id` int(11) NOT NULL,
  `nama_pembeli` varchar(30) DEFAULT NULL,
  `status_pembeli` varchar(20) DEFAULT NULL,
  `tanggal` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `rumah`
--

CREATE TABLE `rumah` (
  `rumah_id` int(11) NOT NULL,
  `alamat` varchar(50) DEFAULT NULL,
  `harga_cash` int(11) DEFAULT NULL,
  `harga_kredit` int(11) DEFAULT NULL,
  `luas_rumah` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `rumah`
--

INSERT INTO `rumah` (`rumah_id`, `alamat`, `harga_cash`, `harga_kredit`, `luas_rumah`) VALUES
(1, 'Jl. Bukit Raya', 200000000, 50000000, 'LT:30m2 LB:30m2'),
(2, 'Jl. Jatisari', 300000000, 75000000, 'LT:72m2 LB:40m2'),
(3, 'Jl. Singaraja', 400000000, 120000000, 'LT:84m2 LB:45m2'),
(4, 'Jl. Dharmawangsa', 500000000, 150000000, 'LT:96m2 LB:60m2'),
(5, 'Jl. Bima', 600000000, 250000000, 'LT:121m2 LB:65m2');

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `v_bandung`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `v_bandung` (
`distributor_id` int(11)
,`nama_distributor` varchar(50)
,`alamat` varchar(50)
,`tlp` char(12)
,`kota` varchar(30)
);

-- --------------------------------------------------------

--
-- Struktur untuk view `v_bandung`
--
DROP TABLE IF EXISTS `v_bandung`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_bandung`  AS SELECT `distributor`.`distributor_id` AS `distributor_id`, `distributor`.`nama_distributor` AS `nama_distributor`, `distributor`.`alamat` AS `alamat`, `distributor`.`tlp` AS `tlp`, `distributor`.`kota` AS `kota` FROM `distributor` WHERE `distributor`.`kota` = 'Bandung' ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `distributor`
--
ALTER TABLE `distributor`
  ADD PRIMARY KEY (`distributor_id`),
  ADD KEY `nama_distributor_indeks` (`nama_distributor`);

--
-- Indeks untuk tabel `pembayaran_cash`
--
ALTER TABLE `pembayaran_cash`
  ADD PRIMARY KEY (`transaksi_id`),
  ADD KEY `pembeli_id` (`pembeli_id`),
  ADD KEY `rumah_id` (`rumah_id`),
  ADD KEY `distributor_id` (`distributor_id`);

--
-- Indeks untuk tabel `pembayaran_kredit`
--
ALTER TABLE `pembayaran_kredit`
  ADD PRIMARY KEY (`transaksi_id`),
  ADD KEY `pembeli_id` (`pembeli_id`),
  ADD KEY `rumah_id` (`rumah_id`),
  ADD KEY `distributor_id` (`distributor_id`);

--
-- Indeks untuk tabel `pembeli`
--
ALTER TABLE `pembeli`
  ADD PRIMARY KEY (`pembeli_id`);

--
-- Indeks untuk tabel `pembeli_log`
--
ALTER TABLE `pembeli_log`
  ADD PRIMARY KEY (`pembeli_id`);

--
-- Indeks untuk tabel `rumah`
--
ALTER TABLE `rumah`
  ADD PRIMARY KEY (`rumah_id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `distributor`
--
ALTER TABLE `distributor`
  MODIFY `distributor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `pembayaran_cash`
--
ALTER TABLE `pembayaran_cash`
  MODIFY `transaksi_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `pembayaran_kredit`
--
ALTER TABLE `pembayaran_kredit`
  MODIFY `transaksi_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `pembeli`
--
ALTER TABLE `pembeli`
  MODIFY `pembeli_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT untuk tabel `pembeli_log`
--
ALTER TABLE `pembeli_log`
  MODIFY `pembeli_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `rumah`
--
ALTER TABLE `rumah`
  MODIFY `rumah_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `pembayaran_cash`
--
ALTER TABLE `pembayaran_cash`
  ADD CONSTRAINT `pembayaran_cash_ibfk_1` FOREIGN KEY (`pembeli_id`) REFERENCES `pembeli` (`pembeli_id`),
  ADD CONSTRAINT `pembayaran_cash_ibfk_2` FOREIGN KEY (`rumah_id`) REFERENCES `rumah` (`rumah_id`),
  ADD CONSTRAINT `pembayaran_cash_ibfk_3` FOREIGN KEY (`distributor_id`) REFERENCES `distributor` (`distributor_id`);

--
-- Ketidakleluasaan untuk tabel `pembayaran_kredit`
--
ALTER TABLE `pembayaran_kredit`
  ADD CONSTRAINT `pembayaran_kredit_ibfk_1` FOREIGN KEY (`pembeli_id`) REFERENCES `pembeli` (`pembeli_id`),
  ADD CONSTRAINT `pembayaran_kredit_ibfk_2` FOREIGN KEY (`rumah_id`) REFERENCES `rumah` (`rumah_id`),
  ADD CONSTRAINT `pembayaran_kredit_ibfk_3` FOREIGN KEY (`distributor_id`) REFERENCES `distributor` (`distributor_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
