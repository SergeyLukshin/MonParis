// ������ ���� ���������
var slider_price_start_min  = $( "#slider_price_min" ).val();          // ��������� �������
var slider_price_start_max  = $( "#slider_price_max" ).val();        // ��������� ��������
var slider_price_min        = 500;          // �������
var slider_price_max        = 100000;       // ��������
var slider_price_step       = 100;          // ���


// ������� ���� ���������
var submenu_hover = false;
var submenu_hover_timeout = false;

// ���� ������, �������, ���������
var if_hits_slider_r1_init = false;
var if_hits_slider_r2_init = false;





(function($) {
	'use strict';

    modals_init();              // ��������� ����

    top_menu_init();            // ������� ����

    first_init_all();           // ������� ��������

    // ������
    $(window).resize(function() {
        resize_init();
    });

    //brend_init();               // �������� ������

    contacts_out_order();       // ��������, �������� ������ �������

    cart_init();                // �������� �������

    gdview_init();              // �������� ������

    catalog_init();             // �������

    footer_resize();            // ����� ������

    setTimeout(function() {
        history_tab_hg();       // ������� ������� - ������������� �������
    }, 100);

    //$('#modal_aviable').modal('show');
    if ( $(".gd_view_out .gd_im .gd_im_inn table td > img").length > 0 ) {
    
        $(".gd_view_out .gd_im .gd_im_inn table td > img").imagezoomsl({

            zoomrange: [1, 5],
            descarea: ".gd_view_out .rg_opt .zoomim",
            magnifierborder: "none",
            magnifiereffectanimate: "fadeIn",
            scrollspeedanimate: 1,
            loadopacity: 0,
            zindex: 1050,
            cursorshade: false
        });

    }

    if ( $(".fancybox").length > 0 ) {
        $(".fancybox").fancybox({
            beforeLoad : function() {

                if (!this.element.hasClass('gd_fansy') && ($('.fancybox-overlay').length == 0)) {
                    return false;
                }
            },
            padding:0
        });
    }

    gd_im_resize();
    
    
    // ��������, ������������ ����� � ��������
    $('.cont_sw_butt').on("click", function(event) {

        var targ = $(this).data('target');

        $('.cont_sw').hide();
        $('.cont_sw_'+targ).show();

        event.preventDefault();
    });

})(jQuery);






function gd_im_resize() {

    if ($('.gd_view_out .gd_im .gd_im_inn table td > img').length ==0) { return; }

    var t1 = $(".gd_view_out .gd_im .gd_im_inn table td > img");
    var t2 = $(".gd_view_out .gd_im .gd_im_inn");

    t1.width('auto').height('auto').hide();

    var t3 = t1.width() / t1.height();
    var t4 = t2.width() / t2.height();

    if (t3 > t4) {

        t1.width('100%');

    } else {

        t1.height('100%');
    }

    t1.show();
}





function resize_init() {

    next_menu_resize();         // ������������� �������� ���� �� ������

    setTimeout(function() {
        top_collection_hg();    // �������� ������ ��������� �� �������
    }, 10);

    if ( $('.brends_slider_inn').length > 0 ) {
        $('.brends_slider_inn').slickGoTo( 0, true );
    }

    hits_list_slider_resize();      // ���� ������, ������, �������� � 1 ��� 2 ������

    contacts_out_order();           // ��������, �������� ������ �������

    history_tab_hg();               // ������� ������� - ������������� �������

    modal_tabsize_pos();            // ������� ��������, �������������

    modal_aviable_pos();            // �������, �������������

    modal_feedback_pos();           // ����� �������� �����, �������������

    footer_resize();                // ����� ������
    
    gd_im_resize();
}


// �������� ����� ����
function test1_go() {

    var opt_arr = [
        ['�������1', '1', 0],
        ['�������2', '2', 0],
        ['�������3', '3', 1],   // selected
        ['�������4', '4', 0],
        ['�������5', '5', 0],
        ['�������6', '6', 0],
        ['�������7', '7', 0],
        ['�������8', '8', 0],
        ['�������9', '9', 0],
        ['�������10', '10', 0]
    ];

    gd_color_add(opt_arr);
}






