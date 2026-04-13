<?php
header("Content-type:text/html;Charset=UTF-8");
include("ketnoi.php");
$p=new dbcnmoi();

$idhd=$_REQUEST['idhd'];
$sql="DELETE FROM HOADON WHERE idhd='$idhd'";
echo $p->themxoasua($sql);



?>