<?php
	$cnt_on_page = 39;

	$query_product_select = "SELECT MP_PRODUCT.ProductID, ProductIDStr, MP_CATEGORY.LatCategoryName, ProductSort, AbsentInStock, SortValue, PriceInEuro, Articul, ProductName, ImagePath, MP_BRAND_SEASON.NewCollection, ";
	$query_product_select = $query_product_select." MP_PRODUCT.Note, IF(imagepath = \"\", 1, 0) AS ImageIsAbsent, MP_BRAND.BrandID, MP_SEASON.SeasonID, COALESCE(MP_USER_PRODUCT.UserID, 0) AS Favourite, ";
	$query_product_select = $query_product_select." BrandName, MP_BRAND.SecondName AS BrandSecondName, SeasonName, MP_PRODUCT.New, ";

	//$price_str = "Price * (100.0 - 33.33) / 100.0";
	//$price_discount_str = "(Price * (100.0 - 33.33) / 100.0) * (100.0 - IF(MP_PRODUCT.DiscountProductValue = 0, MP_BRAND_SEASON.DiscountWholesaleValue, MP_PRODUCT.DiscountProductValue)) / 100.0";

	if (User::getUserWhosaler() == "1")
	{
		$query_product_select = $query_product_select."IF(MP_PRODUCT.DiscountProductValue = 0, MP_BRAND_SEASON.DiscountWholesaleValue, MP_PRODUCT.DiscountProductValue) AS Discount, ";
		$price_discount_str = "Price * (100.0 - IF(MP_PRODUCT.DiscountProductValue = 0, MP_BRAND_SEASON.DiscountWholesaleValue, MP_PRODUCT.DiscountProductValue)) / 100.0";
	}
	else
	{
		$query_product_select = $query_product_select."IF(MP_PRODUCT.DiscountProductValue = 0, MP_BRAND_SEASON.DiscountValue, MP_PRODUCT.DiscountProductValue) AS Discount, ";
		$price_discount_str = "Price * (100.0 - IF(MP_PRODUCT.DiscountProductValue = 0, MP_BRAND_SEASON.DiscountValue, MP_PRODUCT.DiscountProductValue)) / 100.0";
	}
	
	if ($favorites != 0)
	{
		$strIDs = $vec_favorites[$fav_products]['products'];
		$vecIDs = split (",", $strIDs);
		$strFav = "CASE MP_PRODUCT.ProductID";
		for ( $i = 0 ; $i < count ( $vecIDs ); $i ++)
		{
			$strFav = $strFav." WHEN ".$vecIDs[$i]." THEN ".$i;
		}
		$query_product_select = $query_product_select.$strFav." ELSE 99999 END AS OrdBy, ";
	}

	$price_str = "Price";

	if (!User::isAuthorized())
	{
		$query_product_select = $query_product_select."IF(PriceOnlyForRegistered = 0, ".$price_str.", 0) AS OldPrice, ";
		$query_product_select = $query_product_select."IF(PriceOnlyForRegistered = 0, ".$price_discount_str.", 0) AS NewPrice ";
	}
	else
	{
		if (User::getNeedBlockPrice() == "1")
		{
			$query_product_select = $query_product_select."0 AS OldPrice, 0 AS NewPrice ";
		}
		else
		{
			/*if (User::getPriceInEuro() == "1")
			{
				$query_product_select = $query_product_select."PriceInEuro AS OldPrice, PriceInEuro AS NewPrice ";
			}
			else*/
			{
				$query_product_select = $query_product_select."".$price_str." AS OldPrice, ".$price_discount_str." AS NewPrice ";
			}
		}
	}
		
	$query_product_from = " FROM MP_PRODUCT INNER JOIN MP_BRAND_SEASON ON MP_BRAND_SEASON.GroupID = MP_PRODUCT.GroupID";
	$query_product_from = $query_product_from." INNER JOIN MP_BRAND ON MP_BRAND.BrandID = MP_BRAND_SEASON.BrandID";
	$query_product_from = $query_product_from." INNER JOIN MP_SEASON ON MP_SEASON.SeasonID = MP_BRAND_SEASON.SeasonForSiteID";
	$query_product_from = $query_product_from." INNER JOIN MP_CATEGORY ON MP_PRODUCT.CategoryID = MP_CATEGORY.CategoryID";
	$query_product_from = $query_product_from." LEFT JOIN MP_USER_PRODUCT ON MP_PRODUCT.ProductID = MP_USER_PRODUCT.ProductID AND MP_USER_PRODUCT.UserID = ".User::getUserID();
	
	$query_product_where = " WHERE MP_PRODUCT.Invisible = 0 AND MP_BRAND_SEASON.Invisible = 0 AND MP_SEASON.Invisible = 0 AND MP_BRAND_SEASON.CntProduct > 0 AND MP_PRODUCT.CountAttrib > 0";
	if (!User::isAuthorized()) /*если пользователь неавторизован, скрываем коллекции с флагом не показывать цену*/
		$query_product_where = $query_product_where." AND MP_BRAND_SEASON.PriceOnlyForRegistered = 0 "; 	
		
	// фильтр, в зависимости от выбора
	if ($favorites != 0)
	{
		/*$filename = "favorites.txt";
		$handle = fopen($filename, "r");
		if ($handle)
		{
			$favorites_products = fread($handle, filesize($filename));
			fclose($handle);
		}
		if ($favorites_products == "") $favorites_products = "0";*/
		
		$query_product_where = $query_product_where." AND MP_PRODUCT.ProductID IN (".$vec_favorites[$fav_products]['products'].")";
	}
	if ($bigsizes != 0) $query_product_where = $query_product_where." AND BigSize <> 0";
	if ($favorites_user != 0)  $query_product_where = $query_product_where." AND COALESCE(MP_USER_PRODUCT.UserID, 0) <> 0";
	//if ($cat_list != 0 && $category != "") $query_product_where = $query_product_where." AND MP_PRODUCT.CategoryID = ".$category;
	if ($cat_list != 0 && $category != "") $query_product_where = $query_product_where." AND MP_CATEGORY.LatCategoryName = '".$category."'";
	if ($brend_list != 0 && $brend != "") $query_product_where = $query_product_where." AND MP_BRAND.BrandName = '".$brend."'";
	//if ($col_list != 0 && $collection != "") $query_product_where = $query_product_where." AND MP_BRAND_SEASON.SeasonForSiteID = ".$collection;
	if ($new_col_list != 0 && $new_collection != "") $query_product_where = $query_product_where." AND CONCAT(MP_BRAND.BrandName, '-', MP_SEASON.LatSeasonName) = '".$new_collection."'";
	if ($search != 0)
	{
		$search_txt_ = str_replace(' ', '', $search_txt);
		$query_product_where = $query_product_where." AND (Articul LIKE '%".$search_txt_."%' OR ProductName LIKE '%".$search_txt_."%'";
		$query_product_where = $query_product_where." OR REPLACE(BrandName, '_', '') LIKE '%".$search_txt_."%' OR REPLACE(MP_BRAND.SecondName, '_', '') LIKE '%".$search_txt_."%'";
		$query_product_where = $query_product_where." OR REPLACE(BrandName, '-', '') LIKE '%".$search_txt_."%' OR REPLACE(MP_BRAND.SecondName, '-', '') LIKE '%".$search_txt_."%'";
		$query_product_where = $query_product_where." OR REPLACE(SeasonName, ' ', '') LIKE '%".$search_txt_."%')";
	}
	// -------------------------------
	
	// пользовательские фильтры
	if ($str_filter_color != "" && $str_filter_size != "") $query_product_where = $query_product_where." AND EXISTS (SELECT AttribID FROM MP_PRODUCT_ATTRIB AS pa 
		WHERE pa.ProductID = MP_PRODUCT.ProductID AND (YandexColor IN (".$str_filter_color.") OR RussianSize IN (".$str_filter_size.")))";

	if ($str_filter_color != "" && $str_filter_size == "") $query_product_where = $query_product_where." AND EXISTS (SELECT AttribID FROM MP_PRODUCT_ATTRIB AS pa 
		WHERE pa.ProductID = MP_PRODUCT.ProductID AND YandexColor IN (".$str_filter_color."))";

	if ($str_filter_color == "" && $str_filter_size != "") $query_product_where = $query_product_where." AND EXISTS (SELECT AttribID FROM MP_PRODUCT_ATTRIB AS pa 
		WHERE pa.ProductID = MP_PRODUCT.ProductID AND RussianSize IN (".$str_filter_size."))";

	if ($filter_discount != "0" /*&& User::getPriceInEuro() != "1"*/) $query_product_user_where = $query_product_user_where." AND Discount > 0";
	//if ($filter_discount != "0" && User::getPriceInEuro() == "1") $query_product_user_where = $query_product_user_where." AND 1 = 0"; // у валютчиков нет скидок
	if ($filter_min_price != "500") $query_product_user_where = $query_product_user_where." AND NewPrice >= ".$filter_min_price;
	if ($filter_max_price != "100000") $query_product_user_where = $query_product_user_where." AND NewPrice <= ".$filter_max_price;
	if ($str_filter_brand != "") $query_product_user_where = $query_product_user_where." AND BrandID IN (".$str_filter_brand.")";
	if ($str_filter_collection != "") $query_product_user_where = $query_product_user_where." AND SeasonID IN (".$str_filter_collection.")";
	$query_product_user_where = " WHERE 1=1".$query_product_user_where;
	// ------------------------
	
	if ($favorites != 0)
	{
		$query_product_orderby = " ORDER BY OrdBy";
	}
	else
	{
		$query_product_orderby = " ORDER BY ProductSort, AbsentInStock, NewCollection DESC, ImageIsAbsent, SortValue DESC, BrandName, ProductName";
	}

	$query_product = "SELECT * FROM (".$query_product_select.$query_product_from.$query_product_where.") AS tmp".$query_product_user_where.$query_product_orderby;
	//if ($favorites != 0)
	//	echo $query_product;

	// анализируем, нужно ли пересчитывать кол-во товаров
	if (isset($_SESSION['query_where']) && $_SESSION['query_where'] != $query_product_where 
		|| !isset($_SESSION['query_where']) || !isset($_SESSION['cnt_products']))
	{
		$query_cnt_product = "SELECT Count(*) AS Cnt FROM (".$query_product_select.$query_product_from.$query_product_where.") AS tmp".$query_product_user_where;

		$result_cnt_product = mysql_query($query_cnt_product);		
		$row = mysql_fetch_array($result_cnt_product);
		$rowCount = $row["Cnt"];
		mysql_free_result($result_cnt_product);
		
		$_SESSION['cnt_products'] = $rowCount;
	}
	else
	{
		$rowCount = $_SESSION['cnt_products'];
	}
	
	$cur_page_str = $cur_page;

	if ($cur_page == "" || $cur_page == 0)
		$cur_page = 1;
		
	$cnt_pages = 0;
	$cnt_pages = (int)($rowCount / $cnt_on_page);
	if ($cnt_pages * $cnt_on_page != $rowCount)
		$cnt_pages = $cnt_pages + 1;
		
	//if ($cur_page > $cnt_pages)
	//	$cur_page = $cnt_pages;
	
	if ($cnt_pages === 0) $cnt_pages = 1;
		
	if ($cur_page < 1 || $cur_page > $cnt_pages)
	{
		//echo $cur_page."  ".$cnt_pages."   ".$query_product;
		//header ("HTTP/1.1 404 Not Found");
		header('Location: /404.php',TRUE,301);
		exit();
	}

	$query_product = $query_product." LIMIT ".(($cur_page - 1) * $cnt_on_page).", ".$cnt_on_page;

	//echo $query_product;
?>