//  �������� ������ ������ � ������
//  opt_arr = [
//      ['��������', 'value', selected=0/1],
//      ['�����', '1', 0],
//      ['�����', '2', 0]
//  ]
function gd_color_add(opt_arr) {

    var new_opt = '';

    for(var i=0; i < opt_arr.length; i++) {
        new_opt += '<option value="'+opt_arr[i][1]+'" '+((opt_arr[i][2]==1)?'selected="selected"':'')+'>'+opt_arr[i][0]+'</option>';
    }

    $(".gd_view_out .rg_opt .color_sel .dropdown-menu.inner").mCustomScrollbar("destroy");

    $('.gd_view_out .rg_opt .color_sel .selectpicker2').html(new_opt);

    $('.gd_view_out .rg_opt .color_sel .selectpicker2').selectpicker('refresh');

    $(".gd_view_out .rg_opt .color_sel .dropdown-menu.inner").mCustomScrollbar({
        theme:"inset-3-dark"
    });

}





// �������� ������
function gdview_init() {

    gd_recomm_slider_init();    // �������� ������ - ������������, �������


    // �������� ������ - ������ ����� �����
    if ($('.gd_view_out .rg_opt .color_sel .selectpicker2').length  > 0) {
        $('.gd_view_out .rg_opt .color_sel .selectpicker2').selectpicker();
    }

    // �������� ������ - ������ ����� ����� - ������
    if ($('.gd_view_out .rg_opt .color_sel .dropdown-menu.inner').length  > 0) {
        $(".gd_view_out .rg_opt .color_sel .dropdown-menu.inner").mCustomScrollbar({
            theme:"inset-3-dark"
        });
    }

    // �������� ������ - ������ �������� ������
    if ($('.gd_view_out .gd_im .im_list').length  > 0) {
        $(".gd_view_out .gd_im .im_list").mCustomScrollbar({
            theme:"light"
        });
    }


    // �������� ������ - ���� �� ������ ��������
    $('.gd_view_out .gd_im .im_list .item').on("click", function(event) {

        $('.gd_view_out .gd_im .im_list .item').removeClass('act');

        //$('.gd_view_out .gd_im .gd_im_inn').css('background-image', 'url('+$(this).attr('href')+')');
        $('.gd_view_out .gd_im .gd_im_inn td > img').attr('src', ''+$(this).attr('href'));
        $('.gd_view_out .gd_im .gd_im_inn a.gd_fansy').attr('href', ''+$(this).attr('href'));

        $(this).addClass('act');

        gd_im_resize();

        event.preventDefault();
    });


    // �������� ������ - ������� �������������
    $('.gd_view_out .rg_opt .size_manuf_sel a').on("click", function(event) {

        $('.gd_view_out .rg_opt .size_manuf_sel a').removeClass('act');

        $(this).addClass('act');

        $('#size_manuf_sel').val($(this).text());
        //product_size_change();

        event.preventDefault();
    });


    // �������� ������ - ���������� �������
    $('.gd_view_out .rg_opt .size_ross_sel a').on("click", function(event) {

        $('.gd_view_out .rg_opt .size_ross_sel a').removeClass('act');

        $(this).addClass('act');

        $('#size_ross_sel').val($(this).text());

        event.preventDefault();
    });
}


