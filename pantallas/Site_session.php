<?php 

session_start();
require('CargadorClases.php');

if(!isset($_SESSION["user_name"]))
{
	header("Location:index.php");
	exit;
}

?>