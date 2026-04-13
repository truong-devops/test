<?php
header("Content-type:text/html;Charset=UTF-8");
include("ketnoi.php");
$p=new dbcnmoi();

$soluong=$_REQUEST['soluong'];
$ngaymuahang=$_REQUEST['ngaymuahang'];


$sql="INSERT INTO HOADON (soluong, ngaymuahang, idkh)
VALUES('$soluong','$ngaymuahang',(SELECT MAX(idkh) FROM KHACHHANG))";

echo $p->themxoasua($sql);



?>