// �������
function catalog_init() {


    catalog_out_size();     // �������, ����� ����, ������������� ������ ��������


    // ������� ����� ����
    $('.catalog_out .left_menu_inn a').on("click", function(event) {

        var t1 = $(this);

        if (t1.parent().children('ul').length == 0) {
            return;
        }

        t1.parent().children('ul').stop().slideToggle(300, function() {
            $(this).height('auto');
        });

        event.preventDefault();
    });




    // ������� - ������� ���������, �������
    $('.catalog_out .rg_out .filter_out .hd_tp_butt').on("click", function(event) {

        var t1 = $(this);

        $('.catalog_out .rg_out .filter_out .hd_tp_butt').not(this).parent().find('.dw').stop().fadeOut(150);
        $('.catalog_out .rg_out .filter_out .hd_tp_butt.sel').not(this).removeClass('sel');

        t1.toggleClass('sel');

        var t2 = Math.round(t1.outerWidth());

        t1.parent().find('.dw .tp').width(t2-4);

        t1.parent().find('.dw').stop().slideToggle(200, function() {
            $(this).height('auto');
        });

        event.preventDefault();
    });

    filter_item_bt_size();  // �������, ������������� ������ ��������


    // ������� - ������ �������
    $('.sz_checkb li a').on("click", function(event) {

        var t1 = $(this);

        if (t1.hasClass('act')) {

            t1.removeClass('act');
            t1.find('input').val('');

        } else {

            t1.addClass('act');
            t1.find('input').val(t1.find('span').text());
        }

        event.preventDefault();
    });



    // ������� - ������ �����
    $('.brend_checkb li a').on("click", function(event) {

        var t1 = $(this);

        if (t1.hasClass('act')) {

            t1.removeClass('act');
            t1.find('input').val('');

        } else {

            t1.addClass('act');
            t1.find('input').val(t1.data('id'));
        }

        event.preventDefault();
    });


    // ������� - ������ ����
    $('.color_checkb li a').on("click", function(event) {

        var t1 = $(this);

        if (t1.hasClass('act')) {

            t1.removeClass('act');
            t1.find('input').val('');

        } else {

            t1.addClass('act');
            t1.find('input').val(t1.data('id'));
        }

        event.preventDefault();
    });





    // ������� - ������ ����� ������ ������
    if ($('.catalog_out .rg_out .filter_out .filter_it .dw .inn .brend_checkb').length  > 0) {
        $(".catalog_out .rg_out .filter_out .filter_it .dw .inn .brend_checkb").mCustomScrollbar({
            theme:"light"
        });
    }


    // ������� - ������ ���� ��������
    if ($( "#slider_price" ).length > 0) {

        $( "#slider_price" ).slider({
        	range: true,                // �������
        	values: [ slider_price_start_min, slider_price_start_max ],    // ��������� ��������
            min : slider_price_min,     // �������
            max : slider_price_max,     // ��������
            step : slider_price_step,   // ���

            create: function( event, ui ) {     // ��������

                var v1 = $( "#slider_price" ).slider("values", 0);  // �������� ��������� �������� ��
                var v2 = $( "#slider_price" ).slider("values", 1);  // �������� ��������� �������� ��

                $( ".slider_price_min" ).val( v1 );                 // �������� �������� � ���� ��
                $( ".slider_price_max" ).val( v2 );                 // �������� �������� � ���� ��

            },
            slide: function( event, ui ) {      // ��������

                $( ".slider_price_min" ).val( ui.values[0] );   // �������� �������� � ���� ��
                $( ".slider_price_max" ).val( ui.values[1] );   // �������� �������� � ���� ��

            }
        });
    }

    // ��� ��������� � ���� ������� - �������� ��������
    $('.slider_price_min').change(function(event) {

        var v2 = $( "#slider_price" ).slider("values", 1);

        var v1  = $('.slider_price_min').val();
        v1      = v1*1;

        if ( v1 < slider_price_min) {

            v1 = slider_price_min;
            $('.slider_price_min').val(v1);

        } else if (v1 > v2) {
            v1 = v2;
            $('.slider_price_min').val(v1);
        }

        $( "#slider_price" ).slider("values", 0, v1);

    });


    // ��� ��������� � ���� �������� - �������� ��������
    $('.slider_price_max').change(function(event) {

        var v1 = $( "#slider_price" ).slider("values", 0);

        var v2  = $('.slider_price_max').val();
        v2      = v2*1;

        if ( v2 > slider_price_max ) {

            v2 = slider_price_max;
            $('.slider_price_max').val(v2);

        } else if (v2 < v1) {
            v2 = v1;
            $('.slider_price_max').val(v2);
        }

        $( "#slider_price" ).slider("values", 1, v2);

    });
}









