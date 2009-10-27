<?php

$base_path = "images/"; 

if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
   $target = $base_path . $_GET['id'];
   if(file_exists($target)) {
      if(!unlink($target)) {
         header($_SERVER["SERVER_PROTOCOL"]. "File not deleted", true, 500);
         die();
      } else {
         echo("OK");
      }
   } else {
     echo("OK, but nothing deleted");
   }
} else if ($_SERVER['REQUEST_METHOD'] === 'POST') {
   if ($_POST['id'] == '') {
      header($_SERVER["SERVER_PROTOCOL"]." 400 Bad Request");
      echo "No id"; 
   } else if ($_FILES['content']['size'] > 500000) {
      header($_SERVER["SERVER_PROTOCOL"]." 400 Bad Request");
      echo "Your file is too large"; 
   } else { 
      $target = $base_path . $_POST['id'];
      if(file_exists($target)) {
         if(!unlink($target)) {
            header($_SERVER["SERVER_PROTOCOL"]. "Existing file not deleted", true, 500);
            die();
         }
      }
      if(move_uploaded_file($_FILES['content']['tmp_name'], $target)) { 
         echo "OK"; 
      } else { 
         header($_SERVER["SERVER_PROTOCOL"]. "Existing file not deleted", true, 500);
      } 
   } 
} else {
   echo "WTF?";
}

?>
