var Router = Backbone.Router.extend({

	routes: {
		"help":                 "help",    // #help
		"search/:query":        "search",  // #search/kiwis
		"search/:query/p:page": "search"   // #search/kiwis/p7
	},

	help: function() {
		console.log('Help');
	},

	search: function(query, page) {
		console.log('Search "' + query + '" from page: ' + page);
	}

});

var router = new Router(); // Создаём роутер

Backbone.history.start();  // Запускаем HTML5 History push