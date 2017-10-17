<?php

include_once ("classes/Auth.class.php");
include_once ("classes/AjaxRequest.class.php");
require_once ("recaptchalib.php");
include_once('jcart/jcart.php');


header('content-type:text/html; charset=utf-8');
session_start("monparis");

class AuthorizationAjaxRequest extends AjaxRequest
{
    public $actions = array(
        "login" => "login",
        "logout" => "logout",
        "register" => "register",
        "message" => "message",
        //"make_order" => "make_order",
    );
    
    public function message()
    {
        if ($_SERVER["REQUEST_METHOD"] !== "POST") {
            // Method Not Allowed
            http_response_code(405);
            header("Allow: POST");
            $this->setFieldError("main", "Method Not Allowed");
            return;
        }
        
        $username = $this->getRequestParam("username");
		$email = $this->getRequestParam("email");
		$phone = $this->getRequestParam("phone");
		$msg = $this->getRequestParam("msg");

		if (empty($username)) {
			$this->setFieldError("username", "Введите логин");
			return;
		}

		if (empty($email)) {
			$this->setFieldError("email", "Укажите email");
			return;
		}

		if (empty($phone)) {
			$this->setFieldError("phone", "Укажите телефон");
			return;
		}

		if (empty($msg)) {
			$this->setFieldError("msg", "Введите сообщение");
			return;
		}
		
		//$username = mysql_escape_string($username);
		//$email = mysql_escape_string($email);
		//$phone = mysql_escape_string($phone);
		//$msg = mysql_escape_string($msg);
			
        $g_recaptcha_response = $this->getRequestParam("g-recaptcha-response");
        $secret = "6LeaXBITAAAAAH5qBZQlgEkwKlYh9ir-EpbuGrQM";
		// пустой ответ
		$response = null;
		// проверка секретного ключа
		$reCaptcha = new ReCaptcha($secret);
		$response = $reCaptcha->verifyResponse($_SERVER["REMOTE_ADDR"], $g_recaptcha_response);
		if ($response != null && $response->success)
		{
			$msg = "<html><head></head><body><b>Имя : </b> ".$username."<br><b>e-mail :</b> ".$email."<br>
				<b>Телефон :</b>".$phone."<br><b>Сообщение : </b>".$msg."</body></html>";

			//$msg = iconv("utf-8", "windows-1251", $msg);

			$headers = 'MIME-Version: 1.0' . "\r\n";
			$headers .= 'Content-type: text/html; charset=utf-8' . "\r\n";
			$headers .= 'From: <mon-paris.ru>' . "\r\n";
			$headers .= 'Bcc: <mon-paris.ru>' . "\r\n";

			//echo $msg;
			//echo $headers;

			$v = mail('modaopt@gmail.com', 'Сообщение с сайта mon-paris.ru', $msg, $headers );
			$v2 = mail('adoon@inbox.ru', 'Сообщение с сайта mon-paris.ru', $msg, $headers );
			
			if ($v == true)
			{
				$this->setResponse("redirect", ".");
				$this->status = "ok";
			}
			else
			{
				$this->setFieldError("msg", "Не удалось отправить сообщение");
				return;
			}
		}
		else
		{
			$this->setFieldError("username", "Необходимо пройти проверку на робота.");
			return;
		}
	}

    public function login()
    {
        if ($_SERVER["REQUEST_METHOD"] !== "POST") {
            // Method Not Allowed
            http_response_code(405);
            header("Allow: POST");
            $this->setFieldError("main", "Method Not Allowed");
            return;
        }
        
        setcookie('login', '', 0, "/");
		setcookie('password', '', 0, "/");

        $username = $this->getRequestParam("username");
        $password = $this->getRequestParam("password");
        $remember = !!$this->getRequestParam("remember-me");

        if (empty($username)) {
            $this->setFieldError("username", "Введите логин");
            return;
        }

        if (empty($password)) {
            $this->setFieldError("password", "Введите пароль");
            return;
        }
        
        $username = mysql_escape_string($username);
        $password = mysql_escape_string($password);

        $user = new User();
        $auth_result = $user->authorize($username, $password, $remember);
        
        if (!$auth_result) {
            $this->setFieldError("password", "Неверный логин или пароль");
            return;
        }
        

        $this->status = "ok";
        $this->setResponse("redirect", ".");
        $this->message = sprintf("Hello, %s! Access granted.", $username);
    }    

