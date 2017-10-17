	<script type="text/javascript">
	function showOrHideCost(cb, cat) {
		cb = document.getElementById(cb);
		cat = document.getElementById(cat);
		if (cb.checked) cat.style.display = "inline-block";
		else cat.style.display = "none";
	}
	</script>
	
	<label><input id="set_cost" name="set_cost" type="checkbox" onchange = 'showOrHideCost("set_cost", "order_sum")'> указать сумму с доставкой</label><br>
<?php
	echo "<form method=\"POST\" action=\"https://money.yandex.ru/eshop.xml\" target=\"_blank\">";
	echo "<input type=\"hidden\" name=\"shopId\" value=\"75687\">";
	echo "<input type=\"hidden\" name=\"scid\" value=\"70538\">";
	echo "<input type=\"hidden\" name=\"cps_phone\" value=\"".$user_tel."\">";
	echo "<input type=\"hidden\" name=\"customerNumber\" value=\"".$user_email."\">";
	echo "<input id=\"order_sum\", name=\"sum\" style=\"margin: 10px;width: 122px; display:none;\" value=\"".$order_cost."\">";
	echo "<input name=\"paymentType\" value=\"\" type=\"hidden\"/>";
	echo "<input type=\"hidden\" name=\"orderNumber\" value=\"".$order_number."\">";
	echo "<input type=\"hidden\" name=\"custName\" value=\"".$user_fio."\">";
	echo "<input type=\"hidden\" name=\"custEmail\" value=\"".$user_email."\">";
	echo "<button class='form_butt_3' name='' type='submit' value=' '><span>ќѕЋј“»“№</span></button>";
	echo "</form>";
?>
