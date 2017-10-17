<?php
	$strTitle = "ОФОРМЛЕНИЕ ЗАКАЗА";

	include_once ("init.tpl");

	$make_order = 1;
	$main = 0;

	if ($cart->get_count() <= 0)
	{
		header('Location: /');
		exit();
	}
	
	include_once ("top.tpl");
	
	if (User::isAuthorized())
	{
		$query = "SELECT Login, Surname, FirstName, FatherName, Region, Phone, Address FROM `MP_USER` WHERE UserID=".User::getUserID()." LIMIT 1";
		$sql = mysql_query($query) or die(mysql_error());
		if (mysql_num_rows($sql) == 1)
		{
			$row = mysql_fetch_assoc($sql);
			$surname = $row['Surname'];
			$firstname = $row['FirstName'];
			$fathername = $row['FatherName'];
			$region = $row['Region'];
			$phone = $row['Phone'];
			$address = $row['Address'];
			$email = $row['Login'];
		
			if ($email == 'modaopt1@gmail.com')
			{
				$surname = '';
				$firstname = '';
				$fathername = '';
				$region = '';
				$phone = '';
				$address = '';
				$email = '';
			}
		}
		mysql_free_result($sql);
	}
?>

        <div class="clearfix"></div>

        <ul class="breadcrambs">
            <li><a href="/">Главная</a></li>
            <li><a href="/cart.php">Корзина</a></li>
            <li>Оформление заказа</li>
        </ul>
    </div>


    <div class="cart_list_out">

        <div class="title_points cart_list_title"><span>ОФОРМЛЕНИЕ ЗАКАЗА</span></div>

        <div class="cart_list_form_out">

            <div class="container">

                <div class="cart_list_form_out2">

					<form class="form-signin ajax2" method="post" id = "send_order" action="/send_order.php">
						<script src="/js/verify.js" type="text/javascript"></script>
						<div class="main-error alert alert-danger hidden"></div>
						<div class="block contacts_out">
							<h5>1. Ваши контактные данные:</h5>
							<div class="block_inn">
								<div class="inp_bl">
									<label for="f_addr_statat">Фамилия</label>
									<div class="form-group req"><!--has-error-->
										<input name = "user_fio1" id = "user_fio1" type="text" class="form-control fital" maxlength=40 placeholder="" value="<?php echo $surname ?>">
									</div>
								</div>
								<div class="inp_bl">
									<label for="f_addr_statat">Имя</label>
									<div class="form-group req">
										<input name = "user_fio2" id = "user_fio2" type="text" class="form-control fital" maxlength=40 placeholder="" value="<?php echo $firstname ?>">
									</div>
								</div>
								<div class="inp_bl">
									<label for="f_addr_statat">Отчество</label>
									<div class="form-group">
										<input name = "user_fio3" id = "user_fio3" type="text" class="form-control fital" maxlength=40 placeholder="" value="<?php echo $fathername ?>">
									</div>
								</div>

								<div class="inp_bl">
									<label for="f_addr_statat">Ваш e-mail</label>
									<div class="form-group req">
										<input name = "user_email" id = "user_email" type="text" class="form-control fital" maxlength=32 placeholder="" value="<?php echo $email ?>">
									</div>
								</div>
								<div class="inp_bl">
									<label for="f_addr_statat">Контактный телефон</label>
									<div class="form-group req">
										<input name = "user_tel1" id = "user_tel1" type="text" class="form-control fital" maxlength=32 placeholder="" value="<?php echo $phone ?>">
									</div>
								</div>
							</div>
						</div>

						<div class="block contacts_out">
							<h5>1. Желаемый размер:</h5>
							<div class="block_inn">
								<div class="inp_bl">
									<label for="f_addr_statat">Объем груди (см)</label>
									<div class="form-group">
										<input name = "user_size_og" type="text" class="form-control fital" maxlength=5 placeholder="">
									</div>
								</div>
								<div class="inp_bl">
									<label for="f_addr_statat">Объем бедер (см)</label>
									<div class="form-group">
										<input name = "user_size_ob" type="text" class="form-control fital" maxlength=5 placeholder="">
									</div>
								</div>
								<div class="inp_bl">
									<label for="f_addr_statat">Объем талии (см)</label>
									<div class="form-group">
										<input name = "user_size_ot" type="text" class="form-control fital" maxlength=5 placeholder="">
									</div>
								</div>
							</div>
						</div>

						<div class="block delivery_out">
							<h5>2. Выбор способа доставки:</h5>
							<div class="block_inn">
								<input name="user_delivery" id="f_delivery" type="hidden" value="1">
								<!--<div class="title">Способ оплаты:</div>-->
								<div class="radio">

									<a href="#" class="item sel" data-val="1">
										<span class="stitle"><span>Доставка по Москве 350 руб.</span></span>
										<span class="ico ico_cart_deliv_1"></span>
										<span class="stat">Moscow</span>
										<span class="rad"></span>
									</a>

									<a href="#" class="item" data-val="2">
										<span class="stitle"><span>Доставка по России</span></span>
										<span class="ico ico_cart_deliv_1"></span>
										<span class="stat">Russia</span>
										<span class="rad"></span>
									</a>

									<a href="#" class="item" data-val="4">
										<span class="stitle"><span>Международная доставка</span></span>
										<span class="ico ico_cart_deliv_1"></span>
										<span class="stat">World</span>
										<span class="rad"></span>
									</a>

									<a href="#" class="item" data-val="3">
										<span class="stitle"><span>Самовывоз</span></span>
										<span class="ico ico_cart_deliv_2"></span>
										<span class="stat">&nbsp;</span>
										<span class="rad"></span>
									</a>
								</div>

							</div>
						</div>


						<div class="block address_out">
							<h5>3. Адрес доставки:</h5>
							<div class="block_inn">

								<div class="inp_bl">
									<label for="f_addr_statat">Регион</label>
									<div class="form-group">
										<select name="user_region" size="1" class="form-control fital" id = "user_region">
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
											<option value="Еврейская авт. область">Еврейская авт. область</option>
											<option value="Ивановская область">Ивановская область</option>
											<option value="Ингушетия респ.">Ингушетия респ.</option>
											<option value="Иркутская область">Иркутская область</option>
											<option value="Кабардино-Балкарская респ.">Кабардино-Балкарская респ.</option>
											<option value="Калининградская область">Калининградская область</option>
											<option value="Калмыкия респ.">Калмыкия респ.</option>
											<option value="Калужская область">Калужская область</option>
											<option value="Камчатская область">Камчатская область</option>
											<option value="Карачаево-Черкесская респ.">Карачаево-Черкесская респ.</option>
											<option value="Карелия респ.">Карелия респ.</option>
											<option value="Кемеровская область">Кемеровская область</option>
											<option value="Кировская область">Кировская область</option>
											<option value="Коми респ.">Коми респ.</option>
											<option value="Костромская область">Костромская область</option>
											<option value="Краснодарский край">Краснодарский край</option>
											<option value="Красноярский край">Красноярский край</option>
											<option value="Курганская область">Курганская область</option>
											<option value="Курская область">Курская область</option>
											<option value="Ленинградская область">Ленинградская область</option>
											<option value="Липецкая область">Липецкая область</option>
											<option value="Магаданская область">Магаданская область</option>
											<option value="Марий Эл респ.">Марий Эл респ.</option>
											<option value="Мордовия респ.">Мордовия респ.</option>
											<option value="Мурманская область">Мурманская область</option>
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
											<option value="Респ. Казахстан">Респ. Казахстан</option>
											<option value="Ростовская область">Ростовская область</option>
											<option value="Рязанская область">Рязанская область</option>
											<option value="Самарская область">Самарская область</option>
											<option value="Санкт-Петербург">Санкт-Петербург</option>
											<option value="Саратовская область">Саратовская область</option>
											<option value="Саха (Якутия) респ.">Саха (Якутия) респ.</option>
											<option value="Сахалинская область">Сахалинская область</option>
											<option value="Свердловская область">Свердловская область</option>
											<option value="Северная Осетия-Алания респ.">Северная Осетия-Алания респ.</option>
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
											<option value="Челябинская область">Челябинская область</option>
											<option value="Чеченская респ.">Чеченская респ.</option>
											<option value="Читинская область">Читинская область</option>
											<option value="Чувашская респ.">Чувашская респ.</option>
											<option value="Чукотский авт. окр.">Чукотский авт. окр.</option>
											<option value="Ярославская область">Ярославская область</option>
											<option value="Ямало-Ненецкий АО">Ямало-Ненецкий АО</option>
										</select>
									</div>
								</div>

								<div class="inp_bl">
									<label for="f_addr_statat">Адрес доставки</label>
									<div class="form-group">
										<textarea name="user_city" class="form-control fital" maxlength=512><?php echo $address ?></textarea>
									</div>
								</div>

								<div class="inp_bl">
									<label for="f_addr_statat">Комментарий</label>
									<div class="form-group">
										<textarea name="user_comment" class="form-control fital" maxlength=256></textarea>
									</div>
								</div>
							</div>
						</div>

						<div class="clearfix"></div>
						<div class="check_oferta_out">
							<div class="checkbox check_oferta">
								<label><input type="checkbox" id="approve_agreement" name="approve_agreement" checked> С условиями оферты согласен(на)</label>
							</div>
						</div>
						<div class="clearfix"></div>

						<div class="cart_list_order">
							<input type="hidden" name="act" value="make_order">
							<button style = 'float:right;' class='form_butt_2' name='my-send-order-button' onclick="javascript:verifyFields();" type='button' value=' '><span>ПОДТВЕРДИТЬ ЗАКАЗ</span></button>
						</div>
					</form>

                </div>
            </div>
        </div>


    </div>

<?php
	include_once ("bottom.tpl");
?> 
