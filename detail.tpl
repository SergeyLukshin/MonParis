<?php
		$h = getenv("HTTP_REFERER");

		$href = $h;
		if (isset($_SESSION['cur_page']) && $_SESSION['cur_page'] == "0")
			$href = $href."/1";
					
			unset($_SESSION['cur_page']);

		if ($href == "") $href = "/";
?>
        <div class="clearfix"></div>

        <ul class="breadcrambs cat_bread">			
			<li><a href="/">�������</a></li>
<?php
			echo "<li><a href=\"/catalog/all\">�������</a></li>";

			if ($category_for_url != "")
			{
				reset($vec_category);																	
				foreach ($vec_category as $key => $value) 
				{
					if ($key == $category_for_url)
					{
						echo "<li><a href=\"/catalog/".$key."\">".strtoupper($value[0])."</a></li>";
						break;
					}									
				}
			}
			echo "<li>".$product_name."</li>";
?>
        </ul>
<?php			
	echo "<div class='container' style='position:relative; width:100%; height: 25px;float:left;'><a class='return_back' href='".$href."'><span>����� � ������ �������</span></a></div>";
?>
    </div>

	<!-- Yandex.Metrika -->
	<script type="text/javascript">
		<!--window.dataLayerYandex = window.dataLayerYandex || [];-->

		dataLayer.push({
			"ecommerce": {
				"detail": {
					"products": [
						{
							"id": "<?php echo $product_id; ?>",
							"name" : "<?php echo $product_name; ?>",
							"price": <?php echo $product_price; ?>,
							"brand": "<?php echo $product_brand_name; ?>",
							"category": "<?php echo $productCategoryName; ?>",
						}
					]
				}
			}
		});
	</script>
	<!-- /Yandex.Metrika -->


    <div class="gd_view_out">
        <div class="container">			
            <div class="gd_im">
<?php

					if ($product_image_path != "")
					{
    					echo "<div class='gd_im_inn'>";
						echo "<table><tr><td><img src='/goods_images/".$product_image_path."' alt=''></td></tr></table>";

                        echo "<div class='im_list'>";
                            echo "<a rel='gd_fansy' class='fancybox item act' href='/goods_images/".$product_image_path."' style='background-image: url(/goods_images/".$product_image_path.");'><div></div></a>";
                            reset($vec_product_images);
                            foreach ($vec_product_images as $key => $value)
                            {
                                echo "<a rel='gd_fansy' class='fancybox item' href='/goods_images/".$key."' style='background-image: url(/goods_images/".$key.");'><div></div></a>";
                            }
                        echo "</div>";
					}
					else
					{
    					echo "<div class='gd_im_inn' style='padding-left:0px !important;'>";
					    if ($product_is_new_collection != 0)
					    {
					        echo "<img src='/img/empty_big.png' alt=''>";
					    }
					}

					echo "<div class='metk'>";
					if ($product_discount > 0 && $product_price > 10)
						echo "<div class='disc'><div>- ".$product_discount."%</div></div>";
					if ($product_new > 0)
						echo "<div class='new'><div>new</div></div>";
					echo "</div>";
?>
<?php
					if ($product_image_path != "")
					{
                        echo "<div class='gd_fansy_out'>";
                        echo "<a class='fancybox gd_fansy' rel='gd_fansy' href='/goods_images/".$product_image_path."'></a>";
                        echo "</div>";
                    }
?>
                </div>
            </div>

            <div class="rg_opt">
				<div class="zoomim"></div>
				<div class="magnifier2"></div>
<?php
				echo "<input type='hidden' name='productID' id='productID' value='".$productID."' />";
				if (User::getUserLogin() == 'adoon@inbox.ru')
				{
					echo "<h1>".$product_id."</h1>";
				}
?>
                <h1><?php echo $product_name; ?></h1>
<?php
                if ($product_price > 10)
                {
                    $old_price = number_format($product_old_price, 0, '.', ' ');
                    $price = number_format($product_price, 0, '.', ' ');

                    /*if (User::getPriceInEuro() == "1")
                    {
                        $old_price = $old_price." �.�.";
                        $price = $price." �.�.";
                    }
                    else*/
                    {
                        $old_price = $old_price." �.";
                        $price = $price." �.";
                    }

                    echo "<div class='price_bl' style='margin: 10px 0 10px 0;''>";
                    echo "	<div class='rg'>";
                    if ($product_old_price != $product_price)
                        echo "		<div class='old'>".$old_price."</div>";
                    echo "		<div class='curr'>".$price."</div>";
                    echo "	</div>";
                    echo "</div>";
                }
