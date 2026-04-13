<?php
include "ketnoi.php";

$idgv = $_REQUEST["idgv"] ?? '';
$mans = $_REQUEST["mans"] ?? '';
$hodem = $_REQUEST["hodem"] ?? '';
$ten = $_REQUEST["ten"] ?? '';
$ngaysinh = $_REQUEST["ngaysinh"] ?? '';
$idkhoa = $_REQUEST["idkhoa"] ?? '';

if ($idgv === '' || $mans === '' || $hodem === '' || $ten === '' || $ngaysinh === '' || $idkhoa === '') {
    die("thieu tham so");
}

$idgv = mysqli_real_escape_string($conn, $idgv);
$mans = mysqli_real_escape_string($conn, $mans);
$hodem = mysqli_real_escape_string($conn, $hodem);
$ten = mysqli_real_escape_string($conn, $ten);
$ngaysinh = mysqli_real_escape_string($conn, $ngaysinh);
$idkhoa = mysqli_real_escape_string($conn, $idkhoa);

$sql = "UPDATE GIANGVIEN
        SET mans='$mans', hodem='$hodem', ten='$ten', ngaysinh='$ngaysinh', idkhoa='$idkhoa'
        WHERE idgv='$idgv'";

echo mysqli_query($conn, $sql) ? "sua thanh cong" : ("sua that bai: " . mysqli_error($conn));
?>
<!--
http://localhost/60-TranVanTruong-2647761/hovaten_taoapi/sua.php?idgv=1&mans=NS001&hodem=Nguyen%20Van&ten=Anh&ngaysinh=1985-01-15&idkhoa=2
-->