// �������� �������
function cart_init() {

    // ������� - ����� ������� �������� radio
    $('.cart_list_form_out .delivery_out a.item').on("click", function(event) {

        $('.cart_list_form_out .delivery_out a.item').removeClass('sel');
        $(this).addClass('sel');

        $('#f_delivery').val($(this).data('val'));

        event.preventDefault();
    });



    // ������� - ��������� ���������� ������
    $(document).on("click", '#jcart button[name=minus]', function(event) {

		var inp = $(this).parent().find('input');
		
        var count =  inp.val()*1;

        count--;

        if (count < 1) {
            count = 1;
        }

        inp.val(count);

        var updateId = inp.attr('id');
		updateId = updateId.split('=');

		// THE ID OF THE ITEM TO UPDATE
		updateId = updateId[3];

		// GET THE NEW QTY
		var updateQty = inp.val();

		// AS LONG AS THE VISITOR HAS ENTERED A QTY
		if (updateQty !== '')
			{
			// SEND ITEM INFO VIA POST TO INTERMEDIATE SCRIPT WHICH CALLS jcart.php AND RETURNS UPDATED CART HTML
			$.post('/jcart/jcart-relay.php', { "item_id": updateId, "item_qty": updateQty, "jcart_update_item": 'update', "jcart_is_checkout": false }, function(data) {
				var arr = data.split("|||||");
				// REPLACE EXISTING CART HTML WITH UPDATED CART HTML
				$('#jcart').html(arr[0]);
				$('#jcart2').html(arr[1]);
				$('.jcart-hide').remove();

				});
			}
        event.preventDefault();
    });


    // ������� - ��������� ���������� ������
    $(document).on("click", '#jcart button[name=plus]', function(event) {

		var inp = $(this).parent().find('input');

        var count =  inp.val()*1;

        count++;

        inp.val(count);

        var updateId = inp.attr('id');
		updateId = updateId.split('=');

		// THE ID OF THE ITEM TO UPDATE
		updateId = updateId[3];

		// GET THE NEW QTY
		var updateQty = inp.val();

		// AS LONG AS THE VISITOR HAS ENTERED A QTY
		if (updateQty !== '')
			{
			// SEND ITEM INFO VIA POST TO INTERMEDIATE SCRIPT WHICH CALLS jcart.php AND RETURNS UPDATED CART HTML
			$.post('/jcart/jcart-relay.php', { "item_id": updateId, "item_qty": updateQty, "jcart_update_item": 'update', "jcart_is_checkout": false }, function(data) {
				var arr = data.split("|||||");
				// REPLACE EXISTING CART HTML WITH UPDATED CART HTML
				$('#jcart').html(arr[0]);
				$('#jcart2').html(arr[1]);
				$('.jcart-hide').remove();

				});
			}
        event.preventDefault();
    });
}




// �������� ������
function brend_init() {

    $('.brend_list_inn .item').on("click", function(event) {

        var t1 = $(this);

        $('.brend_list_current a.item').attr('href', t1.attr('href'));
        $('.brend_list_current .text_inn2 .mCSB_container').html(t1.find('.text').html());
        $('.brend_list_current .text_inn .title').text(t1.find('.title').text());

        $('.brend_list_current .item .bg').css({'background-image': t1.find('.bg').css('background-image')});

        $('.brend_list_current .text_inn2').mCustomScrollbar("update");

        $('.brend_list_current .text_inn2').mCustomScrollbar('scrollTo','top',{scrollInertia:0});

        event.preventDefault();
        
        //$(document).scrollTop(0);
        if ($(window).scrollTop() > $("#title_points").offset().top)
			$(document).scrollTop($("#title_points").offset().top);
    });


    var brend_list_first_sh = false;

    // ������
    if ( $('.brend_list_inn .item').length > 0 ) {

        $(".brend_list_current .text_inn2").mCustomScrollbar({
            axis:"y",
            scrollInertia: 300,
            theme:"3d-dark",
            callbacks:{
                onInit:function(){
                    if (!brend_list_first_sh) {
                        $('.brend_list_inn .item:first-child').trigger('click');
                        brend_list_first_sh = true;
                    }
                }
            }
        });

        if (!brend_list_first_sh) {
            $('.brend_list_inn .item:first-child').trigger('click');
            brend_list_first_sh = true;
        }
    }
}




