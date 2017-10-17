<?php
	$strTitle = "САМОВЫВОЗ";
	$opt_page = 1;
	include_once ("top.tpl");
?>

        <div class="clearfix"></div>

        <ul class="breadcrambs">
            <li><a href="/">Главная</a></li>
            <li>Самовывоз</li>
        </ul>



        <div class="opt_out">
            <ul class="opt_tabs_nav">
                <li><a href="/opt.php"><span>ОПТОВЫМ ПОКУПАТЕЛЯМ</span></a></li>
                <li><a class="act" href="/samovyvoz.php"><span>САМОВЫВОЗ</span></a></li>
                <li><a href="/delivery.php"><span>ДОСТАВКА</span></a></li>
            </ul>
            <div class="opt_tabs_cont samov_tabs_cont">

                <h2 class="txt_title">Условия самовывоза</h2>

				<div class="map_bl">

                    <!--<div class="links">
                        <div class="links_out">
                            <a class="hd_tp_butt cont_sw_butt" data-target="2" href="#"><span>КАК ПРОЕХАТЬ НА МАШИНЕ</span></a>
                        </div>
                        <div class="links_out">
                            <a class="hd_tp_butt cont_sw_butt" data-target="1" href="#"><span>КАК ПРОЙТИ ПЕШКОМ</span></a>
                        </div>
                    </div>-->

                    <div class="map_inn cont_sw cont_sw_1">
						<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2249.3812026438604!2d37.54879895146862!3d55.68235998043904!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x46b54cec3d82329b%3A0xb44f9f012e12e655!2z0YPQuy4g0JLQsNCy0LjQu9C-0LLQsCwgNjkvNzUsINCc0L7RgdC60LLQsCwgMTE3MzM1!5e0!3m2!1sru!2sru!4v1452853496148" width="100%" height="100%" frameborder="0" style="border:0" allowfullscreen></iframe>
                    </div>

                    <!--<div class="map_inn cont_sw cont_sw_2">
						<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2249.3812026438604!2d37.54879895146862!3d55.68235998043904!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x46b54cec3d82329b%3A0xb44f9f012e12e655!2z0YPQuy4g0JLQsNCy0LjQu9C-0LLQsCwgNjkvNzUsINCc0L7RgdC60LLQsCwgMTE3MzM1!5e0!3m2!1sru!2sru!4v1452853496148" width="100%" height="100%" frameborder="0" style="border:0" allowfullscreen></iframe>
                    </div>-->
                </div>

                <div class="txt cont_sw cont_sw_1">

			<p>Вы можете самостоятельно забрать свой заказ в showroom <strong>MonParis</strong>.
			Преимуществом такого подхода является не только и не столько отсутствие платы за доставку. 
			Главное, что посетив наш showroom, Вы можете заодно ознакомиться с нашим огромным ассортиментом и уточнить свой выбор.
			Напоминаем, что для удобства наших клиентов офис компании <strong>MonParis</strong> работает ежедневно, чтобы Вы могли забрать Ваш заказ в удобное Вам время.
			</p>


                </div>

                <!--<div class="txt cont_sw cont_sw_2">

                    <p>Описание как проехать на машине</p>

                </div>-->

            </div>
        </div>

<?php
	include_once ("bottom.tpl");
?> 
