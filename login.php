<?php
	include_once ("init.tpl");
	
	$h = getenv("HTTP_REFERER");
	if (strpos($h, 'login') == False) $href = $h;
	if ($href == "") $href = "/";

	$result_login_str = "";
	$result_login = 0;
	$user_name = "";
	
	$login = $_GET['logout'];

	if (isset($_SESSION['user_id']))
	{
		if ($login == '1')
		{
			if (isset($_SESSION['user_id']))
			{
				unset($_SESSION['user_id']);
				unset($_SESSION['user_name']);
				unset($_SESSION['user_discount']);
				unset($_SESSION['user_wholesale_discount']);
				unset($_SESSION['user_wholesaler']);
				unset($_SESSION['user_block_prices']);
				//unset($_SESSION['user_use_price_in_euro']);
			}
				
			setcookie('login', '', 0, "/");
			setcookie('password', '', 0, "/");
			
			//echo "<div class='order_info1'>������������ ����� �� �������</div>";
			$cart->refresh_cart($jcart);
			
			header('Location: '.$href);
			exit;
		}
		else
		{
			// ���� ��� ���������, ������������ ��� ������ �� �������� ��������
			header('Location: '.$href);
			echo $href;
			exit;
		}
	}
	
	if (!empty($_POST))
	{
		$login_name = (isset($_POST['login'])) ? mysql_escape_string($_POST['login']) : '';
		// ������ �������� ��������� ������ ��� ���� � �������� ����, ������� ���� ������� ����:
		$password = md5($_POST['password']);
	
		// ������ ������ � ��
		// � ���� ����� � ����� ������� � �������
		//$query = "INSERT INTO `gf_user` (login, password) VALUES ('{$login}', '{$password}')";

		$query = "SELECT `UserID`, FirstName, Discount, WholesaleDiscount, BlockPrices, Wholesaler, UsePriceInEuro FROM `MP_USER` WHERE `login`='{$login_name}' AND `password`='{$password}' LIMIT 1";

		$sql = mysql_query($query) or die(mysql_error());

		// ���� ����� ������������ �������
		if (mysql_num_rows($sql) == 1)
		{
			// �� �� ������ �� ���� ����� � ������ (�������� �� ����� ������� ID ������������)

			$row = mysql_fetch_assoc($sql);
			$_SESSION['user_id'] = $row['UserID'];
			$_SESSION['user_name'] = $row['FirstName'];
			$_SESSION['user_discount'] = $row['Discount'];
			$_SESSION['user_wholesale_discount'] = $row['WholesaleDiscount'];
			$_SESSION['user_wholesaler'] = $row['Wholesaler'];
			$_SESSION['user_block_prices'] = $row['BlockPrices'];
			//$_SESSION['user_use_price_in_euro'] = $row['UsePriceInEuro'];
			
			//if ($_SESSION['user_wholesaler'] != "0") $_SESSION['user_use_price_in_euro'] = "1"; // ��������� ���������� ���� � ����
			// ���� ������������ ����� "��������� ����"
			// �� ������ ��� � ���� ����� � ����� ������
			$time = 86400; // ������ ���� �� 24 ����
			
			$query = "INSERT INTO `MP_USERS_VISITS` (`UserID`) VALUES (".$row['UserID'].")";
			mysql_query($query);
			
			if (isset($_POST['remember']))
			{
				setcookie('login', $login_name, time()+$time, "/");
				setcookie('password', $password, time()+$time, "/");
			}
			
			// � ������������ ��� �� �������� ��������
			//header('Location: closed.php');
			//echo "<p><font class='notetext'>���� � ������� �������� �������.</font></p>";
			$result_login_str = "���� � ������� �������� �������.";
			$result_login = 2;
			
			include_once ("top.tpl");
			
			$cart->refresh_cart($jcart);
			
			include_once ("bottom.tpl");
			
			//header('Location: '.$href);
			//echo "<body  onload='javascript:parent.location.reload();'>";
		}	
		else
		{
			//echo "<body >";
			$result_login_str = "�������� ����� ��� ������.";
			$result_login = 1;
			//echo "<p><font class='errortext'>�������� ����� ��� ������.</font></p>";
			//include ('login_form.tpl');
			
			include_once ("top.tpl");
			include_once ("bottom.tpl");
			
			//$cart->refresh_cart($jcart);
			//header('Location: '.$href);
		}
		mysql_free_result($sql);		
	}
	else
	{ 
		$result_login_str = "&nbsp;";
		include_once ("top.tpl");
		include_once ("bottom.tpl");
	}
?>
