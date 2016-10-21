<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

require_once("/../classes/configuration.php");
require_once("/../classes/dbconnector.class.php");
require_once("/../classes/table_adapters/table_adapter.class.php");
require_once("/../classes/table_adapters/news_table_adapter.class.php");

class KPPublic {
    
    /**
     * Retrievs all news
     *
     * @return array - list of all available currencies
     */
    public function getNewsList() {
        $Connector = new DbConnector($GLOBALS['dbhost'],$GLOBALS['dbname'],$GLOBALS['dbuser'],$GLOBALS['dbpsw']);
	$Connector->createConnection();
        $NewsDictTAdapt = new NewsTableAdapter($Connector, "", "News", null);
        return array($NewsDictTAdapt->getSelectQueryArray());
    }

}


?>
