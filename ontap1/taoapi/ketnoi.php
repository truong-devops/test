<?php
	class dbcnmoi{
		function connect(){
			$con=mysqli_connect("localhost","ontap1","1","ontap1");
			if(!$con){
				die("loi ket noi :".mysqli_connect_error());
				
			}
			mysqli_set_charset($con,"UTF-8");
			return $con;
			
		}
		function xuat($sql){
			$link=$this->connect();
			$kq=mysqli_query($link,$sql);
			if(!$kq){
				die("loi sql :".mysqli_connect_error($link));
			}
			$data = array();
			while($row=mysqli_fetch_assoc($kq)){
				$data[]=$row;
			}
			header("Content-type:application/json;Charset=UTF-8");
			echo json_encode($data);
		}
		function themxoasua($sql){
			return(mysqli_query($this->connect(),$sql)?1:0);
		}
		
	}
	
?>