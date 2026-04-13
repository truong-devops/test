<?php
include "ketnoi.php";
$sql = "select * from HOADON hd join KHACHHANG kh on hd.idkh = kh.idkh";
$result = mysqli_query($conn, $sql);
$data = array();

while($row = mysqli_fetch_assoc($result)){
    $data[] = $row;
}

Header("Content-Type: application/json");
echo json_encode($data);
?>