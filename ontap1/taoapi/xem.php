<?php
header("Content-type:text/html;Charset=UTF-8");
include("ketnoi.php");
$p=new dbcnmoi();

$sql="SELECT hd.idhd,hd.soluong,hd.ngaymuahang,kh.hodem,kh.ten FROM HOADON hd JOIN KHACHHANG kh ON hd.idkh=kh.idkh ORDER BY hd.idhd ASC";
$p->xuat($sql);



?>