<?php
include "ketnoi.php";
$idhd = $_GET["idhd"];


$sql = "delete from HOADON where idhd = $idhd";
echo mysqli_query($conn, $sql)?"xoa thanh cong":"xoa that bai";
?>