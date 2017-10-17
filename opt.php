<?php
	$strTitle = "ОПТОВЫМ ПОКУПАТЕЛЯМ";
	$opt_page = 1;
	include_once ("top.tpl");
?>

        <div class="clearfix"></div>

        <ul class="breadcrambs">
            <li><a href="/">Главная</a></li>
            <li>Оптовым покупателям</li>
        </ul>



        <div class="opt_out">
            <ul class="opt_tabs_nav">
                <li><a class="act" href="/opt.php"><span>ОПТОВЫМ ПОКУПАТЕЛЯМ</span></a></li>
                <li><a href="/samovyvoz.php"><span>САМОВЫВОЗ</span></a></li>
                <li><a href="/delivery.php"><span>ДОСТАВКА</span></a></li>
            </ul>
            <div class="opt_tabs_cont">

                <h2 class="txt_title">Условия и информация касательно оптовых закупок</h2>

                <!--<div class="form">
                    <div class="form_inn">

                        <h5>По вопросам опт. закупок</h5>
                        <div class="clearfix"></div>
                        <form name="form_opt_send" action="?f=1" method="POST">
                            <div class="form-group">
                                <input type="text" class="form-control" placeholder="Ваше имя">
                            </div>
                            <div class="form-group has-error">
                                <input type="text" class="form-control" placeholder="Ваш e-mail">
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" placeholder="Номер телефона">
                            </div>
                            <div class="form-group">
                                <textarea class="form-control" placeholder="Дополнительно"></textarea>
                            </div>
                            <button class="form_butt_1" name="send" type="submit" value="send_form"><span>Отправить</span></button>
                        </form>
                    </div>

                    <div class="reg_ent_bl">
                        <div class="lnk"><a href="#">Регистрация</a></div>
                        <div class="rz"></div>
                        <div class="lnk"><a href="#">Вход</a></div>
                    </div>

                </div> -->

                <div class="txt">

                    <p>Ежедневно специалисты компании <strong>MonParis</strong> работают над тем, чтобы наша женская одежда стала доступной покупательницам во всех регионах России. Поставив во главу угла качество, актуальность коллекций и соответствие стилю жизни российских дам всех возрастов, мы уверены, что женская одежда <strong>MonParis</strong> понравится постоянным клиентам вашего магазина и обеспечит вам рост продаж и приток новых покупателей. Ежедневно специалисты компании <strong>MonParis</strong> работают над тем, чтобы наша женская одежда стала доступной покупательницам во всех регионах России. Поставив во главу угла качество, актуальность коллекций и соответствие стилю жизни российских дам всех возрастов, мы уверены, что женская одежда <strong>MonParis</strong> понравится постоянным клиентам вашего. Ежедневно специалисты компании <strong>MonParis</strong> работают над тем, чтобы наша женская одежда стала доступной покупательницам во всех регионах России. Поставив во главу угла качество, актуальность коллекций и соответствие стилю жизни российских дам всех возрастов, мы уверены, что женская одежда <strong>MonParis</strong> понравится постоянным клиентам вашего магазина и обеспечит вам рост продаж и приток новых покупателей.</p>

                    <p>Ежедневно специалисты компании <strong>MonParis</strong> работают над тем, чтобы наша женская одежда стала доступной покупательницам во всех регионах России. Поставив во главу угла качество, актуальность коллекций и соответствие стилю жизни российских дам всех возрастов, мы уверены, что женская одежда <strong>MonParis</strong> понравится постоянным клиентам вашего магазина и обеспечит вам рост. Ежедневно специалисты компании <strong>MonParis</strong> работают над тем, чтобы наша женская одежда стала доступной покупательницам во всех регионах России. Поставив во главу угла качество, актуальность коллекций и соответствие стилю жизни российских дам всех возрастов, мы уверены, что женская одежда <strong>MonParis</strong> понравится постоянным клиентам вашего магазина и обеспечит вам рост продаж и приток новых покупателей.</p>

                </div>

            </div>
        </div>

<?php

	if (file_exists("catalog/opt.tpl"))
	{
		include "catalog/opt.tpl";
	}

	include_once ("bottom.tpl");
?> 
