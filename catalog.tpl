<div class="clearfix"></div>

		<ul class="breadcrambs cat_bread">
			<li><a href="/">�������</a></li>
<?php		
			if ($all == 1)
				echo "<li>�������</li>";
			else
				echo "<li><a href=\"/catalog/all\">�������</a></li>";

			if ($search == 1)
			{
				if ($search_txt != "")
					echo "<li>".strtoupper($search_txt)."</li>";
			}
			if ($favorites == 1)
			{
				echo "<li>".$vec_favorites[$fav_products]['title']."</li>";
			}
			if ($brend_list === 1 && $brend != "")
			{
				echo "<li>".strtoupper($brend)."</li>";
			}
			if ($cat_list === 1 && $category != "")
			{
				reset($vec_category);																	
				foreach ($vec_category as $key => $value) 
				{
					if ($key == $category)
					{
						echo "<li>".strtoupper($value[0])."</li>";
						break;
					}									
				}
			}
			if ($new_col_list === 1 && $new_collection != "")
			{
				reset($vec_new_collection);																	
				foreach ($vec_new_collection as $key => $value) 
				{
					if ($key == $new_collection)
					{
						echo "<li>��������� ".$value[1]." ".$value[2]."</li>";
						break;
					}									
				}
			}
			if ($bigsizes === 1)
			{
				echo "<li>������� �������</li>";
			}
			// ���� ���� ����������� ������� - ���������� ������
			if ($filter_min_price != "500" || $filter_max_price != "100000" || $filter_discount != "0" ||
				$str_filter_size != "" || $str_filter_color != "" || $str_filter_brand != "" || $str_filter_collection != "")
			{
				echo "<a class='filtr_clear' href='/".$url_str."'><span>����� �������</span></a>";
			}
?>
		</ul>

	</div>
	

	<div class="catalog_out">
		<div class="container">

			<div class="left_menu_out hidden-xs">

				<ul class="left_menu_inn">

<?php
				reset($vec_category);																	
				foreach ($vec_category as $key => $value) 
				{
					if ($cat_list === 1 && $category != "" && $key == $category)
						echo "<li class='act'><a href='/catalog/".$key."'>".strtoupper($value[0])."</a></li>";
					else
						echo "<li><a href='/catalog/".$key."'>".strtoupper($value[0])."</a></li>";
				} 
?>					
				</ul>

			</div>

			<div class="rg_out">
				<div class="rg_inn">

					<div class="filter_out">
<?php
						echo "<form name='form_filter' action='/".$url_str."' method='POST'>";
?>


						<!--<div class="filter_it">
							<a class="hd_tp_butt" href="#"><span>����������</span></a>
							<div class="dw_out">
								<div class="dw">
									<div class="tp"></div>
									<div class="inn">
										<div class="line"><a href="#">�� ����������� ����</a></div>
										<div class="line"><a href="#">�� �������� ����</a></div>
										<div class="line"><a class="act" href="#">�� ��������</a></div>
										<div class="line"><a href="#">�� ������������</a></div>
									</div>
								</div>
							</div>
						</div>-->

						<div class="filter_it filter_size">
							<a class="hd_tp_butt" href="#"><span>������</span></a>
							<div class="dw_out">
								<div class="dw">
									<div class="tp"></div>
									<div class="inn">
										<ul class="sz_checkb">
											<li>
<?php
												$cnt = ceil(count($filter_size) / 2);
												$ind = 0;
												reset($filter_size);
												foreach ($filter_size as $size)
												{
													if (in_array($size, $filter_size_select))
														echo "<a class='act' href='#'><input name='filter_size[]' type='hidden' value='".$size."'><span>".$size."</span></a>";
													else
														echo "<a href='#'><input name='filter_size[]' type='hidden' value=''><span>".$size."</span></a>";
														
													$ind ++;
													
													if ($ind == $cnt)
													{
														echo "</li><li>";
													}
												}
?>
											</li>											
										</ul>
										<button class="apply" type="submit">���������</button>
									</div>
								</div>
							</div>
						</div>

						<div class="filter_it">
							<a class="hd_tp_butt" href="#"><span>�����</span></a>
							<div class="dw_out">
								<div class="dw">
									<div class="tp"></div>
									<div class="inn">
										<ul class="brend_checkb">
											<!--<div class="line"><strong>RUS</strong></div>-->
