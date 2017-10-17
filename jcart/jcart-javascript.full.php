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

	// CHECK IF THERE ARE ANY ITEMS IN THE CART
	var cartHasItems = $('td.jcart-item-qty').html();
	if(cartHasItems === null)
		{
		// DISABLE THE PAYPAL CHECKOUT BUTTON
		$('#jcart-paypal-checkout').attr('disabled', 'disabled');
		}

	// HIDE THE UPDATE AND EMPTY BUTTONS SINCE THESE ARE ONLY USED WHEN JAVASCRIPT IS DISABLED
	$('.jcart-hide').remove();

	// DETERMINE IF THIS IS THE CHECKOUT PAGE BY CHECKING FOR HIDDEN INPUT VALUE
	// SENT VIA AJAX REQUEST TO jcart.php WHICH DECIDES WHETHER TO DISPLAY THE CART CHECKOUT BUTTON OR THE PAYPAL CHECKOUT BUTTON BASED ON ITS VALUE
	// WE NORMALLY CHECK AGAINST REQUEST URI BUT AJAX UPDATE SETS VALUE TO jcart-relay.php
	//var isCheckout = $('#jcart-is-checkout').val();

	// IF THIS IS NOT THE CHECKOUT THE HIDDEN INPUT DOESN'T EXIST AND NO VALUE IS SET
	//if (isCheckout !== 'true') { isCheckout = 'false'; }
	
	isCheckout = 'false';

	// WHEN AN ADD-TO-CART FORM IS SUBMITTED
	$('form.jcart').submit(function(){

		$('button[name=my-add-button]').attr("disabled", "disabled"); // выключаем кнопку, чтобы не было повторных срабатываний

		// GET INPUT VALUES FOR USE IN AJAX POST
		var itemId = $(this).find('input[name=<?php echo $jcart['item_id']?>]').val();
		
		var color = $(this).find('select[name=<?php echo $jcart['item_color']?>]').val();
		var itemAttribID = $(this).find('input[name=<?php echo $jcart['item_size']?>]').val();
		var n = itemAttribID.split("$");
		itemId = itemId + "_" + n[0];
		var size = n[1];
		
		//var itemAttribID = $(this).find('select[name=<?php echo $jcart['item_color']?>]').val();
		//var n = itemAttribID.split("$");
		//itemId = itemId + "_" + n[0];
		//var color = n[1];
		//var size = $(this).find('input[name=<?php echo $jcart['item_size']?>]').val();

		var itemPrice = $(this).find('input[name=<?php echo $jcart['item_price']?>]').val();
		var itemName = $(this).find('input[name=<?php echo $jcart['item_name']?>]').val();
		itemName = itemName + '$' + color + '$' + size;
		
		var itemQty = $(this).find('input[name=<?php echo $jcart['item_qty']?>]').val();
		var itemAdd = $(this).find('button[name=<?php echo $jcart['item_add']?>]').val();
		
		// SEND ITEM INFO VIA POST TO INTERMEDIATE SCRIPT WHICH CALLS jcart.php AND RETURNS UPDATED CART HTML
		$.post('<?php echo $jcart['path'];?>jcart-relay.php', { "<?php echo $jcart['item_id']?>": itemId, "<?php echo $jcart['item_price']?>": itemPrice, "<?php echo $jcart['item_name']?>": itemName, "<?php echo $jcart['item_qty']?>": itemQty, "<?php echo $jcart['item_add']?>" : itemAdd }, function(data) {

			// REPLACE EXISTING CART HTML WITH UPDATED CART HTML
			var arr = data.split("|||||");
			// REPLACE EXISTING CART HTML WITH UPDATED CART HTML
			$('#jcart').html(arr[0]);
			$('#jcart2').html(arr[1]);
			$('.jcart-hide').remove();
			
			$('#basket_msg').show();
			$('#price_bl_lf').height(75);
			$('button[name=my-add-button]').hide();
			$('a[name=my-cart-button]').show();
			//$('#basket_msg').fadeIn(500);
			//$('#basket_msg').fadeOut(3000);			
			});

		// PREVENT DEFAULT FORM ACTION
		return false;

		});
		
	$('form.jcart_put').submit(function(){
		// GET INPUT VALUES FOR USE IN AJAX POST
		var itemId_put = $(this).find('input[name=<?php echo $jcart['item_id_put']?>]').val();
		var itemAdd_put = $(this).find('input[name=<?php echo $jcart['item_add_put']?>]').val();
		
		// SEND ITEM INFO VIA POST TO INTERMEDIATE SCRIPT WHICH CALLS jcart.php AND RETURNS UPDATED CART HTML
		$.post('<?php echo $jcart['path'];?>jcart-relay_put.php', { "<?php echo $jcart['item_id_put']?>": itemId_put, "<?php echo $jcart['item_add_put']?>" : itemAdd_put }, function(data) {

			var arr = data.split("|||||");			
			// REPLACE EXISTING CART HTML WITH UPDATED CART HTML
			$('#jcart_put').html(arr[0]);
			$('#jcart_short_put').html(arr[1]);
			$('.jcart-hide').remove();
			
			$('#basket_msg').fadeIn(500);
			$('#basket_msg').fadeOut(3000);			
			});

		// PREVENT DEFAULT FORM ACTION
		return false;

		});


	// WHEN THE VISITOR HITS THEIR ENTER KEY
	// THE UPDATE AND EMPTY BUTTONS ARE ALREADY HIDDEN
	// BUT THE VISITOR MAY UPDATE AN ITEM QTY, THEN HIT THEIR ENTER KEY BEFORE FOCUSING ON ANOTHER ELEMENT
	// THIS MEANS WE'D HAVE TO UPDATE THE ENTIRE CART RATHER THAN JUST THE ITEM WHOSE QTY HAS CHANGED
	// PREVENT ENTER KEY FROM SUBMITTING FORM SO USER MUST CLICK CHECKOUT OR FOCUS ON ANOTHER ELEMENT WHICH TRIGGERS CHANGE FUNCTION BELOW
	$('#jcart').keydown(function(e) {

		// IF ENTER KEY
		if(e.which == 13) {

		// PREVENT DEFAULT ACTION
		return false;
		}
	});


	// JQUERY live METHOD MAKES FUNCTIONS BELOW AVAILABLE TO ELEMENTS ADDED DYNAMICALLY VIA AJAX

	// WHEN A REMOVE LINK IS CLICKED
	$(document).on('click', '#jcart a', function(){

		// GET THE QUERY STRING OF THE LINK THAT WAS CLICKED
		var queryString = $(this).attr('href');
		queryString = queryString.split('=!'); // делаем так специально, чтобы не спутать с другими ссылками
		
		if (queryString[1]==undefined)
		{
			var bb=$(this).attr('href');
			bb=bb.split('=');
			queryString=b[1];
			document.location=queryString;
			return true;
		};

		// THE ID OF THE ITEM TO REMOVE
		var removeId = queryString[1];
		
		// SEND ITEM ID VIA GET TO INTERMEDIATE SCRIPT WHICH CALLS jcart.php AND RETURNS UPDATED CART HTML
		$.get('<?php echo $jcart['path'];?>jcart-relay.php', { "jcart_remove": removeId, "jcart_is_checkout":  isCheckout },
			function(data) {

			// REPLACE EXISTING CART HTML WITH UPDATED CART HTML
			var arr = data.split("|||||");
			// REPLACE EXISTING CART HTML WITH UPDATED CART HTML
			$('#jcart').html(arr[0]);
			$('#jcart2').html(arr[1]);
			$('.jcart-hide').remove();
			});

		// PREVENT DEFAULT LINK ACTION
		return false;
	});


	// WHEN AN ITEM QTY CHANGES
	// CHANGE EVENT IS NOT CURRENTLY SUPPORTED BY LIVE METHOD
	// STILL WORKS IN MOST BROWSERS, BUT NOT INTERNET EXPLORER
	// INSTEAD WE SIMULATE THE CHANGE EVENT USING KEYUP AND SET A DELAY BEFORE UPDATING THE CART
	$(document).on('keyup', '#jcart input[name=a]', function(){

		// GET ITEM ID FROM THE ITEM QTY INPUT ID VALUE, FORMATTED AS jcart-item-id-n
		var updateId = $(this).attr('id');
		updateId = updateId.split('jcart');

		// THE ID OF THE ITEM TO UPDATE
		updateId = updateId[1];

		// GET THE NEW QTY
		var updateQty = $(this).val();

		// AS LONG AS THE VISITOR HAS ENTERED A QTY
		if (updateQty !== '')
			{
			// UPDATE THE CART ONE SECOND AFTER KEYUP
			var updateDelay = setTimeout(function(){

				if (updateQty <= 0)
				{
					updateQty = 1;
					$(this).val(1);
				}
				// SEND ITEM INFO VIA POST TO INTERMEDIATE SCRIPT WHICH CALLS jcart.php AND RETURNS UPDATED CART HTML
				$.post('<?php echo $jcart['path'];?>jcart-relay.php', { "item_id": updateId, "item_qty": updateQty, "jcart_update_item": '<?php echo $jcart['text']['update_button'];?>', "jcart_is_checkout": isCheckout }, function(data) {
					var arr = data.split("|||||");
					// REPLACE EXISTING CART HTML WITH UPDATED CART HTML
					$('#jcart').html(arr[0]);
					$('#jcart2').html(arr[1]);
					$('.jcart-hide').remove();

					});

				}, 500);
			}

		// IF THE VISITOR PRESSES ANOTHER KEY BEFORE THE TIMER HAS EXPIRED, CLEAR THE TIMER
		// THE NEW KEYDOWN RESULTS IN A NEW KEYUP, TRIGGERING THE KEYUP FUNCTION AGAIN AND RESETTING THE TIMER
		// REPEATS UNTIL THE USER DOES NOT PRESS A KEY BEFORE THE TIMER EXPIRES IN WHICH CASE THE AJAX POST IS EXECUTED
		// THIS PREVENTS THE CART FROM BEING UPDATED ON EVERY KEYSTROKE
		$(this).keydown(function(){
			window.clearTimeout(updateDelay);
			});
		});


	// END THE DOCUMENT READY FUNCTION
	});
