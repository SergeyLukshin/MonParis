<?php

// JCART v1.1
// http://conceptlogic.com/jcart/

// SESSION BASED SHOPPING CART CLASS FOR JCART

/**********************************************************************
Based on Webforce Cart v.1.5
(c) 2004-2005 Webforce Ltd, NZ
http://www.webforce.co.nz/cart/
**********************************************************************/

// USER CONFIG
//include_once ('../db_settings.php');
include_once('jcart-config.php');
include_once('../classes/Auth.class.php');

// DEFAULT CONFIG VALUES
include_once('jcart-defaults.php');
include_once($_SERVER['DOCUMENT_ROOT'].'/colorbox/images/ie6/ie6.php');
header('content-type:text/html; charset=windows-1251');

// JCART
class jcart {
	var $total = 0;
	var $itemcount = 0;
	var $items = array();
	var $itemprices = array();
	var $itemqtys = array();
	var $itemname = array();
	var $order_number = "";
	var $order_delivery_type = 1;
	
	// CONSTRUCTOR FUNCTION
	function jcart() 
	{

	}

	// GET CART CONTENTS
	function get_contents()
		{
		$items = array();
		foreach($this->items as $tmp_item)
			{
				
			$item = FALSE;

			$item['id'] = $tmp_item;
			$item['qty'] = $this->itemqtys[$tmp_item];
			$item['price'] = $this->itemprices[$tmp_item];
			$item['name'] = $this->itemname[$tmp_item];
			$item['subtotal'] = $item['qty'] * $item['price'];
			$items[] = $item;
			}
		return $items;
		}
		
	function get_count()
		{
			return $this->itemcount;//sizeof($this->items);
		}

	// ADD AN ITEM
	function add_item($item_id, $item_qty=1, $item_price, $item_name)
		{
		// VALIDATION
		$valid_item_qty = $valid_item_price = false;

		// IF THE ITEM QTY IS AN INTEGER, OR ZERO
		if (preg_match("/^[0-9-]+$/i", $item_qty))
			{
			$valid_item_qty = true;
			}
		// IF THE ITEM PRICE IS A FLOATING POINT NUMBER
		if (is_numeric($item_price))
			{
			$valid_item_price = true;
			}

		// ADD THE ITEM
		
		
		if ($valid_item_qty !== false && $valid_item_price !== false)
			{
			// IF THE ITEM IS ALREADY IN THE CART, INCREASE THE QTY
			if($this->itemqtys[$item_id] > 0)
				{
				$this->itemqtys[$item_id] = $item_qty + $this->itemqtys[$item_id];
				$this->_update_total();
				}
			// THIS IS A NEW ITEM
			else
				{
				$this->items[] = $item_id;
				$this->itemqtys[$item_id] = $item_qty;
				$this->itemprices[$item_id] = $item_price;
				$this->itemname[$item_id] = $item_name;
				}
			$this->_update_total();
			

			return true;
			}

		else if	($valid_item_qty !== true)
			{
			$error_type = 'qty';
			return $error_type;
			}
		else if	($valid_item_price !== true)
			{
			$error_type = 'price';
			return $error_type;
			}
		}

	// UPDATE AN ITEM
	function update_item($item_id, $item_qty)
		{
		// IF THE ITEM QTY IS AN INTEGER, OR ZERO
		// UPDATE THE ITEM
		if (preg_match("/^[0-9-]+$/i", $item_qty))
			{
			if($item_qty < 1)
				{
				$this->del_item($item_id);
				}
			else
				{
				$this->itemqtys[$item_id] = $item_qty;
				}
			$this->_update_total();
			return true;
			}
		}


	// UPDATE THE ENTIRE CART
	// VISITOR MAY CHANGE MULTIPLE FIELDS BEFORE CLICKING UPDATE
	// ONLY USED WHEN JAVASCRIPT IS DISABLED
	// WHEN JAVASCRIPT IS ENABLED, THE CART IS UPDATED ONKEYUP
	function update_cart()
		{
		// POST VALUE IS AN ARRAY OF ALL ITEM IDs IN THE CART
		if (is_array($_POST['jcart_item_ids']))
			{
			// TREAT VALUES AS A STRING FOR VALIDATION
			$item_ids = implode($_POST['jcart_item_ids']);
			}

		// POST VALUE IS AN ARRAY OF ALL ITEM QUANTITIES IN THE CART
		if (is_array($_POST['jcart_item_qty']))
			{
			// TREAT VALUES AS A STRING FOR VALIDATION
			$item_qtys = implode($_POST['jcart_item_qty']);
			}

		// IF NO ITEM IDs, THE CART IS EMPTY
		if ($_POST['jcart_item_id'])
			{
			// IF THE ITEM QTY IS AN INTEGER, OR ZERO, OR EMPTY
			// UPDATE THE ITEM
			if (preg_match("/^[0-9-]+$/i", $item_qtys) || $item_qtys == '')
				{
				// THE INDEX OF THE ITEM AND ITS QUANTITY IN THEIR RESPECTIVE ARRAYS
				$count = 0;

				// FOR EACH ITEM IN THE CART
				foreach ($_POST['jcart_item_id'] as $item_id)
					{
					// GET THE ITEM QTY AND DOUBLE-CHECK THAT THE VALUE IS AN INTEGER
					$update_item_qty = intval($_POST['jcart_item_qty'][$count]);

					if($update_item_qty < 1)
						{
						$this->del_item($item_id);
						}
					else
						{
						// UPDATE THE ITEM
						$this->update_item($item_id, $update_item_qty);
						}

					// INCREMENT INDEX FOR THE NEXT ITEM
					$count++;
					}
				return true;
				}
			}
		// IF NO ITEMS IN THE CART, RETURN TRUE TO PREVENT UNNECSSARY ERROR MESSAGE
		else if (!$_POST['jcart_item_id'])
			{
			return true;
			}
		}


