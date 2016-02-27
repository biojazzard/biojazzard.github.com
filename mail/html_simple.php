<?php

	date_default_timezone_set('Europe/Madrid');

	// Require the Swift Mailer library
	require_once 'lib/swift_required.php';

	// Enter your SMTP settings here...
	// You can look up your mail server and also see if it supports TLS by going to:
	// http://mxtoolbox.com/diagnostic.aspx
	// and entering smtp:yourdomain.com
	// You'll be given a report stating the server name to use and whether your server supports TLS.


	// Change smtp.example.org to your own server address below
	// Enter your email account username and password below also...

	// If your server supports a security layer (Gmail enforces use of 'tls' and port 587) change port accordingly (587 or 25 usually) and use 'tls' or 'ssl' as a third argument like so:
	// FOR GMAIL: 		$transport = Swift_SmtpTransport::newInstance('smtp.gmail.com', 587, 'tls')
	// GENERIC TLS: 	$transport = Swift_SmtpTransport::newInstance('mail.mediumra.re', 25, 'tls')

	// If you choose not to use SSL or TLS then the following could work for you:
	// $transport = Swift_SmtpTransport::newInstance('mail.mediumra.re', 25)

	// or if you prefer/need to fall back to use PHP's inbuilt mail() function:
	// $transport = Swift_MailTransport::newInstance();

	$transport = Swift_SmtpTransport::newInstance('smtp.gmail.com', 587, 'tls' )
	  ->setUsername('sys@tallerdelsoho.es')
	  ->setPassword('tds1@sys')
	  ;

	$mailer = Swift_Mailer::newInstance($transport);

	// Creating the message text using fields sent through POST

	$message = Swift_Message::newInstance()

	  // Give the message a subject
	  ->setSubject('Feliz Navidad 2015 | psicotecnico.biz')

	  // Set the From address with an associative array
	  ->setFrom(array('sys@tallerdelsoho.es' => 'Feliz Navidad 2015! | psicotecnico.biz'))

	  // Set the To addresses with an associative array
	  ->setTo(array('alfredo@tallerdelsoho.es', 'alfredo@1un.es' => '1unes', 'ines@psicotecnico.biz' => 'Inés | psicotecnico.biz'))

	  // Give it a body
	  //->setBody('<img src="https://cldup.com/El0q8vkpqc.gif" width="500" height="500" alt="Navidad 2015">', 'text/html')

	  // And optionally an alternative body
	  //->addPart('<p>Feliz Navidad!</p>', 'text/html')

	  // Optionally add any attachments
	  //->attach(Swift_Attachment::fromPath('felicita_navidad_2015.gif'))
	  ;

		$message->setBody(
		'<html>' .
		' <head></head>' .
		' <body>' .
		'  <img src="' .
		     $message->embed(Swift_Image::fromPath('http://psicotecnico.biz/site/assets/files/1231/felicita_navidad_2015.gif')) .
		   '"  width="500" height="500" alt="Feliz Navidad!" />' .
		'  <a href="http://psicotecnico.biz">http://psicotecnico.biz</a>' .
		' </body>' .
		'</html>',
		  'text/html'
		);

	// Send the message or catch an error if it occurs.
	try{
		echo($mailer->send($message));
	}
	catch(Exception $e){
		echo($e->getMessage());
	}
	exit;

?>