<?php

function hop($mailFrom, $mailTo, $subject, $body) {
	$headers  = "Content-Type:text/html;charset=utf-8\n";
	$headers .= "Content-Transfer-Encoding: 8bit\n";
	$headers .= "From: ".$mailFrom."\n";
	return ( mail($mailTo, $subject, $body, $headers) );
}

hop( $_POST['mailFrom'], $_POST['mailTo'], $_POST['subject'], $_POST['body']);
?>
