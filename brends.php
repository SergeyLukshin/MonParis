<?php
	$strTitle = "БРЕНДЫ";	
	$brends_page = 1;

	$strTitle = "Бренды модной женской одежды в Москве";
	$strDescription = "Купите стильную женскую одежду из Италии и Франции. Лучшие бренды, удобная доставка! Ваш Мон Пари (MON PARIS).";

	include_once ("top.tpl");
?>

        <div class="clearfix"></div>

        <ul class="breadcrambs">
            <li><a href="/">Главная</a></li>
            <li>Бренды</li>
        </ul>

        <div class="brend_list">
            <div class="title_points" id="title_points"><span>БРЕНДЫ</span></div>

			<!--<div class="brend_list_current">
                <div class="item_out">
                    <a class="item" href="#">
                        <div class="bg"></div>
                        <div class="title"><div>ПЕРЕЙТИ В КАТАЛОГ</div></div>
                    </a>
                </div>
                <div class="text_out">
                    <div class="text_inn">
                        <div class="title"></div>
                        <div class="text_inn2"></div>
                    </div>
                </div>

            </div>-->
            
            <div class="brend_list_inn">
<?php
			reset($vec_brand);																	
			foreach ($vec_brand as $key => $value) 
			{
				$title = str_replace("-", "<wbr>-<wbr>", $key);
				echo "<a class='item' href='/catalog/".$key."'>";
				if (file_exists("brends/".$key.".jpg"))
					echo "    <div class='bg' style='background-image: url(/brends/".$key.".jpg);'></div>";
				else
					echo "    <div class='bg' style='background-image: url(/brends/empty.jpg);'></div>";
                echo "    <div class='title'><span>".$title."</span></div>";
                //echo "    <div class='text'>";
                //echo "        <p>";
                //include "brends/".$value.".tpl";
                //echo "        </p>";
                //echo "    </div>";
                echo "</a>";       
			}
?>
            </div>
			
			<h1 style="color:#afafaf">Одежда от европейских брендов</h1>
            
            <div class="clearfix"></div>
        </div>
<?php
	include_once ("bottom.tpl");
?>   
