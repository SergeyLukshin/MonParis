<?php		
		$order_number = $cart->order_number;
		$order_delivery_type = $cart->order_delivery_type;
		$order_cost = $cart->total;
		
		$cart->empty_cart();

		$curr = "���.";
		if (User::getPriceInEuro() == "1") $curr = "�.�.";
?>

<div class="cart_list_out">

	<div class="title_points cart_list_title"><span>���������� ������</span></div>

	<div class="cart_list_form_out">

		<div class="container">

			<div class="cart_order_inn">

				<div class="stat stat_ok">
					<strong>�������! ��� ����� ������� ���������!</strong><br>
					���� ��������� �������� � ���� � ��������� �����.
				</div>

				<div class="clearfix"></div>

				<table>
					<tr>
						<td>����� ������</td>
						<td><strong><?php echo $order_number ?></strong></td>
					</tr>
					<tr>
						<td>���� ������</td>
						<td><strong><?php echo date("m.d.Y") ?></strong></td>
					</tr>
					<tr>
						<td>���������</td>
						<td><strong><?php 
							if ($order_delivery_type == 1) 
							{
								if (User::getPriceInEuro() == "1")
								{
									echo number_format($order_cost, 0, '.', '')." ".$curr." + �������� �� ������ 350 ���.";
								}
								else
								{
									echo number_format($order_cost, 0, '.', '')." ".$curr." + �������� �� ������ 350 ���. = ".number_format($order_cost + 350, 0, '.', '')." ".$curr;
								}
							}
							if ($order_delivery_type == 2) 
							{
								echo number_format($order_cost, 0, '.', '')." ".$curr." + �������� �� ������ (��������� � ������� ������ ���� ����������� � �����������)";
							}
							if ($order_delivery_type == 3) 
							{
								echo number_format($order_cost, 0, '.', '')." ".$curr."---";
							} 
							if ($order_delivery_type == 4) 
							{
								echo number_format($order_cost, 0, '.', '')." ".$curr." + ������������� �������� (��������� �������� ������ ���� ����������� � �����������)";
							} 
							?></strong></td>
					</tr>
				</table>

				<div class="clearfix"></div>
				������� �� <a href="/">�������</a>
<?php
				if (User::getPriceInEuro() != "1")
				{
					echo "<br><br>���� �� ������ �������� ��� ����� online, ������� �� ������ \"��������\"<br>";
					include_once ("yandex_money.tpl");
				}
?>
			</div>
		</div>
	</div>


</div>