?>
                <h5>�����</h5>
                <h4><?php echo $product_brand_name; if ($product_brand_second_name != "") echo " (".$product_brand_second_name.")"; ?></h4>
                <h5>�������</h5>
                <h4><?php echo $product_articul; ?></h4>
                <h5>���������</h5>
                <h4><?php echo $product_collection_name; ?></h4>

                <h5>����</h5>

				<form method='post' action='' class='jcart' id='formid' name='formid'>

					<div class="color_sel" >
						
						<select class="selectpicker2" data-size="6" name="color_sel" title='�������� ����' onchange='product_color_change()'>
<?php
						reset($vec_product_colors);	
						$i = 0;
						foreach ($vec_product_colors as $key => $value) 
						{
							if ($i == 0)
								echo "<option selected='selected' value='".$key."'>".$key."</option>";
							else
								echo "<option value='".$key."'>".$key."</option>";
								
							$i = $i + 1;
						}                        
?>
						</select>
					</div>
					
					<h5>������� ������������� (<span style = 'color: #8597DC'>���������� �������</span>):</h5>
<?php
					echo "<input id='size_manuf_sel' name='size_manuf_sel' type='hidden' value=''>";
					echo "<div class='size_sel size_manuf_sel' name='size_sel'>";
?>
					</div>
<?php
					if ($cntAll <= 0)
					{
						$year = date("Y");
						$pos = strpos($product_collection_name,  strval($year));
						$pos2 = strpos($product_collection_name,  strval($year + 1));
						if ($pos === False && $pos2 === False)
						{
							echo "<h5 style='color:#ff0000;font-weight:bold;'>�������� �����������</h5>";
						}
						else
						{
							echo "<h5 style='color:green;font-weight:bold;'>��������� �� �����</h5>";
						}
						
						if ($product_price > 10)
						{
							echo "<h6 style='color:grey'>���� ������ ��� �� ������, �� ��� ����� �������� ����� �� ������ \"�������� � �������\"</h6>";
						}
						
						echo "<div class='price_bl' style= 'background-color: #ffffff;'>";
						echo "</div>";
					}
					
					if ($product_price > 10)
					{
						$old_price = number_format($product_old_price, 0, '.', ' ');
						$price = number_format($product_price, 0, '.', ' ');
						
						/*if (User::getPriceInEuro() == "1")
						{ 
							$old_price = $old_price." �.�.";
							$price = $price." �.�.";
						}
						else*/
						{
							$old_price = $old_price." �.";
							$price = $price." �.";
						}
								
						echo "<div class='price_bl'>";
						echo "	<div class='lf' id='price_bl_lf'>";
						echo "		<div style='display:none;' id='basket_msg'><h6 style='font-weight:bold;color: #8597DC;'>����� �������� � �������</h6></div>";
						echo "		<button onClick='document.favourite=0' style='display: -moz-inline-box;display: inline-block; float: left; text-align: center; min-width: 120px;' class='form_butt_2' name='my-add-button' type='submit' value=' '><span>�������� � �������</span></button>";
						echo "		<a class='hd_tp_butt' href='/cart.php' style='display:none;background-color: #E5B81C; float: left' name='my-cart-button'><span>������� � �������</span></a>";
						if (User::isAuthorized())
						{
						    //echo "<form method='post' action='' class='favourite' id='favourite' name='favourite'>";
						    echo "		<input type='hidden' name='product_id' id='item_id' value='".$product_id."' />";
							echo "		<input type='hidden' name='user_id' id='user_id' value='".User::getUserID()."' />";
						    if ($product_favourite != 0)
						        echo "		<input onClick='document.favourite=1' name='favourite' id = 'fav".$product_id."' class='fav_on' type='submit' value=' ' title = '������� �� ����������'><span> </span></button>";
						    else
						        echo "		<input onClick='document.favourite=1' name='favourite' id = 'fav".$product_id."' class='fav_off' type='submit' value=' ' title = '�������� � ���������'><span> </span></button>";
						    //echo "</form>";
						}
						else
						{
						    echo "		<button name='favourite' value = ' ' class = 'fav_off' data-toggle='modal' data-target='#modal_ent'></button>";
						}
						echo "		<input type='hidden' name='my-item-id' id='item_id' value='".$productID."' />";
						echo "		<input type='hidden' name='my-item-name' id='item_name' value=\"".$product_name."$".$product_articul."$".$productLatCategoryName."$".$product_collection_name."$".$product_brand_name."$".$product_image_path."\" />";
						echo "		<input type='hidden' name='my-item-price' value='".number_format($product_price, 0, '.', '')."' />";
						echo "		<input type='hidden' name='my-item-qty' value='1' />";
						echo "		<div class='lnk_sklad'><a href='#' data-toggle='modal' data-target='#modal_aviable'>��������� ������� �� ������</a></div>";
						echo "	</div>";
						//echo "	<div class='rg'>";
						//if ($product_old_price != $product_price)
						//	echo "		<div class='old'>".$old_price."</div>";
						//echo "		<div class='curr'>".$price."</div>";
						//echo "	</div>";
						echo "</div>";
					}
				
