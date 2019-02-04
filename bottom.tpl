<!-- bottom -->

<?php
			if ($catalog != 1 && $detail != 1 && $basket != 1 && $make_order != 1) echo "</div>";
?>
</div>

<div class="footer">
    <div class="container">
        <div class="footer_inn" itemscope itemtype="https://schema.org/LocalBusiness">
			<span itemprop="name" style="display:none;">Mon-Paris.ru</span>
            <div class="col_12">
                <div class="cols col_1">
                    <div class="col_1_s">
                        <div class="title">�� � ���.����:</div>
                        <div class="soc">
                            <a class="tw" href="#"></a>
                            <a class="gp" href="#"></a>
                            <a class="in" href="#"></a>
                            <a class="fb" href="https://facebook.com/moscowtradeoffice"></a>
                        </div>
                    </div>
                    <div class="col_1_k">
                        <div class="title">���� ��������:</div>
                        <div>��������������: <div><span itemprop="telephone">+7-(495)-518-91-65</span></div></div>
                        <div>�������/����: <div><span itemprop="faxNumber">+7-(499)-132-49-81</span></div></div>
                        <div>��������� ������: <div><span itemprop="telephone">+7-(968)-827-33-87</span></div></div>
                    </div>
                </div>
                <div class="clearfix clear_cols"></div>
                <div class="clearfix clear_cols"></div>
                <div class="cols col_2">
                    <div class="col_1_a"  itemprop="address" itemscope itemtype="https://schema.org/PostalAddress">
                        <div class="title">���� ������:</div>
                        <span itemprop="postalCode">117997</span>, <span itemprop="addressLocality">������</span>, <span itemprop="streetAddress">��.��������, 69/75, ��. 809</span>
                    </div>
                    <div class="col_1_t">
                        <div class="title">���� ������:</div>
                        <time itemprop="openingHours" datetime="Mo-Sa 09:30-19:00, Su 09:30-18:00">����������� - �������: � 9.30 �� 19.00<br>
                        �����������: ��������</time>
                    </div>
                </div>
            </div>
            <div class="cols col_3">
                <div class="map">
					<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2249.3812026438604!2d37.54879895146862!3d55.68235998043904!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x46b54cec3d82329b%3A0xb44f9f012e12e655!2z0YPQuy4g0JLQsNCy0LjQu9C-0LLQsCwgNjkvNzUsINCc0L7RgdC60LLQsCwgMTE3MzM1!5e0!3m2!1sru!2sru!4v1452853496148" width="100%" height="100%" frameborder="0" style="border:0" allowfullscreen></iframe>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="modal_feedback_2" class="modal modal_feedback" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <a class="closew" data-dismiss="modal" href="#"></a>

                <h2>�������� ��������</h2>

                <div class="clearfix"></div>

				<form id="pay" method="POST" action="https://money.yandex.ru/eshop.xml" target="_blank">
				<!--<form class="form-signin ajax" method="post" action="/ajax.php">-->
					<div class="main-error alert alert-danger hidden"></div>
<?php
					echo "<input type=\"hidden\" name=\"shopId\" value=\"75687\">";
					echo "<input type=\"hidden\" name=\"scid\" value=\"70538\">";
					echo "<input type=\"hidden\" name=\"cps_phone\" value=\"".User::getUserPhone()."\">";
					echo "<input type=\"hidden\" name=\"customerNumber\" value=\"".User::getUserLogin()."\">";
					echo "<input name=\"paymentType\" value=\"\" type=\"hidden\"/>";
					echo "<input type=\"hidden\" name=\"custName\" value=\"".User::getUserName()."\">";
					echo "<input type=\"hidden\" name=\"custEmail\" value=\"".User::getUserLogin()."\">";
?>
					<div class="form-group">
						<input type="text" class="form-control" name="orderNumber" id="orderNumber" placeholder="����� ������" maxlength="10">
					</div>

					<div class="form-group">
						<input type="text" class="form-control" name="sum" id="sum" placeholder="��������� ��������"  maxlength="10">
					</div>

					<input type="hidden" name="act" value="pay">
					<button class="form_butt_2" id="pay_btn" name="" form="pay" value="send_form"><span>��������</span></button>

					<div class="clearfix"></div>
				</form>
            </div>
        </div>
    </div>
