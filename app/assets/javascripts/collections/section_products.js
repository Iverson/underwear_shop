var SectionProductsCollection = Backbone.Collection.extend({

	model : Product,

	initialize: function() {
		var sectionView = new SectionView({collection: this});
	}

});