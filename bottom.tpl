<!-- bottom -->

<?php
			if ($catalog != 1 && $detail != 1 && $basket != 1 && $make_order != 1) echo "</div>";
?>
</div>

<div class="footer">
    <div class="container">
        <div class="footer_inn" itemscope itemtype="https://schema.org/LocalBusiness">
			<span itemprop="name" style="display:none;">Mon-Paris.ru</span>
            <div class="col_12">
                <div class="cols col_1">
                    <div class="col_1_s">
                        <div class="title">Мы в соц.сети:</div>
                        <div class="soc">
                            <a class="tw" href="#"></a>
                            <a class="gp" href="#"></a>
                            <a class="in" href="#"></a>
                            <a class="fb" href="https://facebook.com/moscowtradeoffice"></a>
                        </div>
                    </div>
                    <div class="col_1_k">
                        <div class="title">Наши контакты:</div>
                        <div>Многоканальный: <div><span itemprop="telephone">+7-(495)-518-91-65</span></div></div>
                        <div>Телефон/факс: <div><span itemprop="faxNumber">+7-(499)-132-49-81</span></div></div>
                        <div>Мобильный Билайн: <div><span itemprop="telephone">+7-(968)-827-33-87</span></div></div>
                    </div>
                </div>
                <div class="clearfix clear_cols"></div>
                <div class="clearfix clear_cols"></div>
                <div class="cols col_2">
                    <div class="col_1_a"  itemprop="address" itemscope itemtype="https://schema.org/PostalAddress">
                        <div class="title">Наши адреса:</div>
                        <span itemprop="postalCode">117997</span>, <span itemprop="addressLocality">Москва</span>, <span itemprop="streetAddress">ул.Вавилова, 69/75, оф. 809</span>
                    </div>
                    <div class="col_1_t">
                        <div class="title">Часы работы:</div>
                        <time itemprop="openingHours" datetime="Mo-Sa 09:30-19:00, Su 09:30-18:00">Понедельник - суббота: с 9.30 до 19.00<br>
                        Воскресенье: выходной</time>
                    </div>
                </div>
            </div>
            <div class="cols col_3">
                <div class="map">
					<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2249.3812026438604!2d37.54879895146862!3d55.68235998043904!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x46b54cec3d82329b%3A0xb44f9f012e12e655!2z0YPQuy4g0JLQsNCy0LjQu9C-0LLQsCwgNjkvNzUsINCc0L7RgdC60LLQsCwgMTE3MzM1!5e0!3m2!1sru!2sru!4v1452853496148" width="100%" height="100%" frameborder="0" style="border:0" allowfullscreen></iframe>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="modal_feedback_2" class="modal modal_feedback" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <a class="closew" data-dismiss="modal" href="#"></a>

                <h2>ОПЛАТИТЬ ДОСТАВКУ</h2>

                <div class="clearfix"></div>

				<form id="pay" method="POST" action="https://money.yandex.ru/eshop.xml" target="_blank">
				<!--<form class="form-signin ajax" method="post" action="/ajax.php">-->
					<div class="main-error alert alert-danger hidden"></div>
<?php
					echo "<input type=\"hidden\" name=\"shopId\" value=\"75687\">";
					echo "<input type=\"hidden\" name=\"scid\" value=\"70538\">";
					echo "<input type=\"hidden\" name=\"cps_phone\" value=\"".User::getUserPhone()."\">";
					echo "<input type=\"hidden\" name=\"customerNumber\" value=\"".User::getUserLogin()."\">";
					echo "<input name=\"paymentType\" value=\"\" type=\"hidden\"/>";
					echo "<input type=\"hidden\" name=\"custName\" value=\"".User::getUserName()."\">";
					echo "<input type=\"hidden\" name=\"custEmail\" value=\"".User::getUserLogin()."\">";
?>
					<div class="form-group">
						<input type="text" class="form-control" name="orderNumber" id="orderNumber" placeholder="Номер заказа" maxlength="10">
					</div>

					<div class="form-group">
						<input type="text" class="form-control" name="sum" id="sum" placeholder="Стоимость доставки"  maxlength="10">
					</div>

					<input type="hidden" name="act" value="pay">
					<button class="form_butt_2" id="pay_btn" name="" form="pay" value="send_form"><span>оплатить</span></button>

					<div class="clearfix"></div>
				</form>
            </div>
        </div>
    </div>
