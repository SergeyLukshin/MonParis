<?php
	include_once ("init.tpl");
	include_once ("init_data.tpl");	
?>

<!-- top -->

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="windows-1251">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="author" content="">
    <meta name='yandex-verification' content='5bae267bbc5bd49c' />

    <meta name="description" content="<?php echo $strDescription; ?>">
    <?php if ($keywords != "") echo $keywords; ?>
    <title><?php echo $strTitle; ?></title>
    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/themes/smoothness/jquery-ui.css" />
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/bootstrap-select.css" rel="stylesheet">
    <link href="/js/flexslider2/flexslider.css" rel="stylesheet" />
    <link href="/js/slick/slick.css" rel="stylesheet">
    <link href="/css/jquery.mCustomScrollbar.css" rel="stylesheet">
    <link href="/js/prettyCheckable/prettyCheckable.css" rel="stylesheet">
<?php
	if ($detail === 1)
	{
		echo "<link href=\"/js/jquery.fancybox/jquery.fancybox.css\" rel=\"stylesheet\">\n";
	}
	if ($main === 1)
	{
		$time_file=filemtime("./news.txt");
		
		echo "<script type=\"text/javascript\">";
		echo "	var jsInit = {";
		echo "		links: {";
		echo "			LayerFirstVisit: './news.txt',";
		echo "			COOKIE_DOMAIN: 'mon-paris.ru',";
		echo "			Ver: 'LAYERFIRSTVISIT_".$time_file."',";
		echo "		},      ";
		echo "		isLayerFirstVisitDisabled: \"False\"";
		echo "	};";
		echo "	if (!(Links)) {var Links = jsInit.links;}";
		echo "</script>\n";
		echo "<script type=\"text/javascript\" src=\"/js/stickyscroll_frw.js\"></script>\n";
		echo "<script type=\"text/javascript\" src=\"/js/stickyscroll_corelib.js\"></script>\n";
		echo "<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/stickyscroll.css\" media=\"screen\">\n";
	}
	
	if ($bigsizes === 1 || $all === 1 || $search === 1 || $favorites === 1 || $brend_list === 1 || $cat_list === 1 || $new_col_list === 1)
	{
		if (!isset($_SESSION['cur_page']) || $_SESSION['cur_page'] != "0")
		{
			echo "<link rel=\"canonical\" href=\"/".$url_str."\"/>";
		}
	}
?>
    <link href="/css/style.css?2" rel="stylesheet">

	<!-- Google Tag Manager -->
	<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
	new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
	j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
	'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
	})(window,document,'script','dataLayer','GTM-MGXKK69');</script>
	<!-- End Google Tag Manager -->


	<!-- Global site tag (gtag.js) - Google Analytics -->
	<!-- Global site tag (gtag.js) - Google Ads: 1038736007 -->
	<!--<script async src="https://www.googletagmanager.com/gtag/js?id=AW-1038736007"></script>
	<script>
	  window.dataLayer = window.dataLayer || [];
	  function gtag(){dataLayer.push(arguments);}
	  gtag('js', new Date());

	  gtag('config', 'AW-1038736007');
	</script>

	<script>
	  gtag('config', 'AW-1038736007/CNn4COeEyYsBEIe1p-8D', {
		'phone_conversion_number': '+7(495)-518-91-65'
	  });
	</script>

	<script>
	  gtag('config', 'AW-1038736007/CNn4COeEyYsBEIe1p-8D', {
		'phone_conversion_number': '+7-(968)-827-33-87'
	  });
	</script>-->


	<!--<script type="text/javascript">
		var __cs = __cs || [];
		__cs.push(["setCsAccount", "iV3EcktRGFVy3blhsRe8IE9WbTPlpvWH"]);
	</script>
	<script type="text/javascript" async src="https://app.comagic.ru/static/cs.min.js"></script>-->

</head>

<body>

	<!-- Google Tag Manager (noscript) -->
	<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-MGXKK69"
	height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
	<!-- End Google Tag Manager (noscript) -->


	<!-- Global site tag (gtag.js) - Google Analytics -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=UA-9896675-4"></script>
	<script>
	  window.dataLayer = window.dataLayer || [];
	  function gtag(){dataLayer.push(arguments);}
	  gtag('js', new Date());

	  gtag('config', 'UA-9896675-4');
	</script>


	<!-- Yandex.Metrika informer -->
	<a href="https://metrika.yandex.ru/stat/?id=17423986&amp;from=informer"
	target="_blank" rel="nofollow"><img src="https://informer.yandex.ru/informer/17423986/3_1_FFFFFFFF_EFEFEFFF_0_pageviews"
	style="width:88px; height:31px; border:0;" alt="Яндекс.Метрика" title="Яндекс.Метрика: данные за сегодня (просмотры, визиты и уникальные посетители)" class="ym-advanced-informer" data-cid="17423986" data-lang="ru" /></a>
	<!-- /Yandex.Metrika informer -->

	<!-- Yandex.Metrika counter -->
	<script type="text/javascript" >
	   (function(m,e,t,r,i,k,a){m[i]=m[i]||function(){(m[i].a=m[i].a||[]).push(arguments)};
	   m[i].l=1*new Date();k=e.createElement(t),a=e.getElementsByTagName(t)[0],k.async=1,k.src=r,a.parentNode.insertBefore(k,a)})
	   (window, document, "script", "https://mc.yandex.ru/metrika/tag.js", "ym");

	   ym(17423986, "init", {
			id:17423986,
			clickmap:true,
			trackLinks:true,
			accurateTrackBounce:true,
			webvisor:true,
			ecommerce:"dataLayer"
	   });
	   <!--window.dataLayerYandex = window.dataLayerYandex || [];-->
	</script>

	<noscript><div><img src="https://mc.yandex.ru/watch/17423986" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
