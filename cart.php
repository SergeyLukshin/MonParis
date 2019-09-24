<?php
	$strTitle = "КОРЗИНА";

	include_once ("init.tpl");

	$basket = 1;
	$main = 0;

	$cart->refresh_cart($jcart);

	include_once ("top.tpl");
?>
<!-- Google Code for &#1047;&#1072;&#1096;&#1077;&#1083; &#1074; &#1050;&#1086;&#1088;&#1079;&#1080;&#1085;&#1072; Conversion Page -->
<script type="text/javascript">
/* <![CDATA[ */
var google_conversion_id = 1038736007;
var google_conversion_language = "en";
var google_conversion_format = "3";
var google_conversion_color = "ffffff";
var google_conversion_label = "oBpyCMrUonUQh7Wn7wM";
var google_conversion_value = 5.00;
var google_conversion_currency = "USD";
var google_remarketing_only = false;
/* ]]> */
</script>
<script type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js">
</script>
<noscript>
<div style="display:inline;">
<img height="1" width="1" style="border-style:none;" alt="" src="//www.googleadservices.com/pagead/conversion/1038736007/?value=5.00&amp;currency_code=USD&amp;label=oBpyCMrUonUQh7Wn7wM&amp;guid=ON&amp;script=0"/>
</div>
</noscript>

        <div class="clearfix"></div>

        <ul class="breadcrambs">
            <li><a href="/">Главная</a></li>
            <li>Корзина</li>
        </ul>
    </div>


    <div class="cart_list_out">

        <div class="container"><div class="title_points cart_list_title"><span>КОРЗИНА</span></div></div>

		<div class='container'>
			<form method='post' action='' class='promocode' id='formid' name='formid'>
			    <div id='jcart' class = "cart_promocode">
<?php
			    $cart->display_cart_promocode($jcart);
?>
    			</div>
            </form>
		</div>
		
    </div>

<?php
	include_once ("bottom.tpl");
?> 