</div>

<div id="modal_feedback_1" class="modal modal_feedback" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <a class="closew" data-dismiss="modal" href="#"></a>

                <h2>ФОРМА ОБРАТНОЙ СВЯЗИ</h2>

                <div class="clearfix"></div>

                <form class="form-signin ajax" method="post" action="/ajax.php">
					<div class="main-error alert alert-danger hidden"></div>

                    <div class="form-group">
                        <input type="text" class="form-control" name="username" id="username" placeholder="Имя">
                    </div>

                    <div class="form-group">
                        <input type="text" class="form-control" name="email" id="email" placeholder="Почта">
                    </div>

                    <div class="form-group">
                        <input type="text" class="form-control" name="phone" id="phone" placeholder="Телефон">
                    </div>

                    <div class="form-group">
                        <textarea class="form-control" placeholder="Сообщение" name="msg" id="msg"></textarea>
                    </div>

                    <div class="captch"><div class = "recaptcha1" id = "recaptcha1"></div></div>

					<input type="hidden" name="act" value="message">
                    <button class="form_butt_2" name="send" type="submit" value="send_form"><span>отправить</span></button>

                </form>

                <div class="clearfix"></div>
            </div>
        </div>
    </div>
</div>

<!-- bottom -->

<!-- auth -->

<div id="modal_reg" class="modal modal_feedback" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <a class="closew" data-dismiss="modal" href="#"></a>

                <h2>РЕГИСТРАЦИЯ</h2>

                <div class="clearfix"></div>

                <form class="form-signin ajax" method="post" action="/ajax.php">
					<div class="main-error alert alert-danger hidden"></div>
		
                    <div class="form-group">
                        <input type="text" class="form-control" name="username" id="username" placeholder="Логин (e-mail)">
                    </div>

                    <div class="form-group">
                        <input type="password" class="form-control" name="password1" id="password1" placeholder="Пароль">
                    </div>

                    <div class="form-group">
                        <input type="password" class="form-control" name="password2" id="password2" placeholder="Подтвердить пароль">
                    </div>

					<div class="ch_list">
						<h5>Данные пользователя</h5>

						<div class="form-group">
							<input type="text" class="form-control" name="user_fio1" id="user_fio1" placeholder="Имя">
						</div>

						<div class="form-group">
							<input type="text" class="form-control" name="user_fio2" id="user_fio2" placeholder="Фамилия">
						</div>

						<div class="form-group">
							<input type="text" class="form-control" name="user_fio3" id="user_fio3" placeholder="Отчество">
						</div>

						<div class="form-group">
							<input type="text" class="form-control" name="user_tel" id="user_tel" placeholder="Контактный номер телефона">
						</div>

						<div class="region_select">
							<select class="selectpicker" data-width="100%" title='Регион' name="user_region" id="user_region">
								<option value="Москва" selected>Москва</option>
									<option value="Московская область">Московская область</option>
									<option value="Адыгея респ.">Адыгея респ.</option>
									<option value="Алтай респ.">Алтай респ.</option>
									<option value="Алтайский край">Алтайский край</option>
									<option value="Амурская область">Амурская область</option>
									<option value="Архангельская область">Архангельская область</option>
									<option value="Астраханская область">Астраханская область</option>
									<option value="Байконур">Байконур</option>
									<option value="Башкортостан респ.">Башкортостан респ.</option>
									<option value="Белгородская область">Белгородская область</option>
									<option value="Брянская область">Брянская область</option>
									<option value="Бурятия респ.">Бурятия респ.</option>
									<option value="Владимирская область">Владимирская область</option>
									<option value="Волгоградская область">Волгоградская область</option>
									<option value="Вологодская область">Вологодская область</option>
									<option value="Воронежская область">Воронежская область</option>
									<option value="Дагестан респ.">Дагестан респ.</option>
									<option value="Еврейская автономная область">Еврейская автономная область</option>
									<option value="Забайкальский край">Забайкальский край</option>
									<option value="Ивановская область">Ивановская область</option>
									<option value="Ингушетия респ.">Ингушетия респ.</option>
									<option value="Иркутская область">Иркутская область</option>
									<option value="Кабардино-Балкарская Республика">Кабардино-Балкарская Республика</option>
									<option value="Калининградская область">Калининградская область</option>
									<option value="Калмыкия респ.">Калмыкия респ.</option>
									<option value="Калужская область">Калужская область</option>
									<option value="Камчатский край">Камчатский край</option>
									<option value="Карачаево-Черкесская Республика">Карачаево-Черкесская Республика</option>
									<option value="Карелия респ.">Карелия респ.</option>
									<option value="Кемеровская область">Кемеровская область</option>
									<option value="Кировская область">Кировская область</option>
									<option value="Коми респ.">Коми респ.</option>
									<option value="Костромская область">Костромская область</option>
									<option value="Краснодарский край">Краснодарский край</option>
									<option value="Красноярский край">Красноярский край</option>
									<option value="Крым респ.">Крым респ.</option>
									<option value="Курганская область">Курганская область</option>
									<option value="Курская область">Курская область</option>
									<option value="Ленинградская область">Ленинградская область</option>
									<option value="Липецкая область">Липецкая область</option>
									<option value="Магаданская область">Магаданская область</option>
									<option value="Марий Эл респ.">Марий Эл респ.</option>
									<option value="Мордовия респ.">Мордовия респ.</option>
									<option value="Мурманская область">Мурманская область</option>
									<option value="Ненецкий автономный округ">Ненецкий автономный округ</option>
									<option value="Нижегородская область">Нижегородская область</option>
									<option value="Новгородская область">Новгородская область</option>
									<option value="Новосибирская область">Новосибирская область</option>
									<option value="Омская область">Омская область</option>
									<option value="Оренбургская область">Оренбургская область</option>
									<option value="Орловская область">Орловская область</option>
									<option value="Пензенская область">Пензенская область</option>
									<option value="Пермский край">Пермский край</option>
									<option value="Приморский край">Приморский край</option>
									<option value="Псковская область">Псковская область</option>
									<option value="Ростовская область">Ростовская область</option>
									<option value="Рязанская область">Рязанская область</option>
									<option value="Самарская область">Самарская область</option>
									<option value="Санкт-Петербург">Санкт-Петербург</option>
									<option value="Саратовская область">Саратовская область</option>
									<option value="Саха (Якутия) респ.">Саха (Якутия) респ.</option>
									<option value="Сахалинская область">Сахалинская область</option>
									<option value="Свердловская область">Свердловская область</option>
									<option value="Севастополь">Севастополь</option>
									<option value="Северная Осетия - Алания респ.">Северная Осетия - Алания респ.</option>
									<option value="Смоленская область">Смоленская область</option>
									<option value="Ставропольский край">Ставропольский край</option>
									<option value="Тамбовская область">Тамбовская область</option>
									<option value="Татарстан респ.">Татарстан респ.</option>
									<option value="Тверская область">Тверская область</option>
									<option value="Томская область">Томская область</option>
									<option value="Тульская область">Тульская область</option>
									<option value="Тыва респ.">Тыва респ.</option>
									<option value="Тюменская область">Тюменская область</option>
									<option value="Удмуртская респ.">Удмуртская респ.</option>
									<option value="Ульяновская область">Ульяновская область</option>
									<option value="Хабаровский край">Хабаровский край</option>
									<option value="Хакасия респ.">Хакасия респ.</option>
									<option value="Ханты-Мансийский автономный округ - Югра">Ханты-Мансийский автономный округ - Югра</option>
									<option value="Челябинская область">Челябинская область</option>
									<option value="Чеченская респ.">Чеченская респ.</option>
									<option value="Чувашская респ.">Чувашская респ.</option>
									<option value="Чукотский автономный округ">Чукотский автономный округ</option>
									<option value="Ямало-Ненецкий автономный округ">Ямало-Ненецкий автономный округ</option>
									<option value="Ярославская область">Ярославская область</option>
							</select>
						</div>

						<div class="clearfix"></div>

						<div class="form-group">
							<textarea class="form-control" name="user_address" id="user_address" placeholder="Адрес доставки"></textarea>
						</div>

						<div class="form-group">
							<input type="checkbox" class="pretty_checkb" value="1" name="user_wholesale" id ="user_wholesale"/>
							<label for="user_wholesale">Оптовый покупатель</label>
						</div>
					</div>

