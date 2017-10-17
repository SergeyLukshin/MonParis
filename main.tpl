
		<div class="clearfix"></div>

	
        <div class="top_collection">


            <div class="item">
                <div class="item_out">
                 <div class="item_inn" style="background-image: url(img/_collect_1.jpg);">
					 <a href="/catalog/bolshie-razmery"> 
						<table><tr><td>Большие размеры</td></tr></table>
                        <div class="optic"></div>
                        <div class="button"><button>посмотреть</button></div>
                    </a>
                    </div>
                    <div class="bg"></div>
                </div>
            </div>

            <div class="item">
                <div class="item_out">
                     <div class="item_inn" style="background-image: url(img/_collect_2.jpg);">
						 <a href="/catalog/AGNELLE"> 
							<table><tr><td>Шарфы и перчатки</td></tr></table>
							<div class="optic"></div>
							<div class="button"><button>посмотреть</button></div>
						</a>
					</div>
                    <div class="bg"></div>
                </div>
            </div>

            <div class="item">
                <div class="item_out">
                    <div class="item_inn" style="background-image: url(img/_collect_3.jpg);"><a href="/catalog/LEO-GUY">
                        <table><tr><td>Женщинам</td></tr></table>
                        <div class="optic"></div>
                        <div class="button"><button>посмотреть</button></div>
                    </a></div>
                    <div class="bg"></div>
                </div>
            </div>

            <div class="item">
                <div class="item_out">
                    <div class="item_inn" style="background-image: url(img/_collect_4.jpg);"><a href="/catalog/devushkam">
                        <table><tr><td>Девушкам</td></tr></table>
                        <div class="optic"></div>
                        <div class="button"><button>посмотреть</button></div>
                    </a></div>
                    <div class="bg"></div>
                </div>
            </div>

        </div>
        <div class="clearfix"></div>


        <div class="top_slider">
            <div class="first_slider">
                <div class="flexslider">
                    <ul class="slides">
                        <li style="background-image: url(img/_top_slider_1.jpg);">
                            <div class="inn">
                                <div class="tx">  
                                    <img src="img/_top_slider_1_tx.png" alt=""> 
                                 </div>
                                <a class="more2" href="/catalog/ELISA-FANTI">подробнее</a>
                            </div>
                        </li>
                        <li style="background-image: url(img/_top_slider_2.jpg);">
                            <div class="inn">
                                <div class="tx">
                                    <img src="img/_top_slider_2_tx.png" alt="">
                                </div>
                                <a class="more" href="/catalog/AGNELLE">подробнее</a>
                            </div>
                        </li>
                    </ul>
                    <div class="frts_slider_nav"></div>
                </div>
            </div>
        </div>


        <div class="brend_slider">

            <div class="title_points"><span>БРЕНДЫ</span></div>

            <div class="brends_slider_inn">
<?php
				reset($vec_brand);																	
				foreach ($vec_brand as $key => $value) 
				{
					if (file_exists("brends/".$key.".jpg"))
						echo "<a href='/catalog/".$key."'><span></span><div style='background-image: url(/brends/".$key.".jpg);'></div></a>";									
					//else
					//	echo "<a href='/catalog/".$key."'><span></span><div style='background-image: url(/brends/empty.jpg);'></div></a>";									
				}
?>
            </div>

        </div>
        
