function User(inUserID,inName,inPhone,inEmail,inOffice) {
	this.userid = inUserID;
	this.name = inName;
	this.phone = inPhone;
	this.email = inEmail;
	this.office = inOffice;
}

User.prototype.getUserID = function() {
		return this.userid;
};
User.prototype.setUserID = function(inUserID) {
		this.userid = inUserID;
};

User.prototype.getName = function() {
		return this.name;
};
User.prototype.setName = function(inName) {
		this.name = inName;
};
	
User.prototype.getPhone = function() {
		return this.phone;
};
User.prototype.setPhone = function(inPhone) {
		this.phone = inPhone;
};
	
User.prototype.getEmail = function() {
		return this.email;
};
User.prototype.setEmail = function(inEmail) {
		this.email = inEmail;
};
	
User.prototype.getOffice = function() {
		return this.office;
};
User.prototype.setOffice = function(inOffice) {
		this.office = inOffice;
};
