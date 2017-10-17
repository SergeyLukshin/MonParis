<?php
	$strTitle = "КОНТАКТЫ";
	$contacts_page = 1;
	include_once ("top.tpl");
?>

        <div class="clearfix"></div>

        <ul class="breadcrambs">
            <li><a href="/">Главная</a></li>
            <li>Контакты</li>
        </ul>


        <div class="contacts_out">

            <div class="title_points"><span>КОНТАКТЫ</span></div>

            <div class="contacts_inn" >
                <div class="addr_1" itemscope itemtype="http://schema.org/LocalBusiness">
					<span itemprop="name" style="display:none;">Mon-Paris.ru</span>
					<!-- Адрес КАК ПРОЙТИ ПЕШКОМ -->
                    <div class="item cont_sw cont_sw_1" itemprop="address" itemscope itemtype="http://schema.org/PostalAddress">
                        <div class="title">Наш адрес:<div class="ico ico_addr"></div></div>
                        <span itemprop="postalCode">117997</span>, <span itemprop="addressLocality">Москва</span>, <span itemprop="streetAddress">ул.Вавилова, 69/75, оф. 809</span>
                    </div>

                    <!-- Адрес КАК ПРОЕХАТЬ НА МАШИНЕ -->
                    <div class="item cont_sw cont_sw_2">
                        <div class="title">Наш адрес:<div class="ico ico_addr"></div></div>
                        Адрес как проехать на машине
                    </div>
                    
                    <div class="item">
                        <div class="title">Часы работы:<div class="ico ico_time"></div></div>
                        <time itemprop="openingHours" datetime="Mo-Sa 09:30-19:00, Su 09:30-18:00">Понедельник - суббота: с 9.30 до 19.00<br>
                        Воскресенье: с 10.00 до 18.00</time>
                    </div>

                    <div class="item">
                        <div class="title">Наша почта:<div class="ico ico_email"></div></div>
                        <span itemprop="email">modaopt@gmail.com</span>
                    </div>

                    <div class="item">
                        <div class="title">Наши контакты:<div class="ico ico_phone"></div></div>
                        Многоканальный: &nbsp; <span itemprop="telephone">+7-(495)-518-91-65</span><br>
                        Телефон/факс: &nbsp; <span itemprop="faxNumber">+7-(499)-132-49-81</span><br>
                        Мобильный Билайн: &nbsp; <span itemprop="telephone">+7-(968)-827-33-87</span>
                    </div>

                    <div class="item">
                        <div class="title">Мы в соц.сети:</div>
                        <div class="soc">
                            <a class="tw" href="#"></a>
                            <a class="gp" href="#"></a>
                            <a class="in" href="#"></a>
                            <a class="fb" href="#"></a>
                        </div>
                    </div>

                </div>

                <div class="map_bl">

                    <!--<div class="links">
                        <div class="links_out">
                            <a class="hd_tp_butt cont_sw_butt" data-target="2" href="#"><span>КАК ПРОЕХАТЬ НА МАШИНЕ</span></a>
                        </div>

                        <div class="links_out">
                            <a class="hd_tp_butt cont_sw_butt" data-target="1" href="#"><span>КАК ПРОЙТИ ПЕШКОМ</span></a>
                        </div>

                    </div>-->
                    
                    <!-- Карта КАК ПРОЙТИ ПЕШКОМ -->
                    <div class="map_inn cont_sw cont_sw_1">
						<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2249.3812026438604!2d37.54879895146862!3d55.68235998043904!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x46b54cec3d82329b%3A0xb44f9f012e12e655!2z0YPQuy4g0JLQsNCy0LjQu9C-0LLQsCwgNjkvNzUsINCc0L7RgdC60LLQsCwgMTE3MzM1!5e0!3m2!1sru!2sru!4v1452853496148" width="100%" height="100%" frameborder="0" style="border:0" allowfullscreen></iframe>
                    </div>

                    <!-- Карта КАК ПРОЕХАТЬ НА МАШИНЕ -->
                    <!--<div class="map_inn cont_sw cont_sw_2">
						<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2249.3812026438604!2d37.54879895146862!3d55.68235998043904!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x46b54cec3d82329b%3A0xb44f9f012e12e655!2z0YPQuy4g0JLQsNCy0LjQu9C-0LLQsCwgNjkvNzUsINCc0L7RgdC60LLQsCwgMTE3MzM1!5e0!3m2!1sru!2sru!4v1452853496148" width="100%" height="100%" frameborder="0" style="border:0" allowfullscreen></iframe>
                    </div>-->
                    
                    <!--<div class="map_inn">
						<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2249.3812026438604!2d37.54879895146862!3d55.68235998043904!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x46b54cec3d82329b%3A0xb44f9f012e12e655!2z0YPQuy4g0JLQsNCy0LjQu9C-0LLQsCwgNjkvNzUsINCc0L7RgdC60LLQsCwgMTE3MzM1!5e0!3m2!1sru!2sru!4v1452853496148" width="100%" height="100%" frameborder="0" style="border:0" allowfullscreen></iframe>
                    </div>-->
                </div>

                <!--<div class="addr_2">
                    <div class="title">Наши реквизиты:<a target="_blank" href="/contacts_rekv.html"><span>Распечатать реквизиты</span></a></div>
					<br><div class="title"></a></div>
					
                    <table>
                        <tr>
                            <td>
                            <p>ООО “БонПари”</p>

                                <p>Юр.Адрес:<br>
                                115 054 г.Москва, ул.Воловая, д.31</p>

                                <p>Факт. адрес:<br>
                                115 184 г.Москва, Большой Овчинниковский пер., д. 16</p>

                                <p>ИНН:<br>
                                7705870870</p>

                                <p>КПП:<br>
                                770501001</p>
								
                            </td>
                            <td>
                                <p>ОКПО:<br>
                                18865829</p>

                                <p>ОГРН:<br>
                                311774604602002</p>

                                <p>ОКАТО:<br>
                                45286560000</p>

                                <p>Банк:<br>
                                АО “Альфа-Банк”</p>

                                <p>Расч.счёт:<br>
                                A0A9A0S99D0A9009087</p>

                                <p>Кор.счёт:<br>
                                A0A9A0S99D0A9009087</p>
								
                            </td>
                        </tr>
                    </table>
                </div>-->
                <div class="addr_3">
					<!-- Ссылка и описание КАК ПРОЙТИ ПЕШКОМ -->
                    <div class="cont_sw cont_sw_1">
                        <div class="title">&nbsp;<a target="_blank" href="contacts_map.html"><span>Распечатать карту проезда и контактные данные</span></a></div>
						
						<p> 
						От М. <b>Профсоюзная:</b> <br>Последний вагон из центра выход налево. Автобус: 130, 67, 153 (2 остановки) Тролейбус: 49 (2 остановки) Маршрутка: 130, 67, 153, 49, 52 <br>
						До остановки «Черёмушкинский рынок» или 900 м пешком. Напротив рынка 10 этажное стеклянное здание (внизу казино). Офис расположен на 8-м этаже в 1-м подъезде
						</p>
						<p>
						От М. <b>Университет:</b> <br>Выход в центре зала к театру «Армена Джигарханьяна» Автобус: 103, 130, 67 Тролейбус: 49, Трамвай: 39, 14, 26, 26к До остановки «Черёмушкинский рынок»
						</p>


						
						
                    </div>

                    <!-- Ссылка и описание КАК ПРОЕХАТЬ НА МАШИНЕ -->
                    <!--<div class="cont_sw cont_sw_2">
                        <div class="title">&nbsp;<a target="_blank" href="contacts_map_auto.html"><span>Распечатать карту проезда и контактные данные</span></a></div>
                        Описание как как проехать на машине
                    </div>-->
                </div>
            </div>
            <div class="max_wd_991"></div>
        </div>


<?php
	include_once ("bottom.tpl");
?> 
