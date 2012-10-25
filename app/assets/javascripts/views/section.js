var SectionView = Backbone.View.extend({
	
	el: ".js-productsList",
	
	initialize: function (args) {
		//_.bindAll(this, 'changeName');
		//this.model.bind('change:name', this.changeName);
		
		this.collection.on("reset", this.render, this);
	},
		
	render: function() {
		this.$el.html( JST['templates/section']({products: this.collection}) );
		return this;
	}
	
});