<?php
											//$cnt = ceil(count($vec_brand) / 2);
											//echo $cnt;
											//$ind = 0;
											reset($vec_brand);
											foreach($vec_brand as $key=>$value)
											{
												if (in_array($key, $filter_brand_select))
													echo "<li><a data-id='".$value."' class='act' href='#'><input name='filter_brand[]' type='hidden' value='".$key."'>".$key."</a></li>";
												else
													echo "<li><a data-id='".$value."' href='#'><input name='filter_brand[]' type='hidden' value=''>".$key."</a></li>";
													
												//$ind ++;
												
												/*if ($ind == $cnt)
												{
													echo "<div class='line'></div>";
												}*/
											}
?>
										</ul>
										<button class="apply" type="submit">���������</button>
									</div>
								</div>
							</div>
						</div>

						<div class="filter_it filter_color">
							<a class="hd_tp_butt" href="#"><span>����</span></a>
							<div class="dw_out">
								<div class="dw">
									<div class="tp"></div>
									<div class="inn">
										<ul class="color_checkb">
											<li>
<?php
												$cnt = ceil(count($filter_color) / 2);
												$ind = 0;
												reset($filter_color);
												foreach($filter_color as $color_id=>$color)
												{
													if (in_array($color_id, $filter_color_select))
														echo "<a data-id='".$color_id."' class='cr_".$color_id." act' href='#'><input name='filter_color[]' type='hidden' value='".$color_id."'>".$color."</a>";
													else
														echo "<a data-id='".$color_id."' class='cr_".$color_id."' href='#'><input name='filter_color[]' type='hidden' value=''>".$color."</a>";
														
													$ind ++;
													
													if ($ind == $cnt)
													{
														echo "</li><li>";
													}
												}
?>
											</li>
										</ul>
										<button class="apply" type="submit">���������</button>
									</div>
								</div>
							</div>
						</div>

						<div class="filter_it">
							<a class="hd_tp_butt" href="#"><span>�����</span></a>
							<div class="dw_out">
								<div class="dw">
									<div class="tp"></div>
									<div class="inn">
										<ul class="brend_checkb sezon_checkb">
<?php
											reset($vec_collection);
											foreach($vec_collection as $collection_id=>$collection)
											{
												if (in_array($collection_id, $filter_collection_select))
													echo "<li><a data-id='".$collection_id."' class='act' href='#'><input name='filter_collection[]' type='hidden' value='".$collection_id."'>".$collection."</a></li>";
												else
													echo "<li><a data-id='".$collection_id."' href='#'><input name='filter_collection[]' type='hidden' value=''>".$collection."</a></li>";
											}
?>	
										</ul>
										<button class="apply" type="submit">���������</button>
									</div>
								</div>
							</div>
						</div>

						<div class="filter_it filter_price">
							<a class="hd_tp_butt" href="#"><span>����</span></a>
							<div class="dw_out">
								<div class="dw">
									<div class="tp"></div>
									<div class="inn">
										<div class="line txsm">��������� ����</div>
										<div class="felds">
											<div class="tx">��</div>
<?php											
											echo "<input class='slider_price_min' id = 'slider_price_min' name='slider_price_min' type='text' value='".$filter_min_price."' maxlength='10'>";
?>
											<div class="tx">��</div>
<?php											
											echo "<input class='slider_price_max mrg2' id = 'slider_price_max' name='slider_price_max' type='text' value='".$filter_max_price."' maxlength='10'>";
?>
											<div class="tx">���</div>
										</div>
										<div class="slider_price_out">
											<div id="slider_price"></div>
										</div>
										<button class="apply" type="submit">���������</button>
									</div>
								</div>
							</div>
						</div>

<?php
						echo "<input id = 'filter_discount' name = 'filter_discount' type='text' value='".$filter_discount."' style='display:none'>";
?>
						<a href="javascript:void(0)" OnClick='$("#filter_discount").val(1); document.form_filter.submit();' class="disc"><div>�� �������</div></a>

						</form>
					</div>

