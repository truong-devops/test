<?php
include "ketnoi.php";
$soluong = $_GET["soluong"];
$ngaymuahang = $_GET["ngaymuahang"];

$sql = "insert into HOADON(soluong, ngaymuahang, idkh) values ('$soluong','$ngaymuahang','3')";
echo mysqli_query($conn, $sql)?"them thanh cong":"them that bai";
?>