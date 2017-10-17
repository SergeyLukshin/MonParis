<?php

// JCART v1.1
// http://conceptlogic.com/jcart/

// THIS FILE TAKES INPUT FROM AJAX REQUESTS VIA JQUERY post AND get METHODS, THEN PASSES DATA TO JCART
// RETURNS UPDATED CART HTML BACK TO SUBMITTING PAGE

// INCLUDE JCART BEFORE SESSION START
include_once 'jcart.php';
header('content-type:text/html; charset=windows-1251');
// START SESSION
session_start();

$var_ = "";
if (isset($_SESSION['product_put']))
	$var_ = $_SESSION['product_put'];

$arr_ = array();
$count_ = 0;
if ($var_ != "")
{
	$arr_ = split(',', $var_);
	$count_ = sizeof($arr_);
}

extract($jcart);

if ($_POST[$item_add_put])
{
	$item_id_put = $_POST[$item_id_put];

	if (sizeof($arr_) < 30)
	{
		$find = 0;
		foreach($arr_ as $tmp_item)
		{
			if ($tmp_item == $item_id_put)
			{
				$find = 1;
				break;
			}
		}
		if ($find == 0)
		{
			$arr_[] = $item_id_put;
		}
			
		$index = 0;
		$var_ = "";
		foreach($arr_ as $tmp_item)
		{
			if ($index == 0)
				$var_ = $tmp_item;
			else
				$var_ = $var_.','.$tmp_item;
			$index ++;
		}
		$_SESSION['product_put'] = $var_;
		$time = 86400 * 60; // ставим куку на 60 суток
		setcookie('product_put', $var_, time()+$time, "/");
	}
}

echo sizeof($arr_);
echo "|||||";
echo sizeof($arr_);

//echo $item_id_put;

// PROCESS INPUT AND RETURN UPDATED CART HTML
//$cart->display_cart_put($jcart);
//echo "|||||";
//$cart->display_short_cart_put($jcart);
?>