	// REMOVE AN ITEM
	/*
	GET VAR COMES FROM A LINK, WITH THE ITEM ID TO BE REMOVED IN ITS QUERY STRING
	AFTER AN ITEM IS REMOVED ITS ID STAYS SET IN THE QUERY STRING, PREVENTING THE SAME ITEM FROM BEING ADDED BACK TO THE CART
	SO WE CHECK TO MAKE SURE ONLY THE GET VAR IS SET, AND NOT THE POST VARS

	USING POST VARS TO REMOVE ITEMS DOESN'T WORK BECAUSE WE HAVE TO PASS THE ID OF THE ITEM TO BE REMOVED AS THE VALUE OF THE BUTTON
	IF USING AN INPUT WITH TYPE SUBMIT, ALL BROWSERS DISPLAY THE ITEM ID, INSTEAD OF ALLOWING FOR USER FRIENDLY TEXT SUCH AS 'remove'
	IF USING AN INPUT WITH TYPE IMAGE, INTERNET EXPLORER DOES NOT SUBMIT THE VALUE, ONLY X AND Y COORDINATES WHERE BUTTON WAS CLICKED
	CAN'T USE A HIDDEN INPUT EITHER SINCE THE CART FORM HAS TO ENCOMPASS ALL ITEMS TO RECALCULATE TOTAL WHEN A QUANTITY IS CHANGED, WHICH MEANS THERE ARE MULTIPLE REMOVE BUTTONS AND NO WAY TO ASSOCIATE THEM WITH THE CORRECT HIDDEN INPUT
	*/
	function del_item($item_id)
		{
		$ti = array();
		$this->itemqtys[$item_id] = 0;
		foreach($this->items as $item)
			{
			if($item != $item_id)
				{
				$ti[] = $item;
				}
			}
		$this->items = $ti;
		$this->_update_total();
		}

	// EMPTY THE CART
	function empty_cart()
		{
		$this->order_number = "";
		$this->order_delivery_type = 1;
		$this->total = 0;
		$this->itemcount = 0;
		$this->items = array();
		$this->itemprices = array();
		$this->itemqtys = array();
		$this->itemname = array();
		}

	/*function empty_cart_put()
		{
		$this->items_put = array();
		}*/

	// INTERNAL FUNCTION TO RECALCULATE TOTAL
	function _update_total()
		{
		$old_itemcount = $this->itemcount;
		$this->itemcount = 0;
		$this->total = 0;
		if(sizeof($this->items) > 0)
			{
			foreach($this->items as $item)
				{
				$this->total = $this->total + ($this->itemprices[$item] * $this->itemqtys[$item]);

				// TOTAL ITEMS IN CART (ORIGINAL wfCart COUNTED TOTAL NUMBER OF LINE ITEMS)
				$this->itemcount += $this->itemqtys[$item];
				}
			}
		}		
		
	/*function display_short_cart_put($jcart)
		{			
			echo sizeof($this->items_put);
		}*/
		
	function display_short_cart($jcart)
		{			
			if (User::getNeedRefreshBasket() == "1")
			{
				User::setNeedRefreshBasket("0");
				$this->refresh_cart($jcart);
			}
			
			$curr = "руб.";
			if (User::getPriceInEuro() == "1") $curr = "у.е.";
			$str_price = number_format(($this->total), 0, '.', ' ');
			$div = $this->itemcount % 100;
			$str_note = "";
			if ($div >= 10  &&  $div <= 20)
			{
				$str_note = "товаров";
			}
			else
			{
				$div = $div % 10;
				if ($div == 1) $str_note = "товар";
				else
				{
					if ($div <= 4 && $div > 0) $str_note = "товара";
					else $str_note = "товаров";
				}
			}
			
			echo "<div class='num'>";
			echo "	<table>";
			echo "		<tr>";
			echo "			<td class='wh'>".$this->itemcount."</td>";
			echo "			<td class='tx'>".$str_note."</td>";
			echo "		</tr>";
			echo "	</table>";
			echo "</div>";
			echo "<div class='rub'>";
			echo "	<table>";
			echo "		<tr>";
			echo "			<td class='wh'>".$str_price."</td>";
			echo "			<td class='tx'>".$curr."</td>";
			echo "		</tr>";
			echo "	</table>";
			echo "</div>";
		}
		