</div>

<div id="modal_feedback_1" class="modal modal_feedback" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <a class="closew" data-dismiss="modal" href="#"></a>

                <h2>����� �������� �����</h2>

                <div class="clearfix"></div>

                <form class="form-signin ajax" method="post" action="/ajax.php">
					<div class="main-error alert alert-danger hidden"></div>

                    <div class="form-group">
                        <input type="text" class="form-control" name="username" id="username" placeholder="���">
                    </div>

                    <div class="form-group">
                        <input type="text" class="form-control" name="email" id="email" placeholder="�����">
                    </div>

                    <div class="form-group">
                        <input type="text" class="form-control" name="phone" id="phone" placeholder="�������">
                    </div>

                    <div class="form-group">
                        <textarea class="form-control" placeholder="���������" name="msg" id="msg"></textarea>
                    </div>

                    <div class="captch"><div class = "recaptcha1" id = "recaptcha1"></div></div>

					<input type="hidden" name="act" value="message">
                    <button class="form_butt_2" name="send" type="submit" value="send_form"><span>���������</span></button>

                </form>

                <div class="clearfix"></div>
            </div>
        </div>
    </div>
</div>

<!-- bottom -->

<!-- auth -->

<div id="modal_reg" class="modal modal_feedback" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <a class="closew" data-dismiss="modal" href="#"></a>

                <h2>�����������</h2>

                <div class="clearfix"></div>

                <form class="form-signin ajax" method="post" action="/ajax.php">
					<div class="main-error alert alert-danger hidden"></div>
		
                    <div class="form-group">
                        <input type="text" class="form-control" name="username" id="username" placeholder="����� (e-mail)">
                    </div>

                    <div class="form-group">
                        <input type="password" class="form-control" name="password1" id="password1" placeholder="������">
                    </div>

                    <div class="form-group">
                        <input type="password" class="form-control" name="password2" id="password2" placeholder="����������� ������">
                    </div>

					<div class="ch_list">
						<h5>������ ������������</h5>

						<div class="form-group">
							<input type="text" class="form-control" name="user_fio1" id="user_fio1" placeholder="���">
						</div>

						<div class="form-group">
							<input type="text" class="form-control" name="user_fio2" id="user_fio2" placeholder="�������">
						</div>

						<div class="form-group">
							<input type="text" class="form-control" name="user_fio3" id="user_fio3" placeholder="��������">
						</div>

						<div class="form-group">
							<input type="text" class="form-control" name="user_tel" id="user_tel" placeholder="���������� ����� ��������">
						</div>

						<div class="region_select">
							<select class="selectpicker" data-width="100%" title='������' name="user_region" id="user_region">
								<option value="������" selected>������</option>
									<option value="���������� �������">���������� �������</option>
									<option value="������ ����.">������ ����.</option>
									<option value="����� ����.">����� ����.</option>
									<option value="��������� ����">��������� ����</option>
									<option value="�������� �������">�������� �������</option>
									<option value="������������� �������">������������� �������</option>
									<option value="������������ �������">������������ �������</option>
									<option value="��������">��������</option>
									<option value="������������ ����.">������������ ����.</option>
									<option value="������������ �������">������������ �������</option>
									<option value="�������� �������">�������� �������</option>
									<option value="������� ����.">������� ����.</option>
									<option value="������������ �������">������������ �������</option>
									<option value="������������� �������">������������� �������</option>
									<option value="����������� �������">����������� �������</option>
									<option value="����������� �������">����������� �������</option>
									<option value="�������� ����.">�������� ����.</option>
									<option value="��������� ���������� �������">��������� ���������� �������</option>
									<option value="������������� ����">������������� ����</option>
									<option value="���������� �������">���������� �������</option>
									<option value="��������� ����.">��������� ����.</option>
									<option value="��������� �������">��������� �������</option>
									<option value="���������-���������� ����������">���������-���������� ����������</option>
									<option value="��������������� �������">��������������� �������</option>
									<option value="�������� ����.">�������� ����.</option>
									<option value="��������� �������">��������� �������</option>
									<option value="���������� ����">���������� ����</option>
									<option value="���������-���������� ����������">���������-���������� ����������</option>
									<option value="������� ����.">������� ����.</option>
									<option value="����������� �������">����������� �������</option>
									<option value="��������� �������">��������� �������</option>
									<option value="���� ����.">���� ����.</option>
									<option value="����������� �������">����������� �������</option>
									<option value="������������� ����">������������� ����</option>
									<option value="������������ ����">������������ ����</option>
									<option value="���� ����.">���� ����.</option>
									<option value="���������� �������">���������� �������</option>
									<option value="������� �������">������� �������</option>
									<option value="������������� �������">������������� �������</option>
									<option value="�������� �������">�������� �������</option>
									<option value="����������� �������">����������� �������</option>
									<option value="����� �� ����.">����� �� ����.</option>
									<option value="�������� ����.">�������� ����.</option>
									<option value="���������� �������">���������� �������</option>
									<option value="�������� ���������� �����">�������� ���������� �����</option>
									<option value="������������� �������">������������� �������</option>
									<option value="������������ �������">������������ �������</option>
									<option value="������������� �������">������������� �������</option>
									<option value="������ �������">������ �������</option>
									<option value="������������ �������">������������ �������</option>
									<option value="��������� �������">��������� �������</option>
									<option value="���������� �������">���������� �������</option>
									<option value="�������� ����">�������� ����</option>
									<option value="���������� ����">���������� ����</option>
									<option value="��������� �������">��������� �������</option>
									<option value="���������� �������">���������� �������</option>
									<option value="��������� �������">��������� �������</option>
									<option value="��������� �������">��������� �������</option>
									<option value="�����-���������">�����-���������</option>
									<option value="����������� �������">����������� �������</option>
									<option value="���� (������) ����.">���� (������) ����.</option>
									<option value="����������� �������">����������� �������</option>
									<option value="������������ �������">������������ �������</option>
									<option value="�����������">�����������</option>
									<option value="�������� ������ - ������ ����.">�������� ������ - ������ ����.</option>
									<option value="���������� �������">���������� �������</option>
									<option value="�������������� ����">�������������� ����</option>
									<option value="���������� �������">���������� �������</option>
									<option value="��������� ����.">��������� ����.</option>
									<option value="�������� �������">�������� �������</option>
									<option value="������� �������">������� �������</option>
									<option value="�������� �������">�������� �������</option>
									<option value="���� ����.">���� ����.</option>
									<option value="��������� �������">��������� �������</option>
									<option value="���������� ����.">���������� ����.</option>
									<option value="����������� �������">����������� �������</option>
									<option value="����������� ����">����������� ����</option>
									<option value="������� ����.">������� ����.</option>
									<option value="�����-���������� ���������� ����� - ����">�����-���������� ���������� ����� - ����</option>
									<option value="����������� �������">����������� �������</option>
									<option value="��������� ����.">��������� ����.</option>
									<option value="��������� ����.">��������� ����.</option>
									<option value="��������� ���������� �����">��������� ���������� �����</option>
									<option value="�����-�������� ���������� �����">�����-�������� ���������� �����</option>
									<option value="����������� �������">����������� �������</option>
							</select>
						</div>

						<div class="clearfix"></div>

						<div class="form-group">
							<textarea class="form-control" name="user_address" id="user_address" placeholder="����� ��������"></textarea>
						</div>

						<div class="form-group">
							<input type="checkbox" class="pretty_checkb" value="1" name="user_wholesale" id ="user_wholesale"/>
							<label for="user_wholesale">������� ����������</label>
						</div>
					</div>

