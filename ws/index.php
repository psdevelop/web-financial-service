<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

ini_set('display_errors',1);

require_once("/../classes/configuration.php");
require_once("KPPublic.class.php");

//Doctrine::loadModels('models');

$server = new SoapServer( $GLOBALS['HTTP_SUFFIX'].'/ws/kp4public.wsdl');
$server->setClass('KPPublic');
$server->handle();

?>