// ������� ��������
function first_init_all() {

    setTimeout(function() {
        top_collection_hg();    // �������� ������ ��������� �� �������
    }, 10);


    hits_add_slider_2_rows();       // ���� ������, ����������� ������� �� 2 ������
    hits_list_slider_resize();      // ���� ������, ������, �������� � 1 ��� 2 ������


    // ������� �� ������� ������
    if ( $('.first_slider .flexslider').length > 0 ) {

        $('.first_slider .flexslider').flexslider({
            animation: "fade",
            directionNav: false,
            controlNav: true,
            slideshow: false,
            slideshowSpeed: 5000,
            prevText: '',
            nextText: '',
            controlsContainer: '.frts_slider_nav'
        });
    }



    // ������� �������
    if ( $('.brends_slider_inn').length > 0 ) {
    	$('.brends_slider_inn').slick({
            infinite: false,
    		draggable: false,
    		dots: false,
    		slidesToShow: 6,
      		slidesToScroll: 6,
            slide: 'a',
            autoplay: false,
            autoplaySpeed: 5000,
            speed: 1000,
            responsive: [
                {
                    breakpoint: 991,
                    settings: {
                        slidesToShow: 4,
                        slidesToScroll: 4,
                        infinite: false,
                        dots: false
                    }
                },
                {
                    breakpoint: 700,
                    settings: {
                        slidesToShow: 3,
                        slidesToScroll: 3
                    }
                },
                {
                    breakpoint: 550,
                    settings: {
                        slidesToShow: 2,
                        slidesToScroll: 2
                    }
                },
                {
                    breakpoint: 400,
                    settings: {
                        slidesToShow: 1,
                        slidesToScroll: 1
                    }
                }
              ]
    	});
    }





}














// ������� ����
function top_menu_init() {

    $( ".top_menu .menu > li > a" ).hover(
        function() {

            var t1 = $( this ).parent().find('.sub-menu');

            if ( t1.length > 0) {

                if (t1.offset().left < 0) {
                    return;
                }

                $( 'body > ul.sub-menu' ).remove();
                t1.clone().appendTo('body');

                $( 'body > ul.sub-menu' ).css({'left':t1.offset().left+'px', 'top':t1.offset().top+'px' });

                $( "body > ul.sub-menu" ).hover(
                    function() { submenu_hover = true; },
                    function() { submenu_hide(); }
                );
                submenu_hover = true;
            }
        }, function() { submenu_hide(); }
    );

    $('.top_menu_scroll .next').on("click", function(event) {

        $('.top_menu').stop().animate({scrollLeft:$('.top_menu').scrollLeft()+$(".top_menu").width()/2}, 300, 'swing', function() {});
        event.preventDefault();
    });

    $('.top_menu_scroll .prev').on("click", function(event) {

        $('.top_menu').stop().animate({scrollLeft:$('.top_menu').scrollLeft() - $(".top_menu").width()/2}, 300, 'swing', function() {});
        event.preventDefault();
    });

    setTimeout(next_menu_resize, 50);   // ������������� �������� ���� �� ������
}





// ��������� ����
function modals_init() {

    // ��������� ����, ��� �������� ������ ������
    $(".modal").on("show.bs.modal", function(){
        var $bodyWidth = $("body").width();
        $("body").css({'overflow-y': "hidden"}).css({'padding-right': ($("body").width()-$bodyWidth)});
    });

    // ��������� ����, ��� �������� �������� ������
    $(".modal").on("hidden.bs.modal", function(){
        $("body").css({'padding-right': "0", 'overflow-y': "auto"});
    });

    // ��������� ����, ��� �������� ������ ������
    $(".modal_tabsize").on("show.bs.modal", function(){
        var $bodyWidth = $("body").width();
    });

    $(".modal_tabsize").on("shown.bs.modal", function(){
        $('.modal-backdrop').addClass('tr');
        modal_tabsize_pos();    // ������� ��������, �������������
    });



    // ��������� ����, ��� �������� ������ ������
    $(".modal_aviable").on("show.bs.modal", function(){
        var $bodyWidth = $("body").width();
    });

    $(".modal_aviable").on("shown.bs.modal", function(){
        $('.modal-backdrop').addClass('tr');
        modal_aviable_pos();    // �������, �������������
    });



    $(".modal_feedback").on("show.bs.modal", function(){
        $('.modal_feedback .modal-dialog').addClass('modal_tr_off');
    });

    $(".modal_feedback").on("shown.bs.modal", function(){
        modal_feedback_pos($(this));    // ����� �������� �����, �������������
    });

    // ��������� ����, ��� �������� �������� ������
    $(".modal_feedback").on("hidden.bs.modal", function(){
        $(this).find('.modal-dialog').stop().css({ 'opacity': '0', 'margin-top' : '0px'});
    });




    // ��������
    $('.pretty_checkb').each(function() {
        $(this).prettyCheckable({});
    });

    // ������� ���
    $('.modal_feedback .ch_list li.ch_all .pretty_checkb').change(function(event) {

        var t1 = $(this).closest('ul').parent().parent().find('li ul li:not(.ch_all) .pretty_checkb');

        if( $(this).is(":checked") ) {

            t1.prettyCheckable('check');

        } else {

            t1.prettyCheckable('uncheck');
        }

        event.preventDefault();
    });

}