	// PROCESS AND DISPLAY CART
	function display_cart($jcart)
		{
			// JCART ARRAY HOLDS USER CONFIG SETTINGS
			extract($jcart);

			// ASSIGN USER CONFIG VALUES AS POST VAR LITERAL INDICES
			// INDICES ARE THE HTML NAME ATTRIBUTES FROM THE USERS ADD-TO-CART FORM
			$item_id = $_POST[$item_id];
			$item_qty = $_POST[$item_qty];
			$item_price = $_POST[$item_price];
			$item_name = $_POST[$item_name];

			//opt3
			//$old_itemcount = $this->itemcount;
			//opt3

			// ADD AN ITEM
			if ($_POST[$item_add])
				{
				$item_added = $this->add_item($item_id, $item_qty, $item_price, $item_name);
				//echo $item_name;
				// IF NOT TRUE THE ADD ITEM FUNCTION RETURNS THE ERROR TYPE
				if ($item_added !== true)
					{
					$error_type = $item_added;
					switch($error_type)
						{
						case 'qty':
							$error_message = $text['quantity_error'];
							break;
						case 'price':
							$error_message = $text['price_error'];
							break;
						}
					}
				}

			// UPDATE A SINGLE ITEM
			// CHECKING POST VALUE AGAINST $text ARRAY FAILS?? HAVE TO CHECK AGAINST $jcart ARRAY
			if ($_POST['jcart_update_item'] == $jcart['text']['update_button'])
				{
				$item_updated = $this->update_item($_POST['item_id'], $_POST['item_qty']);
				if ($item_updated !== true)
					{
					$error_message = $text['quantity_error'];
					}
				}

			// UPDATE ALL ITEMS IN THE CART
			if($_POST['jcart_update_cart'] || $_POST['jcart_checkout'])
				{
				$cart_updated = $this->update_cart();
				if ($cart_updated !== true)
					{
					$error_message = $text['quantity_error'];
					}
				}

			// REMOVE AN ITEM
			if($_GET['jcart_remove']/*$_POST['jcart_remove']*/ && !$_POST[$item_add] && !$_POST['jcart_update_cart'] && !$_POST['jcart_check_out'])
			{
				$this->del_item($_GET['jcart_remove']);
				//echo $_GET['jcart_remove'];
			}
				
			// EMPTY THE CART
			if($_POST['jcart_empty'])
				{
				$this->empty_cart();
				}

			// DETERMINE WHICH TEXT TO USE FOR THE NUMBER OF ITEMS IN THE CART
			if ($this->itemcount >= 0)
				{
				$text['items_in_cart'] = $text['multiple_items'];
				}
			if ($this->itemcount == 1)
				{
				$text['items_in_cart'] = $text['single_item'];
				}

			// DEFAULT INPUT TYPE
			// CAN BE OVERRIDDEN IF USER SETS PATHS FOR BUTTON IMAGES
			$input_type = 'submit';

			// IF THIS ERROR IS TRUE THE VISITOR UPDATED THE CART FROM THE CHECKOUT PAGE USING AN INVALID PRICE FORMAT
			// PASSED AS A SESSION VAR SINCE THE CHECKOUT PAGE USES A HEADER REDIRECT
			// IF PASSED VIA GET THE QUERY STRING STAYS SET EVEN AFTER SUBSEQUENT POST REQUESTS
			if ($_SESSION['quantity_error'] == true)
				{
				$error_message = $text['quantity_error'];
				unset($_SESSION['quantity_error']);
				}

			// OUTPUT THE CART

			// IF THERE'S AN ERROR MESSAGE WRAP IT IN SOME HTML
			if ($error_message)
			{
				$error_message = "<p class='jcart-error'>$error_message</p>";
			}
			
			//opt3
			/*if ($this->itemcount >= 3 && $old_itemcount < 3 || $this->itemcount < 3 && $old_itemcount >= 3)
			{
				if (!(isset($_SESSION['user_wholesaler']) && $_SESSION['user_wholesaler'] != "0"))
				{
					$this->refresh_cart2($jcart);
				}
			}*/
			//opt3
			
			$curr = "руб.";
			if (User::getPriceInEuro() == "1") $curr = "у.е.";

			if($this->itemcount > 0)
			{
				echo "	<div class='cart_list'>";
				echo "		<div class='headtitle'>";
				echo "			<div class='lf'>";
				echo "				<div class='cl cl_1'>№</div>";
				echo "			</div>";
				echo "			<div class='rg'>";
				echo "				<div class='cl cl_2'>Описание</div>";
				echo "				<div class='cl cl_3'>Цена</div>";
				echo "				<div class='cl cl_4'>Кол-во</div>";
				echo "				<div class='cl cl_5'>Сумма</div>";
				echo "				<div class='cl cl_6'>Действие</div>";
				echo "			</div>";
				echo "		</div>";
				echo "		<div class='container cart_list_inn_1'>";
				
				$index = 0;
				foreach($this->get_contents() as $item_)
				{
					$index = $index + 1;
					
					list($productID, $attribID) = explode("_", $item_['id']);
					list($productName, $productArticul, $productLatCategoryName, $productSeasonName, $brand, $image_path, $colors, $sizes) = explode("$", $item_['name']);
					$sizes = iconv("utf-8", "windows-1251", $sizes);
					$brand = iconv("utf-8", "windows-1251", $brand);
					$colors = iconv("utf-8", "windows-1251", $colors);
					$productArticul = iconv("utf-8", "windows-1251", $productArticul);
					$productName = iconv("utf-8", "windows-1251", $productName);
					$productSeasonName = iconv("utf-8", "windows-1251", $productSeasonName);
					$productLatCategoryName = iconv("utf-8", "windows-1251", $productLatCategoryName);
					
					echo  "		<div class='item'>";
					echo  "			<div class='headtitle_inn'>№</div>";
					echo  "			<div class='lf'>";
					echo  "				<div class='num'>".$index."</div>";
					if ($image_path != "")
						echo  "			<a href='/catalog/".$productLatCategoryName."/".$productID."' class='im' style='background-image: url(http://mon-paris.ru/goods_images/".$image_path.");'></a>";
					echo  "			</div>";
					echo  "			<div class='rg'>";
					echo  "				<div class='cl cl_2'>";
					echo  "					<div class='line title'><h6><a style = 'color: #8597DC' href='/catalog/".$productLatCategoryName."/".$productID."'>".$productName."</a></h6></div>";
					echo  "					<div class='line'>Артикул:&nbsp; <strong>".$productArticul."</strong></div>";
					echo  "					<div class='line'>Бренд:&nbsp; <strong>".$brand."</strong></div>";
					echo  "					<div class='line'>Коллекция:&nbsp; <strong>".$productSeasonName."</strong></div>";
					echo  "					<div class='line'>Размер:&nbsp; <strong>".$sizes."</strong></div>";
					echo  "					<div class='line'>Цвет:&nbsp; <strong>".$colors."</strong></div>";
					echo  "				</div>";
					echo  "				<div class='cl cl_3'>";
					echo  "					<div class='line'>";
					//echo  "					<div class="price_old">7 500 руб.</div>";
					echo  "						<div class='price'>".number_format(($item_['price']), 0, '.', ' ')." ".$curr."</div>";
					//echo  "					<div class="disc">Скидка - 9%</div>";
					echo  "					</div>";
					echo  "				</div>";
					echo  "				<div class='cl cl_4'>";
					echo  "					<div class='count_out'>";
					echo  "						<button class='minus' type='button' value='0' name = 'minus'></button>";
					echo  "						<input name='a' type='text' id='jcart". $item_['id'] ."' value='".$item_['qty']."' maxlength='3'>";
					echo  "						<button class='plus' type='button' value='1' name = 'plus'></button>";
					echo  "					</div>";
					echo  "				</div>";
					echo  "				<div class='cl cl_5'>";
					echo  "					<div class='line'>";
					echo  "						<div class='price'>".number_format(($item_['subtotal']), 0, '.', ' ')." ".$curr."</div>";
					echo  "					</div>";
					echo  "				</div>";
					echo  "				<div class='cl cl_6'>";
					echo  "					<a class='del' href='?jcart_remove=!" . $item_['id'] . "' name='delete_btn'><span>Удалить</span></a>";
					echo  "				</div>";
					echo  "			</div>";
					echo  "		</div>";
					
					/*echo  "	<tr>";
					echo  "	<td  >";
					echo  " 	<div class='basket_info3' align='center'>".$index."</div></td>";
					echo  "	<td  >";
					echo  " <table cellpadding=0 cellspacing=4 border='0' width=100%><tr><td style='border-style:none;'>";
					if ($image_path != "")
						echo  "<a href='/goods/".$productID."'><img border='0' width=90px src='/image_product.php?nm=".$image_path."&type=2'/></a>";
					echo  "</td>";
					echo  " <td width=100% style='border-style:none;'><div class='basket_info3' style='margin-left:20px;'>";
					echo  "<a href='/goods/".$productID."'><span class='bold'>".iconv("utf-8", "windows-1251", $productName).",&nbsp;".$brand."</span></a>";
					echo "<br>Артикул: ".iconv("utf-8", "windows-1251", $productArticul);
					if ($colors != "")
						echo "<br>Цвет: ".iconv("utf-8", "windows-1251", $colors);
					if ($sizes != "")
						echo "<br>Размер: ".$sizes;
					echo  "		<input type='hidden' name='jcart_item_name[ ]' value='" . $item_['name'] . "' />";
					echo  "		<input type='hidden' name='jcart_item_id[ ]' value='" . $item_['id'] . "' />";
					echo  " </div></td></tr></table>";
					echo  "	</td>";
					echo  "	<td align='center' ><div class='basket_info3'>";
					echo  "		<input style='text-align:right' class='basket_info' type='text' size='3' maxlength='3' id='jcart-item-id-" . $item_['id'] . "' name='jcart_item_qty[ ]' value='" . $item_['qty'] . "' />";
					echo  "	</div></td>";
					echo  "	<td align='right'><div class='basket_info3'>".number_format(($item_['price']), 0, '.', ' ')."</div></td>";
					echo  "	<td align='right' ><div class='basket_info3'>".number_format(($item_['subtotal']), 0, '.', ' ');
					echo  " 	<input type='hidden' name='jcart_item_price[ ]' value='" . $item_['price'] . "' /></div></td>";

					echo  "	<td align='center'><div class='basket_info3'>";
					echo  "		<a class='jcart-remove ' href='?jcart_remove=" . $item_['id'] . "' style='color:#0000ff;'>удалить</a>";
					echo  "	</div></td>";
					echo  "</tr>";*/
				}
				echo  "		</div></div>";
				echo  "		<div class='cart_list_itog'>";
				echo  "			Итого: ".number_format($this->total, 0, '.', ' ')." ".$curr;
				echo  "		</div>";
				
echo <<< _END
				<div class="cart_list_order">
					<a class="hd_tp_butt" href="/make_order.php"><span>ОФОРМИТЬ ЗАКАЗ</span></a>
				</div>
_END;

			}
			else
			{
				echo  "		<span style='text-align: center;color:#797979;'><h3>Ваша корзина пуста</h3></span>";
			}
			if ($_POST['jcart_update_item'])
			{
				echo "\t" . '<script type="text/javascript">$(function(){$("#jcart' . $_POST['item_id'] . '").focus()});</script>' . "\n";
			}
		}
		
	
	function refresh_cart($jcart)
	{
		// JCART ARRAY HOLDS USER CONFIG SETTINGS
		extract($jcart);
		
		if($this->itemcount > 0)
		{
			$index = 0;
			foreach($this->get_contents() as $item_)
			{
				$index = $index + 1;
				
				//$productID = substr($item_['id'], 0, 11);
				list($productID, $attribID) = explode("_", $item_['id']);

				// желательно обновлять цену товара в зависимости от скидок
				$query_cost = "";
				//$price_discount_str = "(Price * (100.0 - 33.33) / 100.0) * (100.0 - IF(MP_PRODUCT.DiscountProductValue = 0, MP_BRAND_SEASON.DiscountWholesaleValue, MP_PRODUCT.DiscountProductValue)) / 100.0";
				if (User::getUserWhosaler() == "1")
					$price_discount_str = "Price * (100.0 - IF(MP_PRODUCT.DiscountProductValue = 0, MP_BRAND_SEASON.DiscountWholesaleValue, MP_PRODUCT.DiscountProductValue)) / 100.0";
				else
					$price_discount_str = "Price * (100.0 - IF(MP_PRODUCT.DiscountProductValue = 0, MP_BRAND_SEASON.DiscountValue, MP_PRODUCT.DiscountProductValue)) / 100.0";
				

				if (!User::isAuthorized())
				{
					$query_cost = "SELECT IF(PriceOnlyForRegistered = 0, ".$price_discount_str.", 0) AS Price ";
				}
				else
				{
					if (User::getNeedBlockPrice() == "1")
					{
						$query_cost = "SELECT 0 AS Price ";
					}
					else
					{
						if (User::getPriceInEuro() == "1")
						{
							$query_cost = "SELECT PriceInEuro AS Price ";
						}
						else
						{
							$query_cost = "SELECT ".$price_discount_str." AS Price ";
						}
					}
				}

				$query_cost = $query_cost." FROM MP_PRODUCT INNER JOIN MP_BRAND_SEASON ON MP_BRAND_SEASON.GroupID = MP_PRODUCT.GroupID";
				$query_cost = $query_cost." INNER JOIN MP_BRAND ON MP_BRAND.BrandID = MP_BRAND_SEASON.BrandID";
				$query_cost = $query_cost." WHERE MP_PRODUCT.ProductIDStr = '".$productID."'";


				$result_cost = mysql_query($query_cost);
				$rowCount = mysql_num_rows($result_cost);
			
				if ($rowCount == 1)
				{
					$row = mysql_fetch_array($result_cost);
					
					if (number_format($row["Price"], 0, '.', '') != $item_['price'])
					{	
						$item_['price'] = number_format($row["Price"], 0, '.', '');
						$item_['subtotal'] = $item_['price'] * $item_['qty'];
						$this->itemprices[$item_['id']] = $item_['price'];
						$this->_update_total();
					}
					
					mysql_free_result($result_cost);
				}
				else
				{
					mysql_free_result($result_cost);
				}
			}
		}
	}
	
