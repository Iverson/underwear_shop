var ProductsCollection = Backbone.Collection.extend({

	model : Product,

	initialize: function() {
		var catalogView = new CatalogView({collection: this});
	},

});