<?php	

	// ������ ������
	if ($search !== 1) unset($_SESSION['search_txt']);
	
	if (isset ($_POST['search_txt']))
	{
		$search_txt = $_POST['search_txt'];
		$search_txt = mysql_escape_string($search_txt);
		$_SESSION['search_txt'] = $search_txt;
	}
	else
	{
		if (isset ($_SESSION['search_txt']) && $search === 1)
			$search_txt = $_SESSION['search_txt'];
	}


	// ��������� ������ � ��������
	// ���� ���� POST, ��������� �������� � ������, 
	// ���� ���, � �� ����� �� ���������, �� ����������� �������� �� ������
	// ���� ���, � �� ������� �� ������ ��������, �� ������ �������� (��������, ���� ����� ������� �� ������ �������� ������� �������, �� ��������� �����)
	if ($first_page_visit)
	{
		unset($_SESSION['filter_size_select']);
		unset($_SESSION['filter_color_select']);
		unset($_SESSION['filter_brand_select']);
		unset($_SESSION['filter_collection_select']);
		unset($_SESSION['filter_min_price']);
		unset($_SESSION['filter_max_price']);
		unset($_SESSION['filter_discount']);
	}
	
	$filter_size = array(42, 44, 46, 48, 50, 52, 54, 56, 58, 60);
	$filter_size_select = array();
	if (isset ($_POST['filter_size']))
	{
		$filter_size_select = $_POST['filter_size'];
		$_SESSION['filter_size_select'] = $filter_size_select;
	}
	else
	{
		if (isset ($_SESSION['filter_size_select']) && !$first_page_visit)
			$filter_size_select = $_SESSION['filter_size_select'];
	}

	$filter_color = array(1 => "�������", 2 => "�������", 3 => "�������", 4 => "�������", 5 => "�����", 6 => "����������", 7 => "�����", 8 => "������������", 
		9 => "�����", 10 => "������", 11 => "�������", 12 => "����������", 13 => "������", 14 => "���������");
	$filter_color_select = array();
	if (isset ($_POST['filter_color']))
	{
		$filter_color_select = $_POST['filter_color'];
		$_SESSION['filter_color_select'] = $filter_color_select;
	}
	else
	{
		if (!empty ($_SESSION['filter_color_select']) && !$first_page_visit)
			$filter_color_select = $_SESSION['filter_color_select'];
	}

	$filter_brand_select = array();
	if (isset ($_POST['filter_brand']))
	{
		$filter_brand_select = $_POST['filter_brand'];
		$_SESSION['filter_brand_select'] = $filter_brand_select;
	}
	else
	{
		if (!empty ($_SESSION['filter_brand_select']) && !$first_page_visit)
			$filter_brand_select = $_SESSION['filter_brand_select'];
	}

	$filter_collection_select = array();
	if (isset ($_POST['filter_collection']))
	{
		$filter_collection_select = $_POST['filter_collection'];
		$_SESSION['filter_collection_select'] = $filter_collection_select;
	}
	else
	{
		if (!empty ($_SESSION['filter_collection_select']) && !$first_page_visit)
			$filter_collection_select = $_SESSION['filter_collection_select'];
	}
		
	$filter_min_price = "500";
	if (isset ($_POST['slider_price_min']))
	{
		$filter_min_price = $_POST['slider_price_min'];
		$_SESSION['filter_min_price'] = $filter_min_price;
	}
	else
	{
		if (!empty ($_SESSION['filter_min_price']) && !$first_page_visit)
			$filter_min_price = $_SESSION['filter_min_price'];
	}

	$filter_max_price = "100000";
	if (isset ($_POST['slider_price_max']))
	{
		$filter_max_price = $_POST['slider_price_max'];
		$_SESSION['filter_max_price'] = $filter_max_price;
	}
	else
	{
		if (!empty ($_SESSION['filter_max_price']) && !$first_page_visit)
			$filter_max_price = $_SESSION['filter_max_price'];
	}
		
	$filter_discount = "0";
	if (isset ($_POST['filter_discount']))
	{
		$filter_discount = $_POST['filter_discount'];
		$_SESSION['filter_discount'] = $filter_discount;
	}
	else
	{
		if (!empty ($_SESSION['filter_discount']) && !$first_page_visit)
		{
			$filter_discount = $_SESSION['filter_discount'];
		}
	}
	// ----------------------------
	
	$str_filter_size = "";
	$str_filter_color = "";
	$str_filter_brand = "";
	$str_filter_collection = "";
	
	reset($filter_size_select);
	reset($filter_color_select);
	reset($filter_brand_select);
	reset($filter_collection_select);

	foreach ($filter_size_select as $size)
	{
		if ($size != "") 
		{
			if ($str_filter_size == "") $str_filter_size = $size;
			else  $str_filter_size = $str_filter_size.",".$size;
		}
	}
	
	foreach ($filter_color_select as $color)
	{
		if ($color != "") 
		{
			if ($str_filter_color == "") $str_filter_color = "'".$filter_color[(int)$color]."'";
			else  $str_filter_color = $str_filter_color.",'".$filter_color[(int)$color]."'";
		}
	}
	
	foreach ($filter_brand_select as $brand)
	{
		if ($brand != "") 
		{
			if ($str_filter_brand == "") $str_filter_brand = $brand;
			else  $str_filter_brand = $str_filter_brand.",".$brand;
		}
	}
	
	foreach ($filter_collection_select as $collection)
	{
		if ($collection != "") 
		{
			if ($str_filter_collection == "") $str_filter_collection = $collection;
			else  $str_filter_collection = $str_filter_collection.",".$collection;
		}
	}

	reset($filter_size_select);
	reset($filter_color_select);
	reset($filter_brand_select);
	reset($filter_collection_select);
?>
