<?php
	include_once ("init.tpl");
	
	$strTitle = "";
	$strDescription = "";
	$keywords = "";
	$strH1 = "";
	
	$main = 1;
	
	$request_URI = $_SERVER['REQUEST_URI'];

	include_once ("init_data.tpl");	
	
	// �������������
	$pos = stripos($request_URI, '/index.php');
	if($pos !== false) 
	{
		$bodytag = str_ireplace("/index.php", "", $_SERVER['REQUEST_URI']);
		if ($bodytag == "") $bodytag = "/";
		header("Location: ".$bodytag,TRUE,301);
		exit();
	}

	$pos = stripos($request_URI, '/brands'); // ������������� �� ������ ������ ���� http://mon-paris.ru/brands/ETINCELLE �� http://mon-paris.ru/catalog/brends/ETINCELLE
	if($pos !== false) 
	{
		$bodytag = str_ireplace("/brands", "/catalog/brends", $request_URI);
		if ($bodytag == "") $bodytag = "/";
		header("Location: ".$bodytag,TRUE,301);
		exit();
	}

	if($request_URI === "/bigsizes")  // ������������� �� ������ ������ ���� http://mon-paris.ru/bigsizes �� http://mon-paris.ru/catalog/bolshie-razmery
	{
		$bodytag = str_ireplace("/bigsizes", "/catalog/bolshie-razmery", $request_URI);
		if ($bodytag == "") $bodytag = "/";
		header("Location: ".$bodytag,TRUE,301);
		exit();
	}	

	if($request_URI === "/catalog/bigsizes")  // ������������� �� ������ ������ ���� http://mon-paris.ru/catalog/bigsizes �� http://mon-paris.ru/catalog/bolshie-razmery
	{
		$bodytag = str_ireplace("/bigsizes", "/bolshie-razmery", $request_URI);
		if ($bodytag == "") $bodytag = "/";
		header("Location: ".$bodytag,TRUE,301);
		exit();
	}	

	$pos = stripos($request_URI, '/catalog/brends');
	if($pos === 0)  // ������������� �� ������ ������ ���� http://mon-paris.ru/catalog/brends/ �� http://mon-paris.ru/catalog/
	{
		$bodytag = str_ireplace("/brends", "", $request_URI);
		if ($bodytag == "") $bodytag = "/";
		header("Location: ".$bodytag,TRUE,301);
		exit();
	}	

	if($request_URI === "/categories") // ������������� �� ������ ������ ���� http://mon-paris.ru/categories �� http://mon-paris.ru/catalog/all
	{
		$bodytag = str_ireplace("/categories", "/catalog/all", $request_URI);
		if ($bodytag == "") $bodytag = "/";
		header("Location: ".$bodytag,TRUE,301);
		exit();
	}	
	

	if($request_URI === "/catalog") // ������������� http://mon-paris.ru/catalog �� http://mon-paris.ru/catalog/all
	{
		$bodytag = "/catalog/all";
		header("Location: ".$bodytag,TRUE,301);
		exit();
	}	

	$pos = stripos($request_URI, '/categories'); // ������������� �� ������ ������ ���� http://mon-paris.ru/categories/39 �� http://mon-paris.ru/catalog/categories/39
	if($pos === 0) 
	{
		$bodytag = str_ireplace("/categories", "/catalog/categories", $request_URI);
		if ($bodytag == "") $bodytag = "/";
		header("Location: ".$bodytag,TRUE,301);
		exit();
	}	

	$pos = stripos($request_URI, '/goods'); // ������������� �� ������ ������ ���� http://mon-paris.ru/goods/ �� http://mon-paris.ru/detail/
	if($pos === 0)  
	{
		$bodytag = str_ireplace("/goods", "/detail", $request_URI);
		if ($bodytag == "") $bodytag = "/";
		header("Location: ".$bodytag,TRUE,301);
		exit();
	}	
	
	// ������������� �� ������ ������ ���� http://mon-paris.ru/catalog/categories/37 �� http://mon-paris.ru/catalog/aksessuary
	reset($vec_category);																	
	foreach ($vec_category as $key => $value) 
	{
		if($request_URI === "/catalog/categories/".$value[1])
		{
			header("Location: "."/catalog/".$key,TRUE,301);
			exit();								
		}
	}
	
	// ������������� �� ������ ������ ���� http://mon-paris.ru/detail/11616 �� http://mon-paris.ru/catalog/aksessuary/remen-3w707-11616
	$pos = stripos($request_URI, '/detail');
	if($pos === 0)  
	{
		$pid = str_ireplace("/detail/", "", $request_URI);
		$queryP = "SELECT ProductIDStr, LatCategoryName FROM MP_PRODUCT INNER JOIN MP_CATEGORY ON MP_PRODUCT.CategoryID = MP_CATEGORY.CategoryID WHERE ProductID = ".$pid; 
		$resultP = mysql_query($queryP); 
		
		while ($row = mysql_fetch_array($resultP)): 
			mysql_free_result($resultP);
			$bodytag = "/catalog/".$row["LatCategoryName"]."/".$row["ProductIDStr"];
			header("Location: ".$bodytag,TRUE,301);
			exit();
		endwhile;
	}
	// -------------
	
	$mRequestUri = addslashes($_SERVER["REQUEST_URI"]);
	$url = split ("/", $mRequestUri);
	
	$index = 0;
	$url_str = "";
	$category_for_url = "";
	$first_page_visit = true; // ��� ��� ������ ������� � ��������
	$page_no_found = true;
	
	$cnt = 0;
	
	foreach($url as $str)
	{	
		// ����� utm_ �����
		$pos = stripos($str, '?utm_');
		if($pos === 0)
		{
			$page_no_found = false;
			continue;			
		}
		if ($pos > 0)
		{
			$str = substr($str, 0, $pos);
		}
		
		// ����� yclid
		$pos = stripos($str, '?yclid=');
		if($pos === 0)
		{
			$page_no_found = false;
			continue;			
		}
		if ($pos > 0)
		{
			$str = substr($str, 0, $pos);
		}
		
		// ����� gclid
		$pos = stripos($str, '?gclid=');
		if($pos === 0)
		{
			$page_no_found = false;
			continue;			
		}
		if ($pos > 0)
		{
			$str = substr($str, 0, $pos);
		}

		$pos = stripos($str, '?banner-test-tags=');
		if($pos === 0)
		{
			$page_no_found = false;
			continue;			
		}
		if ($pos > 0)
		{
			$str = substr($str, 0, $pos);
		}

		
		if ($index === 0) // ������ ������� ������ ������ ������
		{
			$index ++;
			continue;			
		}
			
		if ($index === 1)
		{			
			if ($str === "") // ������� ��������
			{
				$page_no_found = false;
			}
			
			if ($str === 'catalog') // �������
			{
				$catalog = 1;
				$main = 0;
				$strTitle = "�������";
				$page_no_found = false;
			}
			/*if ($str === 'detail') // �����
			{
				$detail = 1;
				$main = 0;
				$strTitle = "�������� ������";
				//$page_no_found = false;
			}*/
		}
		if ($index === 2)
		{			
			$main = 0;

			$page_no_found = true; // ����� ���������, �.�. ����� ���� ������������ ����������
			
			if ($str == 'search')
			{
				$search = 1;
				$url_str = "catalog/search";
				$page_no_found = false;
			}	
			
			if ($str === 'bolshie-razmery')
			{
				$bigsizes = 1;
				$url_str = "catalog/bolshie-razmery";
				$page_no_found = false;
				$strTitle = "������� �������";
			}

			if ($str === 'izbrannoe')
			{
				$favorites_user = 1;
				$url_str = "catalog/izbrannoe";
				$page_no_found = false;
				$strTitle = "���������";
			}

			if (array_key_exists($str, $vec_favorites)) {
				$favorites = 1;
				$url_str = "catalog/".$str;
				$fav_products = $str;
				$page_no_found = false;
				$strTitle = $vec_favorites[$str]['title'];
			}
			
			if (array_key_exists($str, $vec_brand)) {
				$brend_list = 1;
				$url_str = "catalog/".$str;
				$page_no_found = false;
				$brend = $str;
				
				if ($vec_brand[$brend][1] != "") {
					$strTitle = "������� ����������� � ����������� ������� ������ ".$brend." (".$vec_brand[$brend][1].") � ������ � MON-PARIS";
					$strDescription = "�������� � ������������ ���� �� ������ �� ".$brend." (".$vec_brand[$brend][1].") �������� � ��������-�������� MON-PARIS. ��������� ����������� �������� � ����� ������! +7(495)-518-91-65";
					$strH1 = "������� �� ".$brend." (".$vec_brand[$brend][1].") � � ������";
				}
				else {
					$strTitle = "������� ����������� � ����������� ������� ������ ".$brend." � ������ � MON-PARIS";
					$strDescription = "�������� � ������������ ���� �� ������ �� ".$brend." �������� � ��������-�������� MON-PARIS. ��������� ����������� �������� � ����� ������! +7(495)-518-91-65";
					$strH1 = "������� �� ".$brend." � � ������";
				}
			}
			
			
			if (array_key_exists($str, $vec_category)) {
				$cat_list = 1;
				$url_str = "catalog/".$str;
				$page_no_found = false;
				$category = $str;
				
				$strTitle = "������ ������� ".$vec_category[$str][0]." � ������ �� MON-PARIS";
				$strDescription = "�������� ���������� ������� ".$vec_category[$str][0]." �� �������� ���� ������ � �������� �������� MON PARIS. �������� ������! ����������� ������������, �������� ��������, ������� �������. �������� �������� �� ������.";
				$strH1 = "������� ".$vec_category[$str][0]." ��� ��� � ����� ������";
			}
			
			if (array_key_exists($str, $vec_new_collection)) {
				$new_col_list = 1;
				$url_str = "catalog/".$str;
				$page_no_found = false;
				$new_collection = $str;
			}
			
			/*if ($str === 'brends')
			{
				$brend_list = 1;
				$url_str = "catalog/brends";
			}
			if ($str === 'categories')
			{
				$cat_list = 1;
				$url_str = "catalog/categories";
			}
			if ($str === 'collections')
			{
				$col_list = 1;
				$url_str = "catalog/collections";
				//$page_no_found = false;
			}
			if ($str === 'new_collection')
			{
				$new_col_list = 1;
				$url_str = "catalog/new_collection";
			}*/
			if ($str === 'all')
			{
				$all = 1;
				$url_str = "catalog/all";
				$page_no_found = false;
			}
			/*if ($detail === 1)
			{
				$productID = $str;
				$page_no_found = false;
			}*/
		}
		if ($index == 3) // ��������� ������ ��� ��������� ��� �������� ��� �������� ������� ��� �������� �������
		{
			$page_no_found = true; // ����� ���������, �.�. ����� ���� ������������ ����������

			if ($cat_list === 1) // ����� ���� ������ �� ����� ��� ��������, ���������� ���������
			{
				if (!is_numeric($str))
				{
					$detail = 1;
					$main = 0;
					//$strTitle = "�������� ������";
					$productID = $str;
					$page_no_found = false;
					
					$cat_list = 0;
					$category_for_url = $category;
					$category = "";
					$catalog = 0;
				}
			}

			/*if ($brend_list === 1)
			{
				$brend = $str;
				$url_str = "catalog/brends/".$brend;
				$page_no_found = false;
			}
			if ($cat_list === 1)
			{
				$category = $str;
				$url_str = "catalog/categories/".$category;
				$page_no_found = false;
			}*/

			/*if ($new_col_list === 1)
			{
				$new_collection = $str;
				$url_str = "catalog/new_collection/".$new_collection;
				$page_no_found = false;
			}*/
			
			if ($bigsizes === 1 || $all === 1 || $search === 1 || $favorites === 1 || $brend_list === 1 || $cat_list === 1 || $new_col_list === 1)
			{
				if (!is_numeric($str))
				{
					//header ("HTTP/1.1 404 Not Found");
					header('Location: /404.php',FALSE,301);
					exit();
				}
				
				$cur_page = $str;
				$first_page_visit = false;
				$page_no_found = false;
			}
		}
		if ($index >= 4) // �������� ��� ��������
		{
			$page_no_found = true; // ����� ���������, �.�. ����� ���� ������������ ����������

			/*if ($brend_list === 1 || $cat_list === 1 || $new_col_list === 1)
			{
				$cur_page = $str;
				$first_page_visit = false;
				$page_no_found = false;
			}*/
		}


		$index ++;
	}
	
	if ($page_no_found)
	{
		//header ("HTTP/1.1 404 Not Found");
		header('Location: /404.php',FALSE,301);
		exit();
	}

	//$real_cur_page = $cur_page;
	
	if ($main === 1)
	{
		$strTitle = "�������� ������� MON-PARIS.RU � ������ ������� ������ �� �������, ������, ������ � ������";
		$strDescription = "�� ����� ������� ������� ������ � ������? �������� ����� � Mon-Paris! � ��������-�������� ��� �������, �� �������� ���������� �������� � ���. ����� �������� � ���������� ���� �� ������ � ������� � ��� �����.";
		$strH1 = "��������-������� Mon Paris � ������� ��� ����������� ��������� ����������� ����";
		
		include_once ("top.tpl");
		include_once ("main.tpl");
		include_once ("bottom.tpl");
		exit();
	}
	
	if ($catalog === 1)
	{
		$_SESSION['cur_page'] = $cur_page;
		// ��������� ������ �� ������
		include_once ("filter.tpl");
		include_once ("load_products.tpl");

		include_once ("top.tpl");	
	
		include_once ("catalog.tpl");
		include_once ("bottom.tpl");
		exit();
	}
	
	if ($detail === 1)
	{
		include_once ("load_detail.tpl");
		include_once ("top.tpl");	
		include_once ("detail.tpl");
		include_once ("bottom.tpl");
		exit();
	}
	
	header('Location: /404.php',FALSE,301);
	exit();

?>        