// ������������� ����� �������� �����, ��, ���
function modal_feedback_pos(el) {

    var tp = 0;

    if (typeof el == 'undefined') {

        var el = $('.modal_feedback:visible');

        tp = 1;
    }

    if (el.length == 0) { return; }

    var bodyH = $("body").height();

    var modalH = el.find('.modal-dialog').outerHeight();

    var t1 = (bodyH - modalH)/2;

    if (t1 < 30) {
        t1 = 30;
    }

    if (tp == 0) {

        el.find('.modal-dialog').stop().animate({'margin-top' : t1+'px', 'opacity': '1'}, 300);

    } else {

        $('.modal_feedback .modal-dialog:visible').stop().css({'margin-top' : t1+'px', 'opacity': '1'});

    }
}




// �������, ������������� ������ ��������
function filter_item_bt_size() {

    if ($('.catalog_out .rg_out .filter_out .hd_tp_butt').length ==0) { return; }

    $('.catalog_out .rg_out .filter_out .hd_tp_butt').each(function() {

        var t2 = Math.round($(this).outerWidth());
        $(this).outerWidth(t2);

    });
}








// �������, ����� ����, ������������� ������ ��������
function catalog_out_size() {

    if ($('.catalog_out .left_menu_out').length ==0) { return; }

    var t1 = $('.catalog_out .left_menu_out');
    var t2 = $('.catalog_out');

    if (t1.outerHeight() > t2.height()) {
        t2.css('min-height', t1.outerHeight()+'px');
    }
}










// �������� �������, ������� ��������, �������������
function modal_tabsize_pos() {

    if ($('.modal_tabsize').length ==0) { return; }

    var bodyH = $("body").height();

    var modalH = $('.modal_tabsize .modal-dialog').outerHeight();

    var t1 = (bodyH - modalH)/2;

    if (t1 < 30) {
        t1 = 30;
    }

    $('.modal_tabsize .modal-dialog').css('margin-top', t1+'px');
}


// �������� �������, �������, �������������
function modal_aviable_pos() {

    if ($('.modal_aviable').length ==0) { return; }

    var bodyH = $("body").height();

    var modalH = $('.modal_aviable .modal-dialog').outerHeight();

    var t1 = (bodyH - modalH)/2;

    if (t1 < 30) {
        t1 = 30;
    }

    $('.modal_aviable .modal-dialog').css('margin-top', t1+'px');
}



// ������� ������� - ������������� �������
function history_tab_hg() {

    if ($('.history_tab table').length ==0) { return; }

    $('.history_tab tr').height('auto');
    $('.history_tab tr td').height('auto');

    var t1 = $('.history_tab .tab_lf table thead tr').first();
    var t2 = $('.history_tab .tab_rg table thead tr').first();


    if (t1.height() > t2.height()) {
        t2.height(t1.height());
    }
    if (t1.height() < t2.height()) {
        t1.height(t2.height());
    }

    /* ------------ */

    var tb_1 = $('.history_tab .tab_lf table tbody tr');
    var tb_2 = $('.history_tab .tab_rg table tbody tr');

    tb_2 = tb_2.first();

    var tr_nm = 1;

    tb_1.each(function() {

        var t1 = $(this).height();

        if (t1 > tb_2.height()) {
            tb_2.height(t1);
            $(this).height(t1);
        } else {
            $(this).height(tb_2.height());
            tb_2.height(tb_2.height());
        }

        tb_2 = tb_2.next();

        tr_nm++;
    });
}




