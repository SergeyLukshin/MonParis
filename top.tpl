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
    <title><?php echo $strTitle; ?></title>
    <link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/themes/smoothness/jquery-ui.css" />
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
		echo "</script>";
		echo "<script type=\"text/javascript\" src=\"/js/stickyscroll_frw.js\"></script>";
		echo "<script type=\"text/javascript\" src=\"/js/stickyscroll_corelib.js\"></script>";
		echo "<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/stickyscroll.css\" media=\"screen\">";
		
		/*<div id="layerFirstVisit" style="height: 220px;">
			<div id="firstVisitContainer" style="height: 190px;">
				<div class="fixedWidth">
					<div id="layerTop">
						<a id="closeLayer" href="#">х</a>
					</div>
					<div id = "news">
						Текст новости Текст новости Текст новости
						Текст новости Текст новости Текст новости
						Текст новости Текст новости Текст новости
						Текст новости Текст новости Текст новости
						Текст новости Текст новости Текст новости
					</div>        
				</div>
			</div> 
		</div>*/
	}
	
	if ($bigsizes === 1 || $all === 1 || $search === 1 || $favorites === 1 || $brend_list === 1 || $cat_list === 1 || $new_col_list === 1)
	{
		if (!isset($_SESSION['cur_page']) || $_SESSION['cur_page'] != "0")
		{
			echo "<link rel=\"canonical\" href=\"http://mon-paris.ru/".$url_str."\"/>";
		}
	}
?>
    <link href="/css/style.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy this line! -->
    <!--[if lt IE 9]><script src="js/ie8-responsive-file-warning.js"></script><![endif]-->

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="js/html5shiv.js"></script>
      <script src="js/respond.min.js"></script>
    <![endif]-->


<script>

(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){

(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),

m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)

})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-75150789-1', 'auto');

ga('send', 'pageview');
setTimeout("ga('send', 'event', '15 seconds', 'read')",15000);

</script>



<!-- Yandex.Metrika counter -->
<script type="text/javascript">
    (function (d, w, c) {
        (w[c] = w[c] || []).push(function() {
            try {
                w.yaCounter17423986 = new Ya.Metrika({
                    id:17423986,
                    clickmap:true,
                    trackLinks:true,
                    accurateTrackBounce:true,
                    webvisor:true
                });
            } catch(e) { }
        });

        var n = d.getElementsByTagName("script")[0],
            s = d.createElement("script"),
            f = function () { n.parentNode.insertBefore(s, n); };
        s.type = "text/javascript";
        s.async = true;
        s.src = "https://mc.yandex.ru/metrika/watch.js";

        if (w.opera == "[object Opera]") {
            d.addEventListener("DOMContentLoaded", f, false);
        } else { f(); }
    })(document, window, "yandex_metrika_callbacks");
</script>
<noscript><div><img src="https://mc.yandex.ru/watch/17423986" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
<!-- /Yandex.Metrika counter -->

</head>


<body>

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
                <div class="header_inn_cols" itemscope itemtype="http://schema.org/LocalBusiness">
					<span itemprop="name" style="display:none;">Mon-Paris.ru</span>
					
					<div itemprop="address" itemscope itemtype="http://schema.org/PostalAddress">
                        <span itemprop="postalCode" style="display:none;">117997</span><span itemprop="addressLocality" style="display:none;">Москва</span><span itemprop="streetAddress" style="display:none;">ул.Вавилова, 69/75, оф. 809</span>
                    </div>
                    
                    <div class="header_inn_cols_2">
                        <div class="hcols hcols_1">
                            <div>
                                <div><a class="hd_tp_butt" href="/samovyvoz.php"><span class="ico_zabrat">Забрать в магазине</span></a></div>
                                <div><a class="hd_tp_butt" href="/delivery.php"><span class="ico_besp_deliv">Доставка</span></a></div>
                            </div>
                        </div>
                        <div class="hcols hcols_2">
                            <div>
                                <div class="phone"><div><div><span itemprop="telephone">+7(495)-518-91-65</span></div></div></div>
                                <div><a class="hd_tp_butt tp_recall" href="#" data-toggle="modal" data-target="#modal_feedback_1"><span>Перезвоните мне</span></a></div>
                            </div>
                        </div>
                        <div class="hcols hcols_3">
                            <div>
                                <div class="work_h">
                                    <h6>Часы работы</h6>
                                    <time itemprop="openingHours" datetime="Mo-Sa 09:30-19:00, Su 09:30-18:00">Понедельник - суббота: с 9.30 до 19.00<br>
                                    Воскресенье: с 9.30 до 18.00</time>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="hcols hcols_4">
                        <div>
                            <a href="/cart.php" class="cart_top">
                                <h6>Корзина</h6>
                                <div class="inf" id='jcart2'>
<?php
									$cart->display_short_cart($jcart);									
?>									
                                </div>
                            </a>
                        </div>
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
                            <a <?php if ($catalog == 1 && $bigsizes != 1 && $new_col_list != 1) echo "class='act'"; ?> href="/catalog/all"><span>Одежда</span></a>
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
                            <a <?php if ($new_collection_page == 1 || $catalog == 1 && $new_col_list == 1) echo "class='act'"; ?> href="/new_collections.php"><span>Новые коллекции и Акции</span></a></li><li><span></span>
                            <a <?php if ($brends_page == 1) echo "class='act'"; ?> href="/brends.php"><span>Все бренды</span></a></li><li><span></span>
                            <a <?php if ($opt_page == 1) echo "class='act'"; ?> href="/opt.php"><span>Оптовым покупателям</span></a></li><li><span></span>
                            <a <?php if ($contacts_page == 1) echo "class='act'"; ?> href="/contacts.php"><span>Контакты</span></a></li>
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
        
        <!-- top -->