<!--
					<div style='display:none' id='wholesale_info'>
?php
						$i = 0;
						$cnt = sizeof($vec_brand);
						reset($vec_brand);
						echo "<input type='hidden' name='brand_cnt' value='".$cnt."' />";
?>
						<div class="ch_list">
							<h5>������</h5>
							
							
?php
						foreach ($vec_brand as $key => $value) 
						{
							echo "<input type='hidden' name='user_brand_val".$i."' id='user_brand_val".$i."' value='".$value."' />";
							$i = $i + 1;
						}
?>							
							
							<ul>
								<li>
									<ul>
?php										
						$half = $cnt / 2;
						reset($vec_brand);
						$i = 0;
						foreach ($vec_brand as $key => $value) 
						{
							echo "<li><input type='checkbox' class='pretty_checkb' value='".$i."' name='user_brand".$i."' id='user_brand".$i."' /><label for='user_brand".$i."'>".$value."</label></li>";
							$i = $i + 1;
							
							if ($i > $half && $i > 5)
							{
								echo "</ul></li><li><ul>";
								$half = 0;
							}
						}
?>
										<li class="ch_all"><input type="checkbox" class="pretty_checkb" value="" name="ch_all_1" id="ch_all_1" /><label for="ch_all_1">������� ���</label></li>
									</ul>
								</li>
							</ul>
						</div>