// ��������, �������� ������ �������
function contacts_out_order() {

    if ( $('.contacts_inn').length > 0 ) {

        if ( $('.max_wd_991:visible').length > 0 ) {

            if ( $('.contacts_inn .addr_2').index() == 2 ) {
                $('.contacts_inn .addr_2').insertAfter('.contacts_inn .addr_1');
            }

        } else {

            if ( $('.contacts_inn .addr_2').index() == 1 ) {
                $('.contacts_inn .addr_2').insertAfter('.contacts_inn .map_bl');
            }
        }
    }
}





function footer_resize() {

    if ($('.footer_inn').length ==0) { return; }

    var t1 = $('.footer_inn').outerHeight();

    $('.footer').css({'marginTop': -t1 + 'px' });
    $('.wrapp').css({'paddingBottom': t1 + 'px' });
}





// ���� ������, ������, �������� � 1 ��� 2 ������
function hits_list_slider_resize() {

    if ($('.hits_list_slider').length ==0) { return; }

    var bwd = $('body').width();

    if (bwd < 800) {

        $('.hits_list_slider_out_r1').hide();
        $('.hits_list_slider_out_r2').show();
        $('.hits_list_slider_out_r2 .hits_list_slider').show();

        if (!if_hits_slider_r2_init) {

            if_hits_slider_r2_init = true;

            hits_slider_r2_init();
        }

    } else {

        $('.hits_list_slider_out_r2').hide();
        $('.hits_list_slider_out_r1').show();
        $('hits_list_slider_out_r1 .hits_list_slider').show();

        if (!if_hits_slider_r1_init) {

            if_hits_slider_r1_init = true;

            hits_slider_r1_init();
        }
    }
}



// ���� ������, ����������� ������� �� 2 ������
function hits_add_slider_2_rows() {

    if ($('.hits_list_slider_out_r1 .hits_list_slider').length ==0) { return; }

    var arr_item = [];

    $('.hits_list_slider_out_r1 .hits_list_slider .item').each(function() {
        arr_item[arr_item.length] = $(this).html();
    });

    var new_items = '<div class="item">';

    for (var ti1 = 0; ti1 < arr_item.length; ti1++ ) {

        new_items += arr_item[ti1];

        if ( ((ti1+1) < arr_item.length) && ((ti1+1)%2 == 0) ) {
            new_items += '</div><div class="item">';
            t1 = 0;
        }
    }
    new_items += '</div>';

    $('.hits_list').append('<div class="hits_list_slider_out_r2"><div class="hits_list_slider"></div></div>');
    $('.hits_list_slider_out_r2 .hits_list_slider').append(new_items);
}



// �������� ������ - ������������, �������
function gd_recomm_slider_init() {

    if ($('.gd_recomm_slider').length ==0) { return; }

	$('.gd_recomm_slider').slick({
        infinite: false,
		draggable: false,
		dots: false,
		slidesToShow: 5,
  		slidesToScroll: 5,
        slide: '.item',
        autoplay: false,
        autoplaySpeed: 5000,
        speed: 1000,
        /*variableWidth: true,   */
        responsive: [
            {
                breakpoint: 1201,
                settings: {
                    slidesToShow: 4,
                    slidesToScroll: 4
                }
            },
            {
                breakpoint: 992,
                settings: {
                    slidesToShow: 3,
                    slidesToScroll: 3
                }
            },
            {
                breakpoint: 700,
                settings: {
                    slidesToShow: 2,
                    slidesToScroll: 2
                }
            },
            {
                breakpoint: 520,
                settings: {
                    slidesToShow: 1,
                    slidesToScroll: 1
                }
            }
          ],
          onInit : function(event, slick, direction){

                $(window).resize(function() {
                    if ( $('.gd_recomm_slider').length > 0 ) {
                        $('.gd_recomm_slider').slickGoTo( 0, true );
                    }
                });
          }
	});
}





