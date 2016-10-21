<?php

/* 16042012 Copyright Poltarokov SP 2012
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

ini_set('display_errors',1);
require_once("classes/dbconnector.class.php");
require_once("classes/tools.class.php");
require_once("classes/auth.class.php");
require_once("classes/configuration.php");
require_once("classes_header.php");

echo "
<!DOCTYPE html>
<html>
    <head>
        <title></title>
        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">";

echo "  <link rel=\"stylesheet\" href=\"styles/jquery.mobile-1.0.1.min.css\" />
        <script src=\"jscripts/jquery-1.6.4.min.js\"></script>
        <script type=\"text/javascript\" src=\"jscripts/jquery.mobile-1.0.1.min.js\">
        </script>   
        <script type=\"text/javascript\" src=\"jscripts/ajax140612.js\"></script>";
//include_once '../jquery_mob_headers.php';

$purse_id=-1;
if (isset($_GET['purse_id'])) {
    $purse_id=$_GET['purse_id'];
}
$Connector = new DbConnector($GLOBALS['dbhost'],$GLOBALS['dbname'],$GLOBALS['dbuser'],$GLOBALS['dbpsw']);
$Connector->createConnection();
$FCAIncomeDictTAdapt = new FinanceActDataTableAdapter($Connector, "", "FinanceActData");
//$FCAIncomeDictTAdapt->base_filter = " ( (fca_operation_type_id={$GLOBALS['income_operation_type_id']}) AND 
//    (fca_purse_id={$purse_id}) ) ";

$FCAOutcomeDictTAdapt = new FinanceActDataTableAdapter($Connector, "", "FinanceActData");
//$FCAOutcomeDictTAdapt->base_filter = " ( (fca_operation_type_id={$GLOBALS['outcome_operation_type_id']}) AND 
//    (fca_purse_id={$purse_id}) ) ";
$FCAIncomeDictTAdapt->values_filter_array = array("fca_operation_type_id"=>"(fca_operation_type_id=***___fca_operation_type_id)",
        "fca_purse_id"=>"(fca_purse_id=***___fca_purse_id)");
$FCAIncomeDictTAdapt->values_filter_values["fca_operation_type_id"]=$GLOBALS['income_operation_type_id'];
$FCAIncomeDictTAdapt->values_filter_values["fca_purse_id"]=$purse_id;
$FCAOutcomeDictTAdapt->values_filter_array = array("fca_operation_type_id"=>"(fca_operation_type_id=***___fca_operation_type_id)",
        "fca_purse_id"=>"(fca_purse_id=***___fca_purse_id)");
$FCAOutcomeDictTAdapt->values_filter_values["fca_operation_type_id"]=$GLOBALS['outcome_operation_type_id'];
$FCAOutcomeDictTAdapt->values_filter_values["fca_purse_id"]=$purse_id;
$income_object = $FCAIncomeDictTAdapt->getObjectAdapterInstance()->getDataClassInstance();
$income_object->fca_operation_type_id=$GLOBALS['income_operation_type_id'];
$income_object->fca_purse_id=$purse_id;
$outcome_object = $FCAOutcomeDictTAdapt->getObjectAdapterInstance()->getDataClassInstance();
$outcome_object->fca_operation_type_id=$GLOBALS['outcome_operation_type_id'];
$outcome_object->fca_purse_id=$purse_id;

echo "  <script language=\"JavaScript\" type=\"text/javascript\">
        
        $(document).ready(function() {
              $(\"#purse_stat_page\").trigger('create');
              $(\"#purse_stat_page\").page();
              $.mobile.changePage($(\"#purse_stat_page\"), {
                                        transition: \"slide\",
                                        reverse: true
                                    });
              //$(\"#add_income_page\").html('');
        });
        
        function backToPurses() {
            $.mobile.changePage(\"index.php\", {
                                        transition: \"slide\",
                                        reverse: true
                                    });
            $.mobile.changePage($(\"#purse_page\"), {
                                        transition: \"slide\",
                                        reverse: true
                                    });                                
        }

        function showAddIncomePage(accountID)    {
            //$(\"#add_income_page\").trigger('create');
            //$(\"#add_income_page\").trigger('pagecreate');
            //$(\"#add_income_page\").page();
            $.mobile.changePage($(\"#add_income_page\"), {
                                        transition: \"slide\",
                                        reverse: true
                                    }); 
        }
        
        function load_get_stat() {
            $(\"#add_income_page\").trigger('create');
            $(\"#add_income_page\").page();
            //$.mobile.changePage($(\"#add_income_page\"), {
            //                            transition: \"slide\",
            //                            reverse: true
            //                        });
            
            $(\"#add_income_back\").click(function() {
                                try {
                                    $.mobile.changePage($(\"#purse_stat_page\"), {
                                        transition: \"slide\",
                                        reverse: true
                                    });
                                } catch ( e ) {
                                   //container_object.innerHTML = \"Ошибка отображения результата AJAX-запроса в контейнере!\"+e.toString();
                                }
                            } );
                            
            $(\"#cancel_income_id\").click(function() {
                                try {
                                    $.mobile.changePage($(\"#purse_stat_page\"), {
                                        transition: \"slide\",
                                        reverse: true
                                    });
                                } catch ( e ) {
                                   //container_object.innerHTML = \"Ошибка отображения результата AJAX-запроса в контейнере!\"+e.toString();
                                }
                            } );
                            
            $(\"#add_income_id\").click(function() {
                                $(\"#income_table\").append('<tr><td>'+document.getElementById('op_date').value+
                                '</td><td>'+document.getElementById('company').value+'</td><td>'+
                                document.getElementById('comments').innerHTML+'</td><td>'+
                                document.getElementById('summ').value+'</td></tr>');
                                try {
                                    $.mobile.changePage($(\"#purse_stat_page\"), {
                                        transition: \"slide\",
                                        reverse: true
                                    });
                                } catch ( e ) {
                                   //container_object.innerHTML = \"Ошибка отображения результата AJAX-запроса в контейнере!\"+e.toString();
                                }
                            } );

        }
        
        
        </script>
    </head>
    <body onLoad=\" load_get_stat(); \">
        <div id=\"warning_region\"></div>
        <div id=\"purse_stat_page\" data-role=\"page\">
        <div data-role=\"header\">
            <a id=\"account_stat_back\" href=\"index.php?page_id=purse_page\" onClick=\"\" data-icon=\"back\" rel=\"external\">Назад</a>
            <h1>Обороты на счете</h1>
        </div>
        <div data-role=\"content\">
            <div data-role=\"collapsible-set\">
                <div data-role=\"collapsible\" data-collapsed=\"false\">
                    <h2>Приход</h2>
                    <div data-role=\"fieldcontainer\">
                        <label for=\"search\">Поиск:</label>
                        <input type=\"search\" id=\"search\" name=\"search\">
                    </div>
                    <div id=\"{$FCAIncomeDictTAdapt->class_name}_income_table_div\">
                    <!--<table id=\"income_table\" border=\"0\" width=\"95%\">
                        <tr><td>Дата</td><td>Контрагент</td><td>Описание</td><td>Сумма</td></tr>
                    </table>--!>";
      
      $FCAIncomeDictTAdapt->selectFullWithRelative();
      $FCAIncomeDictTAdapt->writeMobileTable();
      
      echo      "        </div>
                        <div data-role=\"collapsible-set\">
                                        <div data-role=\"collapsible\" data-collapsed=\"true\">
                                            <h2>Добавление прихода</h2>";
      $FCAIncomeDictTAdapt->generateMobileListInsertFormWithNum($income_object, 
            " function (next_function) { ".$FCAIncomeDictTAdapt->generateMobileSelectJSWithFilterTAdaptParams
            ("",0,$FCAIncomeDictTAdapt->class_name."_income_table_div")." } ", 
            $FCAIncomeDictTAdapt->class_name."_income");          
      echo      "  </div></div>  
                </div>
                <div data-role=\"collapsible\" data-collapsed=\"true\">
                    <h2>Расход</h2>
                </div>
            </div>    
        </div>
        <div data-role=\"footer\" data-position=\"fixed\">
            <h1>Подвал</h1>
            <a id=\"add_income_footer\" href=\"#\" onClick=\"showAddIncomePage(0);\" data-theme=\"b\" data-icon=\"plus\">Доб. приход</a>
            <a id=\"add_charge_footer\" href=\"#\" data-theme=\"b\" data-icon=\"plus\">Доб. расход</a>
        </div>
      </div>
      <div id=\"add_income_page\" data-role=\"page\">
        <div data-role=\"header\">
            <a id=\"add_income_back\" href=\"#\" onClick=\"backToAccountStat();\" data-icon=\"back\">Назад</a>
            <h1>Добавление прихода</h1>
        </div>
        <div data-role=\"content\">
            <div data-role=\"fieldcontainer\">
                <label for=\"op_date\">Дата:</label>
                <input type=\"date\" id=\"op_date\" name=\"op_date\" value=\"16-04-2012\">
                <label for=\"company\">Контрагент:</label>
                <input type=\"text\" id=\"company\" name=\"company\" value=\"Ростелеком\">
                <label for=\"comments\">Описание:</label>
                <textarea id=\"comments\" name=\"comments\">Оплата Интернета за март 2012 года, тариф Супер</textarea>
                <label for=\"summ\">Сумма:</label>
                <input type=\"text\" id=\"summ\" name=\"summ\" value=\"1280.00\">
            </div>

            <div data-role=\"controlgroup\" data-type=\"horizontal\">
            <center>
                <a id=\"add_income_id\" href=\"#\" data-theme=\"b\" data-icon=\"plus\" data-role=\"button\" data-inline=\"true\">Доб. приход</a>
                <a id=\"cancel_income_id\" href=\"#\" data-theme=\"b\" data-icon=\"back\" data-role=\"button\" data-inline=\"true\">Отмена</a>
            </center>
            </div>      
        </div>
        <div data-role=\"footer\" data-position=\"fixed\">
            <h1>Подвал</h1>
        </div>
      </div>
    </body>
  </html>"; 

?>
