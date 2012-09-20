var CatalogView = Backbone.View.extend({
	
	el: ".box-product",
	
	initialize: function (args) {
		//_.bindAll(this, 'changeName');
		//this.model.bind('change:name', this.changeName);
		
		this.collection.on("reset", this.render, this);
	},
		
	render: function() {
		console.log(this.collection);
		this.$el.html( JST['templates/products']({products: this.collection}) );
		return this;
	}
	
});