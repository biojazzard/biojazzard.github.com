<?php

//navidaz //zoripan

date_default_timezone_set('Europe/Madrid');

// Require the Swift Mailer library

require_once 'lib/swift_required.php';

$imageurl = 'http://psicotecnico.biz/site/assets/files/1231/felicita_navidad_2015.gif';
//$imageurl = 'https://cldup.com/El0q8vkpqc.gif';

if( isset($_GET['default']) ) {
	echo '<img id="img-preview" class="img-responsive" src="'.$imageurl.'">';
}

if( isset($_POST['email']) ) {

	$email = $_POST['email'];

	if( isset($_POST['password']) ) {

		$sha2 = sha1(sha1($_POST['password']));

		if( $sha2 == 'c71067c366284e814d9bc9b0469e1df4489907ec' || $sha2 == '5e5f61e67065538382bfc40870b1e9387af72b8b' ) {

			if ($_POST['url'] != '' && $_POST['url'] != null) {
				$imageurl = $_POST['url'];
			}

			$subject = $_POST['subject'];
			$body = $_POST['body'];

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

			if ($sha2 == 'c71067c366284e814d9bc9b0469e1df4489907ec') {
				$U = 'mail@psicotecnico.biz';
				$P = 'M1@psibio';
				$REPLAY = 'ines@psicotecnico.biz';
				$NAME = 'INSTITUTO PSICOTÉCNICO BIZKAIA';
				$DOM = 'psicotecnico.biz';
			} else if ($sha2 == 'b2d5594e6c3ffbf11f2c37d751b1b8aabf77ac3a') {
				$U = 'sys@tallerdelsoho.es';
				$P = 'tds1@sys';
				$REPLAY = 'alfredo@1un.es';
				$NAME = '1un.es';
				$DOM = '1un.es';
			} else {
				$U = 'sys@tallerdelsoho.es';
				$P = 'tds1@sys';
				$NAME = '1un.es';
				$REPLAY = 'alfredo@1un.es';
				$DOM = '1un.es';
			}

			$transport = Swift_SmtpTransport::newInstance('smtp.gmail.com', 587, 'tls' )
		  	->setUsername($U)
		  	->setPassword($P)
			  ;

			$mailer = Swift_Mailer::newInstance($transport);

			// Creating the message text using fields sent through POST

			$message = Swift_Message::newInstance()

			  // Give the message a subject
			  ->setSubject($subject.' | '.$NAME)

			  // Set the From address with an associative array
			  ->setFrom(array($U => $NAME))

			  ->setReplyTo(array($REPLAY))

			  // Set the To addresses with an associative array
			  //->setTo(array('alfredo@tallerdelsoho.es', 'alfredo@1un.es' => '1unes', 'ines@psicotecnico.biz' => 'Inés | psicotecnico.biz'))
			  ->setTo(array($email))

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
				     $message->embed(Swift_Image::fromPath($imageurl)) .
				   '" alt="Feliz Navidad!" />' .
				'  <p>'.$body.'</p>' .
				'  <a href="http://'.$DOM.'">http://'.$DOM.'</a>' .
				' </body>' .
				'</html>',
				  'text/html'
				);

				// Send the message or catch an error if it occurs.
				try{
					//echo($mailer->send($message));
					if ($mailer->send($message) > 0) {
						echo '<div class="alert alert-success">';
						echo '<p><strong>Mensaje enviado a '.$email.'</strong></p>';
						echo '</div>';
					}
				}
				catch(Exception $e){
					echo '<div class="alert alert-danger">';
					echo '<p>Mensaje enviado a '.$e->getMessage().'</p>';
					echo '</div>';
				}

			exit;

		}

	}

}
?>