<!-- /Yandex.Metrika counter -->

<div class="wrapp">
    <div class="container">
		
        <div class="header">
            <div class="reg_ent">
<?php
				if (!User::isAuthorized())
					{
					echo "<div class='lnk'><a href='#' data-toggle='modal' data-target='#modal_reg'>Регистрация</a></div>";
					echo "<div class='rz'></div>";
					echo "<div class='lnk'><a href='#' data-toggle='modal' data-target='#modal_ent'>Вход</a></div>";
				}
				else
				{
					echo "<div class='lnk'><div class='work_h'>Добро пожаловать, ".User::getUserName()."</div></div>";
					echo "<div class='rz'></div>";
					echo "<div class='lnk'><a href='/logout.php'>Выход</a></div>";
				}
?>
            </div>

            <div class="header_inn">
                <div class="clearfix"><a class="logo" href="/"></a></div>
                <div class="header_inn_cols" itemscope itemtype="https://schema.org/LocalBusiness">
					<span itemprop="name" style="display:none;">Mon-Paris.ru</span>
					
					<div itemprop="address" itemscope itemtype="https://schema.org/PostalAddress">
                        <span itemprop="postalCode" style="display:none;">117997</span><span itemprop="addressLocality" style="display:none;">Москва</span><span itemprop="streetAddress" style="display:none;">ул.Вавилова, 69/75, оф. 602</span>
                    </div>
                    
                    <div class="header_inn_cols_2">
						<div class="hcols hcols_1">
                            <div>
                                <div><a class="hd_tp_butt" href="/samovyvoz.php"><span class="ico_zabrat">Забрать в магазине</span></a></div>
                                <div><a class="hd_tp_butt" href="/delivery.php"><span class="ico_besp_deliv">Доставка</span></a></div>
                                <div><a class="hd_tp_butt tp_recall" href="#"  data-toggle="modal" data-target="#modal_feedback_1"><span>Перезвоните мне</span></a></div>
                            </div>
                        </div>
                        <div class="hcols hcols_2">
                            <div class = "comagic_phone" >
                                <div class="phone visible-xs visible-sm"><div><div><span itemprop="telephone"><a href="tel:+74955189165" onClick="ga('send', 'event', 'form', 'click');">+7(495)-518-91-65</a></span></div></div></div>
                                <div class="phone2 visible-xs visible-sm"><div><div><span itemprop="telephone"><a href="https://wa.me/79688273387" onClick="ga('send', 'event', 'form', 'click');">+7(968)-827-33-87</a></span></div></div></div>
                                <div class="phone2 visible-xs visible-sm"><div><div><span itemprop="telephone"><a href="https://wa.me/79688273387" onClick="ga('send', 'event', 'form', 'click');">+7(499)-132-49-81</a></span></div></div></div>
                                <div class="phone visible-md visible-lg"><div><div><span itemprop="telephone">+7(495)-518-91-65</span></div></div></div>
                                <div class="phone2 visible-md visible-lg"><div><div><span itemprop="telephone">+7(968)-827-33-87</span></div></div></div>
                                <div class="phone2 visible-md visible-lg"><div><div><span itemprop="telephone">+7(499)-132-49-81</span></div></div></div>
                                <!--<div><a class="hd_tp_butt tp_recall" href="#" data-toggle="modal" data-target="#modal_feedback_1"><span>Перезвоните мне</span></a></div>-->
                            </div>
                        </div>
                        <div class="hcols hcols_3">
                            <div>
                                <div class="work_h">
                                    <h6>Часы работы</h6>
                                    <time itemprop="openingHours" datetime="Mo-Sa 09:30-19:00, Su 09:30-18:00">Понедельник - суббота: с 9.30 до 19.00<br>
                                    Воскресенье: выходной</time>
                                </div>
<?php
                                if (User::isAuthorized())
                                {
                                    echo "<div><a class='hd_tp_butt tp_recall' href='/catalog/izbrannoe'>";
                                    echo "  <span style='width: auto;padding-right: 0px;height: 100%;color: #8597dc;'>.</span>";
                                    echo "  <div style='float: left;height: 25px;margin-top: 2px;margin-left: -5px;height: 25px;width: 25px;background-image: url(/img/fav_off.svg);background-position: -3px -4px;' src='/img/fav_off.png'></div>";
                                    echo "  <span style='width: auto;padding-right: 0px;border-left: 0px;'>ИЗБРАННОЕ</span>";
                                    echo "</a></div>";
                                }
