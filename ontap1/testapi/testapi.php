
<?php
header("Content-type:text/html;Charset=UTF-8");
$data=file_get_contents("http://127.0.0.1/ontap1/taoapi/xem.php");
$arr= json_decode($data,true);

?>




<table width="700" border="1" align="center" cellpadding="5" cellspacing="5">
  <caption>
    <strong>DANH SACH HOA DON</strong>
  </caption>
  <tbody>
    <tr>
      <th scope="col">ID HD</th>
      <th scope="col">SO LUONG</th>
      <th scope="col">NGAY MUA HANG</th>
      <th scope="col">HO DEM</th>
      <th scope="col">TEN</th>
    </tr>
	  <?php foreach($arr as $row){ ?>
    <tr>
		
      <td><?php echo $row['idhd']; ?></td>
      <td><?php echo $row['soluong']; ?></td>
      <td><?php echo $row['ngaymuahang']; ?></td>
      <td><?php echo $row['hodem']; ?></td>
      <td><?php echo $row['ten']; ?></td>
    </tr>
	  <?php } ?>
  </tbody>
</table>