?php
						$i = 0;
						$cnt = sizeof($vec_category);
						reset($vec_category);
						echo "<input type='hidden' name='cat_cnt' value='".$cnt."' />";*/
?>
						<div class="ch_list">
							<h5>��������� �������</h5>
?php
						foreach ($vec_category as $key => $value) 
						{
							echo "<input type='hidden' name='user_cat_val".$i."' id='user_cat_val".$i."' value='".$value."' />";
							$i = $i + 1;
						}
?>	

							<ul>
								<li>
									<ul>
?php										
						$half = $cnt / 2;
						reset($vec_category);
						$i = 0;
						foreach ($vec_category as $key => $value) 
						{
							echo "<li><input type='checkbox' class='pretty_checkb' value='".$i."' name='user_cat".$i."' id='user_cat".$i."' /><label for='user_cat".$i."'>".$value."</label></li>";
							$i = $i + 1;
							
							if ($i > $half && $i > 5)
							{
								echo "</ul></li><li><ul>";
								$half = 0;
							}
						}
?>										
										<li class="ch_all"><input type="checkbox" class="pretty_checkb" value="" name="ch_all_1" id="ch_all_2" /><label for="ch_all_2">������� ���</label></li>
									</ul>
								</li>
							</ul>
						</div>


						<div class="ch_list">
							<h5>������� �������</h5>

							<input type='hidden' name='user_size_val1' id='user_size_val1' value='�������' />
							<input type='hidden' name='user_size_val2' id='user_size_val2' value='�������' />
							<input type='hidden' name='user_size_val3' id='user_size_val3' value='���������' />

							<ul>
								<li>
									<ul>
										<li><input type="checkbox" class="pretty_checkb" value="1" name="user_size1" id="user_size1" /><label for="user_size1">�������</label></li>
										<li><input type="checkbox" class="pretty_checkb" value="2" name="user_size2" id="user_size2" /><label for="user_size2">�������</label></li>
									</ul>
								</li>
								<li>
									 <ul>
										<li><input type="checkbox" class="pretty_checkb" value="11" name="user_size3" id="user_size3" /><label for="user_size3">���������</label></li>
									</ul>
								</li>
							</ul>
						</div>
					</div>
-->

                    <div class="captch"><div class = "recaptcha2" id = "recaptcha2"></div></div>
                    
					<div style="float: left;width: 100%; text-align: left;">
						<input type="checkbox" class="pretty_checkb" name="user_agree_delivery" id ="user_agree_delivery" class="checkbox" checked /><label for="user_agree_delivery">� ��������(-���) �������� ��������</label>
					</div>

					<div style="float: left;width: 100%; text-align: center;">
						<input type="hidden" name="act" value="register">
						<button class="form_butt_2" name="send" type="submit" value="send_form" style="text-align: right;"><span>���������</span></button>
					</div>

                </form>

                <div class="clearfix"></div>
            </div>
        </div>
    </div>
</div>




