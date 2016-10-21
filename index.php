<?php

/**
 * @author Poltarokov SP
 * @copyright 2011
 */

ini_set('display_errors',1);

if (!defined("ABSOLUTE_PATH"))
    define("ABSOLUTE_PATH", dirname(__FILE__)."/");

if (!file_exists(constant("ABSOLUTE_PATH")."classes_header.php"))
        exit('Bad module PATH!');
require_once(constant("ABSOLUTE_PATH")."classes_header.php");
require_once(constant("ABSOLUTE_PATH")."classes/index_html_page.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/dbconnector.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/auth.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/configuration.php");
require_once(constant("ABSOLUTE_PATH")."classes/view_forms/manage_menu.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/view_forms/planning_menu.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/view_forms/jschart.class.php");

if(isset($_REQUEST['app_type']))
    $_REQUEST['app_mode']='YES';

class IndexPage extends IndexHTMLPage
{
 function MainText($Connector)
 {  
     $FinanceActData_account_refresh_js="";

     //echo ABSOLUTE_PATH;
     $left_menu_style="gray_accordeon";
     $two_level_main_style="black_accordeon";
     //preg_match("/(\d+)\.(\d{2})/","45.00",$matches);
     
     if (array_key_exists("mobile_mode",$_GET))
             echo "<div data-role=\"page\"></div>";
     else
     {
        if (!array_key_exists("desktop_mode",$_GET)
             &&!(isset($_SESSION['desktop_mode'])?($_SESSION['desktop_mode']=="YES"):false))
            
            echo "<script language=\"JavaScript\">
                if ((windowWidth() > 700)) {
                    }
                else { document.write('<div data-role=\"page\"></div>'); } 
                </script>";
     }
     if (array_key_exists("desktop_mode",$_GET)
             ||(isset($_SESSION['desktop_mode'])?($_SESSION['desktop_mode']=="YES"):false))    {
        $manage_menu = new ManageMenuClass();
        
        $PurseDictTAdapt = new PurseTableAdapter($Connector, "", "Purse", "_account");
        $PurseDictTAdapt->assignNumSuffix("_account");
        $PurseDictTAdapt->setFormsFloating(true);
        
        //$purses_detail_params = array($FCAIncomeDictTAdapt->class_name.
        //    "_filt_"."fca_purse_id".$FCAIncomeDictTAdapt->class_name.
        //    $FCAIncomeDictTAdapt->num_suffix=>
        //    $FCAIncomeDictTAdapt->generateSelectJSWithFilterWithNum
        //    ("",0,$FCAIncomeDictTAdapt->class_name."_account_table_div","_account"));
        //$PurseDictTAdapt->setDetailAdaptersParams($purses_detail_params);
        
        $tabs_array = array(
                    array(
                        "tab_caption"=>"Счета",
                        "container_id"=>$PurseDictTAdapt->class_name."_account_table_tab_div",
                        "active"=>true),
                    array(
                        "tab_caption"=>"Импорт",
                        "container_id"=>"import_account_table_div",
                        "active"=>false),
                    array(
                        "tab_caption"=>"Категории",
                        "container_id"=>"Category"."_account_table_tab_div",
                        "active"=>false));
                //print_r($_SESSION);
                if (!$_SESSION['load_visa_default_cats']&&!array_key_exists("sql_action", $_GET))   {
                    echo "<div class=\"system_attention\">Вами не загружены категории по умолчанию!
                        <a class=\"button green\" href=\"index.php?desktop_mode&sql_action&sql_action_type=load_visa_cats\" rel=\"external\">Загрузить?</a></div>";
                }
                
                if (array_key_exists("prev_sql_action", $_GET)) {
                    if ($_GET['prev_sql_action']="clear_user_transaction")
                    {
                        echo "<div class=\"system_attention\">Внимание! Приняты параметры запроса удаления всех транзакций!
                        <a class=\"button green\" onclick=\" load_main_region('', 
                        '&desktop_mode&sql_action&sql_action_type=clear_user_transactions');\" 
                        href=\"#\" rel=\"external\">Удалить?</a></div>";
                    }
                }
                
                if (array_key_exists("sql_action", $_GET))  {
                    if(isset($_GET['sql_action_type'])) {
                        if (($_GET['sql_action_type']=="load_visa_cats")&&!$_SESSION['load_visa_default_cats']) {
                            if ($Connector->exec_with_prepare_and_params_2ver(
                                    " call `add_visa_categories`('{$_SESSION['user_id']}'); ", array()))
                                    {
                                        $Connector->exec_with_prepare_and_params_2ver(
                                            " UPDATE users SET load_visa_cats=1 
                                                WHERE id='{$_SESSION['user_id']}'; ", array());
                                    }
                        }
                    }
                }
                echo "<table border=\"0\" class=\"inside\"><tr><td style=\"vertical-align:top;width:300px;\">";
                
                if ($left_menu_style=="gray_accordeon")    {
                    echo "<div class=\"menu6\">";
                    echo "<li id=\"li_one\" class=\"li_menu6_active\"><a class=\"main_menu_head\" href=\"#li_one\" 
                        onclick=\"$('#li_one').toggleClass('li_menu6'); $('#li_one').toggleClass('li_menu6_active');\"  
                        title=\"Список счетов\">ОБЗОР</a><div>";
                    
                }   else    {
                    echo "<table border=\"0\">";
                    echo "<tr><td colspan=\"2\" class=\"group_header\">ОБЗОР</td></tr>";
                    echo "<tr><td width=\"20\"></td><td>";
                }
                if ($two_level_main_style=="black_accordeon")   {
                    echo "
                    <DIV class=\"container\">
                        <H2 class=\"acc_trigger\"><A href=\"#\">Счета</A></H2>
                        <DIV class=\"acc_container\" style=\"display: none; \">
                             <DIV class=\"block\">";
                }   else    {
                    echo $PurseDictTAdapt->getTabContentHeader($tabs_array, "tab_main_container_account");
                    echo "<div id=\"tab_main_container_account\" class=\"tab_content\">";
                }
                echo "<div id=\"".$PurseDictTAdapt->class_name."_account_table_tab_div"."\" 
                    style=\"display:;\">";
                echo "<div id=\"".$PurseDictTAdapt->class_name."_account_table_div"."\" 
                    style=\"display:;\">";
                $PurseDictTAdapt->selectFullWithRelative();
                $PurseDictTAdapt->setDefTableWidth(280);
                $PurseDictTAdapt->writeTableExt(true, true);
                echo "</div>";
                
                $PurseDictTAdapt->generateInsertFormWithNum(null, 
                    " function (next_function) { ".$PurseDictTAdapt->generateSelectJSWithFilterWithNum
                    ("",0,$PurseDictTAdapt->class_name."_account_table_div","_account")." } ", 
                    "_account");
                $FinanceActData_account_refresh_js .= " ".$PurseDictTAdapt->generateSelectJSWithFilterWithNum
                    ("",0,$PurseDictTAdapt->class_name."_account_table_div","_account");
                $PurseDictTAdapt->writeActionsFormsWithoutSlide();
                
                $PurseDictTAdapt->generateAddButtonWithStyle("button medium green");                
                
                $last_purse_table_first_id=$PurseDictTAdapt->getLastTableGetFirstObjectId();
                if (isset($last_purse_table_first_id))
                    echo "<script language=\"JavaScript\"> first_purse_id={$last_purse_table_first_id}; </script>";
                else 
                    echo "<script language=\"JavaScript\"> first_purse_id=null; </script>";
                
                echo "</div>";

                if ($two_level_main_style=="black_accordeon")   {
                    echo "
                            </div>
                        </div>";  
                }
                
                if ($left_menu_style=="gray_accordeon")    {
                    echo "</div></li>";
                    
                    echo "<li id=\"li_two\" class=\"li_menu6\"><a class=\"main_menu_head\" href=\"#li_two\" 
                        onclick=\"$('#li_two').toggleClass('li_menu6_active');\" 
                        title=\"Функции управления (настройки) аккаунтом\">УПРАВЛЕНИЕ</a><div>";
                }   else    {
                    echo "</td></tr>";
                    echo "<tr><td colspan=\"2\" class=\"group_header\"><br/>УПРАВЛЕНИЕ</td></tr>";
                    echo "<tr><td width=\"20\"></td><td>";
                }
                echo "<div class=\"container\">";
                $manage_menu->writeMenu("acc_container_menu");
                
                echo "</div>";
                
                if ($left_menu_style=="gray_accordeon")    {
                    echo "</div></li>";
                    echo "<li id=\"li_three\" class=\"li_menu6\"><a class=\"main_menu_head\" href=\"#li_three\" 
                        onclick=\"$('#li_three').toggleClass('li_menu6_active');\" 
                        title=\"Инструменты финансового планирования\">ПЛАНИРОВАНИЕ</a><div>";
                }   else    {
                    echo "</td></tr>";
                    echo "<tr><td colspan=\"2\" class=\"group_header\"><br/>ПЛАНИРОВАНИЕ</td></tr>";
                    echo "<tr><td width=\"20\"></td><td>";
                }
                
                $planning_menu = new PlanningMenuClass();
                echo "<div class=\"container\">";
                $planning_menu->writeMenu("acc_container_menu");
                echo "</div>";
                
                //$DebtPlanDictTAdapt = new PlanTableAdapter($Connector, "", "Plan", 
                //        "_planning_debt", "planning_debt_environment");
                //$DebtPlanDictTAdapt->assignNumSuffix("_planning_debt");
                //$DebtPlanDictTAdapt->setFormsFloating(true);
                //$DebtPlanDictTAdapt->setPlanCalculatingAlgorithm(
                //        $GLOBALS['debt_plan_calculating_algorithm']);
                //$DebtPlanDictTAdapt->filters_values['plan_optype_id'] = 
                //        $GLOBALS['planned_debt_payment_operation_type_id'];
                
                
                //$DebtPlanDictTAdapt->setActionTableRefreshJS(
                //    $DebtPlanDictTAdapt->generateSelectJSWithFilterWithNum
                //    ("",0,$DebtPlanDictTAdapt->class_name."_planning_debt_table_div","_planning_debt"));
                
                //$debt_plan_detail_params = array($FCAPlanDictTAdapt->class_name.
                //    "_filt_"."fca_plan_id".$FCAPlanDictTAdapt->class_name.
                //    $FCAPlanDictTAdapt->num_suffix=>
                //    $FCAPlanDictTAdapt->generateSelectJSWithFilterWithNum
                //    ("",0,$FCAPlanDictTAdapt->class_name."_planning_table_div","_planning"));
                //$DebtPlanDictTAdapt->setActionsDetailAdaptersParams($debt_plan_detail_params);
                
                //echo "
                //    <DIV class=\"container\">
                //
                //        <H2 class=\"acc_trigger\"><A href=\"#\">Погашение кредитов</A></H2>
                //        <DIV class=\"acc_container\" style=\"display: none; \">
                //                <DIV class=\"block\">";

                //$DebtPlanDictTAdapt->setHideFilterFormMode(true);
                //$DebtPlanDictTAdapt->generateFiltersFormWithNum(
                //        $DebtPlanDictTAdapt->class_name."_planning_debt_table_div", "_planning_debt");
                //echo "<div id=\"".$DebtPlanDictTAdapt->class_name."_planning_debt_table_div"."\" 
                //    style=\"display:;\">";
                //$DebtPlanDictTAdapt->selectFullWithRelative();
                //$DebtPlanDictTAdapt->setDefTableWidth(280);
                //$DebtPlanDictTAdapt->writeTableExt(true, true);
                //
                //echo "</div>";
                //$debt_plan_object = $DebtPlanDictTAdapt->object_adapter->getDataClassInstance();
                //$debt_plan_object->plan_optype_id = 
                //        $GLOBALS['planned_debt_payment_operation_type_id'];
                //$DebtPlanDictTAdapt->generateInsertFormWithNum($debt_plan_object, 
                //    " function (next_function) { ".$DebtPlanDictTAdapt->generateSelectJSWithFilterWithNum
                //    ("",0,$DebtPlanDictTAdapt->class_name."_planning_debt_table_div","_planning_debt")." } ", 
                //    "_planning_debt");
                //$FinanceActData_account_refresh_js .= " ".$DebtPlanDictTAdapt->generateSelectJSWithFilterWithNum
                //    ("",0,$DebtPlanDictTAdapt->class_name."_planning_debt_table_div","_planning_debt");
                //$DebtPlanDictTAdapt->generateAddButtonWithStyle("button medium green");
                //$DebtPlanDictTAdapt->writeActionsFormsWithoutSlide();

                //echo "               </DIV>
                //        </DIV>
                //
                //        <H2 class=\"acc_trigger\"><A href=\"#\">Планируемые доходы</A></H2>
                //        <DIV class=\"acc_container\" style=\"display: none; \">
                //                <DIV class=\"block\">
                //                        <H3>Раздел в разработке...</H3>
                //                </DIV>
                //        </DIV>
                //
                //        <H2 class=\"acc_trigger active\"><A href=\"#\">Планирование расходов</A></H2>
                //        <DIV class=\"acc_container\" style=\"display: block; \">
                //                <DIV class=\"block\">
                //                        <H3>Раздел в разработке...</H3>
                //                </DIV>
                //        </DIV>
                //
                //        <H2 class=\"acc_trigger\"><A href=\"#\">Возвраты мне</A></H2>
                //        <DIV class=\"acc_container\" style=\"display: none; \">
                //                <DIV class=\"block\">
                //                        <H3>Раздел в разработке...</H3>
                //                </DIV>
                //        </DIV>";
                //
                //if ($two_level_main_style=="black_accordeon")   {
                //    echo "<H2 class=\"acc_trigger\"><A href=\"#\">Цели</A></H2>
                //        <div class=\"acc_container\" style=\"display: none; \">
                //            <div class=\"block\">";
                //}
                //
                //
                //
                //
                //if ($two_level_main_style=="black_accordeon")   {
                //    echo "
                //        </div>
                //        </div>";
                //}
                //
                //echo    "</DIV>
                //    <!--<div id=\"accordion\">
                //            <h3 class=\"head\">Секция #1</h3>
                //            <div class=\"block\">
                //            </div>	
                //            <h3 class=\"head\">Секция #2</h3>
                //            <div class=\"block\">
                //            </div>	
                //            <h3 class=\"head\">Секция #3</h3>
                //            <div class=\"block\">
                //        </div>	
                //    </div>-->";
                if ($left_menu_style=="gray_accordeon")    {
                    echo "</div></li></div>";
                }   else    {
                    echo "</td></tr></table>";
                }
                
                
                require "include/payment_forms_inc.php";
                require "include/seo_scripts_menu_bottom.php";
                
                if (($_SESSION['login'] == "psdevelop")&&array_key_exists("test_assist_wsdl", $_GET))
                    Tools::checkCurrentUserPaymentsApproved();
                
                echo "</td><td style=\"vertical-align:top;\">";
        
                echo "<div id=\"main_region\"></div>";
                
                echo "<script language=\"JavaScript\">
                        function master_refresh_FinanceActData_account()    {
                            {$FinanceActData_account_refresh_js}
                        }
                    </script>";
                
                echo "</td></tr><table>";
     }
     else
     {
                $Connector = new DbConnector($GLOBALS['dbhost'],$GLOBALS['dbname'],$GLOBALS['dbuser'],$GLOBALS['dbpsw']);
                $Connector->createConnection();
                $PurseDictTAdapt = new PurseTableAdapter($Connector, "", "Purse");
            
		echo "      
                        <div id=\"purse_page\" data-role=\"page\" data-add-back-btn=\"false\" 
                          data-back-btn-text=\"Назад\" data-back-btn-theme=\"e\">
                          <div id=\"purse_header_id\" data-role=\"header\">
                            <a id=\"purse_form_header\" href=\"#main_page\" 
                                data-icon=\"back\">Назад</a>
                            <h3>Кошельки</h3>
                          </div>
                                 
                          <!--Начало контента страницы кошельков-->
                          <div data-role=\"content\">
                            <div id=\"{$PurseDictTAdapt->class_name}_dict_table_div\">";
                             //Динамически создается список кошельков-->";
                                        
                            $PurseDictTAdapt->selectFullWithRelative();
                            //$PurseDictTAdapt->generateDictHeader();
                            $PurseDictTAdapt->writeMobileListTable();

                 echo    "  </div>
                            <div data-role=\"collapsible-set\">
                                <div data-role=\"collapsible\" data-collapsed=\"true\">
                                    <h2>Добавление кошелька</h2>";
                                    $PurseDictTAdapt->generateMobileListInsertForm();
                 echo    "      </div>
                            </div>    
                          </div>
                          
                          <div data-role=\"footer\" data-position=\"fixed\">
                            <a id=\"purse_home_footer\" href=\"#\" data-theme=\"b\" 
                                data-icon=\"home\">На главную</a>
                          </div>
                        </div>
                            
                        <div id=\"planned_page\" data-role=\"page\" data-add-back-btn=\"false\" 
                            data-back-btn-text=\"Назад\" data-back-btn-theme=\"e\">
                    
                            <div id=\"planned_header_id\" data-role=\"header\">
                                <a id=\"planned_back_header\" href=\"#main_page\" 
                                    data-icon=\"back\">Назад</a>
                                <h3>Планирование</h3>
                            </div>
                                
                            <div data-role=\"content\">
                                <ul data-role=\"listview\" data-inset=\"true\">
                                    <!--//Динамически создается список-->
                                    <li><a href=\"#\" rel=\"external\">Периодические операции</a></li>
                                    <li><a href=\"#\" rel=\"external\">Постоянные операции с неопр. датой</a></li>
                                    <li><a href=\"#\" rel=\"external\">Цели</a></li>
                                    <li><a href=\"#\" rel=\"external\">Подбор вкладов</a></li>
                                    <li><a href=\"#\" rel=\"external\">Планирование бюджета</a></li>
                                </ul>
                            </div>
                            <div data-role=\"footer\" data-position=\"fixed\">
                                <a id=\"purse_home_footer\" href=\"#\" data-theme=\"b\" data-icon=\"home\">На главную</a>
                            </div>
                        </div>
                            
                        <div id=\"fact_page\" data-role=\"page\" data-add-back-btn=\"false\" 
                            data-back-btn-text=\"Назад\" data-back-btn-theme=\"e\">
                    
                            <div id=\"fact_header_id\" data-role=\"header\">
                                <a id=\"fact_back_header\" href=\"#main_page\" data-icon=\"back\">Назад</a>
                                <h3>Анализ, отчеты</h3>
                            </div>

                            <div data-role=\"content\">
                                <ul data-role=\"listview\" data-inset=\"true\">
                                    <li><a href=\"#\" rel=\"external\">Состояние бюджета</a></li>
                                    <li><a href=\"#\" rel=\"external\">Прогнозы</a></li>
                                    <li><a href=\"#\" rel=\"external\">Отчеты</a></li>
                                    <li><a href=\"#\" rel=\"external\">Диаграммы</a></li>
                                </ul>
                            </div>
                            <div data-role=\"footer\" data-position=\"fixed\">
                                <a id=\"purse_home_footer\" href=\"#\" data-theme=\"b\" data-icon=\"home\">На главную</a>
                            </div>
                        </div>
                            
                        <div id=\"other_page\" data-role=\"page\" data-add-back-btn=\"false\" 
                            data-back-btn-text=\"Назад\" data-back-btn-theme=\"e\">

                            <div id=\"other_header_id\" data-role=\"header\">
                                <a id=\"other_back_header\" href=\"#e\" data-icon=\"back\">Назад</a>
                                <h3>Дополнительно</h3>
                            </div>

                            <div data-role=\"content\">
                                <ul data-role=\"listview\" data-inset=\"true\">
                                    <li><a href=\"#\" rel=\"external\">Справочники</a></li>
                                    <li><a href=\"#\" rel=\"external\">Импорт</a></li>
                                    <li><a href=\"#\" rel=\"external\">Экспорт</a></li>
                                    <li><a href=\"#\" rel=\"external\">О программе</a></li>
                                </ul>
                            </div>
                            <div data-role=\"footer\" data-position=\"fixed\">
                                <a id=\"purse_home_footer\" href=\"#\" data-theme=\"b\" data-icon=\"home\">На главную</a>
                            </div>
                        </div>
                            
                        <div id=\"logout_dialog\" data-role=\"page\">

                            <div id=\"logout_header_id\" data-role=\"header\">
                                <h3>Подтверждение</h3>
                            </div>

                            <div data-role=\"content\">
                                <center><b><h2>Выйти из системы?</h2></b></center>
                                <div data-role=\"controlgroup\" data-type=\"horizontal\">
                                    <center>
                                        <a id=\"logout_ok\" href=\"index.php?action=logout\" data-role=\"button\" data-theme=\"b\" data-icon=\"home\" rel=\"external\">OK</a>
                                        <a id=\"logout_cancel\" href=\"#\"  data-role=\"button\" data-theme=\"b\" data-icon=\"home\">Отмена</a>
                                    </center>
                                </div>
                            </div>
                            <div data-role=\"footer\" data-position=\"fixed\">
                                <!--<a href=\"\">На главную</a>-->

                            </div>
                        </div>
                            
                        <div id=\"settings_page\" data-role=\"page\">

                            <div id=\"settings_header_id\" data-role=\"header\">
                                <h3>Настройки приложения</h3>
                            </div>

                            <div data-role=\"content\">
                                <div data-role=\"controlgroup\" data-type=\"horizontal\">
                                    <center>
                                        <a id=\"go_to_desktop_mode\" 
                                            href=\"index.php?desktop_mode\" 
                                            data-role=\"button\" data-theme=\"b\" 
                                            data-icon=\"home\" rel=\"external\">Desktop-интерфейс</a>
                                    </center>
                                </div>
                            </div>
                            <div data-role=\"footer\" data-position=\"fixed\">
                            </div>
                        </div>

                        <div id=\"main_page\" data-role=\"page\">

                            <div id=\"header_id\" data-role=\"header\">
                                <a id=\"logout_dialog_id\" href=\"#\" data-rel=\"dialog\" 
                                data-transition=\"pop\" data-role=\"button\">Выход</a>
                                <h3>Копилка</h3>
                                <a id=\"show_settings\" href=\"settings\" data-icon=\"gear\">Настр.</a>
                                <div data-role=\"navbar\">
                                    <ul>
                                        <li><a id=\"showPurseButton\" data-icon=\"home\" rel=\"external\">Кошельки</a></li>
                                        <li><a id=\"showPlanningButton\" href=\"#\" data-icon=\"star\">Планирование</a></li>
                                        <li><a id=\"showFactButton\" href=\"#\" data-icon=\"info\">Анализ, отчеты</a></li>
                                        <li><a id=\"showOtherButton\" href=\"#news\" data-icon=\"grid\">Другое</a></li>
                                    </ul>
                                </div>
                            </div>

                            <div data-role=\"content\">

                                <!-- This defines the whole collapsible set (accordion) -->
                                <div data-role=\"collapsible-set\">
                                    <div data-role=\"collapsible\" data-collapsed=\"false\">
                                        <h2>Часто требуются</h2>
                                        <ul>
                                            <li>Programming the Mobile Web</li>
                                            <li>jQuery Mobile: Up & Running</li>
                                            <li>Mobile HTML5</li>
                                        </ul>
                                    </div>
                                    <div data-role=\"collapsible\" data-collapsed=\"true\">
                                        <h2>Важные уведомления</h2>
                                        <ul>
                                            <li>Velocity Conference</li>
                                            <li>OSCON</li>
                                            <li>Mobile World Congress</li>
                                            <li>Google DevFest</li>
                                        </ul>
                                    </div>
                                    <div data-role=\"collapsible\" data-collapsed=\"true\">
                                        <h2>Краткая сводка</h2>
                                        <ul>
                                            <li>Velocity Conference</li>
                                            <li>OSCON</li>
                                            <li>Mobile World Congress</li>
                                            <li>Google DevFest</li>
                                        </ul>
                                    </div>
                                    <div data-role=\"collapsible\" data-collapsed=\"true\">
                                        <h2>Дерево функций</h2>
                                        <ul>
                                            <li>Velocity Conference</li>
                                            <li>OSCON</li>
                                            <li>Mobile World Congress</li>
                                            <li>Google DevFest</li>
                                        </ul>
                                    </div>
                                    <div data-role=\"collapsible\" data-collapsed=\"true\">
                                        <h2>Новости</h2>
                                        <ul>
                                            <li>Velocity Conference</li>
                                            <li>OSCON</li>
                                            <li>Mobile World Congress</li>
                                            <li>Google DevFest</li>
                                        </ul>
                                    </div>
                                </div>
                                <!-- end of collapsible set (accordion) -->

                            </div>
                            <div data-role=\"footer\" data-position=\"fixed\">
                                <a href=\"add\" data-theme=\"b\" data-icon=\"home\">На главную</a>
                            </div>
                        </div>
                            
                        ";
                 echo "<div id=\"main_region\"></div>";
     }
        
     
 }
 
 function getStartJS($Connector)  {
    $class_name = "Ticket";
    if (isset($_GET['class_name'])) 
        $class_name=$_GET['class_name'];
    
    $reflectionClass = new ReflectionClass($class_name."TableAdapter");
    $DictTAdapt = $reflectionClass->newInstanceArgs(array($Connector,
        "",$class_name));
    
    return $DictTAdapt->generateSelectJSWithFilter("",0,$class_name.$GLOBALS['dict_container_base']);
    //return $DictTAdapt->generateSelectJS("",0,"master_dict_div");
 }
 
}

$Page = new IndexPage("Главная страница");

$Page->Write();

?>