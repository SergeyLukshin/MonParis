<?php
	header ("HTTP/1.1 404 Not Found");

	$strTitle = "������";
	include_once ("top.tpl");

?>

        <div class="clearfix"></div>

        <ul class="breadcrambs">
            <li><a href="#">�������</a></li>
            <li>������ 404</li>
        </ul>

        <div class="err_404">

            <img src="img/404_bg.jpg" alt="">

            <div class="clearfix"></div>

            <div class="err_404_inn">
                ���-�� ����� �� ���, � �� �� ������ ����� ������ ��������:(<br>
                <div class="clearfix"></div>
                <div class="line"></div>
                <div class="clearfix"></div>
                ��������� �� <a href="/">�������</a>:)
            </div>
        </div>

<?php
	include_once ("bottom.tpl");
?> 
