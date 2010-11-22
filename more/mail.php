<?php

function hop($mailFrom, $mailTo, $subject, $body) {
	$headers  = "Content-Type:text/plain;charset=utf-8\n";
	$headers .= "Content-Transfer-Encoding: 8bit\n";
	$headers .= "From: ".$mailFrom."\n";
	return ( mail($mailTo, $subject, $body, $headers) );
}

return hop( $_POST['mailFrom'], $_POST['mailTo'], $_POST['subject'], $_POST['body']);
?>