    public function register()
    {
        if ($_SERVER["REQUEST_METHOD"] !== "POST") {
            // Method Not Allowed
            http_response_code(405);
            header("Allow: POST");
            $this->setFieldError("main", "Method Not Allowed");
            return;
        }
        
        $username = $this->getRequestParam("username");
		$password1 = $this->getRequestParam("password1");
		$password2 = $this->getRequestParam("password2");

        $username = mysql_escape_string($username);
        $password1 = mysql_escape_string($password1);
        $password2 = mysql_escape_string($password2);

		if (empty($username)) {
			$this->setFieldError("username", "Введите логин");
			return;
		}

		if (empty($password1)) {
			$this->setFieldError("password1", "Введите пароль");
			return;
		}

		if (empty($password2)) {
			$this->setFieldError("password2", "Подтвердите пароль");
			return;
		}

		if ($password1 !== $password2) {
			$this->setFieldError("password2", "Повторно введенный пароль должен совпадать с основным паролем");
			return;
		}
		
		$firstname = $this->getRequestParam("user_fio1");
		$surname = $this->getRequestParam("user_fio2");
		$fathername = $this->getRequestParam("user_fio3");
		$phone = $this->getRequestParam("user_tel");
		$region = $this->getRequestParam("user_region");
		$address = $this->getRequestParam("user_address");

		if (empty($firstname)) {
			$this->setFieldError("user_fio1", "Введите имя");
			return;
		}
		
		if (empty($phone)) {
			$this->setFieldError("user_tel", "Укажите телефон");
			return;
		}

        //$firstname = mysql_escape_string($firstname);
        //$surname = mysql_escape_string($surname);
        //$fathername = mysql_escape_string($fathername);
        //$phone = mysql_escape_string($phone);
        //$region = mysql_escape_string($region);
        //$address = mysql_escape_string($address);

		
		$wholesaler = $this->getRequestParam("user_wholesale");
		if ($wholesaler != '') $wholesalerInt = 1;
		else $wholesalerInt = 0;

		$agree_delivery = $this->getRequestParam("user_agree_delivery");
		if ($agree_delivery != '') $agree_deliveryInt = 1;
		else $agree_deliveryInt = 0;

		$user_brand_str = '';
		$user_cat_str = '';
		$user_size_str = '';
			
        $g_recaptcha_response = $this->getRequestParam("g-recaptcha-response");
        $secret = "6LeaXBITAAAAAH5qBZQlgEkwKlYh9ir-EpbuGrQM";
		// пустой ответ
		$response = null;
		// проверка секретного ключа
		$reCaptcha = new ReCaptcha($secret);
		$response = $reCaptcha->verifyResponse($_SERVER["REMOTE_ADDR"], $g_recaptcha_response);
		if ($response != null && $response->success)
		{
			/*if ($wholesalerInt != 0)
			{
				// запоминаем бренды
				$brand_cnt = $this->getRequestParam("brand_cnt");
				for ($i = 0; $i < $brand_cnt; $i++) 
				{
					$tmp = $this->getRequestParam("user_brand".$i);
					if ($tmp != '')
					{
						if ($user_brand_str == '')
							$user_brand_str = $this->getRequestParam("user_brand_val".$i);
						else
							$user_brand_str = $user_brand_str.", ".$this->getRequestParam("user_brand_val".$i);
					}
				}
				
				// запоминаем размеры
				for ($i = 1; $i <= 3; $i++) 
				{
					$tmp = $this->getRequestParam("user_size".$i);
					if ($tmp != '')
					{
						if ($user_size_str == '')
							$user_size_str = $this->getRequestParam("user_size_val".$i);
						else
							$user_size_str = $user_size_str.", ".$this->getRequestParam("user_size_val".$i);
					}
				}
				
				// запоминаем категории
				$cat_cnt = $this->getRequestParam("cat_cnt");
				for ($i = 0; $i < $cat_cnt; $i++) 
				{
					$tmp = $this->getRequestParam("user_cat".$i);
					if ($tmp != '')
					{
						if ($user_cat_str == '')
							$user_cat_str = $this->getRequestParam("user_cat_val".$i);
						else
							$user_cat_str = $user_cat_str.", ".$this->getRequestParam("user_cat_val".$i);
					}
				}
			}*/

			$user = new User();

			try {
				$user->create($username, $password1, $firstname, $surname, $fathername, $phone, $region, $address, $user_brand_str, $user_cat_str, $user_size_str, $wholesalerInt, $agree_deliveryInt);
			} catch (Exception $e) {
				$this->setFieldError("username", $e->getMessage());
				return;
			}
			
			$user->authorize($username, $password1);

			$this->message = sprintf("Hello, %s! Thank you for registration.", $username);
			$this->setResponse("redirect", ".");
			$this->status = "ok";
		}
		else
		{
			$this->setFieldError("username", "Необходимо пройти проверку на робота.");
			return;
		}
    }
    