<div id="modal_ent" class="modal modal_feedback modal_ent" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <a class="closew" data-dismiss="modal" href="#"></a>

                <h2>�����������</h2>

                <div class="clearfix"></div>

                <form class="form-signin ajax" method="post" action="/ajax.php">
					<div class="main-error alert alert-danger hidden"></div>
					
                    <div class="form-group">
                        <input name="username" type="text" class="form-control" placeholder="����� (e-mail)">
                    </div>

                    <div class="form-group">
                        <input name="password" type="password" class="form-control" placeholder="������">
                    </div>

                    <input type="checkbox" class="pretty_checkb" value="1" name="remember-me" id="memb_my" /><label for="memb_my">��������� ����</label>


                    <div class="clearfix"></div>
                    <br>
                    <!--<div class="captch">��� ������</div>-->
                    <div style="float: left;width: 100%; text-align: center;">
						<input type="hidden" name="act" value="login">
                        <button style="display: -moz-inline-box;display: inline-block; float: none; text-align: center; min-width: 120px;" class="form_butt_2" name="send" type="submit" value="send_form"><span>�����</span></button>
                    </div>


                </form>

                <div class="clearfix"></div>
            </div>
        </div>
    </div>
</div>

<?php

if ($main != 0)
{
	if ($cnt_news > 0)
	{
		echo <<< END_NEWS
<div id="modal_news" class="modal modal_feedback modal_news" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <a class="closew" data-dismiss="modal" href="#"></a>

                <h2>�������</h2>

                <div class="clearfix"></div>
END_NEWS;
				reset ($news);
				foreach ($news as $key => $value)
				{
					echo "<div class='form-group_news'>".$value."</div>";
				}
		echo <<< END_NEWS
                <div style="float: left;width: 100%; text-align: center;">
                    <button style="display: -moz-inline-box;display: inline-block; float: none; text-align: center; min-width: 120px;" class="form_butt_2" name="send" type="button" data-dismiss="modal"><span>�������</span></button>
                </div>

                <div class="clearfix"></div>
            </div>
        </div>
    </div>
</div>
END_NEWS;
	}
}

?>


<!-- auth -->


<!-- Bootstrap core JavaScript
================================================== -->

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script src="/js/bootstrap-select.js"></script>
<script src="/js/flexslider2/jquery.flexslider.js"></script>
<script src="/js/flexslider2/setting.js"></script>
<script src="/js/slick/slick.min.js"></script>
<script src="/js/prettyCheckable/prettyCheckable.min.js"></script>
<script src="/js/jquery.mCustomScrollbar.js"></script>
<?php
	if ($detail != 0)
	{
echo <<< END2
		<script src="/js/jquery.fancybox/jquery.fancybox.js"></script>
		<script src="/js/zoomsl-3.0.js"></script>
END2;
	}
?>
<script src="/js/script.js"></script>
<script src="/js/ajax-form.js"></script>
<script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit" async defer></script>
<script src="/js/maskedinput-1.2.2.min.js" type="text/javascript"></script>
<script>
			function isNumeric(value) {
				return /^-{0,1}\d+$/.test(value);
			}

			$('#pay_btn').on('click', function(event) {
				event.preventDefault();
				
				var orderNumber = $('#orderNumber');
				var orderSum = $('#sum');
				var form = $('form#pay');

				if (!$.trim(orderNumber.val()) || !isNumeric(orderNumber.val())) {
					
					var $mainErrorContainer = form.find('.main-error');
					if ($mainErrorContainer.hasClass('hidden')) {
						$mainErrorContainer.removeClass('hidden');
					}
                    $mainErrorContainer.html("������� ����� ������").show();
                    $('#modal_feedback_2').scrollTop(0);
                    
					orderNumber.focus();
					$mainErrorContainer.fadeOut(3000);
					
					return;
				}
				
				if (!$.trim(orderSum.val()) || !isNumeric(orderSum.val())) {
					
					var $mainErrorContainer = form.find('.main-error');
					if ($mainErrorContainer.hasClass('hidden')) {
						$mainErrorContainer.removeClass('hidden');
					}
                    $mainErrorContainer.html("������� ��������� ��������").show();
                    $('#modal_feedback_2').scrollTop(0);
					orderSum.focus();
					$mainErrorContainer.fadeOut(3000);
					
					return;
				}

				//alert(1);
				$(document).off('submit', 'form#pay');
				form.submit();
			});	
	
            $(document).ready(function() {
				$("#user_tel").mask("+7 (999) ?999999999");
				$("#phone").mask("+7 (999) ?999999999");
				
<?php				
				if ($make_order == 1)
				{
					echo "$(\"#user_tel1\").mask(\"+7 (999) ?999999999\");\n";
					if (User::isAuthorized())
						echo "$(\"#user_region\").val(\"".$region."\");\n";
				}

				if ($detail != 0)
				{
echo <<< END2
					product_color_change();
					/*Config = {
							"item": {
								"allow360X":true,
								"interaction": "mousemove", // "drag"
								"impetus": "true", //"false"
								"containerSelector": ".pro360",
								"autoplay": {"interval": 100, "bounce": false},//frame timeout
								"folder":"/500px/",
								"zoomfolder":"/1000px/",
								"file": function(x,y) {	return pad(72 * y + x, 3) + ".jpg"},	//"000" slice(-3)	
								"type": "rect",
								"startX":1,
								"minX": 1,
								"maxX": 73,
								"startY":0,
								"minY": 0,
								"maxY": 5,
								"width": 320,
								"height": 320,
								"zoomfactor": 3
							}
						}					
					window.item = new PRO360(Config.item);*/
END2;
				}
				
				if ($main != 0 && $cnt_news > 0)
				{
					echo "$('#modal_news').modal('show');";
				}
				
?>
            });
            
