<?php
	$strTitle = "����� ���������";
	$new_collection_page = 1;
	include_once ("top.tpl");
?>

        <div class="clearfix"></div>

        <ul class="breadcrambs">
            <li><a href="/">�������</a></li>
            <li>����� ���������</li>
        </ul>

        <div class="akcii_list">
            <div class="title_points"><span>����� ���������</span></div>
            <div class="akcii_list_inn">

<?php
		/*$query = "SELECT GroupID, MP_SEASON.SeasonID, MP_SEASON.SeasonName, MP_BRAND.BrandID, MP_BRAND.BrandName FROM MP_BRAND_SEASON INNER JOIN MP_SEASON ON MP_SEASON.SeasonID = MP_BRAND_SEASON.SeasonID ";
		$query = $query."INNER JOIN MP_BRAND ON MP_BRAND.BrandID = MP_BRAND_SEASON.BrandID "; 
		$query = $query."WHERE MP_BRAND_SEASON.NewCollection <> 0 AND MP_BRAND_SEASON.CntProduct > 0  ORDER BY MP_BRAND.BrandSort, MP_SEASON.SeasonSort DESC, MP_BRAND.BrandName"; 

		$result_col = mysql_query($query); 
		
		while ($row = mysql_fetch_array($result_col)): 
			//$vec_new_collection[$row["GroupID"]] = "��������� ".$row["BrandName"]." ".$row["SeasonName"];
			echo "<div class='item'>";
			echo "	<table>";
			echo "		<tr>";
			echo "			<td class='im'><img src='/new_collections/".$row["GroupID"].".jpg' alt=''></td>";
			echo "			<td class='rg'>";
			echo "				<div class='title'>�����: <span>".$row["BrandName"]."</span></div>";
			echo "				<div class='title'>���������: <span>".$row["SeasonName"]."</span></div>";
			echo "				<div class='descr'>";
			include "new_collections/".$row["GroupID"].".tpl";
			echo "				</div>";
			echo "				<a class='hd_tp_butt' href='/catalog/new_collection/".$row["GroupID"]."'><span>������� � �������</span></a>";
			echo "			</td>";
			echo "		</tr>";
			echo "	</table>";
			echo "</div>";
		endwhile;
		mysql_free_result($result_col);*/
		
		reset($vec_new_collection);																	
		foreach ($vec_new_collection as $key => $value) 
		{
			echo "<div class='item'>";
			echo "	<table>";
			echo "		<tr>";
			if (file_exists("new_collections/".$value[0].".jpg"))
				echo "			<td class='im'><img src='/new_collections/".$value[0].".jpg' alt=''></td>";
			else
				echo "			<td class='im'><img src='/new_collections/empty.jpg' alt=''></td>";
			echo "			<td class='rg'>";
			if (User::getUserLogin() == 'adoon@inbox.ru' || User::getUserLogin() == 'optmoda@gmail.com')
			{
				echo "				<div class='title'>���: <span>".$value[0]."</span></div>";
			}
			echo "				<div class='title'>�����: <span>".$value[1]."</span></div>";
			echo "				<div class='title'>���������: <span>".$value[2]."</span></div>";
			echo "				<div class='descr'>";
			include "new_collections/".$value[0].".tpl";
			echo "				</div>";
			echo "				<a class='hd_tp_butt' href='/catalog/".$key."'><span>������� � �������</span></a>";
			echo "			</td>";
			echo "		</tr>";
			echo "	</table>";
			echo "</div>";
		}
		
		//$_SESSION['new_collection'] = $vec_new_collection;
?>

                <!--<div class="item">
                    <table>
                        <tr>
                            <td class="im"><img src="img/akc_1.jpg" alt=""></td>
                            <td class="rg">
                                <div class="title">�����: <span>LEO-GUY</span></div>
                                <div class="title">���������: <span>���� 2016</span></div>
                                <div class="descr">
                                    ��������� �� ����� 15 000 ����� � ������ <br>������� ������ � �������
                                </div>
                                <a class="hd_tp_butt" href="catalog.html"><span>������ �� �������</span></a>
                            </td>
                        </tr>
                    </table>
                </div>-->
                <!--<div class="item">
                    <table>
                        <tr>
                            <td class="im"><img src="img/akc_2.jpg" alt=""></td>
                            <td class="rg">
                                <div class="title">�����: <span>������� ��������</span></div>
                                <div class="descr">
                                    ��������� �� ����� 15 000 ����� � ������ <br>������� ������ � �������
                                </div>
                                <div class="dat">21 �������� 2015 - 21 ������ 2015</div>
                                <a class="hd_tp_butt" href="catalog.html"><span>������ �� ������� � ������ ����� ������</span></a>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="item">
                    <table>
                        <tr>
                            <td class="im"><img src="img/akc_3.jpg" alt=""></td>
                            <td class="rg">
                                <div class="title">�����: <span>������� ��������</span></div>
                                <div class="descr">
                                    ��������� �� ����� 15 000 ����� � ������ <br>������� ������ � �������
                                </div>
                                <div class="dat">21 �������� 2015 - 21 ������ 2015</div>
                                <a class="hd_tp_butt" href="catalog.html"><span>������ �� ������� � ������ ����� ������</span></a>
                            </td>
                        </tr>
                    </table>
                </div>-->
            </div>
            <!--<div class="akcii_list_all"><a class="butt_fiolet" href="catalog.html"><span>��� ���� � ������</span></a></div>-->
        </div>
<?php

	if (file_exists("catalog_descr/new_collections.tpl"))
	{
		include "catalog_descr/new_collections.tpl";
	}

	include_once ("bottom.tpl");
?> 
