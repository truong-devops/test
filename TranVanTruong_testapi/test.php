<?php
$json = file_get_contents("http://127.0.0.1/html/TranVanTruong_22647761/TranVanTruong_taoapi/xem.php");
$data = json_decode($json, true);


echo '<h1>Danh sach mua hang</h1>';
echo '<table border=1>
    <tr>
        <th>ID hoa don</th>
        <th>So luong</th>
        <th>Ngay mua hang</th>
        <th>Ho dem</th>
        <th>Ten</th>
    </tr>';
foreach($data as $d){
    echo '<tr>
        <td>'.$d['idhd'].'</td>
        <td>'.$d['soluong'].'</td>
        <td>'.$d['ngaymuahang'].'</td>
        <td>'.$d['hodem'].'</td>
        <td>'.$d['ten'].'</td>
    </tr>';
}

echo '</table>';
?>