<!--
					<div style='display:none' id='wholesale_info'>
?php
						$i = 0;
						$cnt = sizeof($vec_brand);
						reset($vec_brand);
						echo "<input type='hidden' name='brand_cnt' value='".$cnt."' />";
?>
						<div class="ch_list">
							<h5>Бренды</h5>
							
							
?php
						foreach ($vec_brand as $key => $value) 
						{
							echo "<input type='hidden' name='user_brand_val".$i."' id='user_brand_val".$i."' value='".$value."' />";
							$i = $i + 1;
						}
?>							
							
							<ul>
								<li>
									<ul>
?php										
						$half = $cnt / 2;
						reset($vec_brand);
						$i = 0;
						foreach ($vec_brand as $key => $value) 
						{
							echo "<li><input type='checkbox' class='pretty_checkb' value='".$i."' name='user_brand".$i."' id='user_brand".$i."' /><label for='user_brand".$i."'>".$value."</label></li>";
							$i = $i + 1;
							
							if ($i > $half && $i > 5)
							{
								echo "</ul></li><li><ul>";
								$half = 0;
							}
						}
?>
										<li class="ch_all"><input type="checkbox" class="pretty_checkb" value="" name="ch_all_1" id="ch_all_1" /><label for="ch_all_1">ВЫБРАТЬ ВСЕ</label></li>
									</ul>
								</li>
							</ul>
						</div>
