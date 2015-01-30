function Filter(inObjectType,inFilterField,inOperator,inFilterValue,inFilterDisplayValue,inFormField) {
	this.objecttype = inObjectType;
	this.filterfield = inFilterField;
	this.operator = inOperator;
	this.filtervalue = inFilterValue;
	this.filterdisplayvalue = inFilterDisplayValue;
	this.formfield = inFormField;
}

Filter.prototype.getObjectType = function() {
		return this.objecttype;
};
Filter.prototype.setObjectType = function(inObjectType) {
		this.objecttype = inObjectType;
};

Filter.prototype.getFilterField = function() {
		return this.filterfield;
};
Filter.prototype.setFilterField = function(inFilterField) {
		this.filterfield = inFilterField;
};

Filter.prototype.getOperator = function() {
		return this.operator;
};
Filter.prototype.setOperator = function(inOperator) {
		this.operator = inOperator;
};

Filter.prototype.getFilterValue = function() {
		return this.filtervalue;
};
Filter.prototype.setFilterValue = function(inFilterValue) {
		this.filtervalue = inFilterValue;
};

Filter.prototype.getFilterDisplayValue = function() {
		return this.filterdisplayvalue;
};
Filter.prototype.setFilterDisplayValue = function(inFilterDisplayValue) {
		this.filterdisplayvalue = inFilterDisplayValue;
};

Filter.prototype.getFormField = function() {
		return this.formfield;
};
Filter.prototype.setFormField = function(inFormField) {
		this.formfield = inFormField;
};

