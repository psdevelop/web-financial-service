<?php


require_once("classes/configuration.php");

$hostname = $GLOBALS['dbhost']; 
$username = $GLOBALS['dbuser']; 
$password = $GLOBALS['dbpsw']; 
$dbName = $GLOBALS['dbname']; 



$adminaddress = "administration@me.com"; 


mysql_connect($hostname,$username,$password) OR DIE("Не могу создать соединение "); 

mysql_query("SET character_set_client = utf8");
mysql_query("SET character_set_results = utf8");
mysql_query("SET character_set_connection = utf8");
mysql_query("SET collation_connection = utf8_general_ci");


mysql_select_db($dbName) or die(mysql_error());  

$email = $_POST['email'];

$name = strip_tags($_POST['name']);
$name = htmlspecialchars($name);
$name = mysql_escape_string($name);


$query = "INSERT INTO invite(name, email) VALUES('$name','$email')"; 

mysql_query($query) or die(mysql_error()); 

mysql_close();

?>