</script>

<script>
	$( "#clothers" ).click(function( event ) {
		event.preventDefault();
	});
</script>

<?php
	if ($detail != 0 || $basket != 0)
	{
echo <<< END2
		<script type="text/javascript" src="/jcart/jcart-javascript.full.php"></script>
END2;
	}


	if ($detail != 0)
	{
echo <<< END1
		<script type='text/javascript'>
		/*function product_size_change()
		{
			
			var size_name = $('input[name="size_manuf_sel"]').val();
			var product_id = document.getElementById('productID').value;
			if(!size_name){
					$('div[name="color_sel"]').html('');
			}else{
					$.ajax({
							type: "POST",
							url: "/ajax_get_colors.php",
							data: { action: 'show_colors', size: size_name, product_id: product_id },
							cache: false,
							success: function(responce)
							{ 
								$(".gd_view_out .rg_opt .color_sel .dropdown-menu.inner").mCustomScrollbar("destroy");
								$('.gd_view_out .rg_opt .color_sel .selectpicker2').html(responce);
								//$('select[name="color_sel"]').html(responce); 
								$('.gd_view_out .rg_opt .color_sel .selectpicker2').selectpicker('refresh');
								$(".gd_view_out .rg_opt .color_sel .dropdown-menu.inner").mCustomScrollbar({
									theme:"inset-3-dark"
								});
							}
					});
			};
		}*/
		function product_color_change()
		{
			
			var id_color = $('select[name="color_sel"]').val();
			var product_id = document.getElementById('productID').value;
			//$('div[name="size_sel"]').html('');

			$.ajax({
					type: "POST",
					url: "/ajax_get_colors.php",
					data: { action: 'show_sizes', color: id_color, product_id: product_id },
					cache: false,
					success: function(responce)
					{ 
						$('div[name="size_sel"]').html(responce); 
						
						$('#size_manuf_sel').val($('.gd_view_out .rg_opt .size_manuf_sel a')[0].name);
						
						$('.gd_view_out .rg_opt .size_manuf_sel a').on("click", function(event) {
							$('.gd_view_out .rg_opt .size_manuf_sel a').removeClass('act');

							$(this).addClass('act');

							$('#size_manuf_sel').val($(this)[0].name);
							//product_size_change();

							event.preventDefault();
						});
					}
			});			
		}
		</script>
END1;
	}
?>


<script type="text/javascript">
	var widgetId1;
    var widgetId2;


	var onloadCallback = function() {
		
		mysitekey = '6LeaXBITAAAAAHNffkgFBmtAe2WLP5zxhkRKu8YM';
		widgetId1 = grecaptcha.render('recaptcha1', {
		'sitekey' : mysitekey});
		widgetId2 = grecaptcha.render('recaptcha2', {
		'sitekey' : mysitekey});
	};
	
	var refresh_captcha = function() {
		grecaptcha.reset(widgetId1);
		grecaptcha.reset(widgetId2);
	};
</script>

  </body>
</html>

<?php
	mysql_close();
?>