    /*public function make_order()
    {
        if ($_SERVER["REQUEST_METHOD"] !== "POST") {
            // Method Not Allowed
            http_response_code(405);
            header("Allow: POST");
            $this->setFieldError("main", "Method Not Allowed");
            return;
        }
        
		$user_fio1 = $this->getRequestParam("user_fio1");
		$user_fio2 = $this->getRequestParam("user_fio2");
		$user_fio3 = $this->getRequestParam("user_fio3");
		$user_email = $this->getRequestParam("user_email");
		$user_tel1 = $this->getRequestParam("user_tel1");
		$user_address = $this->getRequestParam("user_city");
		$user_comment = $this->getRequestParam("user_comment");
		$user_region = $this->getRequestParam("user_region");

		$user_size_og = $this->getRequestParam("user_size_og");
		$user_size_ob = $this->getRequestParam("user_size_ob");
		$user_size_ot = $this->getRequestParam("user_size_ot");

		$delivery_type = $this->getRequestParam("user_delivery");
		
		$approve_agreement = $this->getRequestParam("approve_agreement");
		
		if ($approve_agreement != '') $approve_agreementInt = 1;
		else $approve_agreementInt = 0;

		if (empty($user_fio1)) {
			$this->setFieldError("user_fio1", "Введите фамилию");
			return;
		}

		if (empty($user_fio2)) {
			$this->setFieldError("user_fio2", "Введите имя");
			return;
		}

		if (empty($user_email)) {
			$this->setFieldError("user_email", "Укажите email");
			return;
		}

		if (empty($user_tel1)) {
			$this->setFieldError("user_tel1", "Укажите телефон");
			return;
		}
		
		if ($approve_agreementInt != 1)
		{
			$this->setFieldError("approve_agreement", "Необходимо согласиться с условиями оферты");
			return;
		}
		
		$cart =& $_SESSION['jcart']; 
		if(!is_object($cart))
		{
			$cart = new jcart();
		}
		
		if ($cart->get_count() <= 0)
		{
			$this->setResponse("redirect", "/index.php");
			$this->status = "err";	
			return;
		}
		
		$send_result = "";
		$cart->send_card($jcart, $user_fio1, $user_fio2, $user_fio3, $user_email, $user_tel1, $user_size_og, $user_size_ob, $user_size_ot, $user_region, $user_address, $user_comment, $delivery_type, $send_result);
		
		if ($send_result === "")
		{
			$this->setResponse("redirect", "/order_err.php");
			$this->status = "ok";	
		}
		else
		{
			$this->setResponse("redirect", "/order_ok.php");
			$this->status = "ok";	
		}
	}*/
}

$ajaxRequest = new AuthorizationAjaxRequest($_REQUEST);
$ajaxRequest->showResponse();
