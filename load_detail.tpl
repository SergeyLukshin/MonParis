<?php
	$query_detail_select = "SELECT ProductID, ProductIDStr, MP_CATEGORY.LatCategoryName, PriceInEuro, Articul, ProductName, ImagePath, ";
	$query_detail_select = $query_detail_select." MP_PRODUCT.Note, MP_BRAND.BrandID, MP_SEASON.SeasonID, BrandName, SeasonName, New, ";

	//$price_str = "Price * (100.0 - 33.33) / 100.0";
	//$price_discount_str = "(Price * (100.0 - 33.33) / 100.0) * (100.0 - IF(MP_PRODUCT.DiscountProductValue = 0, MP_BRAND_SEASON.DiscountWholesaleValue, MP_PRODUCT.DiscountProductValue)) / 100.0";

	if (User::getUserWhosaler() == "1")
	{
		$query_detail_select = $query_detail_select."IF(MP_PRODUCT.DiscountProductValue = 0, MP_BRAND_SEASON.DiscountWholesaleValue, MP_PRODUCT.DiscountProductValue) AS Discount, ";
		$price_discount_str = "Price * (100.0 - IF(MP_PRODUCT.DiscountProductValue = 0, MP_BRAND_SEASON.DiscountWholesaleValue, MP_PRODUCT.DiscountProductValue)) / 100.0";
	}
	else
	{
		$query_detail_select = $query_detail_select."IF(MP_PRODUCT.DiscountProductValue = 0, MP_BRAND_SEASON.DiscountValue, MP_PRODUCT.DiscountProductValue) AS Discount, ";
		$price_discount_str = "Price * (100.0 - IF(MP_PRODUCT.DiscountProductValue = 0, MP_BRAND_SEASON.DiscountValue, MP_PRODUCT.DiscountProductValue)) / 100.0";
	}
	
	$price_str = "Price";

	if (!User::isAuthorized())
	{
		$query_detail_select = $query_detail_select."IF(PriceOnlyForRegistered = 0, ".$price_str.", 0) AS OldPrice, ";
		$query_detail_select = $query_detail_select."IF(PriceOnlyForRegistered = 0, ".$price_discount_str.", 0) AS NewPrice ";
	}
	else
	{
		if (User::getNeedBlockPrice() == "1")
		{
			$query_detail_select = $query_detail_select."0 AS OldPrice, 0 AS NewPrice ";
		}
		else
		{
			if (User::getPriceInEuro() == "1")
			{
				$query_detail_select = $query_detail_select."PriceInEuro AS OldPrice, PriceInEuro AS NewPrice ";
			}
			else
			{
				$query_detail_select = $query_detail_select."".$price_str." AS OldPrice, ".$price_discount_str." AS NewPrice ";
			}
		}
	}
		
	$query_detail_from = " FROM MP_PRODUCT INNER JOIN MP_BRAND_SEASON ON MP_BRAND_SEASON.GroupID = MP_PRODUCT.GroupID";
	$query_detail_from = $query_detail_from." INNER JOIN MP_BRAND ON MP_BRAND.BrandID = MP_BRAND_SEASON.BrandID";
	$query_detail_from = $query_detail_from." INNER JOIN MP_SEASON ON MP_SEASON.SeasonID = MP_BRAND_SEASON.SeasonForSiteID";
	$query_detail_from = $query_detail_from." INNER JOIN MP_CATEGORY ON MP_PRODUCT.CategoryID = MP_CATEGORY.CategoryID";
	
	$query_detail_where = " WHERE MP_PRODUCT.ProductIDStr = '".$productID."'";
	
	$query_detail = $query_detail_select.$query_detail_from.$query_detail_where;

	$result_detail = mysql_query($query_detail);	
	
	$product_id = 0;
	$product_brand_name = "";
	$product_articul = "";
	$product_name = "";
	$product_note = "";
	$product_collection_name = "";
	$product_price = 0.0;
	$product_old_price = 0.0;
	$product_image_path = "";
	$vec_product_images = array();
	//$vec_product_attribs = array();
	$vec_product_sizes = array();
	$vec_product_colors = array();
	$vec_product_attribs = array();
	$product_new = 0;
	$productLatCategoryName = "";
	
	//echo $query_detail;
	//exit();
	
	if (mysql_num_rows($result_detail) == 1)
	{
		$row = mysql_fetch_array($result_detail);

		$product_id = $row["ProductID"];
		$product_brand_name = $row["BrandName"];
		$product_articul = $row["Articul"];
		$product_name = $row["ProductName"];
		$product_note = $row["Note"];
		$product_collection_name = $row["SeasonName"];
		$product_price = $row["NewPrice"];
		$product_old_price = $row["OldPrice"];
		$product_image_path = $row["ImagePath"];
		$product_discount = $row["Discount"];	
		$product_new = $row["New"];	
		$productLatCategoryName = $row["LatCategoryName"];	
		
		$strTitle = $product_name." – купить недорого онлайн в mon-paris.ru";
		$strDescription = $product_name." в интернет-магазине MON-PARIS – отличная покупка! Выбирайте европейское качество и стиль в Москве с нами. Недорого, удобно, с удовольствием! +7-(499)-132-49-81";
	
		if (User::getPriceInEuro() == "1") $product_discount = 0;

		$query_detail_images = "SELECT ImagePath FROM MP_PRODUCT_IMAGES WHERE ProductID = ".$product_id." ORDER BY ImagePath";
		$detail_images = mysql_query($query_detail_images);		
		$cnt_images = mysql_num_rows($detail_images);
		
		if ($cnt_images > 0)
		{
			while ($rowImage = mysql_fetch_array($detail_images)):
				$vec_product_images[$rowImage["ImagePath"]] = 1;
			endwhile;
		}

		$query_detail_attribs = "SELECT Color, Count, Size, AttribID FROM MP_PRODUCT_ATTRIB WHERE ProductID = ".$product_id." ORDER BY Color, Size";
		$detail_attribs = mysql_query($query_detail_attribs);		
		$cnt_attribs = mysql_num_rows($detail_attribs);
		
		$cntAll = 0;

		if ($cnt_attribs > 0)
		{
			while ($rowAttrib = mysql_fetch_array($detail_attribs)): 
				//$vec_product_attribs[$rowAttrib["Color"]] = 1;
				//$vec_product_sizes[$rowAttrib["Size"]][$rowAttrib["Color"]] = $rowAttrib["Count"];
				//$vec_product_colors[$rowAttrib["Color"]]= 1;

				$vec_product_attribs[$rowAttrib["Color"]][$rowAttrib["Size"]][$rowAttrib["AttribID"]] = $rowAttrib["Count"];
				$vec_product_colors[$rowAttrib["Color"]][$rowAttrib["Size"]] = $rowAttrib["Count"];
				$vec_product_sizes[$rowAttrib["Size"]]= 1;
				
				$cnt_tmp = $rowAttrib["Count"];
				if ($cnt_tmp < 0) $cnt_tmp = 0;
				$cntAll = $cntAll + $cnt_tmp;
			endwhile;
			
			ksort($vec_product_sizes);
			ksort($vec_product_colors);
			
			$_SESSION["attribs"] = $vec_product_attribs;
		}
		
		mysql_free_result($result_detail);
		mysql_free_result($detail_images);
		mysql_free_result($detail_attribs);
	}
	else
	{
		mysql_free_result($result_detail);
		
		//header ("HTTP/1.1 404 Not Found");
		header('Location: /404.php',TRUE,301);
		exit();
	}
?>
