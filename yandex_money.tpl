	<script type="text/javascript">
	function showOrHideCost(cb, cat) {
		cb = document.getElementById(cb);
		cat = document.getElementById(cat);
		if (cb.checked) cat.style.display = "inline-block";
		else cat.style.display = "none";
	}
	</script>
	
	<script type="text/javascript">
	function updateCost(s1, s2, s3) {
		s1 = document.getElementById(s1);
		s2 = document.getElementById(s2);
		s3 = document.getElementById(s3);
		
		delivery = parseInt(s1.value);
		if (isNaN(delivery) || delivery < 0)
			delivery = 0;
		
		s3.value = delivery + parseInt(s2.value);
			
		s4 = document.getElementById("itog");
		s4.innerHTML = s3.value;
	}
	</script>
	
	<label><input id="set_cost" name="set_cost" type="checkbox" onchange = 'showOrHideCost("set_cost", "delivery_cost")'> указать другую сумму доставки</label><br>
<?php
	echo "<form method=\"POST\" action=\"https://money.yandex.ru/eshop.xml\" target=\"_blank\">";
	echo "<input type=\"hidden\" name=\"shopId\" value=\"75687\">";
	echo "<input type=\"hidden\" name=\"scid\" value=\"70538\">";
	echo "<input type=\"hidden\" name=\"cps_phone\" value=\"".$user_tel."\">";
	echo "<input type=\"hidden\" name=\"customerNumber\" value=\"".$user_email."\">";
	echo "<input id=\"delivery_cost\" style=\"margin: 10px;width: 122px; display:none;\" value=\"".$delivery_cost."\" onchange='updateCost(\"delivery_cost\", \"old_sum\", \"sum\")'>";
	echo "<input id = \"sum\" name=\"sum\" type=\"hidden\" value=\"".number_format($order_cost + $delivery_cost + $commission, 0, '.', '')."\">";
	echo "<input id=\"old_sum\" type=\"hidden\" value=\"".number_format($order_cost + $commission, 0, '.', '')."\">";
	echo "<input name=\"paymentType\" value=\"\" type=\"hidden\"/>";
	echo "<input type=\"hidden\" name=\"orderNumber\" value=\"".$order_number."\">";
	echo "<input type=\"hidden\" name=\"custName\" value=\"".$user_fio."\">";
	echo "<input type=\"hidden\" name=\"custEmail\" value=\"".$user_email."\">";
	echo "<button class='form_butt_3' name='' type='submit' value=' '><span>ќѕЋј“»“№</span></button>";
	echo "</form>";
?>
