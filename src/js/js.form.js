/* 2011 alfredo.llanos */

$(document).ready(function(){

	//global vars
	var nameTo = $("#name_to");
	var nameToHelp = $("#name_to_help");
	var emailTo = $("#email_to");
	var emailToHelp = $("#email_to_help");
	var textTo = $("#text_to");
	var textToHelp = $("#text_to_help");
	var helpBlock = $("#help_block");

	var sendIt = $("#send_it");
	
	var repeatForm = $("#repeat_form");
	var resendForm = $("#resend_form");
	
	//On blur
	nameTo.blur(validateName);
	emailTo.blur(validateEmail);
	textTo.blur(validateText);

	sendIt.click(function() {
		if(validateName() & validateEmail() & validateText()) {
			$("#frmcontact").hide();
			$("#sending").show();
			$.ajax({
				url: "../ajax2mail/ajaxJmail.php",
				type: "POST",
				data: {
					name_to: $("#name_to").val(),
					email_to: $("#email_to").val(),
					text_to: $("#text_to").val()
					},
					//dataType: "html",
					success: function(html){
						$("#sending").hide();
						$("#formsended").prepend(html);
						$("#send_disclaimer").show();
						$("#formsended").show();
					}
			});
			return false;
		} else {
			$("#validation_err").show();
			$("#send_it").addClass("danger");
			$("#send_it").addClass("disabled");
			return false;		
		}
	});

	//validation functions

	function validateName(){
		//if it's NOT valid
		if(nameTo.val().length < 2){
			nameTo.parent().parent().addClass("error");
			nameTo.parent().parent().removeClass("success");
			nameToHelp.html("Requerido");
			$("#send_it").addClass("danger");
			$("#send_it").addClass("disabled");
			return false;
		}
		//if it's valid
		else {
			nameTo.parent().parent().removeClass("error");
			nameTo.parent().parent().addClass("success");
			nameToHelp.html("OK");
			$("#send_it").removeClass("danger");
			$("#send_it").removeClass("disabled");
			return true;
		}
	}
	
	function validateEmail(){
		//testing regular expression
		var a = $("#email_to").val();
		var filter = /^[a-zA-Z0-9]+[a-zA-Z0-9_.-]+[a-zA-Z0-9_-]+@[a-zA-Z0-9]+[a-zA-Z0-9.-]+[a-zA-Z0-9]+.[a-z]{2,4}$/;
		//if it's valid email
		if(filter.test(a)){
			emailTo.parent().parent().removeClass("error");
			emailTo.parent().parent().removeClass("warning");
			emailTo.parent().parent().addClass("success");
			emailToHelp.html("OK");
			return true;
		//if it's NOT valid
		} else {
			if (a.length < 2){
				emailTo.parent().parent().addClass("error");
				emailTo.parent().parent().removeClass("success");
				emailTo.parent().parent().removeClass("warning");
				emailToHelp.html("Email válido");
				return false;
			} else {
				emailTo.parent().parent().addClass("warning");
				emailTo.parent().parent().removeClass("success");
				emailTo.parent().parent().removeClass("error");
				emailToHelp.html("Requerido");
				return false;
			}		
		}
	}

	function validateText(){
		//if it's NOT valid
		if(textTo.val().length < 2){
			textTo.parent().parent().addClass("error");
			textTo.parent().parent().removeClass("success");
			textToHelp.html("Requerido");
			helpBlock.empty();
			return false;
		}
		//if it's valid
		else {
			textTo.parent().parent().removeClass("error");
			textTo.parent().parent().addClass("success");
			textToHelp.html("OK");
			helpBlock.empty();
			if(validateName() & validateEmail()) {
				$("#validation_err").hide("slow");
				$("#send_it").removeClass("danger");
				$("#send_it").removeClass("disabled");
				$("#send_it").addClass("success");
			}
			return true;
		}
	}
	
	// FORM REPEAT
	repeatForm.click(function() {
		$("#frmcontact").each(function(){
			this.reset();
		});
		nameTo.parent().parent().removeClass("success");
		nameToHelp.html("");
		emailTo.parent().parent().removeClass("success");
		emailToHelp.html("");
		textTo.parent().parent().removeClass("success");
		textToHelp.html("");
		$("#send_it").removeClass("success");
		$("#frmcontact").show();
		$("#send_success").hide();
		$("#send_fail").hide();
		$("#send_disclaimer").hide();
	});

	// FORM REPEAT
	resendForm.click(function() {
		$("#frmcontact").show();
		$("#send_success").hide();
		$("#send_fail").hide();
		$("#send_disclaimer").hide();
	});

});
