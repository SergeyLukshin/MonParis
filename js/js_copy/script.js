// фильтр цена установки
var slider_price_start_min  = $( "#slider_price_min" ).val();          // начальное минимум
var slider_price_start_max  = $( "#slider_price_max" ).val();        // начальное максимум
var slider_price_min        = 500;          // минимум
var slider_price_max        = 100000;       // максимум
var slider_price_step       = 100;          // шаг


// верхнее меню установки
var submenu_hover = false;
var submenu_hover_timeout = false;

// хиты продаж, слайдер, установки
var if_hits_slider_r1_init = false;
var if_hits_slider_r2_init = false;





(function($) {
	'use strict';

    modals_init();              // модальные окна

    top_menu_init();            // верхнее меню

    first_init_all();           // главная страница

    // ресайз
    $(window).resize(function() {
        resize_init();
    });

    //brend_init();               // страница бренды

    contacts_out_order();       // контакты, смещение блоков адаптив

    cart_init();                // страница корзины

    gdview_init();              // карточка товара

    catalog_init();             // каталог

    footer_resize();            // футер ресайз

    setTimeout(function() {
        history_tab_hg();       // История Заказов - корректировка таблицы
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
    
    
    // контакты, переключение карты и описания
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

    next_menu_resize();         // корректировка верхнего меню по ширине

    setTimeout(function() {
        top_collection_hg();    // обновить высоту коллекций на главной
    }, 10);

    if ( $('.brends_slider_inn').length > 0 ) {
        $('.brends_slider_inn').slickGoTo( 0, true );
    }

    hits_list_slider_resize();      // хиты продаж, ресайз, показать в 1 или 2 строки

    contacts_out_order();           // контакты, смещение блоков адаптив

    history_tab_hg();               // История Заказов - корректировка таблицы

    modal_tabsize_pos();            // таблица размеров, центрирование

    modal_aviable_pos();            // наличие, центрирование

    modal_feedback_pos();           // модал обратная связь, центрирование

    footer_resize();                // футер ресайз
    
    gd_im_resize();
}


// добавить цвета тест
function test1_go() {

    var opt_arr = [
        ['бежевый1', '1', 0],
        ['бежевый2', '2', 0],
        ['бежевый3', '3', 1],   // selected
        ['бежевый4', '4', 0],
        ['бежевый5', '5', 0],
        ['бежевый6', '6', 0],
        ['бежевый7', '7', 0],
        ['бежевый8', '8', 0],
        ['бежевый9', '9', 0],
        ['бежевый10', '10', 0]
    ];

    gd_color_add(opt_arr);
}






//  добавить списко цветов в селект
//  opt_arr = [
//      ['название', 'value', selected=0/1],
//      ['Белый', '1', 0],
//      ['Синий', '2', 0]
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





// карточка товара
function gdview_init() {

    gd_recomm_slider_init();    // карточка товара - рекоммендуем, слайдер


    // карточка товара - селект выбор цвета
    if ($('.gd_view_out .rg_opt .color_sel .selectpicker2').length  > 0) {
        $('.gd_view_out .rg_opt .color_sel .selectpicker2').selectpicker();
    }

    // карточка товара - селект выбор цвета - скролл
    if ($('.gd_view_out .rg_opt .color_sel .dropdown-menu.inner').length  > 0) {
        $(".gd_view_out .rg_opt .color_sel .dropdown-menu.inner").mCustomScrollbar({
            theme:"inset-3-dark"
        });
    }

    // карточка товара - скролл картинок превью
    if ($('.gd_view_out .gd_im .im_list').length  > 0) {
        $(".gd_view_out .gd_im .im_list").mCustomScrollbar({
            theme:"light"
        });
    }


    // карточка товара - клик по превью картинок
    $('.gd_view_out .gd_im .im_list .item').on("click", function(event) {

        $('.gd_view_out .gd_im .im_list .item').removeClass('act');

        //$('.gd_view_out .gd_im .gd_im_inn').css('background-image', 'url('+$(this).attr('href')+')');
        $('.gd_view_out .gd_im .gd_im_inn td > img').attr('src', ''+$(this).attr('href'));
        $('.gd_view_out .gd_im .gd_im_inn a.gd_fansy').attr('href', ''+$(this).attr('href'));

        $(this).addClass('act');

        gd_im_resize();

        event.preventDefault();
    });


    // карточка товара - Размеры производителя
    $('.gd_view_out .rg_opt .size_manuf_sel a').on("click", function(event) {

        $('.gd_view_out .rg_opt .size_manuf_sel a').removeClass('act');

        $(this).addClass('act');

        $('#size_manuf_sel').val($(this).text());
        //product_size_change();

        event.preventDefault();
    });


    // карточка товара - Российские размеры
    $('.gd_view_out .rg_opt .size_ross_sel a').on("click", function(event) {

        $('.gd_view_out .rg_opt .size_ross_sel a').removeClass('act');

        $(this).addClass('act');

        $('#size_ross_sel').val($(this).text());

        event.preventDefault();
    });
}


// каталог
function catalog_init() {


    catalog_out_size();     // каталог, левое меню, корректировка высоты страницы


    // каталог левое меню
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




    // каталог - фильтры раскрытие, скрытие
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

    filter_item_bt_size();  // каталог, корректировка ширины фильтров


    // каталог - фильтр размеры
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



    // каталог - фильтр бренд
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


    // каталог - фильтр цвет
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





    // каталог - фильтр бренд скролл списка
    if ($('.catalog_out .rg_out .filter_out .filter_it .dw .inn .brend_checkb').length  > 0) {
        $(".catalog_out .rg_out .filter_out .filter_it .dw .inn .brend_checkb").mCustomScrollbar({
            theme:"light"
        });
    }


    // каталог - фильтр цены ползунки
    if ($( "#slider_price" ).length > 0) {

        $( "#slider_price" ).slider({
        	range: true,                // двойной
        	values: [ slider_price_start_min, slider_price_start_max ],    // начальные значения
            min : slider_price_min,     // минимум
            max : slider_price_max,     // максимум
            step : slider_price_step,   // Шаг

            create: function( event, ui ) {     // создание

                var v1 = $( "#slider_price" ).slider("values", 0);  // получить начальное значение от
                var v2 = $( "#slider_price" ).slider("values", 1);  // получить начальное значение до

                $( ".slider_price_min" ).val( v1 );                 // обновить значение в поле от
                $( ".slider_price_max" ).val( v2 );                 // обновить значение в поле от

            },
            slide: function( event, ui ) {      // движение

                $( ".slider_price_min" ).val( ui.values[0] );   // обновить значение в поле от
                $( ".slider_price_max" ).val( ui.values[1] );   // обновить значение в поле до

            }
        });
    }

    // при изменении в поле минимум - обновить ползунок
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


    // при изменении в поле максимум - обновить ползунок
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









// страница корзины
function cart_init() {

    // корзина - Выбор способа доставки radio
    $('.cart_list_form_out .delivery_out a.item').on("click", function(event) {

        $('.cart_list_form_out .delivery_out a.item').removeClass('sel');
        $(this).addClass('sel');

        $('#f_delivery').val($(this).data('val'));

        event.preventDefault();
    });



    // корзина - уменьшить количество товара
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


    // корзина - увеличить количество товара
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




// страница бренды
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

    // скролл
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




// главная страница
function first_init_all() {

    setTimeout(function() {
        top_collection_hg();    // обновить высоту коллекций на главной
    }, 10);


    hits_add_slider_2_rows();       // хиты продаж, дублировать слайдер на 2 строки
    hits_list_slider_resize();      // хиты продаж, ресайз, показать в 1 или 2 строки


    // слайдер на главной вверху
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



    // слайдер брендов
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














// верхнее меню
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

    setTimeout(next_menu_resize, 50);   // корректировка верхнего меню по ширине
}





// модальные окна
function modals_init() {

    // модальное окно, при открытии скрыть скролл
    $(".modal").on("show.bs.modal", function(){
        var $bodyWidth = $("body").width();
        $("body").css({'overflow-y': "hidden"}).css({'padding-right': ($("body").width()-$bodyWidth)});
    });

    // модальное окно, при закрытии показать скролл
    $(".modal").on("hidden.bs.modal", function(){
        $("body").css({'padding-right': "0", 'overflow-y': "auto"});
    });

    // модальное окно, при открытии скрыть скролл
    $(".modal_tabsize").on("show.bs.modal", function(){
        var $bodyWidth = $("body").width();
    });

    $(".modal_tabsize").on("shown.bs.modal", function(){
        $('.modal-backdrop').addClass('tr');
        modal_tabsize_pos();    // таблица размеров, центрирование
    });



    // модальное окно, при открытии скрыть скролл
    $(".modal_aviable").on("show.bs.modal", function(){
        var $bodyWidth = $("body").width();
    });

    $(".modal_aviable").on("shown.bs.modal", function(){
        $('.modal-backdrop').addClass('tr');
        modal_aviable_pos();    // наличие, центрирование
    });



    $(".modal_feedback").on("show.bs.modal", function(){
        $('.modal_feedback .modal-dialog').addClass('modal_tr_off');
    });

    $(".modal_feedback").on("shown.bs.modal", function(){
        modal_feedback_pos($(this));    // модал обратная связь, центрирование
    });

    // модальное окно, при закрытии показать скролл
    $(".modal_feedback").on("hidden.bs.modal", function(){
        $(this).find('.modal-dialog').stop().css({ 'opacity': '0', 'margin-top' : '0px'});
    });




    // чекбоксы
    $('.pretty_checkb').each(function() {
        $(this).prettyCheckable({});
    });

    // выбрать все
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












// центрирование попап обратная связь, лк, рег
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




// каталог, корректировка ширины фильтров
function filter_item_bt_size() {

    if ($('.catalog_out .rg_out .filter_out .hd_tp_butt').length ==0) { return; }

    $('.catalog_out .rg_out .filter_out .hd_tp_butt').each(function() {

        var t2 = Math.round($(this).outerWidth());
        $(this).outerWidth(t2);

    });
}








// каталог, левое меню, корректировка высоты страницы
function catalog_out_size() {

    if ($('.catalog_out .left_menu_out').length ==0) { return; }

    var t1 = $('.catalog_out .left_menu_out');
    var t2 = $('.catalog_out');

    if (t1.outerHeight() > t2.height()) {
        t2.css('min-height', t1.outerHeight()+'px');
    }
}










// карточка товаров, таблица размеров, центрирование
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


// карточка товаров, наличие, центрирование
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



// История Заказов - корректировка таблицы
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




// контакты, смещение блоков адаптив
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





// хиты продаж, ресайз, показать в 1 или 2 строки
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



// хиты продаж, дублировать слайдер на 2 строки
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



// карточка товара - рекоммендуем, слайдер
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





// хиты продаж слайдер в 1 строку
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





// хиты продаж слайдер в 2 строки
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



// обновить высоту коллекций на главной
function top_collection_hg() {

    if ($('.top_collection .item_out').length ==0) { return; }

    var thg = $('.top_collection .item:not(.right_it) > .item_out').first().outerWidth();

    $('.top_collection .item:not(.right_it) > .item_out').outerHeight(thg);

    $('.top_collection .right_it > .item_out').outerHeight(thg*2+10);
}




// верхнее меню - скрыть подменю
function submenu_hide() {

    clearTimeout(submenu_hover_timeout);

    submenu_hover_timeout = setTimeout(function() {
        if (!submenu_hover) {
            $( 'body > ul.sub-menu' ).remove();
        }
    }, 200);

    submenu_hover = false;
}






// корректировка верхнего меню по ширине
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




// скролл меню, показать/скрыть
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



