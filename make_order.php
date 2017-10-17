<?php
	$strTitle = "���������� ������";

	include_once ("init.tpl");

	$make_order = 1;
	$main = 0;

	if ($cart->get_count() <= 0)
	{
		header('Location: /');
		exit();
	}
	
	include_once ("top.tpl");
	
	if (User::isAuthorized())
	{
		$query = "SELECT Login, Surname, FirstName, FatherName, Region, Phone, Address FROM `MP_USER` WHERE UserID=".User::getUserID()." LIMIT 1";
		$sql = mysql_query($query) or die(mysql_error());
		if (mysql_num_rows($sql) == 1)
		{
			$row = mysql_fetch_assoc($sql);
			$surname = $row['Surname'];
			$firstname = $row['FirstName'];
			$fathername = $row['FatherName'];
			$region = $row['Region'];
			$phone = $row['Phone'];
			$address = $row['Address'];
			$email = $row['Login'];
		
			if ($email == 'modaopt1@gmail.com')
			{
				$surname = '';
				$firstname = '';
				$fathername = '';
				$region = '';
				$phone = '';
				$address = '';
				$email = '';
			}
		}
		mysql_free_result($sql);
	}
?>

        <div class="clearfix"></div>

        <ul class="breadcrambs">
            <li><a href="/">�������</a></li>
            <li><a href="/cart.php">�������</a></li>
            <li>���������� ������</li>
        </ul>
    </div>


    <div class="cart_list_out">

        <div class="title_points cart_list_title"><span>���������� ������</span></div>

        <div class="cart_list_form_out">

            <div class="container">

                <div class="cart_list_form_out2">

					<form class="form-signin ajax2" method="post" id = "send_order" action="/send_order.php">
						<script src="/js/verify.js" type="text/javascript"></script>
						<div class="main-error alert alert-danger hidden"></div>
						<div class="block contacts_out">
							<h5>1. ���� ���������� ������:</h5>
							<div class="block_inn">
								<div class="inp_bl">
									<label for="f_addr_statat">�������</label>
									<div class="form-group req"><!--has-error-->
										<input name = "user_fio1" id = "user_fio1" type="text" class="form-control fital" maxlength=40 placeholder="" value="<?php echo $surname ?>">
									</div>
								</div>
								<div class="inp_bl">
									<label for="f_addr_statat">���</label>
									<div class="form-group req">
										<input name = "user_fio2" id = "user_fio2" type="text" class="form-control fital" maxlength=40 placeholder="" value="<?php echo $firstname ?>">
									</div>
								</div>
								<div class="inp_bl">
									<label for="f_addr_statat">��������</label>
									<div class="form-group">
										<input name = "user_fio3" id = "user_fio3" type="text" class="form-control fital" maxlength=40 placeholder="" value="<?php echo $fathername ?>">
									</div>
								</div>

								<div class="inp_bl">
									<label for="f_addr_statat">��� e-mail</label>
									<div class="form-group req">
										<input name = "user_email" id = "user_email" type="text" class="form-control fital" maxlength=32 placeholder="" value="<?php echo $email ?>">
									</div>
								</div>
								<div class="inp_bl">
									<label for="f_addr_statat">���������� �������</label>
									<div class="form-group req">
										<input name = "user_tel1" id = "user_tel1" type="text" class="form-control fital" maxlength=32 placeholder="" value="<?php echo $phone ?>">
									</div>
								</div>
							</div>
						</div>

						<div class="block contacts_out">
							<h5>1. �������� ������:</h5>
							<div class="block_inn">
								<div class="inp_bl">
									<label for="f_addr_statat">����� ����� (��)</label>
									<div class="form-group">
										<input name = "user_size_og" type="text" class="form-control fital" maxlength=5 placeholder="">
									</div>
								</div>
								<div class="inp_bl">
									<label for="f_addr_statat">����� ����� (��)</label>
									<div class="form-group">
										<input name = "user_size_ob" type="text" class="form-control fital" maxlength=5 placeholder="">
									</div>
								</div>
								<div class="inp_bl">
									<label for="f_addr_statat">����� ����� (��)</label>
									<div class="form-group">
										<input name = "user_size_ot" type="text" class="form-control fital" maxlength=5 placeholder="">
									</div>
								</div>
							</div>
						</div>

						<div class="block delivery_out">
							<h5>2. ����� ������� ��������:</h5>
							<div class="block_inn">
								<input name="user_delivery" id="f_delivery" type="hidden" value="1">
								<!--<div class="title">������ ������:</div>-->
								<div class="radio">

									<a href="#" class="item sel" data-val="1">
										<span class="stitle"><span>�������� �� ������ 350 ���.</span></span>
										<span class="ico ico_cart_deliv_1"></span>
										<span class="stat">Moscow</span>
										<span class="rad"></span>
									</a>

									<a href="#" class="item" data-val="2">
										<span class="stitle"><span>�������� �� ������</span></span>
										<span class="ico ico_cart_deliv_1"></span>
										<span class="stat">Russia</span>
										<span class="rad"></span>
									</a>

									<a href="#" class="item" data-val="4">
										<span class="stitle"><span>������������� ��������</span></span>
										<span class="ico ico_cart_deliv_1"></span>
										<span class="stat">World</span>
										<span class="rad"></span>
									</a>

									<a href="#" class="item" data-val="3">
										<span class="stitle"><span>���������</span></span>
										<span class="ico ico_cart_deliv_2"></span>
										<span class="stat">&nbsp;</span>
										<span class="rad"></span>
									</a>
								</div>

							</div>
						</div>


						<div class="block address_out">
							<h5>3. ����� ��������:</h5>
							<div class="block_inn">

								<div class="inp_bl">
									<label for="f_addr_statat">������</label>
									<div class="form-group">
										<select name="user_region" size="1" class="form-control fital" id = "user_region">
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
											<option value="��������� ���. �������">��������� ���. �������</option>
											<option value="���������� �������">���������� �������</option>
											<option value="��������� ����.">��������� ����.</option>
											<option value="��������� �������">��������� �������</option>
											<option value="���������-���������� ����.">���������-���������� ����.</option>
											<option value="��������������� �������">��������������� �������</option>
											<option value="�������� ����.">�������� ����.</option>
											<option value="��������� �������">��������� �������</option>
											<option value="���������� �������">���������� �������</option>
											<option value="���������-���������� ����.">���������-���������� ����.</option>
											<option value="������� ����.">������� ����.</option>
											<option value="����������� �������">����������� �������</option>
											<option value="��������� �������">��������� �������</option>
											<option value="���� ����.">���� ����.</option>
											<option value="����������� �������">����������� �������</option>
											<option value="������������� ����">������������� ����</option>
											<option value="������������ ����">������������ ����</option>
											<option value="���������� �������">���������� �������</option>
											<option value="������� �������">������� �������</option>
											<option value="������������� �������">������������� �������</option>
											<option value="�������� �������">�������� �������</option>
											<option value="����������� �������">����������� �������</option>
											<option value="����� �� ����.">����� �� ����.</option>
											<option value="�������� ����.">�������� ����.</option>
											<option value="���������� �������">���������� �������</option>
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
											<option value="����. ���������">����. ���������</option>
											<option value="���������� �������">���������� �������</option>
											<option value="��������� �������">��������� �������</option>
											<option value="��������� �������">��������� �������</option>
											<option value="�����-���������">�����-���������</option>
											<option value="����������� �������">����������� �������</option>
											<option value="���� (������) ����.">���� (������) ����.</option>
											<option value="����������� �������">����������� �������</option>
											<option value="������������ �������">������������ �������</option>
											<option value="�������� ������-������ ����.">�������� ������-������ ����.</option>
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
											<option value="����������� �������">����������� �������</option>
											<option value="��������� ����.">��������� ����.</option>
											<option value="��������� �������">��������� �������</option>
											<option value="��������� ����.">��������� ����.</option>
											<option value="��������� ���. ���.">��������� ���. ���.</option>
											<option value="����������� �������">����������� �������</option>
											<option value="�����-�������� ��">�����-�������� ��</option>
										</select>
									</div>
								</div>

								<div class="inp_bl">
									<label for="f_addr_statat">����� ��������</label>
									<div class="form-group">
										<textarea name="user_city" class="form-control fital" maxlength=512><?php echo $address ?></textarea>
									</div>
								</div>

								<div class="inp_bl">
									<label for="f_addr_statat">�����������</label>
									<div class="form-group">
										<textarea name="user_comment" class="form-control fital" maxlength=256></textarea>
									</div>
								</div>
							</div>
						</div>

						<div class="clearfix"></div>
						<div class="check_oferta_out">
							<div class="checkbox check_oferta">
								<label><input type="checkbox" id="approve_agreement" name="approve_agreement" checked> � ��������� ������ ��������(��)</label>
							</div>
						</div>
						<div class="clearfix"></div>

						<div class="cart_list_order">
							<input type="hidden" name="act" value="make_order">
							<button style = 'float:right;' class='form_butt_2' name='my-send-order-button' onclick="javascript:verifyFields();" type='button' value=' '><span>����������� �����</span></button>
						</div>
					</form>

                </div>
            </div>
        </div>


    </div>

<?php
	include_once ("bottom.tpl");
?> 
