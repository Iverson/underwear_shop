$(function() {
	
	var token = $("meta[name='csrf-token']").attr("content");
	
	$.ajaxSetup({
		type: "POST",
		
		headers: {
			'X-CSRF-Token': token
		},
		error: function (request, status, error)
		{
			showNoti( JST['templates/shared/error']({text: error}) );
		}
	});
	
	/* Cart */
	
	var cart = $('#cart');
	
	function animateProduct(image,cart)
	{
		var image_offset = image.offset();

		$("body").append('<img class="box-product-animate js-imgClone" src="' + image.attr('src') + '" style="position: absolute; z-index:9999; top:'+image_offset.top+'px; left:'+image_offset.left+'px" />');

		var cart_offset = cart.offset();
		params = {
			top : cart_offset.top + 'px',
			left : cart_offset.left + 'px',
			opacity : 0.0
			//width : cart.width(),
			//height : cart.height()
		};

		$('.js-imgClone:last').animate(params, 'slow', false, function()
		{
			$(this).remove();
		});
	}
	
	$('.b-cart-remove-item').click(function()
	{
		$(this).closest('.quantity').find('.js-cartRemoveItemHidden').click();
	});
	
	function addToCart(id, sender)
	{
		$.ajax({
			url: Routes.cart_add_path({format: 'json'}),
			data: {instance: id},
			success: function(data)
			{
				var img = $(sender).closest('.js-product').find(".js-productImage");
				if ( img.length > 0 )
				{
					animateProduct(img , $("#cart"));
				}
				
				$('.js-cart').empty().append( JST['templates/cart']({cart: data}) );
				showNoti( JST['templates/notis/cart_add']({add: true}) );
			}
		});
	}
	
	var activeButton;
	
	function selectProductSize(product, sender)
	{
		clearPopups();
		
		$.ajax({
			type: "GET",
			url: Routes.products_instances_path({format: 'json'}),
			data: {id: product},
			success: function(data)
			{
				$('body').append( JST['templates/shared/popup']({instances: data}) );
			}
		});
	}
	
	$('.js-addToCart').live('click', function()
	{
		var sender = this;
		if ($(this).data('fastadd'))
		{
			addToCart($(this).data('fastadd'), this)
		} else {
			activeButton = this;
			selectProductSize($(this).data('product'), this);
			
		}
		
		return false;
	});
	
	$('.js-selectedSize').live('click', function()
	{
		var instance = $('.b-popup__select-size input:checked').val();
		
		clearPopups();
		addToCart(instance, activeButton);
		
		return false;
	});
	
	$('.js-removeFromCart').live('click', function()
	{
		$.ajax({
			url: Routes.cart_remove_path({format: 'json'}),
			data: {instance: $(this).attr('rel')},
			success: function(data)
			{
				$('.js-cart').empty().append( JST['templates/cart']({cart: data}) ).ready(function()
				{
					$('#cart').addClass('active');
				});
				
				showNoti( JST['templates/notis/cart_add']({add: false}) );
			}
		});
		
		return false;
	});
	
	
	
	$('.js-AddToFavorite').live('click', function()
	{
		if (User.id)
		{
		
		var sender = this;
		
		$.ajax({
			url: Routes.favorite_add_path({format: 'json'}),
			data: {params: {product_id: $(this).attr('rel'), user_id: User.id}},
			success: function(data)
			{
				if (data.add)
				{
					$('.js-favoritesCounter').html(data.count);
				} else {
					
				}
				
				showNoti( JST['templates/notis/favorite'](data) );
				
			}
		});
		
		} else {
			showNoti( JST['templates/shared/noti']({text: 'Вы не авторизованы.'}) );
		}
		
		return false;
	});
	
	/* Mini Cart */
	$('#cart .heading').live('click', function() {
		$('#cart').toggleClass('active');
	});
	
	/* Mega Menu */
	$('#menu ul > li > a + div').each(function(index, element) {
		
		var menu = $('#menu').offset();
		var dropdown = $(this).parent().offset();
		
		i = (dropdown.left + $(this).outerWidth()) - (menu.left + $('#menu').outerWidth());
		
		if (i > 0) {
			$(this).css('margin-left', '-' + (i + 5) + 'px');
		}
	});

	function removeNoti()
	{
		$('.js-noti').fadeOut('slow', function() {
			$(this).remove();
		});
	}
	
	function clearPopups()
	{
		$('.b-popup').remove();
	}
	
	$('.js-popupClose').live('click', function()
	{
		$(this).closest('.b-popup').fadeOut('fast', function()
		{
			$(this).remove();
		})
		
		return false;
	});
	
	function showNoti(html)
	{
		$('#notification').empty().append( html ).ready(function()
		{
			$(this).find('.js-noti').fadeIn('slow');
			setTimeout(removeNoti, 4000);
		});
		
	}
	
	$('.success img, .warning img, .attention img, .information img').live('click', function() {
		removeNoti();
	});
	
	/* back-top */
	
	// hide #back-top first
	$("#back-top").hide();
	// fade in #back-top
	$(window).scroll(function()
	{
		if ($(this).scrollTop() > 100)
		{
			$('#back-top').fadeIn();
		} else {
			$('#back-top').fadeOut();
		}
	});

	// scroll body to 0px on click
	$('#back-top a').click(function()
	{
		$('body,html').animate({scrollTop: 0}, 800);
		
		return false;
	});
	
	/* Filters */
	
	var viewModes = $('.js-productsViewModeSelect .item');
	
	viewModes.click(function()
	{
		if (!$(this).hasClass('active'))
		{
			viewModes.removeClass('active');
			$(this).addClass('active');
			
			viewModes.each(function()
			{
				$('.js-productsList').removeClass($(this).attr('data-mode'));
			});
			
			$('.js-productsList').addClass($(this).attr('data-mode'));
			
		}
		
		
		return false;
	});
	
	/* FancyBox */
	
	$(".js-fancybox").fancybox({
	    helpers:  {
	        title : {
	            type : 'inside'
	        },
	        overlay : {
	            css : {
	                'background' : 'rgba(0,0,0,0.75)'
	            }
	        },
			thumbs : {
				width: 50,
				height: 50
			}
	    }
	});
	
	/* Cloudzoom */
	
	$('.js-jqzoom').jqzoom({
		zoomType: 'reverse',
		zoomWidth: 395,
		zoomHeight: 460,
		xOffset: 20
	});
	
	
	$('.js-productZoom').click(function()
	{
		$('#' + $(this).data('gallery') + ' .js-fancybox:first').click();
		
		return false;
	});
	
	/* Tabs */
	
	$('#tabs a').tabs();
	
	$('.js-submit').click(function()
	{
		$(this).closest('form').submit();
	});
		
});