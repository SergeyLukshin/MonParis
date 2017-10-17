<?php
	$strTitle = "КОРЗИНА";

	include_once ("init.tpl");

	$basket = 1;
	$main = 0;

	$cart->refresh_cart($jcart);

	include_once ("top.tpl");
?>

        <div class="clearfix"></div>

        <ul class="breadcrambs">
            <li><a href="/">Главная</a></li>
            <li>Корзина</li>
        </ul>
    </div>


    <div class="cart_list_out">

        <div class="container"><div class="title_points cart_list_title"><span>КОРЗИНА</span></div></div>

		<div class='container'>
			<div id='jcart'>

<?php
				$cart->display_cart($jcart);
?>
			</div>
		</div>
		
    </div>

<?php
	include_once ("bottom.tpl");
?> 