<?php
        $fp = fopen("hits.txt", "r"); // Открываем файл в режиме чтения
        $productIDs = "";
		if ($fp)
		{
			while (!feof($fp))
			{
				$productIDs = $productIDs.fgets($fp, 10000);
			}
		}
		fclose($fp);
		
		if ($productIDs !== "")
		{
			// получаем информацию о товарах
			$query_product_select = "SELECT ProductID, ProductIDStr, MP_CATEGORY.LatCategoryName, ProductSort, AbsentInStock, SortValue, PriceInEuro, Articul, ProductName, ImagePath, ";
			$query_product_select = $query_product_select." MP_PRODUCT.Note, IF(imagepath = \"\", 1, 0) AS ImageIsAbsent, MP_BRAND.BrandID, MP_SEASON.SeasonID, ";
			$query_product_select = $query_product_select." BrandName, SeasonName, New, ";

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
					if (User::getPriceInEuro() == "1")
					{
						$query_product_select = $query_product_select."PriceInEuro AS OldPrice, PriceInEuro AS NewPrice ";
					}
					else
					{
						$query_product_select = $query_product_select."".$price_str." AS OldPrice, ".$price_discount_str." AS NewPrice ";
					}
				}
			}
				
			$query_product_from = " FROM MP_PRODUCT INNER JOIN MP_BRAND_SEASON ON MP_BRAND_SEASON.GroupID = MP_PRODUCT.GroupID";
			$query_product_from = $query_product_from." INNER JOIN MP_BRAND ON MP_BRAND.BrandID = MP_BRAND_SEASON.BrandID";
			$query_product_from = $query_product_from." INNER JOIN MP_SEASON ON MP_SEASON.SeasonID = MP_BRAND_SEASON.SeasonForSiteID";
			$query_product_from = $query_product_from." INNER JOIN MP_CATEGORY ON MP_CATEGORY.CategoryID = MP_PRODUCT.CategoryID";
			
			$query_product_where = " WHERE MP_PRODUCT.Invisible = 0 AND MP_BRAND_SEASON.Invisible = 0 AND MP_SEASON.Invisible = 0 AND MP_BRAND_SEASON.CntProduct > 0 AND MP_PRODUCT.CountAttrib > 0 ";
			$query_product_where = $query_product_where." AND MP_PRODUCT.ProductID IN (".$productIDs.")";
			
			$query_product_orderby = " ORDER BY ProductSort, AbsentInStock, ImageIsAbsent, SortValue DESC, BrandName, ProductName";

			$query_product = "SELECT * FROM (".$query_product_select.$query_product_from.$query_product_where.") AS tmp".$query_product_orderby;
			
			$result_product = mysql_query($query_product);		

			if (mysql_num_rows($result_product) > 0)
			{
				echo "<div class='hits_list'>";
				echo "	<div class='title_points'><span>ХИТЫ ПРОДАЖ</span></div>";
				echo "	<div class='hits_list_slider_out_r1'>";
				echo "		<div class='hits_list_slider'>";
                
				while ($row = mysql_fetch_array($result_product)):
					
					$discount = $row["Discount"];						

					$small_path = "";
					if ($row["ImagePath"] != "")
					{
						$small_path = $row["ImagePath"];
						$small_path = str_replace(".jpg", "_s.jpg", $small_path);
					}
					
					$old_price = number_format($row["OldPrice"], 0, '.', ' ');
					$price = number_format($row["NewPrice"], 0, '.', ' ');
					
					if (User::getPriceInEuro() == "1")
					{ 
						$discount = 0;
						$old_price = $old_price." у.е.";
						$price = $price." у.е.";
					}
					else 
					{
						$old_price = $old_price." р.";
						$price = $price." р.";
					}
				
					echo "<div class='item'><div class='gd_it'>";
					if ($small_path != "")
						echo "	<a class='im' href='/catalog/".$row["LatCategoryName"]."/".$row["ProductIDStr"]."' style='background-image: url(http://mon-paris.ru/goods_images/".$small_path.");'></a>";
					else
						echo "	<a class='im' href='/catalog/".$row["LatCategoryName"]."/".$row["ProductIDStr"]."'></a>";
					echo "	<div class='inf'>";

					echo "<div class='otm'>";
						if ($discount > 0 && $row["NewPrice"] > 10)
							echo "<div class='disc'><div>- ".$discount."%</div></div>";
						if ($row["New"] > 0)
							echo "<div class='new'><div>new</div></div>";
					echo "</div>";

					echo "		<div class='brend'>".$row["BrandName"]."</div>";
					echo "		<div class='title'>".$row["ProductName"]."</div>";
					echo "	</div>";
					echo "	<div class='ord'>";
					if ($row["NewPrice"] > 10)
					{
						if ($old_price != $price)
							echo "		<div class='price_old'>".$old_price."</div>";
						echo "		<div class='price'>".$price."</div>";
					}
					echo "			<button class='order_gd' name='order_gd' type='button' value='' onClick='location.href=\"/detail/".$row["ProductIDStr"]."\"'>КУПИТЬ</button>";
					echo "	</div>";
					echo "</div></div>";
				endwhile;
				
				echo "</div></div></div>";
			}
			
			mysql_free_result($result_product);
		}
?>
 
        <div class="first_bott_text">
			<h1><?php echo $strH1; ?></h1>
			<p><b>Mon-Paris.ru</b>— это <b>магазин женской одежды</b> из Франции и Италии</p>  
			<b>Mon-Paris.ru</b>— это off-line магазин и одновременно интернет-магазин женской одежды.  
			<p>Наша компания существует с сентября 1992,  эти годы мы успешно боремся за доверие наших  покупателей. Совершая покупки в нашем магазине, Вы на можете быть уверены в том, что это действительно оригинальная дизайнерская вещь из коллекции модного бренда. Мы  используем <b>ОРИГИНАЛЬНЫЕ АРТИКУЛЫ ПРОИЗВОДИТЕЛЯ БРЕНДОВ</b>, чтобы Вы могли найти выбранные модели на сайте производителя или сравнить цены с другими поставщиками. В наш магазин, можно на  месте выбрать то, что нужно именно Вам. Наш ассортимент отражает наш многолетний опыт. </p>
			<p>Всем нравится стильно одеваться, но ходить по магазинам любят не все. Интернет магазин <b>Mon-Paris.ru</b> это подробный интернет-каталог с множеством разделов : юбки, брюки, костюмы, куртки, пальто, перчатки, шарфы и  прочие аксессуары.  Купить одежду в <b>Mon-Paris.ru</b> просто и быстро - не нужно тратить время на передвижение по городу и совершать покупки впопыхах. </p>
			<p><b>Mon-Paris.ru</b>— проверенный временем магазин женской одежды с многолетней устойчивой  репутацией, которой мы очень дорожим. Наш интернет магазин <b>Mon-Paris.ru</b> не продает копий, подделок и стоковых вещей. </p>
			<p>В нашем магазине существует  система скидок на модные вещи для постоянных клиентов. Кроме того, у нас проходят регулярные акции и распродажи, позволяющие купить одежду, со скидками  до 70%!<p>
        </div>
