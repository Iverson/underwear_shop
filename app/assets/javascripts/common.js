$(document).ready(function() {
	var token = $("meta[name='csrf-token']").attr("content");
	
	/* Cart */
	
	var cart = $('#cart');
	
	function animateProduct(image,cart)
	{
		var image_offset = image.offset();
		console.log(image);

		$("body").append('<img src="' + image.attr('src') + '" id="temp" style="position: absolute; z-index:9999; top:'+image_offset.top+'px; left:'+image_offset.left+'px" />');

		var cart_offset = cart.offset();
		params = {
			top : cart_offset.top + 'px',
			left : cart_offset.left + 'px',
			opacity : 0.0,
			width : cart.width(),
			height : cart.height()
		};

		$('#temp').animate(params, 'slow', false, function()
		{
			$('#temp').remove();
		});
	}
	
	$('.js-addToCart').click(function()
	{
		var sender = this;
		
		$.ajax({
			type: "POST",
			url: "/cart/add",
			headers: {
				'X-CSRF-Token': token
			},
			data: {id: $(this).attr('rel')},
			success: function(data)
			{
				animateProduct($(sender).closest('.padd-both').find(".image2 img") , $("#cart"));
				$('.js-cart').empty().append(data);
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
			type: "POST",
			url: "/cart/remove",
			headers: {
				'X-CSRF-Token': token
			},
			data: {id: $(this).attr('rel')},
			success: function(data)
			{
				$('.js-cart').empty().append(data).ready(function()
				{
					console.log(cart);
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
	
	/* Ajax Cart */
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

	
	$('.success img, .warning img, .attention img, .information img').live('click', function() {
		$(this).parent().fadeOut('slow', function() {
			$(this).remove();
		});
	});	
});