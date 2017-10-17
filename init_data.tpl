<?php
	/*if ($main != "") 
	{
		unset($_SESSION['collection']);
		unset($_SESSION['category']);
		unset($_SESSION['brand']);
		//unset($_SESSION['favorites']);
	}*/
		
	if (!isset($_SESSION['user_data']))
	{
		// то проверяем его куки
		// вдруг там есть логин и пароль к нашему скрипту
		if (isset($_COOKIE['login']) && isset($_COOKIE['password']))
		{
			// если же такие имеются
			// то пробуем авторизовать пользователя по этим логину и паролю
			$login_name = mysql_escape_string($_COOKIE['login']);
			$password = mysql_escape_string($_COOKIE['password']);
			
			$user = new User();
			$user->authorize($login_name, $password, true, false);
		}
	}

	//if (!isset($_SESSION['collection']))
	{
		//$query = "SELECT SeasonID, SeasonName FROM MP_SEASON WHERE MP_SEASON.Invisible = 0 ORDER BY SeasonSort DESC"; 
		$query = "SELECT SeasonID, SeasonName FROM MP_SEASON WHERE MP_SEASON.Invisible = 0 AND EXISTS ";
		$query = $query."(SELECT * FROM MP_BRAND_SEASON WHERE MP_BRAND_SEASON.Invisible = 0 AND MP_BRAND_SEASON.CntProduct > 0 AND MP_BRAND_SEASON.SeasonForSiteID = MP_SEASON.SeasonID) ORDER BY SeasonSort DESC"; 

		$result1 = mysql_query($query); 
		
		while ($row = mysql_fetch_array($result1)): 
			$vec_collection[$row["SeasonID"]] = $row["SeasonName"];
		endwhile;
		mysql_free_result($result1);																						
		//$_SESSION['collection'] = $vec_collection;
	}
	/*else
	{
		$vec_collection = $_SESSION['collection'];
	}*/

	//if (!isset($_SESSION['category']))
	{
		$query = "SELECT CategoryID, CategoryName, LatCategoryName FROM MP_CATEGORY WHERE Invisible = 0 ORDER BY CategoryName"; 
		$result2 = mysql_query($query); 
		
		while ($row = mysql_fetch_array($result2)): 
			$vec_category[$row["LatCategoryName"]] = array($row["CategoryName"], $row["CategoryID"]);
		endwhile;
		mysql_free_result($result2);																						
		//$_SESSION['category'] = $vec_category;
	}
	/*else
	{
		$vec_category = $_SESSION['category'];
	}*/

	//$query = "SELECT BrandName FROM GF_BRAND GROUP BY BrandName ORDER BY BrandName"; 
	//$result3 = mysql_query($query); 

	//if (!isset($_SESSION['brand']))
	{
		$query = "SELECT MP_BRAND.BrandID, MP_BRAND.BrandName, MP_SEASON.SeasonID, MP_SEASON.SeasonName FROM MP_BRAND_SEASON ";
		$query = $query."INNER JOIN MP_BRAND ON MP_BRAND.BrandID = MP_BRAND_SEASON.BrandID ";
		$query = $query."INNER JOIN MP_SEASON ON MP_SEASON.SeasonID = MP_BRAND_SEASON.SeasonForSiteID ";
		$query = $query."WHERE MP_BRAND_SEASON.Invisible = 0 AND MP_SEASON.Invisible = 0 AND MP_BRAND_SEASON.CntProduct > 0 ";
		$query = $query."ORDER BY BrandSort, BrandName"; 
		$result4 = mysql_query($query); 
		
		while ($row = mysql_fetch_array($result4)): 
			//$vec_brand[$row["BrandName"]][$row["SeasonID"]] = $row["SeasonName"];
			$vec_brand[$row["BrandName"]] = $row["BrandID"];
		endwhile;
		mysql_free_result($result4);																						
		//$_SESSION['brand'] = $vec_brand;
	}
	/*else
	{
		$vec_brand = $_SESSION['brand'];
	}*/
	
	
	$query = "SELECT GroupID, MP_BRAND.BrandName, MP_SEASON.SeasonName, MP_SEASON.LatSeasonName FROM MP_BRAND_SEASON INNER JOIN MP_SEASON ON MP_SEASON.SeasonID = MP_BRAND_SEASON.SeasonForSiteID ";
	$query = $query."INNER JOIN MP_BRAND ON MP_BRAND.BrandID = MP_BRAND_SEASON.BrandID "; 
	$query = $query."WHERE MP_BRAND_SEASON.NewCollection <> 0 AND MP_BRAND_SEASON.CntProduct > 0 "; 
	if (!User::isAuthorized()) /*если пользователь неавторизован, скрываем коллекции с флагом не показывать цену*/
		$query = $query." AND MP_BRAND_SEASON.PriceOnlyForRegistered = 0 "; 
	$query = $query."ORDER BY MP_BRAND.BrandSort, MP_SEASON.SeasonSort DESC, MP_BRAND.BrandName"; 

	$result_col = mysql_query($query); 
	
	while ($row = mysql_fetch_array($result_col)): 
		$vec_new_collection[$row["BrandName"].'-'.$row["LatSeasonName"]] = array($row["GroupID"], $row["BrandName"], $row["SeasonName"]);
	endwhile;
	mysql_free_result($result_col);
	
?>
