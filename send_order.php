<?php
	$strTitle = "ОФОРМЛЕНИЕ ЗАКАЗА";

	$make_order = 1;
	$main = 0;

	include_once ("init.tpl");

	if ($cart->get_count() <= 0)
	{
		header('Location: /');
		exit();
	}

	$user_fio = $_POST['user_fio1']." ".$_POST['user_fio2']." ".$_POST['user_fio3'];
	$user_email = $_POST['user_email'];
	$user_tel = $_POST['user_tel1'];
	
	$send_result = "";
	//$v2 = mail('adoon@inbox.ru', "test", "test");
	$cart->send_card($jcart, $send_result);
	
	include_once ("top.tpl");
	//echo $v2;
?>
	
		<div class="clearfix"></div>

		<ul class="breadcrambs">
			<li><a href="/">Главная</a></li>
			<li>Оформление заказа</li>
		</ul>
	</div>
	
<?php
	if ($send_result !== "")
	{
		include_once ("order_err.tpl");
	}
	else
	{
		include_once ("order_ok.tpl");
	}

	include_once ("bottom.tpl");
?> 
