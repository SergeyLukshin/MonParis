<?php
	$strTitle = "������";	
	$brends_page = 1;

	$strTitle = "������ ������ ������� ������ � ������";
	$strDescription = "������ �������� ������� ������ �� ������ � �������. ������ ������, ������� ��������! ��� ��� ���� (MON PARIS).";

	include_once ("top.tpl");
?>

        <div class="clearfix"></div>

        <ul class="breadcrambs">
            <li><a href="/">�������</a></li>
            <li>������</li>
        </ul>

        <div class="brend_list">
            <div class="title_points" id="title_points"><span>������</span></div>

			<!--<div class="brend_list_current">
                <div class="item_out">
                    <a class="item" href="#">
                        <div class="bg"></div>
                        <div class="title"><div>������� � �������</div></div>
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
			
			<h1 style="color:#afafaf">������ �� ����������� �������</h1>
            
            <div class="clearfix"></div>
        </div>
<?php
	include_once ("bottom.tpl");
?>   
