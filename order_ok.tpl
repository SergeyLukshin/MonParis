<?php		
		$order_number = $cart->order_number;
		$order_delivery_type = $cart->order_delivery_type;
		$order_cost = $cart->total;
		
		$cart->empty_cart();

		$curr = "руб.";
		if (User::getPriceInEuro() == "1") $curr = "у.е.";
?>

<div class="cart_list_out">

	<div class="title_points cart_list_title"><span>ОФОРМЛЕНИЕ ЗАКАЗА</span></div>

	<div class="cart_list_form_out">

		<div class="container">

			<div class="cart_order_inn">

				<div class="stat stat_ok">
					<strong>СПАСИБО! ВАШ ЗАКАЗ УСПЕШНО ОТПРАВЛЕН!</strong><br>
					Наши менеджеры свяжутся с Вами в ближайшее время.
				</div>

				<div class="clearfix"></div>

				<table>
					<tr>
						<td>Номер заказа</td>
						<td><strong><?php echo $order_number ?></strong></td>
					</tr>
					<tr>
						<td>Дата заказа</td>
						<td><strong><?php echo date("m.d.Y") ?></strong></td>
					</tr>
					<tr>
						<td>Стоимость</td>
						<td><strong><?php 
							if ($order_delivery_type == 1) 
							{
								if (User::getPriceInEuro() == "1")
								{
									echo number_format($order_cost, 0, '.', '')." ".$curr." + доставка по Москве 350 руб.";
								}
								else
								{
									echo number_format($order_cost, 0, '.', '')." ".$curr." + доставка по Москве 350 руб. = ".number_format($order_cost + 350, 0, '.', '')." ".$curr;
								}
							}
							if ($order_delivery_type == 2) 
							{
								echo number_format($order_cost, 0, '.', '')." ".$curr." + доставка по России (стоимость в РЕГИОНЫ должна быть согласована с менеджерами)";
							}
							if ($order_delivery_type == 3) 
							{
								echo number_format($order_cost, 0, '.', '')." ".$curr."---";
							} 
							if ($order_delivery_type == 4) 
							{
								echo number_format($order_cost, 0, '.', '')." ".$curr." + международная доставка (стоимость доставки должна быть согласована с менеджерами)";
							} 
							?></strong></td>
					</tr>
				</table>

				<div class="clearfix"></div>
				Перейти на <a href="/">главную</a>
<?php
				if (User::getPriceInEuro() != "1")
				{
					echo "<br><br>Если Вы хотите оплатить Ваш заказ online, нажмите на кнопку \"Оплатить\"<br>";
					include_once ("yandex_money.tpl");
				}
?>
			</div>
		</div>
	</div>


</div>
