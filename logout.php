<?php
	include_once ("init.tpl");
	
	$h = getenv("HTTP_REFERER");
	if (strpos($h, 'login') == False) $href = $h;
	if ($href == "") $href = "/";

	if (isset($_SESSION['user_data']))
	{
		unset($_SESSION['user_data']);
				
		setcookie('login', '', 0, "/");
		setcookie('password', '', 0, "/");
		
		User::setNeedRefreshBasket("1");
	}
	header('Location: '.$href);
	exit;
?>