	/*function send_card($jcart, $user_fio1, $user_fio2, $user_fio3, $user_email, $user_tel, $user_size_og, $user_size_ob, $user_size_ot, $user_region, $user_address, $user_comment, $delivery_type, &$send_result)
		{

		// иногда возникают дубликаты заказов, в первом что то не так с кодировкой, поэтому отсекаем его так
		if (iconv("utf-8", "windows-1251", $user_fio1) == "")
		{
			return;
		}

		extract($jcart);

		$user_fio = iconv("utf-8", "windows-1251", $user_fio1)." ".iconv("utf-8", "windows-1251", $user_fio2)." ".iconv("utf-8", "windows-1251", $user_fio3);
		$user_email = $sizes = iconv("utf-8", "windows-1251", $user_email);
		$user_tel = $sizes = iconv("utf-8", "windows-1251", $user_tel);
		
		$user_size_og = iconv("utf-8", "windows-1251", $user_size_og);
		$user_size_ob = iconv("utf-8", "windows-1251", $user_size_ob);
		$user_size_ot = iconv("utf-8", "windows-1251", $user_size_ot);

		$user_region = iconv("utf-8", "windows-1251", $user_region);
		$user_city = iconv("utf-8", "windows-1251", $user_address);
		$user_comment = iconv("utf-8", "windows-1251", $user_comment);

		if($this->itemcount > 0)
		{
			$my_server = 'u189200.mysql.masterhost.ru';
			$my_user   = 'u189200';
			$my_pwd    = '9hoomo2makerv';
			$my_name  = 'u189200';
    
			@mysql_connect($my_server, $my_user, $my_pwd) or die("Could not connect to MySQL server!"); 
			@mysql_select_db($my_name) or die("Could not select products database!"); 
			mysql_query("SET NAMES \"cp1251\"");
			
			if (User::isAuthorized())
			{
				$str_query = "insert into MP_ORDER (CustomerName, Email, Phone, City, Note, Region, Size, SumOrder, DeliveryType, UserID) values 
					('".$user_fio."','".$user_email."','".$user_tel."','".$user_city."','".$user_comment."','".$user_region."', 'ОГ - ".$user_size_og." см, ОБ - ".$user_size_ob." см, ОТ - ".$user_size_ot." см', 0.0, ".$delivery_type.", ".User::getUserID().")";
			}
			else
			{
				$str_query = "insert into MP_ORDER (CustomerName, Email, Phone, City, Note, Region, Size, SumOrder, DeliveryType, UserID) values 
					('".$user_fio."','".$user_email."','".$user_tel."','".$user_city."','".$user_comment."','".$user_region."', 'ОГ - ".$user_size_og." см, ОБ - ".$user_size_ob." см, ОТ - ".$user_size_ot." см', 0.0, ".$delivery_type.", -1)";
			}

			$rollback = false;
			$all_price = 0.0;
			if (!mysql_query($str_query))
			{
				//mysql_query("rollback");
				$rollback = true;
			}
			else
			{
				$id = mysql_insert_id();

				$mail_str_query = "<html><head></head><body><b>Заказчик : </b> ".$user_fio."<br>";
				$mail_str_query = $mail_str_query."<b>Желаемый размер : </b> ОГ - ".$user_size_og." см, ОБ - ".$user_size_ob." см, ОТ - ".$user_size_ot." см<br>";
				$mail_str_query = $mail_str_query."<b>e-mail : </b> ".$user_email."<br>";
				$mail_str_query = $mail_str_query."<b>Контактный телефон : </b> ".$user_tel."<br>";
				$mail_str_query = $mail_str_query."<b>Регион : </b> ".$user_region."<br>";
				if ($delivery_type == 1)
					$mail_str_query = $mail_str_query."<b>Способ доставки : </b> доставка по Москве (400 руб.)<br>";
				if ($delivery_type == 2)
					$mail_str_query = $mail_str_query."<b>Способ доставки : </b> доставка по России (стоимость в РЕГИОНЫ должна быть согласована с менеджерами)<br>";
				if ($delivery_type == 3)
					$mail_str_query = $mail_str_query."<b>Способ доставки : </b> самовывоз<br>";
					
				$mail_str_query = $mail_str_query."<b>Адрес доставки : </b> ".$user_city."<br>";
				$mail_str_query = $mail_str_query."<b>Примечание : </b> ".$user_comment."<br><br>";
				$mail_str_query = $mail_str_query."<table border = 1><tr><td>Наименование товара</td><td>Бренд</td><td>Коллекция</td><td>Цвет</td><td>Размер</td><td>Количество</td><td>Цена за единицу</td><td>Стоимость</td></tr>";

				$mail_str_query2 = "<html><head></head><body>Здравствуйте, ".$user_fio."<br>";
				$mail_str_query2 = $mail_str_query2."Вы сделали заказ в интернет-магазине mon-paris.ru<br><br>";
				$mail_str_query2 = $mail_str_query2."Номер заказа: <b>".$id."</b><br>";
				$mail_str_query2 = $mail_str_query2."<b>Желаемый размер : </b> ОГ - ".$user_size_og." см, ОБ - ".$user_size_ob." см, ОТ - ".$user_size_ot." см<br>";
				$mail_str_query2 = $mail_str_query2."<b>Контактный телефон : </b> ".$user_tel."<br>";
				if ($delivery_type == 1)
					$mail_str_query2 = $mail_str_query2."<b>Способ доставки : </b> доставка по Москве (400 руб.)<br>";
				if ($delivery_type == 2)
					$mail_str_query2 = $mail_str_query2."<b>Способ доставки : </b> доставка по России (стоимость в РЕГИОНЫ должна быть согласована с менеджерами)<br>";
				if ($delivery_type == 3)
					$mail_str_query2 = $mail_str_query2."<b>Способ доставки : </b> самовывоз<br>";
				$mail_str_query2 = $mail_str_query2."<b>Адрес доставки : </b> ".$user_city."<br><br><br>";
				$mail_str_query2 = $mail_str_query2."<b>Данные по заказу</b><br><br>";
				$mail_str_query2 = $mail_str_query2."<table border = 1><tr><td>Наименование товара</td><td>Бренд</td><td>Коллекция</td><td>Цвет</td><td>Размер</td><td>Количество</td><td>Цена за единицу</td><td>Стоимость</td></tr>";

				$curr = "руб.";
				if (User::getPriceInEuro() == "1") $curr = "у.е.";

				if ($id != 0)
				{
					foreach($this->get_contents() as $item)
					{
						list($productID, $attribID) = explode("_", $item['id']);
						list($productName, $productArticul, $productSeasonName, $brand, $image_path, $colors, $sizes) = explode("$", $item['name']);
						$sizes = iconv("utf-8", "windows-1251", $sizes);
						$productName = iconv("utf-8", "windows-1251", $productName);
						$productArticul = iconv("utf-8", "windows-1251", $productArticul);
						$productSeasonNameForClient = iconv("utf-8", "windows-1251", $productSeasonName);
						// здесь надо выбирать сезон, который указан в базе
						$query_product_info = "SELECT SeasonName FROM MP_PRODUCT";
						$query_product_info = $query_product_info." INNER JOIN MP_BRAND_SEASON ON MP_BRAND_SEASON.GroupID = MP_PRODUCT.GroupID";
						$query_product_info = $query_product_info." INNER JOIN MP_SEASON ON MP_SEASON.SeasonID = MP_BRAND_SEASON.SeasonID";
						$query_product_info = $query_product_info." WHERE MP_PRODUCT.ProductID = ".$productID;
						$result_product_info = mysql_query($query_product_info);
						$rowCount = mysql_num_rows($result_product_info);
						if ($rowCount == 1)
						{
							$row = mysql_fetch_array($result_product_info);
							$productSeasonNameForSupplier = $row["SeasonName"];
							mysql_free_result($result_product_info);
						}
						else
						{
							mysql_free_result($result_product_info);
						}
						$colors = iconv("utf-8", "windows-1251", $colors);
						$brand = iconv("utf-8", "windows-1251", $brand);

						$str_query = "insert into MP_ORDER_PRODUCT (OrderID, ProductID, Cost, Count, Color, Size, NameForPrint) values 
						(".$id.",".$productID.",".$item['price'].",".$item['qty'].",'".$colors."','".$sizes."', '".$productName." (".$productArticul.")')";
						
						$mail_str_query = $mail_str_query."<tr><td>".$productName." (".$productArticul.")</td><td>".$brand."</td><td>".$productSeasonNameForSupplier."</td><td>".$colors."</td><td>".$sizes."</td><td>".$item['qty']."</td><td>".$item['price']." ".$curr."</td><td>".$item['qty'] * $item['price']." ".$curr."</td></tr>";
						$mail_str_query2 = $mail_str_query2."<tr><td>".$productName." (".$productArticul.")</td><td>".$brand."</td><td>".$productSeasonNameForClient."</td><td>".$colors."</td><td>".$sizes."</td><td>".$item['qty']."</td><td>".$item['price']." ".$curr."</td><td>".$item['qty'] * $item['price']." ".$curr."</td></tr>";
						
						if (!mysql_query($str_query))
						{
							$rollback = true;
						}
					}
					
					if ($rollback == false)
					{
						$str_query = "update MP_ORDER SET SumOrder = (SELECT SUM(Cost * Count) FROM MP_ORDER_PRODUCT 
							WHERE MP_ORDER_PRODUCT.OrderID = MP_ORDER.OrderID) WHERE OrderID = ".$id;
						if (!mysql_query($str_query))
						{
							$rollback = true;
						}
					}
				}
				else
				{
					$rollback = true;
				}
				$mail_str_query = $mail_str_query."</table>";
				$mail_str_query2 = $mail_str_query2."</table>";
				
				if ($delivery_type == 1)
				{
					if (User::getPriceInEuro() == "1")
					{
						$mail_str_query = $mail_str_query."<br><b>Общая стоимость заказа : </b> ".number_format($this->total, 0, '.', '')." ".$curr." + доставка по Москве 400 руб.<br></body></html>";
						$mail_str_query2 = $mail_str_query2."<br><b>Общая стоимость заказа : </b> ".number_format($this->total, 0, '.', '')." ".$curr." + доставка по Москве 400 руб.<br></body></html>";
					}
					else
					{
						$mail_str_query = $mail_str_query."<br><b>Общая стоимость заказа : </b> ".number_format($this->total, 0, '.', '')." ".$curr." + доставка по Москве 400 руб. = ".number_format($this->total + 400, 0, '.', '')." ".$curr."<br></body></html>";
						$mail_str_query2 = $mail_str_query2."<br><b>Общая стоимость заказа : </b> ".number_format($this->total, 0, '.', '')." ".$curr." + доставка по Москве 400 руб. = ".number_format($this->total + 400, 0, '.', '')." ".$curr."<br></body></html>";
					}
				}
				else
				{
					if ($delivery_type == 2)
					{
						$mail_str_query = $mail_str_query."<br><b>Общая стоимость заказа : </b> ".number_format($this->total, 0, '.', '')." ".$curr." + доставка (согласовать)<br></body></html>";
						$mail_str_query2 = $mail_str_query2."<br><b>Общая стоимость заказа : </b> ".number_format($this->total, 0, '.', '')." ".$curr." + доставка (согласовать)<br></body></html>";
					}
					else
					{
						$mail_str_query = $mail_str_query."<br><b>Общая стоимость заказа : </b> ".number_format($this->total, 0, '.', '')." ".$curr."<br></body></html>";
						$mail_str_query2 = $mail_str_query2."<br><b>Общая стоимость заказа : </b> ".number_format($this->total, 0, '.', '')." ".$curr."<br></body></html>";
					}
				}
									
				
				if ($rollback == false)
				{
					//$this->empty_cart(); будем очищать корзину при отображении успешной страницы
					$this->order_number = $id;
					$this->order_delivery_type = $delivery_type;
					
					$headers = 'MIME-Version: 1.0' . "\r\n";
					$headers .= 'Content-type: text/html; charset=windows-1251' . "\r\n";
					$headers .= 'From: <mon-paris.ru>' . "\r\n";
					$headers .= 'Bcc: <mon-paris.ru>' . "\r\n";

					$headers2 = 'MIME-Version: 1.0' . "\r\n";
					$headers2 .= 'Content-type: text/html; charset=windows-1251' . "\r\n";
					$headers2 .= 'From: <mon-paris.ru>' . "\r\n";
					$headers2 .= 'Bcc: <'.$user_email.'>' . "\r\n";

					ini_set('display_errors', 'Off');
					$v = mail('modaopt@gmail.com', 'Новый заказ № '.$id, $mail_str_query, $headers );
					//$v = mail('adoon@inbox.ru', 'Новый заказ № '.$id, $mail_str_query, $headers );
					ini_set('display_errors', 'on');

					$send_result = "$id";
				
					$mail_str_query2 = $mail_str_query2."<br><br><b>Наши контактные данные:</b><br><br>";
					$mail_str_query2 = $mail_str_query2."117997, Москва, ул. Вавилова, 69/75, офис 809.<br>";
					$mail_str_query2 = $mail_str_query2."тел/факс:  <b>8 (495) 518-91-65</b><br>";
					$mail_str_query2 = $mail_str_query2."e-mail:  <b>modaopt@gmail.com</b><br>";
					
					ini_set('display_errors', 'Off');
					$v2 = mail($user_email, "Ваш заказ в интернет-магазине mon-paris.ru", $mail_str_query2, $headers2 );
					ini_set('display_errors', 'on');

					if ($v != true)
						$send_result = $send_result."<p><font class='errortext'>Произошла ошибка при отправлении письма с уведомлением.</font></p>";
				}
				else
				{
					$str_query = "DELETE FROM MP_ORDER WHERE OrderID = ".$id;
					mysql_query($str_query);
					$str_query = "DELETE FROM MP_ORDER_PRODUCT WHERE OrderID = ".$id;
					mysql_query($str_query);
				}
			}
			
			mysql_close();
		}
		}*/
		
