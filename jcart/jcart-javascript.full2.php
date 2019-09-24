<?php

// JCART v1.1
// http://conceptlogic.com/jcart/

// INCLUDE CONFIG SO THIS SCRIPT HAS ACCESS USER FIELD NAMES
require_once('jcart-config.php');

// INCLUDE DEFAULT VALUES SINCE WE NEED TO PASS THE VALUE OF THE UPDATE BUTTON BACK TO jcart.php IF UPDATING AN ITEM QTY
// IF NO VALUE IS SET IN CONFIG, THERE MUST BE A DEFAULT VALUE SINCE SIMPLY CHECKING FOR THE VAR ITSELF FAILS
require_once('jcart-defaults.php');

// OUTPUT PHP FILE AS JAVASCRIPT
header('content-type:application/x-javascript');
header('content-type:text/html; charset=windows-1251');
// PREVENT CACHING
header("Cache-Control: no-cache, must-revalidate"); // HTTP/1.1
header("Expires: Sat, 26 Jul 1997 05:00:00 GMT"); // Date in the past

// CONTINUE THE SESSION
session_start("monparis");

?>

// WHEN THE DOCUMENT IS READY
$(function(){

    $('form.favourite').submit(function(){

        var product_id = $(this).find('input[name=product_id]').val();
        var user_id = $(this).find('input[name=user_id]').val();

        $.post('<?php echo $jcart['path'];?>jcart-relay_fav.php', { "product_id" : product_id, "user_id" : user_id }, function(data) {
			// REPLACE EXISTING CART HTML WITH UPDATED CART HTML
			if (data == 1 || data == '1')
			    $('#fav' + product_id).removeClass("fav_off").addClass("fav_on");
			else
			    $('#fav' + product_id).removeClass("fav_on").addClass("fav_off");
			});

        return false;
		});

	$('form.favourite_del').submit(function(){

        var product_id = $(this).find('input[name=product_id]').val();
        var user_id = $(this).find('input[name=user_id]').val();

        $.post('<?php echo $jcart['path'];?>jcart-relay_fav.php', { "product_id" : product_id, "user_id" : user_id }, function(data) {
			// REPLACE EXISTING CART HTML WITH UPDATED CART HTML
			if (data == 1 || data == '1')
			    $('#fav' + product_id).removeClass("fav_off").addClass("fav_on");
			else
			{
			    $('#item' + product_id).remove();
			    if ($('.item').length == 0)
			    {
			        $('.hits_list_slider').html("<div><h4><p>������ � ��� ������ ��� � ����������</p></h4></div>" +
                            "<div><p>����� �������� ������������� ����� � ����������, �������� ��� �������� <ins class='wishlist_img'></ins>! ��� ����� ������� ��� �� �������� ������, ��� � �� ������ ��������.</p></div>" +
                            "<div><p>������ ��������� ������� ����������� � ����� ���������, ��� ������, ����� �� ����������� ����������� ������������. ��������, ���� �� �������������� ����� �����������, ��������� � ����������.</p></div>" +
                            "<div><p>������� ����� � ���������, �� ����� ������� ��������� � ���� � ������� ��� ��� �����. ��������, ����� �������� ������������� ��� ������ � ������ ���������� ����������� �������, ��� �������� ������� ����������� ���������� ������������.</p></div>");
			    }
			}
			});

        return false;
		});
	// END THE DOCUMENT READY FUNCTION
	});
