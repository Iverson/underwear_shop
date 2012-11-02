$(function() {
	
	var token = $("meta[name='csrf-token']").attr("content");
	
	$.ajaxSetup({
		type: "POST",
		
		headers: {
			'X-CSRF-Token': token
		},
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
	
	$('.js-addToCart').live('click', function()
	{
		var sender = this;
		
		$.ajax({
			url: "/cart/add.json",
			data: {id: $(this).attr('rel')},
			success: function(data)
			{
				var img = $(sender).closest('.js-product').find(".js-productImage");
				if ( img.length > 0 )
				{
					animateProduct(img , $("#cart"));
				}
				
				$('.js-cart').empty().append( JST['templates/cart']({cart: data}) );
			},
			error: function(data)
			{
				console.log('Error: ' + data);
			}
		});
		
		return false;
	});
	
	$('.js-removeFromCart').live('click', function()
	{
		$.ajax({
			url: "/cart/remove.json",
			data: {id: $(this).attr('rel')},
			success: function(data)
			{
				$('.js-cart').empty().append( JST['templates/cart']({cart: data}) ).ready(function()
				{
					$('#cart').addClass('active');
				});
			},
			error: function(data)
			{
				console.log('Error: ' + data);
			}
		});
		
		return false;
	});
	
	
	
	$('.js-AddToFavorite').live('click', function()
	{
		var sender = this;
		
		$.ajax({
			url: "/favorite/add.json",
			data: {params: {product_id: $(this).attr('rel'), user_id: User.id}},
			success: function(data)
			{
				if (data.add)
				{
					$('.js-favoritesCounter').html(data.count);
				} else {
					
				}
				
				$('#notification').empty().append( JST['templates/noti'](data) ).ready(function()
				{
					$(this).find('.js-noti').fadeIn('slow');
					setTimeout(removeNoti, 5000);
				});
			},
			error: function(data)
			{
				console.log('Error: ' + data);
			}
		});
		
		return false;
	});
	
	/* Search */
	$('.button-search').bind('click', function() {
		url = $('base').attr('href') + 'index.php?route=product/search';
				 
		var filter_name = $('input[name=\'filter_name\']').attr('value');
		
		if (filter_name) {
			url += '&filter_name=' + encodeURIComponent(filter_name);
		}
		
		location = url;
	});
	/* Sidebar Search */
	$('.button-sidebarsearch').bind('click', function() {
		url = 'index.php?route=product/search';
		 
		var filter_name = $('input[name=\'sidebar_name\']').attr('value')
		
		if (filter_name) {
			url += '&filter_name=' + encodeURIComponent(filter_name);
		}
		
		location = url;
	});
	
	$('input[name=\'sidebar_name\']').keydown(function(e) {
		if (e.keyCode == 13) {
			url = 'index.php?route=product/search';
			 
			var filter_name = $('input[name=\'sidebar_name\']').attr('value')
			
			if (filter_name) {
				url += '&filter_name=' + encodeURIComponent(filter_name);
			}
			
			location = url;
		}
	});
	$('#header input[name=\'filter_name\']').bind('keydown', function(e) {
		if (e.keyCode == 13) {
			url = $('base').attr('href') + 'index.php?route=product/search';
			 
			var filter_name = $('input[name=\'filter_name\']').attr('value');
			
			if (filter_name) {
				url += '&filter_name=' + encodeURIComponent(filter_name);
			}
			
			location = url;
		}
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
		
});