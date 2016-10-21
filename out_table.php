<?php

/**
 * @author Poltarokov SP
 * @copyright 2011
 */
 
    ini_set('display_errors',1);
    session_start();
    date_default_timezone_set('Europe/Moscow');

    require_once("classes/dbconnector.class.php");
    require_once("classes/configuration.php");
    require_once("classes/auth.class.php");
    require_once("classes_header.php");

    $class_name=null;
    
    if (isset($_GET['class_name'])) 
        $class_name=$_GET['class_name'];
    if (isset($_POST['class_name'])) 
        $class_name=$_POST['class_name'];
    
    if (!isset($class_name))
        die("Не задан параметр сущности для скрипта выборки!");
    
    //print_r($_GET);
    
    $request_mode="";
    if (isset($_GET['request_mode'])) 
	    $request_mode=$_GET['request_mode'];
    if (isset($_POST['request_mode'])) 
	    $request_mode=$_POST['request_mode'];
	//else 
	//    $select_table_name="";
    
    $page_capacity_val=null;
    if (isset($_GET['page_capacity_val'])) 
	    $page_capacity_val=$_GET['page_capacity_val'];
    
    $entity_suffix=null;
    if (isset($_GET['entity_suffix'])) 
	    $entity_suffix=$_GET['entity_suffix'];
    if (isset($_POST['entity_suffix'])) 
	    $entity_suffix=$_POST['entity_suffix'];

    //print_r($_GET);
    $Connector = new DbConnector($GLOBALS['dbhost'],$GLOBALS['dbname'],$GLOBALS['dbuser'],$GLOBALS['dbpsw']);
    $UserAuth = new UserAuthentification($Connector);
    
    //out_table.php?class_name=InOutCats&request_mode=out_report_mode&entity_suffix=_account&report_name=outcome_categories_diagramm&result_type=json
    if ($UserAuth->checkLogin($_SESSION['login'], $_SESSION['psw']))    {
    //echo "----";
    if ($request_mode==$GLOBALS['out_report_mode'])  {
        $report_name=null;
        //echo "----";
        if (isset($_GET['report_name'])) 
	    $report_name=$_GET['report_name'];
        if (isset($_POST['report_name'])) 
	    $report_name=$_POST['report_name'];
        
        $reflectionClass = new ReflectionClass($class_name."Report");
        $ReportAdapt = $reflectionClass->newInstanceArgs(array($Connector,
            "", $class_name));
        $ReportAdapt->acceptAjaxParams(array_merge($_GET, $_POST), $entity_suffix);
        $ReportAdapt->setDefaultReportName($report_name);
        
        if (isset($_GET['result_type'])) 
	    if($_GET['result_type']=="json")
                $ReportAdapt->setJSONOutType(true);
        if (isset($_POST['result_type'])) 
	    if($_POST['result_type']=="json")
                $ReportAdapt->setJSONOutType(true);
        
        
            $ReportAdapt->generateReport();
    }   else    {
        $reflectionClass = new ReflectionClass($class_name."TableAdapter");
        $DictTAdapt = $reflectionClass->newInstanceArgs(array($Connector,
            "", $class_name, $entity_suffix));
        
        if($page_capacity_val!=null) 
            if (is_numeric($page_capacity_val))
                $DictTAdapt->setPartCapacity((int)$page_capacity_val);
            
        $DictTAdapt->assignNumSuffix($entity_suffix);

        $DictTAdapt->prepareFilterArray($_GET);
    
        if ($request_mode==$GLOBALS['select_mode'])  {
            $DictTAdapt->selectWithRelative();
            if (!$DictTAdapt->without_dict_header_mode)
                $DictTAdapt->generateDictHeaderWithNum();
            $DictTAdapt->writeTable();
            //echo "--------------";
        }
        else if ($request_mode==$GLOBALS['mobile_list_table_mode'])  {
            $DictTAdapt->selectFullWithRelative();
            //$PurseDictTAdapt->generateDictHeader();
            $DictTAdapt->writeMobileListTable();
        }
        else if ($request_mode==$GLOBALS['mobile_table_mode'])  {
            $DictTAdapt->selectFullWithRelative();
            //$PurseDictTAdapt->generateDictHeader();
            $DictTAdapt->writeMobileTable();
        }
        else if ($request_mode==$GLOBALS['get_sel_options_mode'])  {
            echo $DictTAdapt->getSelectContentFullByFilter();
        }
        else if ($request_mode==$GLOBALS['get_list_div_mode'])  {
            echo $DictTAdapt->getListDivContentFullByFilter();
        }
        else    {
            echo "Неизвестный режим выборки в AJAX-запросе!";
        }
    }
    //echo "<div>jkhuhuihuih";
    //print_r($_SESSION);
    //echo "</div>";
    if ($GLOBALS['global_ajax_timeout']>0)
        sleep($GLOBALS['global_ajax_timeout']);
    }   else
        echo "Нет аутентификации!";

?>