<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
?>
    <div id="app_status"></div>
<?php
    $client = new SoapClient( $GLOBALS['HTTP_SUFFIX'].'/ws/kp4public.wsdl');
    print_r($client->getNewsList());
?>