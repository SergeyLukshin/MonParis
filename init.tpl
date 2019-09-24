<?php
	include_once('db_settings.php');
	include_once('jcart/jcart.php');
	session_start("monparis");
	include_once('classes/Auth.class.php');

	setlocale(LC_ALL, 'ru_RU.CP1251');

	// INITIALIZE JCART AFTER SESSION START
	//if (isset($_COOKIE['jcart'])) $cart = & $_COOKIE['jcart'];
	$cart =& $_SESSION['jcart']; 
	if(!is_object($cart))
	{
		$cart = new jcart();
	}
	
	@mysql_connect(db::$my_server, db::$my_user, db::$my_pwd) or die("Could not connect to MySQL server!"); 
	@mysql_select_db(db::$my_name) or die("Could not select products database!"); 
	mysql_query("SET NAMES \"cp1251\"");
	
	$make_order = 0;
	$basket = 0;
	$catalog = 0;
	$bigsizes = 0;
	$favorites = 0;
	$fav_products = "";
	$brend_list = 0;
	$brend = "";
	$cat_list = 0;
	$category = "";
	//$col_list = 0;
	//$collection = "";
	$new_col_list = 0;
	$new_collection = "";
	$all = 0;
	$cur_page = 0;
	$search = 0;
	$detail = 0;
	$productID = 0;
	$favorites_user = 0;
	
	//if (!isset($_SESSION['favorites']))
	{
		$handle = @fopen("favorites.txt", "r");
		if ($handle) 
		{
			while (($buffer = fgets($handle, 4096)) !== false) 
			{
				$str = $buffer;
				list($fav_name, $fav_title, $fav_products) = split ("\t", $str);
				$vec_favorites[$fav_name]['title'] = $fav_title;
				$vec_favorites[$fav_name]['products'] = $fav_products;
			}
			fclose($handle);
		}
	}
	//else
	//{
	//	$vec_favorites = $_SESSION['favorites'];
	//}
?>
