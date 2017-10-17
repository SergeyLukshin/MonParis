<?php
	header ("HTTP/1.1 404 Not Found");

	$strTitle = "ОШИБКА";
	include_once ("top.tpl");

?>

        <div class="clearfix"></div>

        <ul class="breadcrambs">
            <li><a href="#">Главная</a></li>
            <li>Ошибка 404</li>
        </ul>

        <div class="err_404">

            <img src="img/404_bg.jpg" alt="">

            <div class="clearfix"></div>

            <div class="err_404_inn">
                Что-то пошло не так, и мы не смогли найти данную страницу:(<br>
                <div class="clearfix"></div>
                <div class="line"></div>
                <div class="clearfix"></div>
                Перейдите на <a href="/">главную</a>:)
            </div>
        </div>

<?php
	include_once ("bottom.tpl");
?> 
