function verifyFields()
{
	var $form = $('form.ajax2');
	
	if (document.getElementById('user_fio1').value == ''
		|| document.getElementById('user_fio2').value == ''
		|| document.getElementById('user_email').value == ''
		|| document.getElementById('user_tel1').value == '')
	{
		var $mainErrorContainer = $form.find('.main-error');
		var $msg = "";
		var $errField = null;

		if (document.getElementById('user_fio1').value == '')
		{
			$errField = $form.find('[name|="user_fio1"]');
			$msg = "������� �������";
		}

		if ($msg == "" && document.getElementById('user_fio2').value == '')
		{
			$errField = $form.find('[name|="user_fio2"]');
			$msg = "������� ���";
		}

		if ($msg == "" && document.getElementById('user_email').value == '')
		{
			$errField = $form.find('[name|="user_email"]');
			$msg = "������� email";
		}

		if ($msg == "" && document.getElementById('user_tel1').value == '')
		{
			$errField = $form.find('[name|="user_tel1"]');
			$msg = "������� �������";
		}

		if ($mainErrorContainer.hasClass('hidden')) {
			$mainErrorContainer.removeClass('hidden');
		}
		$mainErrorContainer.html($msg).show();
		$errField.focus();
		
		$(document).scrollTop(0);
		$mainErrorContainer.fadeOut(3000);

	}
	else
	{
		if (!document.getElementById('approve_agreement').checked)
		{
			var $mainErrorContainer = $form.find('.main-error');
			var $msg = "���������� ����������� � ��������� ������";
			var $errField = $form.find('[name|="approve_agreement"]');
			
			if ($mainErrorContainer.hasClass('hidden')) {
				$mainErrorContainer.removeClass('hidden');
			}
			$mainErrorContainer.html($msg).show();
			$errField.focus();
			
			$(document).scrollTop(0);
			$mainErrorContainer.fadeOut(3000);
			
			return;
		}
		document.getElementById('send_order').submit();
	}
}