?php
						$i = 0;
						$cnt = sizeof($vec_category);
						reset($vec_category);
						echo "<input type='hidden' name='cat_cnt' value='".$cnt."' />";*/
?>
						<div class="ch_list">
							<h5>Категория товаров</h5>
?php
						foreach ($vec_category as $key => $value) 
						{
							echo "<input type='hidden' name='user_cat_val".$i."' id='user_cat_val".$i."' value='".$value."' />";
							$i = $i + 1;
						}
?>	

							<ul>
								<li>
									<ul>
?php										
						$half = $cnt / 2;
						reset($vec_category);
						$i = 0;
						foreach ($vec_category as $key => $value) 
						{
							echo "<li><input type='checkbox' class='pretty_checkb' value='".$i."' name='user_cat".$i."' id='user_cat".$i."' /><label for='user_cat".$i."'>".$value."</label></li>";
							$i = $i + 1;
							
							if ($i > $half && $i > 5)
							{
								echo "</ul></li><li><ul>";
								$half = 0;
							}
						}
?>										
										<li class="ch_all"><input type="checkbox" class="pretty_checkb" value="" name="ch_all_1" id="ch_all_2" /><label for="ch_all_2">ВЫБРАТЬ ВСЕ</label></li>
									</ul>
								</li>
							</ul>
						</div>


						<div class="ch_list">
							<h5>Размеры товаров</h5>

							<input type='hidden' name='user_size_val1' id='user_size_val1' value='Большие' />
							<input type='hidden' name='user_size_val2' id='user_size_val2' value='Средние' />
							<input type='hidden' name='user_size_val3' id='user_size_val3' value='Маленькие' />

							<ul>
								<li>
									<ul>
										<li><input type="checkbox" class="pretty_checkb" value="1" name="user_size1" id="user_size1" /><label for="user_size1">Большие</label></li>
										<li><input type="checkbox" class="pretty_checkb" value="2" name="user_size2" id="user_size2" /><label for="user_size2">Средние</label></li>
									</ul>
								</li>
								<li>
									 <ul>
										<li><input type="checkbox" class="pretty_checkb" value="11" name="user_size3" id="user_size3" /><label for="user_size3">Маленькие</label></li>
									</ul>
								</li>
							</ul>
						</div>
					</div>
-->

                    <div class="captch"><div class = "recaptcha2" id = "recaptcha2"></div></div>
                    
					<div style="float: left;width: 100%; text-align: left;">
						<input type="checkbox" class="pretty_checkb" name="user_agree_delivery" id ="user_agree_delivery" class="checkbox" checked /><label for="user_agree_delivery">Я согласен(-сна) получать рассылку</label>
					</div>

					<div style="float: left;width: 100%; text-align: center;">
						<input type="hidden" name="act" value="register">
						<button class="form_butt_2" name="send" type="submit" value="send_form" style="text-align: right;"><span>отправить</span></button>
					</div>

                </form>

                <div class="clearfix"></div>
            </div>
        </div>
    </div>
</div>