?>
				</form>

                <!--<div class="soc">
                    <a class="tw" href="#"></a>
                    <a class="gp" href="#"></a>
                    <a class="in" href="#"></a>
                    <a class="fb" href="#"></a>
                </div>-->
            </div>

            <div class="descr_tabs">
                <!-- Nav tabs -->
                <ul class="nav nav-tabs">
                  <li class="active">
                    <a href="#gdv_descr" data-toggle="tab">��������</a></li><li>
                    <a href="#gdv_brend" data-toggle="tab">� ������</a></li><li>
                    <a href="#gdv_deliv" data-toggle="tab">��������/���������</a></li>
                </ul>

                <!-- Tab panes -->
                <div class="tab-content">
                  <div class="tab-pane active" id="gdv_descr">
<?php
                    echo $product_note;
?>
                  </div>
                  <div class="tab-pane" id="gdv_brend">
					  <p>
<?php
						include "brends/".$product_brand_name.".tpl";
?>
					  </p>
                  </div>
                  <div class="tab-pane" id="gdv_deliv">
                    <p>MonParis.ru � ��������-������� ������ � �����! ����� � ������� ��������� ����� ���, �� ������ �� ���������, �����������, �������� �� �������.</p>
                  </div>
                </div>
            </div>
        </div>

    </div>

<div id="modal_aviable" class="modal modal_aviable" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <a class="closew" data-dismiss="modal" href="#"></a>
                <h2 style="text-align: left;">�������</h2>

                <div class="tab_bl">
                    <div class="tcol">
                        <table>
<?php
							reset($vec_product_sizes);
							reset($vec_product_colors);

							echo "<thead><tr><td class='lf'>����/������</td>";									
							foreach ($vec_product_sizes as $key2 => $value_size) 
							{
								echo "<td>".$key2."</td>";
							}									
							echo "</tr></thead>";
							
							echo "<tbody>";
							foreach ($vec_product_colors as $key => $value_color) 							
							{
								echo "<tr>";
								echo "<td class='lf'>".$key."</td>";
								foreach ($vec_product_sizes as $key2 => $value_size) 
								{
									if (array_key_exists($key2, $value_color))
									{
										if ($value_color[$key2] > 0)
											echo "<td class='on'></td>";
										else
											echo "<td class='off'></td>";
									}
									else 
										echo "<td class='off'></td>";
								}								
								echo "</tr>";
							}
							echo "</tbody>";
?>
                        </table>
                    </div>

                </div>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
</div>