	function send_card($jcart, &$send_result)
		{
		extract($jcart);

		$user_fio = $_POST['user_fio1']." ".$_POST['user_fio2']." ".$_POST['user_fio3'];
		$user_email = $_POST['user_email'];
		$user_tel = $_POST['user_tel1'];
		
		$user_size_og = $_POST['user_size_og'];
		$user_size_ob = $_POST['user_size_ob'];
		$user_size_ot = $_POST['user_size_ot'];

		$user_region = $_POST['user_region'];
		$user_city = $_POST['user_city'];
		$user_comment = $_POST['user_comment'];
		
		//$user_fio = mysql_escape_string($user_fio);
		//$user_email = mysql_escape_string($user_email);
		//$user_tel = mysql_escape_string($user_tel);
		//$user_size_og = mysql_escape_string($user_size_og);
		//$user_size_ob = mysql_escape_string($user_size_ob);
		//$user_size_ot = mysql_escape_string($user_size_ot);
		//$user_region = mysql_escape_string($user_region);
		//$user_city = mysql_escape_string($user_city);
		//$user_comment = mysql_escape_string($user_comment);

		
		$delivery_type = $_POST['user_delivery'];
		
		if($this->itemcount > 0)
		{
			if (User::isAuthorized())
			{
				$str_query = "insert into MP_ORDER (CustomerName, Email, Phone, City, Note, Region, Size, SumOrder, DeliveryType, UserID) values 
					('".$user_fio."','".$user_email."','".$user_tel."','".$user_city."','".$user_comment."','".$user_region."', 'ОГ - ".$user_size_og." см, ОБ - ".$user_size_ob." см, ОТ - ".$user_size_ot." см', 0.0, ".$delivery_type.", ".User::getUserID().")";
			}
			else
			{
				$str_query = "insert into MP_ORDER (CustomerName, Email, Phone, City, Note, Region, Size, SumOrder, DeliveryType, UserID) values 
					('".$user_fio."','".$user_email."','".$user_tel."','".$user_city."','".$user_comment."','".$user_region."', 'ОГ - ".$user_size_og." см, ОБ - ".$user_size_ob." см, ОТ - ".$user_size_ot." см', 0.0, ".$delivery_type.", -1)";
			}

			$rollback = false;
			$all_price = 0.0;
			if (!mysql_query($str_query))
			{
				//mysql_query("rollback");
				$rollback = true;
				$send_result = mysql_error()." ".$str_query;//"error #1";
			}
			else
			{
				$id = mysql_insert_id();

				$mail_str_query = "<html><head></head><body><b>Заказчик : </b> ".$user_fio."<br>";
				$mail_str_query = $mail_str_query."<b>Желаемый размер : </b> ОГ - ".$user_size_og." см, ОБ - ".$user_size_ob." см, ОТ - ".$user_size_ot." см<br>";
				$mail_str_query = $mail_str_query."<b>e-mail : </b> ".$user_email."<br>";
				$mail_str_query = $mail_str_query."<b>Контактный телефон : </b> ".$user_tel."<br>";
				$mail_str_query = $mail_str_query."<b>Регион : </b> ".$user_region."<br>";
				if ($delivery_type == 1)
					$mail_str_query = $mail_str_query."<b>Способ доставки : </b> доставка по Москве (400 руб.)<br>";
				if ($delivery_type == 2)
					$mail_str_query = $mail_str_query."<b>Способ доставки : </b> доставка по России (стоимость в РЕГИОНЫ должна быть согласована с менеджерами)<br>";
				if ($delivery_type == 3)
					$mail_str_query = $mail_str_query."<b>Способ доставки : </b> самовывоз<br>";
				if ($delivery_type == 4)
					$mail_str_query = $mail_str_query."<b>Способ доставки : </b> международная доставка (стоимость доставки должна быть согласована с менеджерами)<br>";
					
				$mail_str_query = $mail_str_query."<b>Адрес доставки : </b> ".$user_city."<br>";
				$mail_str_query = $mail_str_query."<b>Примечание : </b> ".$user_comment."<br><br>";
				$mail_str_query = $mail_str_query."<table border = 1><tr><td>Наименование товара</td><td>Бренд</td><td>Коллекция</td><td>Цвет</td><td>Размер</td><td>Количество</td><td>Цена за единицу</td><td>Стоимость</td></tr>";

				$mail_str_query2 = "<html><head></head><body>Здравствуйте, ".$user_fio."<br>";
				$mail_str_query2 = $mail_str_query2."Вы сделали заказ в интернет-магазине mon-paris.ru<br><br>";
				$mail_str_query2 = $mail_str_query2."Номер заказа: <b>".$id."</b><br>";
				$mail_str_query2 = $mail_str_query2."<b>Желаемый размер : </b> ОГ - ".$user_size_og." см, ОБ - ".$user_size_ob." см, ОТ - ".$user_size_ot." см<br>";
				$mail_str_query2 = $mail_str_query2."<b>Контактный телефон : </b> ".$user_tel."<br>";
				if ($delivery_type == 1)
					$mail_str_query2 = $mail_str_query2."<b>Способ доставки : </b> доставка по Москве (400 руб.)<br>";
				if ($delivery_type == 2)
					$mail_str_query2 = $mail_str_query2."<b>Способ доставки : </b> доставка по России (стоимость в РЕГИОНЫ должна быть согласована с менеджерами)<br>";
				if ($delivery_type == 3)
					$mail_str_query2 = $mail_str_query2."<b>Способ доставки : </b> самовывоз<br>";
				if ($delivery_type == 4)
					$mail_str_query2 = $mail_str_query2."<b>Способ доставки : </b> международная доставка (стоимость доставки должна быть согласована с менеджерами)<br>";
				$mail_str_query2 = $mail_str_query2."<b>Адрес доставки : </b> ".$user_city."<br><br><br>";
				$mail_str_query2 = $mail_str_query2."<b>Данные по заказу</b><br><br>";
				$mail_str_query2 = $mail_str_query2."<table border = 1><tr><td>Наименование товара</td><td>Бренд</td><td>Коллекция</td><td>Цвет</td><td>Размер</td><td>Количество</td><td>Цена за единицу</td><td>Стоимость</td></tr>";

				$curr = "руб.";
				if (User::getPriceInEuro() == "1") $curr = "у.е.";

				if ($id != 0)
				{
					foreach($this->get_contents() as $item)
					{
						list($productID, $attribID) = explode("_", $item['id']);
						list($productName, $productArticul, $productLatCategoryName, $productSeasonName, $brand, $image_path, $colors, $sizes) = explode("$", $item['name']);
						$sizes = iconv("utf-8", "windows-1251", $sizes);
						$productName = iconv("utf-8", "windows-1251", $productName);
						$productArticul = iconv("utf-8", "windows-1251", $productArticul);
						$productSeasonNameForClient = iconv("utf-8", "windows-1251", $productSeasonName);
						// здесь надо выбирать сезон, который указан в базе
						$query_product_info = "SELECT ProductID, SeasonName FROM MP_PRODUCT";
						$query_product_info = $query_product_info." INNER JOIN MP_BRAND_SEASON ON MP_BRAND_SEASON.GroupID = MP_PRODUCT.GroupID";
						$query_product_info = $query_product_info." INNER JOIN MP_SEASON ON MP_SEASON.SeasonID = MP_BRAND_SEASON.SeasonID";
						$query_product_info = $query_product_info." WHERE MP_PRODUCT.ProductIDStr = '".$productID."'";
						$result_product_info = mysql_query($query_product_info);
						$rowCount = mysql_num_rows($result_product_info);
						if ($rowCount == 1)
						{
							$row = mysql_fetch_array($result_product_info);
							$productSeasonNameForSupplier = $row["SeasonName"];
							$pID = $row["ProductID"];
							mysql_free_result($result_product_info);
						}
						else
						{
							mysql_free_result($result_product_info);
						}
						$colors = iconv("utf-8", "windows-1251", $colors);
						$brand = iconv("utf-8", "windows-1251", $brand);

						$str_query = "insert into MP_ORDER_PRODUCT (OrderID, ProductID, Cost, Count, Color, Size, NameForPrint) values 
						(".$id.",".$pID.",".$item['price'].",".$item['qty'].",'".$colors."','".$sizes."', '".$productName." (".$productArticul.")')";
						
						$mail_str_query = $mail_str_query."<tr><td>".$productName." (".$productArticul.")</td><td>".$brand."</td><td>".$productSeasonNameForSupplier."</td><td>".$colors."</td><td>".$sizes."</td><td>".$item['qty']."</td><td>".$item['price']." ".$curr."</td><td>".$item['qty'] * $item['price']." ".$curr."</td></tr>";
						$mail_str_query2 = $mail_str_query2."<tr><td>".$productName." (".$productArticul.")</td><td>".$brand."</td><td>".$productSeasonNameForClient."</td><td>".$colors."</td><td>".$sizes."</td><td>".$item['qty']."</td><td>".$item['price']." ".$curr."</td><td>".$item['qty'] * $item['price']." ".$curr."</td></tr>";
						
						if (!mysql_query($str_query))
						{
							$rollback = true;
						}
					}
					
					if ($rollback == false)
					{
						$str_query = "update MP_ORDER SET SumOrder = (SELECT SUM(Cost * Count) FROM MP_ORDER_PRODUCT 
							WHERE MP_ORDER_PRODUCT.OrderID = MP_ORDER.OrderID) WHERE OrderID = ".$id;
						if (!mysql_query($str_query))
						{
							$rollback = true;
						}
					}
				}
				else
				{
					$rollback = true;
				}
				$mail_str_query = $mail_str_query."</table>";
				$mail_str_query2 = $mail_str_query2."</table>";
				
				if ($delivery_type == 1)
				{
					if (User::getPriceInEuro() == "1")
					{
						$mail_str_query = $mail_str_query."<br><b>Общая стоимость заказа : </b> ".number_format($this->total, 0, '.', '')." ".$curr." + доставка по Москве 400 руб.<br></body></html>";
						$mail_str_query2 = $mail_str_query2."<br><b>Общая стоимость заказа : </b> ".number_format($this->total, 0, '.', '')." ".$curr." + доставка по Москве 400 руб.<br></body></html>";
					}
					else
					{
						$mail_str_query = $mail_str_query."<br><b>Общая стоимость заказа : </b> ".number_format($this->total, 0, '.', '')." ".$curr." + доставка по Москве 400 руб. = ".number_format($this->total + 400, 0, '.', '')." ".$curr."<br></body></html>";
						$mail_str_query2 = $mail_str_query2."<br><b>Общая стоимость заказа : </b> ".number_format($this->total, 0, '.', '')." ".$curr." + доставка по Москве 400 руб. = ".number_format($this->total + 400, 0, '.', '')." ".$curr."<br></body></html>";
					}
				}
				else
				{
					if ($delivery_type == 2 || $delivery_type == 4)
					{
						$mail_str_query = $mail_str_query."<br><b>Общая стоимость заказа : </b> ".number_format($this->total, 0, '.', '')." ".$curr." + доставка (согласовать)<br></body></html>";
						$mail_str_query2 = $mail_str_query2."<br><b>Общая стоимость заказа : </b> ".number_format($this->total, 0, '.', '')." ".$curr." + доставка (согласовать)<br></body></html>";
					}
					else
					{
						$mail_str_query = $mail_str_query."<br><b>Общая стоимость заказа : </b> ".number_format($this->total, 0, '.', '')." ".$curr."<br></body></html>";
						$mail_str_query2 = $mail_str_query2."<br><b>Общая стоимость заказа : </b> ".number_format($this->total, 0, '.', '')." ".$curr."<br></body></html>";
					}
				}
									
				
				if ($rollback == false)
				{
					//$this->empty_cart(); будем очищать корзину при отображении успешной страницы
					$this->order_number = $id;
					$this->order_delivery_type = $delivery_type;
					
					$headers = 'MIME-Version: 1.0' . "\r\n";
					$headers .= 'Content-type: text/html; charset=windows-1251' . "\r\n";
					$headers .= 'From: <mon-paris.ru>' . "\r\n";
					$headers .= 'Bcc: <mon-paris.ru>' . "\r\n";

					$headers2 = 'MIME-Version: 1.0' . "\r\n";
					$headers2 .= 'Content-type: text/html; charset=windows-1251' . "\r\n";
					$headers2 .= 'From: <mon-paris.ru>' . "\r\n";
					$headers2 .= 'Bcc: <'.$user_email.'>' . "\r\n";

					ini_set('display_errors', 'Off');
					$v = mail('modaopt@gmail.com', 'Новый заказ № '.$id, $mail_str_query, $headers );
					//$v = mail('adoon@inbox.ru', 'Новый заказ № '.$id, $mail_str_query, $headers );
					ini_set('display_errors', 'on');

					//$send_result = "$id";
				
					$mail_str_query2 = $mail_str_query2."<br><br><b>Наши контактные данные:</b><br><br>";
					$mail_str_query2 = $mail_str_query2."117997, Москва, ул. Вавилова, 69/75, офис 809.<br>";
					$mail_str_query2 = $mail_str_query2."тел/факс:  <b>8 (495) 518-91-65</b><br>";
					$mail_str_query2 = $mail_str_query2."e-mail:  <b>modaopt@gmail.com</b><br>";
					
					ini_set('display_errors', 'Off');
					$v2 = mail($user_email, "Ваш заказ в интернет-магазине mon-paris.ru", $mail_str_query2, $headers2 );
					ini_set('display_errors', 'on');

					//if ($v != true)
					//	$send_result = "mail send error";
				}
				else
				{
					$str_query = "DELETE FROM MP_ORDER WHERE OrderID = ".$id;
					mysql_query($str_query);
					$str_query = "DELETE FROM MP_ORDER_PRODUCT WHERE OrderID = ".$id;
					mysql_query($str_query);
					
					$send_result = "error";
				}
			}
		}
		}
	}
?>