?>
                            </div>
                        </div>
                    </div>
                    <div class="hcols hcols_4">
                        <div class = "cart_div">
                            <a href="/cart.php" class="cart_top">
                                <h6>Корзина</h6>
                                <div class="inf" id='jcart2'>
<?php
									$cart->display_short_cart($jcart);									
?>									
                                </div>
                            </a>
                        </div>
                        <div><a class="hd_tp_butt tp_recall" href="#" data-toggle="modal" data-target="#modal_feedback_2"><span>Оплатить доставку</span></a></div>
                    </div>
                    <div class="hcols hcols_5">
                        <div>
                            <div class="search_tp">
                                <div class="search_inp">

									<form name="search_form" action="/catalog/search" method="POST" enctype="multipart/form-data">
<?php
										if ($search != 0)
											echo "<input name='search_txt' type='text' value='".$search_txt."' maxlength='255' placeholder='Поиск одежды...'>";
										else
											echo "<input name='search_txt' type='text' value='' maxlength='255' placeholder='Поиск одежды...'>";
?>
										<button name="search_butt" type="submit" value="1"></button>
									</form>
<!--
                                    <form name="form_search" action="/catalog/search" method="POST" enctype="multipart/form-data">
                                        <input name="search_txt" type="text" value="" maxlength="255" placeholder="Поиск одежды...">
                                        <button name="search_butt" type="submit" value="1"></button>
                                    </form>
-->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="top_menu_out">
            <div class="top_menu">
                <nav>
                    <ul class="menu">
                        <li><a <?php if ($main == 1) echo "class='act'"; ?> href="/"><span>Главная</span></a></li><li><span></span>
                            <a <?php if ($catalog == 1 && $bigsizes != 1 && $new_col_list != 1) echo "class='act'"; ?> id='clothers' href="/catalog/all"><span>Одежда</span></a>
                                <ul class="sub-menu">
<?php
									reset($vec_category);																	
									foreach ($vec_category as $key => $value) 
									{
										echo "<li><span></span><a href='/catalog/".$key."'>".strtoupper($value[0])."</a></li>";										
									}
?>
                                </ul></li><li><span></span>
                            <a <?php if ($catalog == 1 && $bigsizes == 1) echo "class='act'"; ?> href="/catalog/bolshie-razmery"><span>Большие размеры</span></a></li><li><span></span>
                            <a <?php if ($new_collection_page == 1 || $catalog == 1 && $new_col_list == 1) echo "class='act'"; ?> href="/new_collections.php"><span>Каталоги</span></a></li><li><span></span>
                            <a <?php if ($brends_page == 1) echo "class='act'"; ?> href="/brends.php"><span>Дизайнеры</span></a></li><li><span></span>
                            <a <?php if ($opt_page == 1) echo "class='act'"; ?> href="/opt.php"><span>Оптовикам</span></a></li><li><span></span>
                            <a <?php if ($contacts_page == 1) echo "class='act'"; ?> href="/contacts.php"><span>Контакты</span></a></li><li><span></span>
                            <a <?php if ($vacancy_page == 1) echo "class='act'"; ?> href="/vacancy.php"><span>Вакансии</span></a></li><li><span></span>
                    </ul>
                </nav>
            </div>
            <div class="top_menu_search">
                <div class="search_inp">
                    <form name="search_form" action="/catalog/search" method="POST" enctype="multipart/form-data">
<?php
						if ($search != 0)
							echo "<input name='search_txt' type='text' value='".$search_txt."' maxlength='255' placeholder='Поиск одежды...'>";
						else
							echo "<input name='search_txt' type='text' value='' maxlength='255' placeholder='Поиск одежды...'>";
?>
                        <button name="search_butt" type="submit" value="1"></button>
                    </form>
                </div>
            </div>
            <div class="top_menu_scroll">
                <div class="top_menu_scroll_inn">
                    <a class="next" href="#"></a>
                    <a class="prev" href="#"></a>
                </div>
            </div>
        </div>

<?php
	if ($main === 1)  echo <<< END

<div class='content-wrapper' style='padding: 0 20px'>
	<div class='content'>
		<form action='https://lk.mailopost.ru/subscriptions/u65bo6n46vgrtyxhu/form' charset='UTF-8' method='post'>
			<div class='form-group'>
				<label class="required" for="email">Email</label>
				<input type="text" name="recipient[email]" id="recipient_email" value="" required="required" class="form-control" />
			</div>
			<div class='form-group row'>
				<div class='col-xs-12 col-sm-12 text-right'>
					<button class='btn form_butt_2' style="float:right;background-color:#ff579d;" type='submit'>
						<i class='fi fi-return'></i>
						<span>Подписаться на новости и акции</span>
					</button>
				</div>
			</div>
		</form>
	</div>
</div>

END
?>

        
        <!-- top -->