<div id="modal_ent" class="modal modal_feedback modal_ent" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <a class="closew" data-dismiss="modal" href="#"></a>

                <h2>АВТОРИЗАЦИЯ</h2>

                <div class="clearfix"></div>

                <form class="form-signin ajax" method="post" action="/ajax.php">
					<div class="main-error alert alert-danger hidden"></div>
					
                    <div class="form-group">
                        <input name="username" type="text" class="form-control" placeholder="Логин (e-mail)">
                    </div>

                    <div class="form-group">
                        <input name="password" type="password" class="form-control" placeholder="Пароль">
                    </div>

                    <input type="checkbox" class="pretty_checkb" value="1" name="remember-me" id="memb_my" /><label for="memb_my">Запомнить меня</label>


                    <div class="clearfix"></div>
                    <br>
                    <!--<div class="captch">код каптчи</div>-->
                    <div style="float: left;width: 100%; text-align: center;">
						<input type="hidden" name="act" value="login">
                        <button style="display: -moz-inline-box;display: inline-block; float: none; text-align: center; min-width: 120px;" class="form_butt_2" name="send" type="submit" value="send_form"><span>Войти</span></button>
                    </div>


                </form>

                <div class="clearfix"></div>
            </div>
        </div>
    </div>
</div>

<?php

if ($main != 0)
{
	if ($cnt_news > 0)
	{
		echo <<< END_NEWS
<div id="modal_news" class="modal modal_feedback modal_news" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <a class="closew" data-dismiss="modal" href="#"></a>

                <h2>НОВОСТИ</h2>

                <div class="clearfix"></div>
END_NEWS;
				reset ($news);
				foreach ($news as $key => $value)
				{
					echo "<div class='form-group_news'>".$value."</div>";
				}
		echo <<< END_NEWS
                <div style="float: left;width: 100%; text-align: center;">
                    <button style="display: -moz-inline-box;display: inline-block; float: none; text-align: center; min-width: 120px;" class="form_butt_2" name="send" type="button" data-dismiss="modal"><span>Закрыть</span></button>
                </div>

                <div class="clearfix"></div>
            </div>
        </div>
    </div>
</div>
END_NEWS;
	}
}

?>


<!-- auth -->


<!-- Bootstrap core JavaScript
================================================== -->

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script src="/js/bootstrap-select.js"></script>
<script src="/js/flexslider2/jquery.flexslider.js"></script>
<script src="/js/flexslider2/setting.js"></script>
<script src="/js/slick/slick.min.js"></script>
<script src="/js/prettyCheckable/prettyCheckable.min.js"></script>
<script src="/js/jquery.mCustomScrollbar.js"></script>
<?php
	if ($detail != 0)
	{
echo <<< END2
		<script src="/js/jquery.fancybox/jquery.fancybox.js"></script>
		<script src="/js/zoomsl-3.0.js"></script>
END2;
	}
?>
<script src="/js/script.js"></script>
<script src="/js/ajax-form.js"></script>
<script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit" async defer></script>
<script src="/js/maskedinput-1.2.2.min.js" type="text/javascript"></script>
<script>
			function isNumeric(value) {
				return /^-{0,1}\d+$/.test(value);
			}

			$('#pay_btn').on('click', function(event) {
				event.preventDefault();
				
				var orderNumber = $('#orderNumber');
				var orderSum = $('#sum');
				var form = $('form#pay');

				if (!$.trim(orderNumber.val()) || !isNumeric(orderNumber.val())) {
					
					var $mainErrorContainer = form.find('.main-error');
					if ($mainErrorContainer.hasClass('hidden')) {
						$mainErrorContainer.removeClass('hidden');
					}
                    $mainErrorContainer.html("Укажите номер заказа").show();
                    $('#modal_feedback_2').scrollTop(0);
                    
					orderNumber.focus();
					$mainErrorContainer.fadeOut(3000);
					
					return;
				}
				
				if (!$.trim(orderSum.val()) || !isNumeric(orderSum.val())) {
					
					var $mainErrorContainer = form.find('.main-error');
					if ($mainErrorContainer.hasClass('hidden')) {
						$mainErrorContainer.removeClass('hidden');
					}
                    $mainErrorContainer.html("Укажите стоимость доставки").show();
                    $('#modal_feedback_2').scrollTop(0);
					orderSum.focus();
					$mainErrorContainer.fadeOut(3000);
					
					return;
				}

				//alert(1);
				$(document).off('submit', 'form#pay');
				form.submit();
			});	
	
            $(document).ready(function() {
				$("#user_tel").mask("+7 (999) ?999999999");
				$("#phone").mask("+7 (999) ?999999999");
				
<?php				
				if ($make_order == 1)
				{
					echo "$(\"#user_tel1\").mask(\"+7 (999) ?999999999\");\n";
					if (User::isAuthorized())
						echo "$(\"#user_region\").val(\"".$region."\");\n";
				}

				if ($detail != 0)
				{
echo <<< END2
					product_color_change();
					/*Config = {
							"item": {
								"allow360X":true,
								"interaction": "mousemove", // "drag"
								"impetus": "true", //"false"
								"containerSelector": ".pro360",
								"autoplay": {"interval": 100, "bounce": false},//frame timeout
								"folder":"/500px/",
								"zoomfolder":"/1000px/",
								"file": function(x,y) {	return pad(72 * y + x, 3) + ".jpg"},	//"000" slice(-3)	
								"type": "rect",
								"startX":1,
								"minX": 1,
								"maxX": 73,
								"startY":0,
								"minY": 0,
								"maxY": 5,
								"width": 320,
								"height": 320,
								"zoomfactor": 3
							}
						}					
					window.item = new PRO360(Config.item);*/
END2;
				}
				
				if ($main != 0 && $cnt_news > 0)
				{
					echo "$('#modal_news').modal('show');";
				}
				
?>
            });
            