// ���� ������ ������� � 1 ������
function hits_slider_r1_init() {

    if ($('.hits_list_slider_out_r1 .hits_list_slider').length ==0) { return; }

	$('.hits_list_slider_out_r1 .hits_list_slider').slick({
        infinite: false,
		draggable: false,
		dots: false,
		slidesToShow: 4,
  		slidesToScroll: 4,
        slide: '.item',
        autoplay: false,
        autoplaySpeed: 5000,
        speed: 1000,
        responsive: [
            {
                breakpoint: 991,
                settings: {
                    slidesToShow: 3,
                    slidesToScroll: 3
                }
            }
          ],
          onInit : function(event, slick, direction){

                $(window).resize(function() {
                    if ( $('.hits_list_slider_out_r1 .hits_list_slider').length > 0 ) {
                        $('.hits_list_slider_out_r1 .hits_list_slider').slickGoTo( 0, true );
                    }
                });
          }
	});
}





// ���� ������ ������� � 2 ������
function hits_slider_r2_init() {

    if ($('.hits_list_slider_out_r2 .hits_list_slider').length ==0) { return; }

	$('.hits_list_slider_out_r2 .hits_list_slider').slick({
        infinite: false,
		draggable: false,
		dots: false,
		slidesToShow: 2,
  		slidesToScroll: 2,
        slide: '.item',
        autoplay: false,
        autoplaySpeed: 5000,
        speed: 1000,
        responsive: [
            {
                breakpoint: 550,
                settings: {
                    slidesToShow: 1,
                    slidesToScroll: 1
                }
            }
          ],
          onInit : function(event, slick, direction){

                $(window).resize(function() {

                    if ( $('.hits_list_slider_out_r2 .hits_list_slider').length > 0 ) {
                        $('.hits_list_slider_out_r2 .hits_list_slider').slickGoTo( 0, true );
                    }
                });
          }
	});
}



// �������� ������ ��������� �� �������
function top_collection_hg() {

    if ($('.top_collection .item_out').length ==0) { return; }

    var thg = $('.top_collection .item:not(.right_it) > .item_out').first().outerWidth();

    $('.top_collection .item:not(.right_it) > .item_out').outerHeight(thg);

    $('.top_collection .right_it > .item_out').outerHeight(thg*2+10);
}




// ������� ���� - ������ �������
function submenu_hide() {

    clearTimeout(submenu_hover_timeout);

    submenu_hover_timeout = setTimeout(function() {
        if (!submenu_hover) {
            $( 'body > ul.sub-menu' ).remove();
        }
    }, 200);

    submenu_hover = false;
}






// ������������� �������� ���� �� ������
function next_menu_resize() {

    if ($('.top_menu').length ==0) { return; }


    var el_mn_ul_wd = $('.top_menu').outerWidth();
    var c_mn_padd = parseInt($('.top_menu .menu > li > a').css('paddingLeft'));
    var c_mn_width = 10;
    var min_padd = 7;


    $('.top_menu .menu > li').each(function() {
        c_mn_width+=$(this).outerWidth();
    });

    var t1 = Math.floor( (el_mn_ul_wd - c_mn_width) / ($('.top_menu .menu > li').length*2) );


    c_mn_padd+=t1

    if (c_mn_padd < min_padd) {
        c_mn_padd = min_padd;
    }
    $('.top_menu .menu > li > a').css({'paddingLeft': c_mn_padd+'px','paddingRight': c_mn_padd+'px'});


    setTimeout(function() {
        c_mn_width = 0;
        $('.top_menu .menu > li').each(function() {
            c_mn_width+=$(this).outerWidth();
        });
        $('.top_menu nav').width(0);
        $('.top_menu nav').width( c_mn_width + 100);
        top_menu_scroll_toggle();
    }, 1);

}




// ������ ����, ��������/������
function top_menu_scroll_toggle() {

    if ($('.top_menu').length ==0) { return; }

    var el_mn_ul_wd = $('.top_menu').outerWidth();
    var c_mn_width = 0;

    $('.top_menu .menu > li').each(function() {
        c_mn_width+=$(this).outerWidth();
    });

    if (c_mn_width+5 > el_mn_ul_wd ) {
        $('.top_menu_scroll').show();
    } else {
        $('.top_menu_scroll').hide();
        $('.top_menu').stop().scrollLeft(0);
    }
}



