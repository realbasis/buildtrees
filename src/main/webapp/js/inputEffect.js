// JavaScript Document
function initwrite(flag, form) {
	if(flag != 1) {
		// Se select box to Other
		form.position1.selectedIndex =  form.position1.options.length - 1;
	}
	else {
		// Make text box disappear
		form.position2.disabled = true;
		form.position2.type = "hidden";
	}
}
function rewrite(form) {
    var chosenIndex = form.position1.selectedIndex;
    var chosenItem = form.position1.options[chosenIndex];
	var otherItem = form.position2;
	
    if (chosenItem.text == "Other") {
        otherItem.type = "text";
		otherItem.disabled = false;
    }
    else {
        otherItem.disabled = true;
		otherItem.type = "hidden";
    }
}
function setPosition(form) {
	if(form.checktype.value == "jobs") {
		
		if (form.position2.disabled == false) {
			form.position.value = form.position2.value;
		}
		else {
			var chosenIndex = form.position1.selectedIndex;
		    var chosenItem = form.position1.options[chosenIndex];
			
			form.position.value = chosenItem.text;
		}
		
	}
	else if(form.checktype.value == "courses") {

		if (form.position2.disabled == false) {
			form.courseType.value = form.position2.value;
		}
		else {
			var chosenIndex = form.position1.selectedIndex;
		    var chosenItem = form.position1.options[chosenIndex];

			form.courseType.value = chosenItem.text;
		}
	}
	else if(form.checktype.value == "licenses") {
		
		if (form.position2.disabled == false) {
			form.licenseName.value = form.position2.value;
		}
		else {
			var chosenIndex = form.position1.selectedIndex;
		    var chosenItem = form.position1.options[chosenIndex];

			form.licenseName.value = chosenItem.text;
		}
		
	}
	else
		alert("Wrong page.  Contact Technical Support!");
}