</script>

<script>
	$( "#clothers" ).click(function( event ) {
		event.preventDefault();
	});
</script>

<?php
	if ($detail != 0 || $basket != 0)
	{
echo <<< END2
		<script type="text/javascript" src="/jcart/jcart-javascript.full.php"></script>
END2;
	}


	if ($detail != 0)
	{
echo <<< END1
		<script type='text/javascript'>
		/*function product_size_change()
		{
			
			var size_name = $('input[name="size_manuf_sel"]').val();
			var product_id = document.getElementById('productID').value;
			if(!size_name){
					$('div[name="color_sel"]').html('');
			}else{
					$.ajax({
							type: "POST",
							url: "/ajax_get_colors.php",
							data: { action: 'show_colors', size: size_name, product_id: product_id },
							cache: false,
							success: function(responce)
							{ 
								$(".gd_view_out .rg_opt .color_sel .dropdown-menu.inner").mCustomScrollbar("destroy");
								$('.gd_view_out .rg_opt .color_sel .selectpicker2').html(responce);
								//$('select[name="color_sel"]').html(responce); 
								$('.gd_view_out .rg_opt .color_sel .selectpicker2').selectpicker('refresh');
								$(".gd_view_out .rg_opt .color_sel .dropdown-menu.inner").mCustomScrollbar({
									theme:"inset-3-dark"
								});
							}
					});
			};
		}*/
		function product_color_change()
		{
			
			var id_color = $('select[name="color_sel"]').val();
			var product_id = document.getElementById('productID').value;
			//$('div[name="size_sel"]').html('');

			$.ajax({
					type: "POST",
					url: "/ajax_get_colors.php",
					data: { action: 'show_sizes', color: id_color, product_id: product_id },
					cache: false,
					success: function(responce)
					{ 
						$('div[name="size_sel"]').html(responce); 
						
						$('#size_manuf_sel').val($('.gd_view_out .rg_opt .size_manuf_sel a')[0].name);
						
						$('.gd_view_out .rg_opt .size_manuf_sel a').on("click", function(event) {
							$('.gd_view_out .rg_opt .size_manuf_sel a').removeClass('act');

							$(this).addClass('act');

							$('#size_manuf_sel').val($(this)[0].name);
							//product_size_change();

							event.preventDefault();
						});
					}
			});			
		}
		</script>
END1;
	}
?>


<script type="text/javascript">
	var widgetId1;
    var widgetId2;


	var onloadCallback = function() {
		
		mysitekey = '6LeaXBITAAAAAHNffkgFBmtAe2WLP5zxhkRKu8YM';
		widgetId1 = grecaptcha.render('recaptcha1', {
		'sitekey' : mysitekey});
		widgetId2 = grecaptcha.render('recaptcha2', {
		'sitekey' : mysitekey});
	};
	
	var refresh_captcha = function() {
		grecaptcha.reset(widgetId1);
		grecaptcha.reset(widgetId2);
	};
</script>

  </body>
</html>

<?php
	mysql_close();
?>