<div id="modal_tabsize" class="modal modal_tabsize" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <a class="closew" data-dismiss="modal" href="#"></a>
                <h2>�������</h2>

                <div class="tab_bl">
                    <div class="tcol tcol_0">
                        <table>
                            <thead>
                                <tr>
                                    <td class="lf">����� / ������</td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="lf">Bagutti</td>
                                </tr>
                                <tr>
                                    <td class="lf">Benino</td>
                                </tr>
                                <tr>
                                    <td class="lf">Etincelle</td>
                                </tr>
                                <tr>
                                    <td class="lf">Giani Forte</td>
                                </tr>
                                <tr>
                                    <td class="lf">Leo Guy</td>
                                </tr>
                                <tr>
                                    <td class="lf">Orna Farno</td>
                                </tr>
                                <tr>
                                    <td class="lf">Philippe Carat</td>
                                </tr>
                                <tr>
                                    <td class="lf">Sagaie</td>
                                </tr>
                                <tr>
                                    <td class="lf">Sparkle</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="tcol tcol_1">
                        <table>
                            <thead>
                                <tr>
                                    <td>40-42</td>
                                    <td>42-44</td>
                                    <td>44-46</td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>1</td>
                                    <td>1</td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>1</td>
                                    <td>2</td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>SM</td>
                                    <td>SM</td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td>38</td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td>SM</td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>1</td>
                                    <td>2</td>
                                </tr>
								<tr>
                                    <td>1</td>
                                    <td>2</td>
                                    <td>3</td>
                                </tr>                                
                            </tbody>
                        </table>
                    </div>
                    <div class="clearfix tb_rz"></div>
                    <div class="tcol tcol_2">
                        <table>
                            <thead>
                                <tr>
                                    <td>46-48</td>
                                    <td>48-50</td>
                                    <td>50-52</td>
                                    <td>52-54</td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>ML</td>
                                    <td>XL</td>
                                    <td>XXL</td>
                                    <td>XXXL</td>
                                </tr>
                                <tr>
                                    <td>2</td>
                                    <td>3</td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>3</td>
                                    <td>4</td>
                                    <td>5</td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>T0</td>
                                    <td>T1</td>
                                    <td>T2</td>
                                </tr>
                                <tr>
                                    <td>ML</td>
                                    <td>XL</td>
                                    <td>XXL</td>
                                    <td>XXXL</td>
                                </tr>
                                <tr>
                                    <td>40</td>
                                    <td>42</td>
                                    <td>44</td>
                                    <td>44</td>
                                </tr>
                                <tr>
                                    <td>ML</td>
                                    <td>XL</td>
                                    <td>XXL</td>
                                    <td>XXXL</td>
                                </tr>
                                <tr>
                                    <td>3</td>
                                    <td>4</td>
                                    <td>5</td>
                                    <td>6</td>
                                </tr>
								<tr>
                                    <td>4</td>
                                    <td>5</td>
                                    <td>6</td>
                                    <td></td>
                                </tr>                                
                            </tbody>
                        </table>
                    </div>
                    <div class="clearfix tb_rz tb_rz2"></div>
                    <div class="tcol tcol_3">
                        <table>
                            <thead>
                                <tr>
                                    <td>54-56</td>
                                    <td>56-58</td>
                                    <td>58-60</td>
                                    <td>60-62</td>                                    
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>T3</td>
                                    <td>T4</td>
                                    <td>T5</td>
                                    <td>T6</td>
                                </tr>
                                <tr>
                                    <td>XXXXL</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>46</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>XXXXL</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>7</td>
                                    <td>8</td>
                                    <td></td>
                                    <td></td>
                                </tr>
								<tr>
                                    <td>&nbsp;</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>                                
                            </tbody>
                        </table>
                    </div>
                    <div class="clearfix tb_rz tb_rz3"></div>
                    <div class="butt_out"><a class="hd_tp_butt tp_recall" href="#" data-toggle="modal" data-target="#modal_feedback_1"><span>��������� � ����������</span></a></div>
                </div>


                <div class="gerl"></div>

                <div class="descr">
                    <div class="descr_inn">

                        ������� ����� ������������� � ���������� ������ � �������. ��� ����������� ������������� ����� � ������� ��������. ��� ��������� ����� ������� ����� �����, ����� ��� ���� ������ ���� ����������� ����.
                        <br><br>
                        ������ ����� ���������� �� ������ ������������ ����� ����� ������� � �� ������� ���� ������� �����.
                        <br><br>
                        ������ ����� � �� ����� ����� ����� �����.

                    </div>
                </div>

                <div class="clearfix"></div>
            </div>
        </div>
    </div>
</div>
