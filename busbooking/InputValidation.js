// JavaScript Document

//Validation Function For Alphabet Field Where Number Cannot Be inserted
//Invoked On onKeyUp Event
function alp(ele){
	var val = ele.value;
	var len = val.length;
	if(val.search(/[^a-zA-Z]/) != -1){			// \d is for digits i.e [0-9]
		alert("Enter Only Alphabets");
		ele.value = ele.value.substring(0,len-1);
		ele.focus();
	}
}

//Validation Function For Alphabet Field Where Number Cannot Be inserted only alphabets and blank space is allowed
//Invoked On onKeyUp Event
function alp1(ele){
	var val = ele.value;
	var len = val.length;
	if(val.search(/[^a-zA-Z\s]/) != -1){			// \d is for digits i.e [0-9]
		alert("Enter Only Alphabets");
		ele.value = ele.value.substring(0,len-1);
		ele.focus();
	}
}


//Validation Function For Number Field Where Alphanumeric Characters Cannot Be inserted
//Invoked On onKeyUp Event
function num(ele){
	var val = ele.value;
	var len = val.length;
	if(val.search(/\D/) != -1){			// \D is For Not A Digit searc i.e [^0-9]
		alert("Enter Only Numbers");
		ele.value = ele.value.substring(0,len-1);
		ele.focus();
		return false;
 }
	 return true;
}


//Validation for email id field where characters other than a-z 0-9 @ _ . Cannot Be inserted
//Invoked On onKeyUp Event
function validateEmail(ele)
{
var val = ele.value;
var atpos=val.indexOf("@");
var dotpos=val.lastIndexOf(".");		//Last Occurrence Of Dot Character

//@ should not be the first character	||   two characters after @ symbol	||	two characters after last dot character
if (atpos < 1 || dotpos < atpos+2 || dotpos+2 >= val.length)   
  {
	  	alert("In valid e-mail address (abc@xyz.com)");
  		ele.focus();
		ele.select();
		return false;
 }
 return true;
}

//Validation for email id field To Have The Syntax Of Email Id Such As abc@xyz.com
//Invoked On onChange Event
function EmailInsert(ele){
  	var val = ele.value;
	var len = val.length;
 var pattern = /[^a-z0-9\_@.]/;
 if( val.search(pattern) != -1){
		alert("Invalid Input");
		ele.value = ele.value.substring(0,len-1);
		ele.focus();
		return false;
 }
 return true;
}


//Validation Function For Empty Field
function Empty(ele){
	var val = ele.value;
	var len = val.length;
 if( len == 0){
		alert("Field Cannot Be Left Blank");
		ele.focus();
		ele.select();
		return false;
 }
 return true;
}
