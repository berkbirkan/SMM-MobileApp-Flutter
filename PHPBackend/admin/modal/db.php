<?php
     try
     {
          $db = new PDO("mysql:host=localhost;dbname=berkbirk_berkbirkan", "berkbirk_berkbirkan", "kolokolokolo");
          $db->query("SET CHARACTER SET utf8");
     }
     catch ( PDOException $e )
     {
          print $e->getMessage();
     }
?>
