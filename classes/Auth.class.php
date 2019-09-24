<?php
//include_once ('../db_settings.php');

class User
{
    private $user_id;
    private $user_data;
    
    private $need_refresh_basket;
    /*public $user_name;
    public $user_discount;
	public $user_wholesale_discount;
	public $user_wholesaler;
	public $user_block_prices;
	public $user_use_price_in_euro;*/

    private $is_authorized = false;
    
    private $database;
    private $db_host = "u189200.mysql.masterhost.ru";
    private $db_name = "u189200";
    private $db_user = "u189200";
    private $db_pass = "9hoomo2makerv";

    function User() 
	{
	}

	public function __construct($username = null, $password = null)
    {
        $this->username = $username;
        $this->connectDb();
    }

    public function __destruct()
    {
        $this->database = null;
    }
    
    public static function isAuthorized()
    {
        if (!empty($_SESSION["user_data"])) {
            return (bool) $_SESSION["user_data"];
        }
        return false;
    }
    
    /*public static function getPriceInEuro()
    {
        if (!empty($_SESSION["user_data"])) {
            return $_SESSION["user_data"]["UsePriceInEuro"];
        }
        return "";
    }*/
    
    public static function getNeedBlockPrice()
    {
        if (!empty($_SESSION["user_data"])) {
            return $_SESSION["user_data"]["BlockPrices"];
        }
        return "";
    }
    
    public static function getUserName()
    {
        if (!empty($_SESSION["user_data"])) {
            return $_SESSION["user_data"]["FirstName"];
        }
        return "";
    }
    
    public static function getUserLogin()
    {
        if (!empty($_SESSION["user_data"])) {
            return $_SESSION["user_data"]["UserLogin"];
        }
        return "";
    }
    
    public static function getUserPhone()
    {
        if (!empty($_SESSION["user_data"])) {
            return $_SESSION["user_data"]["UserPhone"];
        }
        return "";
    }
    
    public static function getUserID()
    {
        if (!empty($_SESSION["user_data"])) {
            return $_SESSION["user_data"]["UserID"];
        }
        return "0";
    }

    public static function getUserWhosaler()
    {
        if (!empty($_SESSION["user_data"])) {
            return $_SESSION["user_data"]["Wholesaler"];
        }
        return "";
    }

    public static function getNeedRefreshBasket()
    {
        if (!empty($_SESSION["need_refresh_button"])) {
            return $_SESSION["need_refresh_button"];
        }
        return "0";
    }
    
    public static function setNeedRefreshBasket($val)
    {
        $_SESSION["need_refresh_button"] = $val;
    }
    
    public function authorize($username, $psw, $remember=false, $from_ajax = true)
    {
		if ($from_ajax)
		{
			$username = iconv("UTF-8", "windows-1251", $username);
			$psw = iconv("UTF-8", "windows-1251", $psw);
			$password = md5($psw);
		}
		else
			$password = $psw;
		
		$query = "select `UserID`, FirstName, BlockPrices, UsePriceInEuro, Login, Phone, Wholesaler FROM `MP_USER` WHERE `login` = '{$username}' and `password` = '{$password}' limit 1";
		$sth = $this->database->prepare($query);
            
        $sth->execute();
        $this->user_ = $sth->fetch();
        
        if (!$this->user_) {
            $this->is_authorized = false;
        } else {
            $this->is_authorized = true;
            $this->user_data['UserID'] = $this->user_['UserID'];
			$this->user_data['FirstName'] = $this->user_['FirstName'];//iconv("windows-1251", "UTF-8", $this->user_['FirstName']);
			$this->user_data['BlockPrices'] = (string)$this->user_['BlockPrices'];
			//$this->user_data['UsePriceInEuro'] = (string)$this->user_['UsePriceInEuro'];
			$this->user_data['NeedRefreshBasket'] = "1";
            $this->user_data['UserLogin'] = $this->user_['Login'];
            $this->user_data['UserPhone'] = $this->user_['Phone'];
            $this->user_data['Wholesaler'] = (string)$this->user_['Wholesaler'];
            
            $this->saveSession($username, $password, $remember);
            
            $query = "INSERT INTO `MP_USERS_VISITS` (`UserID`) VALUES (".$this->user_['UserID'].")";
			$sth = $this->database->prepare($query);            
			$sth->execute();
        }

        return $this->is_authorized;
    }
    
    public function saveSession($username, $password, $remember = false, $http_only = true, $days = 7)
    {
        $_SESSION["user_data"] = $this->user_data;
        User::setNeedRefreshBasket("1");

        if ($remember) {
            $expire = time() + $days * 24 * 3600;
			
			setcookie('login', $username, $expire, "/");
			setcookie('password', $password, $expire, "/");
        }
    }
    
    public function create($username, $psw, $firstname, $surname, $fathername, $phone, $region, $address, $user_brand_str, $user_cat_str, $user_size_str, $wholesalerInt, $agree_deliveryInt) 
    {
		$username = iconv("UTF-8", "windows-1251", $username);
		$firstname = iconv("UTF-8", "windows-1251", $firstname);
		$surname = iconv("UTF-8", "windows-1251", $surname);
		$fathername = iconv("UTF-8", "windows-1251", $fathername);
		$region = iconv("UTF-8", "windows-1251", $region);
		$address = iconv("UTF-8", "windows-1251", $address);
		
		$user_brand_str = iconv("UTF-8", "windows-1251", $user_brand_str);
		$user_cat_str = iconv("UTF-8", "windows-1251", $user_cat_str);
		$user_size_str = iconv("UTF-8", "windows-1251", $user_size_str);
		
		
		$psw = iconv("UTF-8", "windows-1251", $psw);
		$password = md5($psw);
		
		$query = "SELECT `UserID` FROM `MP_USER` WHERE `login`='{$username}' LIMIT 1";
		$sth = $this->database->prepare($query);
            
        $sth->execute();
        $this->user_ = $sth->fetch();
        
        if (!$this->user_) 
        {
			
			if ($wholesalerInt == 0)
				$block_prices = 0;
			else
				$block_prices = 1;
				
			$query = "INSERT INTO `MP_USER` (Login, Password, Surname, FirstName, FatherName, Phone, Region, Address, WholeSaler, BrandWishes, SizeWishes, CategoryWishes, New, PasswordNoMD5, BlockPrices, AgreeWithDelivery) values ";			
			$query = $query."('{$username}', '{$password}', '{$surname}', '{$firstname}', '{$fathername}', '{$phone}', '{$region}', '{$address}', {$wholesalerInt}, '{$user_brand_str}', '{$user_size_str}', '{$user_cat_str}', 1, '{$psw}', {$block_prices}, {$agree_deliveryInt})";
			$sth = $this->database->prepare($query);

			try 
			{
				$result = $sth->execute();
				
			} catch (PDOException $e) {
				throw new Exception("Database error: ".$e->getMessage());
			}
		}
		else
			throw new Exception("Пользователь с таким логином уже зарегистрирован", 1);	
		
			
        return;
    }

    public function connectdb()
    {
        try {
            $this->database = new pdo("mysql:host=$this->db_host;dbname=$this->db_name", $this->db_user, $this->db_pass);
        } catch (pdoexception $e) {
            echo "database error: " . $e->getmessage();
            die();
        }
        $this->database->query('SET NAMES \'cp1251\'');

        return $this;
    }
}