<?php

					//echo $search_txt;

					//echo $query_product;

					$result_product = mysql_query($query_product);		

					if (mysql_num_rows($result_product) > 0)
					{
						if (User::getUserLogin() == 'milch1@newmail.ru')
						{
							$strID = "";
							while ($row = mysql_fetch_array($result_product)):
							
								if ($strID == '') $strID = $strID.$row["ProductID"];
								else $strID = $strID.", ".$row["ProductID"];
								
							endwhile;
							
							mysql_data_seek($result_product,0);
							echo "<br><br>������ �����:<br>";
							echo $strID;
						}
						
						echo "<div class='gd_list_out'>";
						echo "	<div class='hits_list_slider'>";
						
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
								$old_price = $old_price." �.�.";
								$price = $price." �.�.";
								$discount = 0;
							}
							else 
							{
								$old_price = $old_price." �.";
								$price = $price." �.";
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
							if ($row["NewPrice"] > 10)
							{
								echo "	<div class='ord'>";
								if ($old_price != $price)
									echo "		<div class='price_old'>".$old_price."</div>";
								echo "		<div class='price'>".$price."</div>";
								echo "			<button class='order_gd' name='order_gd' type='button' value='' onClick='location.href=\"/catalog/".$row["LatCategoryName"]."/".$row["ProductIDStr"]."\"'>������</button>";
								echo "	</div>";
							}
							else
							{
								echo "	<div class='ord'>";
								echo "			<button class='order_gd' name='order_gd' type='button' value='' onClick='location.href=\"/catalog/".$row["LatCategoryName"]."/".$row["ProductIDStr"]."\"'>������</button>";
								echo "	</div>";
							}
							echo "</div></div>";
						endwhile;
						
						echo "</div></div>";
					}
					else
					{
						echo "<div><h4><p><br><br>�� ������ ������� ������ �� �������.</p></h4></div>";
					}
					
					mysql_free_result($result_product);

					include_once ("pages_number.tpl");					
?>					
					<div class="content">
<?php
						$bFind = 0;
						if ($brend != "")
						{	
							echo "<h1>".$strH1."</h1>\n";
							if (file_exists("brends/".$brend.".tpl"))
							{
								include "brends/".$brend.".tpl";
								$bFind = 1;
							}
						}
						else
						{
							if ($category != "")
							{	
								if (file_exists("catalog_descr/".$category.".tpl"))
								{
									include "catalog_descr/".$category.".tpl";
									$bFind = 1;
								}
							}
							else
							{
								if ($bigsizes != 0)
								{
									if (file_exists("catalog_descr/bolshie-razmery.tpl"))
									{
										include "catalog_descr/bolshie-razmery.tpl";
										$bFind = 1;
									}
								}
							}
						}
						if ($bFind == 0)
						{
echo <<< END
<p>Mon-Paris.ru � ��� ������� ������� ������ �� ������� � ������</p>  
Mon-Paris.ru � ��� off-line ������� � ������������ ��������-������� ������� ������.  
<p>���� �������� ���������� � �������� 1992,  ��� ���� �� ������� ������� �� ������� �����  �����������. �������� ������� � ����� ��������, �� �� ������ ���� ������� � ���, ��� ��� ������������� ������������ ������������ ���� �� ��������� ������� ������. ��  ���������� ������������ �������� ������������� �������, ����� �� ����� ����� ��������� ������ �� ����� ������������� ��� �������� ���� � ������� ������������. � ��� �������, ����� ��  ����� ������� ��, ��� ����� ������ ���. ��� ����������� �������� ��� ����������� ����. </p>
<p>���� �������� ������� ���������, �� ������ �� ��������� ����� �� ���. �������� ������� Mon-Paris.ru  ��� ��������� ��������-������� � ���������� �������� : ����, �����, �������, ������, ������, ��������, ����� �  ������ ����������.  ������ ������ � Mon-Paris.ru  ������ � ������ - �� ����� ������� ����� �� ������������ �� ������ � ��������� ������� ��������. </p>
<p>Mon-Paris.ru � ����������� �������� ������� ������� ������ � ����������� ����������  ����������, ������� �� ����� �������. ��� �������� ������� Mon-Paris.ru  �� ������� �����, �������� � �������� �����. </p>
<p>� ����� �������� ����������  ������� ������ �� ������ ���� ��� ���������� ��������. ����� ����, � ��� �������� ���������� ����� � ����������, ����������� ������ ������, �� ��������  �� 70%!<p>
END;
						}
?>
					</div>
				</div>
			</div>

		</div>
	</div>
