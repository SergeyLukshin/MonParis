<?php		
		$order_number = $cart->order_number;
		$order_delivery_type = $cart->order_delivery_type;
		$order_cost = $cart->total;
		
		$cart->empty_cart();

		$curr = "руб.";
		if (User::getPriceInEuro() == "1") $curr = "у.е.";
		
		$commission = $order_cost * 4 / 100;
		$delivery_cost = 0;
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
						<td><strong><?php echo date("d.m.Y") ?></strong></td>
					</tr>
					<tr>
						<td>Стоимость</td>
						<td><strong><?php 
							if ($order_delivery_type == 1) 
							{
								if (User::getPriceInEuro() == "1")
								{
									echo number_format($order_cost, 0, '.', '')." ".$curr." + доставка по Москве 400 руб.";
								}
								else
								{
									echo number_format($order_cost, 0, '.', '')." ".$curr." + доставка по Москве 400 руб. = ".number_format($order_cost + 400, 0, '.', '')." ".$curr;
									$delivery_cost = 400;
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
					echo "<br><table><tr>";
					//echo "	<td>Комиссия</td>";
					//echo "	<td><strong>".number_format($commission, 0, '.', '')." ".$curr."</strong></td>";
					//echo "</tr>";
					//echo "<tr>";
					echo "	<td>Итого</td>";
					echo "	<td><strong><span id='itog'>".number_format($order_cost + $delivery_cost, 0, '.', '')."</span> ".$curr."</strong></td>";
					//echo "	<td>Итого с учетом комиссии</td>";
					//echo "	<td><strong><span id='itog'>".number_format($order_cost + $delivery_cost + $commission, 0, '.', '')."</span> ".$curr."</strong></td>";
					echo "</tr></table><br>";
					include_once ("yandex_money.tpl");
				}
?>
			</div>
		</div>
	</div>


</div>
