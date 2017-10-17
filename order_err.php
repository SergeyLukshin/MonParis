<?php
	$strTitle = "ОФОРМЛЕНИЕ ЗАКАЗА";

	$make_order = 1;
	$main = 0;

	include_once ("init.tpl");
	include_once ("top.tpl");
?>


        <div class="clearfix"></div>

        <ul class="breadcrambs">
            <li><a href="/">Главная</a></li>
            <li>Оформление заказа</li>
        </ul>
    </div>


    <div class="cart_list_out">

        <div class="title_points cart_list_title"><span>ОФОРМЛЕНИЕ ЗАКАЗА</span></div>

        <div class="cart_list_form_out">

            <div class="container">

                <div class="cart_order_inn">

                    <div class="stat stat_err">
                        <strong>ВО ВРЕМЯ ОТПРАВКИ ЗАКАЗА ПРОИЗОШЛА ОШИБКА!</strong>
                    </div>

                    <div class="clearfix"></div>

                    <div class="clearfix"></div>
                    Вернуться <a href="javascript:history.back();">назад</a> и попробовать еще раз.

                </div>
            </div>
        </div>


    </div>

<?php
	include_once ("bottom.tpl");
?> 
