<?php

/**
 * @author Poltarokov SP
 * @copyright 2012
 */ 

session_start();
date_default_timezone_set('Europe/Moscow');
ini_set('display_errors',1);

if (!defined("ABSOLUTE_PATH"))
    define("ABSOLUTE_PATH", dirname(__FILE__)."/");

require_once(constant("ABSOLUTE_PATH")."classes/configuration.php");
require_once(constant("ABSOLUTE_PATH")."classes/view_forms/report_menu.class.php"); 
require_once(constant("ABSOLUTE_PATH")."classes_header.php");
    
    if (    (
                (isset($_GET['browser_width'])?($_GET['browser_width']>700):true)
                &&(!array_key_exists("mobile_mode", $_GET))
                &&(!array_key_exists("mobile_mode", $_POST))
            )
            ||(array_key_exists("desktop_mode", $_GET))
            ||(isset($_SESSION['desktop_mode'])?($_SESSION['desktop_mode']=="YES"):false))	{
        
        $class_name = "FinanceActData";
        if(array_key_exists("class_name", $_GET))
            $class_name = $_GET['class_name'];
        $report_name = null;
        if(isset($_GET['report_name']))
            $report_name = $_GET['report_name'];
        
        $page_id = null;
        if(isset($_GET['page_id']))
            $page_id = $_GET['page_id'];
        
        $env_mode = null;
        if(isset($_GET['env_mode']))
            $env_mode = $_GET['env_mode'];
        
	$Connector = new DbConnector($GLOBALS['dbhost'],$GLOBALS['dbname'],$GLOBALS['dbuser'],$GLOBALS['dbpsw']);
	$Connector->createConnection();
        
        if(array_key_exists("sql_action", $_GET)&&array_key_exists("sql_action_type", $_GET))  {
            if($_GET['sql_action_type']=="clear_user_transactions") {
                if($Connector->exec_with_prepare_and_params_2ver("UPDATE finance_action_data_storage 
                    SET closed=1 WHERE fca_purse_id IN (SELECT purse_dictionary_id FROM purse_dictionary WHERE 
                    user_id='{$_SESSION['user_id']}');", array()))  {
                        echo "Транзакции удалены!";
                }   else 
                    echo "Ошибка при удалении транзакций!";
            }
        }
        
        if(array_key_exists("report_mode", $_GET))  {
            $reflectionClass = new ReflectionClass($class_name."Report");
            $ReportObject = $reflectionClass->newInstanceArgs(array($Connector,$class_name));
            $ReportObject->setDefaultReportName($report_name);
            $ReportObject->generateReportExecutionPanel($class_name.$GLOBALS['dict_container_base']);
            echo "<div id=\"".$class_name.$GLOBALS['dict_container_base']."\">";
            if ($report_name==null)    
                $ReportObject->generateReport();
            else
            {
                $ReportObject->generateReportByName($report_name);
            }
            echo "</div>";
        } else if(array_key_exists("categories_page_mode", $_GET))  {
            $CategoryDictTAdapt = new CategoryTableAdapter($Connector, "", "Category");
            $CategoryDictTAdapt->assignNumSuffix("_account");
            $CategoryDictTAdapt->setFormsFloating(true);
            echo "<h1 class=\"dict_header_big_style\">Категории</h1>";
            echo "<div id=\"".$CategoryDictTAdapt->class_name."_account_table_tab_div"."\" 
                    style=\"display:;\" class=\"left_menu_blue_gradient_hor\">";
            echo "<div id=\"".$CategoryDictTAdapt->class_name."_account_table_div"."\" 
                style=\"display:;\" class=\"scrolled\">";
            $CategoryDictTAdapt->selectFullWithRelative();
            $CategoryDictTAdapt->setDefTableWidth(270);
            $CategoryDictTAdapt->writeTableExt(true, true);
            echo "</div>";
            $CategoryDictTAdapt->generateInsertFormWithNum(null, 
                " function (next_function) { ".$CategoryDictTAdapt->generateSelectJSWithFilterWithNum
                ("",0,$CategoryDictTAdapt->class_name."_account_table_div","_account")." } ", 
                "_account");
            //$FinanceActData_account_refresh_js .= " ".$CategoryDictTAdapt->generateSelectJSWithFilterWithNum
            //    ("",0,$CategoryDictTAdapt->class_name."_account_table_div","_account");
            $CategoryDictTAdapt->generateAddButtonWithStyle("button medium green");
            echo "</div>";
        } 
        else if(array_key_exists("news_page_mode", $_GET))  {
            echo "<h1 class=\"dict_header_big_style\">Управление новостной лентой</h1>";
            $NewsDictTAdapt = new NewsTableAdapter($Connector, "", "News", null);
            
            $NewsDictTAdapt->selectWithRelative();
            $NewsDictTAdapt->setDefTableWidth(650);
            $NewsDictTAdapt->fixed_table_width = false;
            $NewsDictTAdapt->writeActionsFormsWithoutSlide();

            //Вывод блока табличного адаптера с базовым набором функций (фильтры, форма правки и проч.)
            echo "<div id=\"entity_full_region\"><table border=\"0\" width=\"100%\"><tr><td class=\"default_struct_td\" 
                style=\"padding-left:10px;padding-right:10px;\">";

            echo "<div class=\"panel_mate_blue\"><table border=\"0\"><tr><td>";
            //$FCAIncomeDictTAdapt->setHideFilterFormMode(true);
            //$InvitesDictTAdapt->generateFiltersFormWithNum($FCAIncomeDictTAdapt->class_name."_account_table_div",
            //        "_account");
            echo "</td><td>";
            $NewsDictTAdapt->generatePagerFormWithNum($NewsDictTAdapt->class_name."_account_table_div", 
                "_account");
            echo "</td></tr></table></div>";
            //$FCAIncomeDictTAdapt->generateAddButtonWithStyle("button medium green");
            echo "<div id=\"".$NewsDictTAdapt->class_name."_account_table_div"."\">";
            //echo "<span style=\"display:none;\">"; 
            $NewsDictTAdapt->generateDictHeaderWithNum(); 
            //echo "</span>";
            $NewsDictTAdapt->writeTable();
            //echo "</div>";
            $news_object = $NewsDictTAdapt->getLastTableGetFirstObject();
            echo "</div>";
            echo "</td><td class=\"default_struct_td\" style=\"width:250px;\">";
            $NewsDictTAdapt->generateInsertFormWithNum($news_object, 
                " function (next_function) { ".$NewsDictTAdapt->generateSelectJSWithFilterWithNum
                ("",0,$NewsDictTAdapt->class_name."_account_table_div","_account")." ".
                " } ", 
                "_account");
            echo "</td></tr><table></div>";
            
        }
        else if(array_key_exists("invites_page_mode", $_GET))  {
            echo "<h1 class=\"dict_header_big_style\">Список заявок на приглашение</h1>";
            $InvitesDictTAdapt = new InviteTableAdapter($Connector, "", "Invite", null);
            
            $InvitesDictTAdapt->selectWithRelative();
            $InvitesDictTAdapt->setDefTableWidth(650);
            $InvitesDictTAdapt->fixed_table_width = false;
            $InvitesDictTAdapt->writeActionsFormsWithoutSlide();

            //Вывод блока табличного адаптера с базовым набором функций (фильтры, форма правки и проч.)
            //echo "<div id=\"entity_full_region\"><table border=\"0\" width=\"100%\"><tr><td class=\"default_struct_td\" 
            //    style=\"padding-left:10px;padding-right:10px;\">";

            echo "<div class=\"panel_mate_blue\"><table border=\"0\"><tr><td>";
            //$FCAIncomeDictTAdapt->setHideFilterFormMode(true);
            //$InvitesDictTAdapt->generateFiltersFormWithNum($FCAIncomeDictTAdapt->class_name."_account_table_div",
            //        "_account");
            echo "</td><td>";
            $InvitesDictTAdapt->generatePagerFormWithNum($InvitesDictTAdapt->class_name."_account_table_div", 
                "_account");
            echo "</td></tr></table></div>";
            //$FCAIncomeDictTAdapt->generateAddButtonWithStyle("button medium green");
            echo "<div id=\"".$InvitesDictTAdapt->class_name."_account_table_div"."\">";
            //echo "<span style=\"display:none;\">"; 
            $InvitesDictTAdapt->generateDictHeaderWithNum(); 
            //echo "</span>";
            $InvitesDictTAdapt->writeTable();
            echo "</div>";
            
        }
        else if(array_key_exists("import_page_mode", $_GET))  {
            echo "<h1 class=\"dict_header_big_style\">Импорт транзакций из банковских файлов-выписок</h1>";
            $PurseDictTAdapt = new PurseTableAdapter($Connector, "", "Purse", "_account");
            $PurseDictTAdapt->assignNumSuffix("_account");
            //$PurseDictTAdapt->setFormsFloating(true);
            $PurseDictTAdapt->selectFullWithRelative();
            echo "<div id=\"import_account_table_div"."\" 
                        style=\"display:;\" class=\"panel_mate_blue\">";
            echo $PurseDictTAdapt->getClassSelectElementJS("import_select", "Кошелек",
                    " document.getElementById('import_form').action = 
                        'index.php?upload&desktop_mode&upld_purse_id='+this.value; ");
            echo "<form id=\"import_form\" action=\"index.php?upload&desktop_mode\" action=\"post\" data-ajax=\"false\"
            method=\"post\" enctype=\"multipart/form-data\">
            <input class=\"gray\" type=\"file\" name=\"uploadfile\">
            <input  class=\"button blue\" type=\"submit\" value=\"Загрузить\"></form>
            ";
            echo "</div>";
        } else if(array_key_exists("fplan_page_mode", $_GET)) 
        {
            
        } else if(array_key_exists("fincomes_page_mode", $_GET)) 
        {
            echo "<h1 class=\"dict_header_big_style\">Планирование будущих доходов</h1>";
            $IncomesPlanDictTAdapt = new PlanTableAdapter($Connector, "", "Plan", 
                    "_planning_incomes", "planning_income_environment");
            $IncomesPlanDictTAdapt->assignNumSuffix("_planning_incomes");
            $IncomesPlanDictTAdapt->object_adapter->hidden_keys['apr']="hidden";
            $IncomesPlanDictTAdapt->object_adapter->hidden_keys['plan_shedule_id']="hidden";
            $IncomesPlanDictTAdapt->setFormsFloating(true);
            $IncomesPlanDictTAdapt->showCustomHiddenKeys(array("target_date"=>"showed"));
            $IncomesPlanDictTAdapt->filters_values['plan_optype_id'] = 
                    $GLOBALS['planned_income_operation_type_id'];

            $IncomesPlanDictTAdapt->setHideFilterFormMode(true);
            $IncomesPlanDictTAdapt->generateFiltersFormWithNum(
                    $IncomesPlanDictTAdapt->class_name."_planning_incomes_table_div", "_planning_incomes");
            echo "<div id=\"".$IncomesPlanDictTAdapt->class_name."_planning_incomes_table_div"."\" 
                style=\"display:;\">";
            $IncomesPlanDictTAdapt->selectFullWithRelative();
            $IncomesPlanDictTAdapt->writeTableExt(true, true);

            echo "</div>";
            $income_plan_object = $IncomesPlanDictTAdapt->object_adapter->getDataClassInstance();
            $income_plan_object->plan_optype_id = 
                    $GLOBALS['planned_income_operation_type_id'];
            $income_plan_object->apr = 0;
            $income_plan_object->relative_props['plan_shedule_id'] = 0;
            $IncomesPlanDictTAdapt->generateInsertFormWithNum($income_plan_object, 
                " function (next_function) { ".$IncomesPlanDictTAdapt->generateSelectJSWithFilterWithNum
                ("",0,$IncomesPlanDictTAdapt->class_name."_planning_incomes_table_div",
                "_planning_incomes")." } ", "_planning_incomes");
            //$FinanceActData_account_refresh_js .= " ".$TargetPlanDictTAdapt->generateSelectJSWithFilterWithNum
            //    ("",0,$TargetPlanDictTAdapt->class_name."_planning_target_table_div",
            //    "_planning_target");
            $IncomesPlanDictTAdapt->generateAddButtonWithStyle("button medium green");
            $IncomesPlanDictTAdapt->writeActionsFormsWithoutSlide();
        } else if(array_key_exists("fcharges_page_mode", $_GET)) 
        {
            echo "<h1 class=\"dict_header_big_style\">Планирование будущих расходов</h1>";
            $ChargesPlanDictTAdapt = new PlanTableAdapter($Connector, "", "Plan", 
                    "_planning_charge", "planning_charge_environment");
            $ChargesPlanDictTAdapt->assignNumSuffix("_planning_charge");
            $ChargesPlanDictTAdapt->object_adapter->hidden_keys['apr']="hidden";
            $ChargesPlanDictTAdapt->object_adapter->hidden_keys['plan_shedule_id']="hidden";
            $ChargesPlanDictTAdapt->setFormsFloating(true);
            $ChargesPlanDictTAdapt->showCustomHiddenKeys(array("target_date"=>"showed"));
            //print_r($TargetPlanDictTAdapt->object_adapter->hidden_keys);
            //$TargetPlanDictTAdapt->setPlanCalculatingAlgorithm(
            //        $GLOBALS['target_plan_calculating_algorithm']);
            $ChargesPlanDictTAdapt->filters_values['plan_optype_id'] = 
                    $GLOBALS['planned_outcome_operation_type_id'];

            $ChargesPlanDictTAdapt->setHideFilterFormMode(true);
            $ChargesPlanDictTAdapt->generateFiltersFormWithNum(
                    $ChargesPlanDictTAdapt->class_name."_planning_charge_table_div", "_planning_charge");
            echo "<div id=\"".$ChargesPlanDictTAdapt->class_name."_planning_charge_table_div"."\" 
                style=\"display:;\">";
            $ChargesPlanDictTAdapt->selectFullWithRelative();
            //$ChargesPlanDictTAdapt->setDefTableWidth(280);
            $ChargesPlanDictTAdapt->writeTableExt(true, true);

            echo "</div>";
            $charge_plan_object = $ChargesPlanDictTAdapt->object_adapter->getDataClassInstance();
            $charge_plan_object->plan_optype_id = 
                    $GLOBALS['planned_outcome_operation_type_id'];
            $charge_plan_object->apr = 0;
            $charge_plan_object->relative_props['plan_shedule_id'] = 0;
            $ChargesPlanDictTAdapt->generateInsertFormWithNum($charge_plan_object, 
                " function (next_function) { ".$ChargesPlanDictTAdapt->generateSelectJSWithFilterWithNum
                ("",0,$ChargesPlanDictTAdapt->class_name."_planning_charge_table_div",
                "_planning_charge")." } ", "_planning_charge");
            //$FinanceActData_account_refresh_js .= " ".$TargetPlanDictTAdapt->generateSelectJSWithFilterWithNum
            //    ("",0,$TargetPlanDictTAdapt->class_name."_planning_target_table_div",
            //    "_planning_target");
            $ChargesPlanDictTAdapt->generateAddButtonWithStyle("button medium green");
            $ChargesPlanDictTAdapt->writeActionsFormsWithoutSlide();
        } else if(array_key_exists("debts_page_mode", $_GET)) 
        {
            echo "<h1 class=\"dict_header_big_style\">Планирование выплат кредитов и долгов</h1>";
            $DebtPlanDictTAdapt = new PlanTableAdapter($Connector, "", "Plan", 
                    "_planning_debt", "planning_debt_environment");
            $DebtPlanDictTAdapt->assignNumSuffix("_planning_debt");
            $DebtPlanDictTAdapt->setFormsFloating(true);
            $DebtPlanDictTAdapt->setPlanCalculatingAlgorithm(
                    $GLOBALS['debt_plan_calculating_algorithm']);
            $DebtPlanDictTAdapt->filters_values['plan_optype_id'] = 
                    $GLOBALS['planned_debt_payment_operation_type_id'];


            //$DebtPlanDictTAdapt->setActionTableRefreshJS(
            //    $DebtPlanDictTAdapt->generateSelectJSWithFilterWithNum
            //    ("",0,$DebtPlanDictTAdapt->class_name."_planning_debt_table_div","_planning_debt"));

            //$debt_plan_detail_params = array($FCAPlanDictTAdapt->class_name.
            //    "_filt_"."fca_plan_id".$FCAPlanDictTAdapt->class_name.
            //    $FCAPlanDictTAdapt->num_suffix=>
            //    $FCAPlanDictTAdapt->generateSelectJSWithFilterWithNum
            //    ("",0,$FCAPlanDictTAdapt->class_name."_planning_table_div","_planning"));
            //$DebtPlanDictTAdapt->setActionsDetailAdaptersParams($debt_plan_detail_params);

            $DebtPlanDictTAdapt->setHideFilterFormMode(true);
            $DebtPlanDictTAdapt->generateFiltersFormWithNum(
                    $DebtPlanDictTAdapt->class_name."_planning_debt_table_div", "_planning_debt");
            echo "<div id=\"".$DebtPlanDictTAdapt->class_name."_planning_debt_table_div"."\" 
                 class=\"scrolled\" style=\"display:;\">";
            $DebtPlanDictTAdapt->selectFullWithRelative();
            $DebtPlanDictTAdapt->setDefTableWidth(280);
            $DebtPlanDictTAdapt->writeTableExt(true, true);

            echo "</div>";
            $debt_plan_object = $DebtPlanDictTAdapt->object_adapter->getDataClassInstance();
            $debt_plan_object->plan_optype_id = 
                    $GLOBALS['planned_debt_payment_operation_type_id'];
            $DebtPlanDictTAdapt->generateInsertFormWithNum($debt_plan_object, 
                " function (next_function) { ".$DebtPlanDictTAdapt->generateSelectJSWithFilterWithNum
                ("",0,$DebtPlanDictTAdapt->class_name."_planning_debt_table_div","_planning_debt")." } ", 
                "_planning_debt");
            //$FinanceActData_account_refresh_js .= " ".$DebtPlanDictTAdapt->generateSelectJSWithFilterWithNum
            //    ("",0,$DebtPlanDictTAdapt->class_name."_planning_debt_table_div","_planning_debt");
            $DebtPlanDictTAdapt->generateAddButtonWithStyle("button medium green");
            $DebtPlanDictTAdapt->writeActionsFormsWithoutSlide();
        } else if(array_key_exists("targets_page_mode", $_GET)) 
        {
            echo "<h1 class=\"dict_header_big_style\">Планирование реализации намеченных целей</h1>";
            $TargetPlanDictTAdapt = new PlanTableAdapter($Connector, "", "Plan", 
                    "_planning_target", "planning_target_environment");
            $TargetPlanDictTAdapt->assignNumSuffix("_planning_target");
            $TargetPlanDictTAdapt->object_adapter->hidden_keys['apr']="hidden";
            $TargetPlanDictTAdapt->object_adapter->hidden_keys['plan_shedule_id']="hidden";
            $TargetPlanDictTAdapt->setFormsFloating(true);
            $TargetPlanDictTAdapt->showCustomHiddenKeys(array("target_date"=>"showed"));
            //print_r($TargetPlanDictTAdapt->object_adapter->hidden_keys);
            $TargetPlanDictTAdapt->setPlanCalculatingAlgorithm(
                    $GLOBALS['target_plan_calculating_algorithm']);
            $TargetPlanDictTAdapt->filters_values['plan_optype_id'] = 
                    $GLOBALS['planned_target_outcome_operation_type_id'];

            $TargetPlanDictTAdapt->setHideFilterFormMode(true);
            $TargetPlanDictTAdapt->generateFiltersFormWithNum(
                    $TargetPlanDictTAdapt->class_name."_planning_target_table_div", "_planning_target");
            echo "<div id=\"".$TargetPlanDictTAdapt->class_name."_planning_target_table_div"."\" 
                style=\"display:;\">";
            $TargetPlanDictTAdapt->selectFullWithRelative();
            $TargetPlanDictTAdapt->setDefTableWidth(280);
            $TargetPlanDictTAdapt->writeTableExt(true, true);

            echo "</div>";
            $target_plan_object = $TargetPlanDictTAdapt->object_adapter->getDataClassInstance();
            $target_plan_object->plan_optype_id = 
                    $GLOBALS['planned_target_outcome_operation_type_id'];
            $target_plan_object->apr = 0;
            $target_plan_object->relative_props['plan_shedule_id'] = 0;
            $TargetPlanDictTAdapt->generateInsertFormWithNum($target_plan_object, 
                " function (next_function) { ".$TargetPlanDictTAdapt->generateSelectJSWithFilterWithNum
                ("",0,$TargetPlanDictTAdapt->class_name."_planning_target_table_div",
                "_planning_target")." } ", "_planning_target");
            //$FinanceActData_account_refresh_js .= " ".$TargetPlanDictTAdapt->generateSelectJSWithFilterWithNum
            //    ("",0,$TargetPlanDictTAdapt->class_name."_planning_target_table_div",
            //    "_planning_target");
            $TargetPlanDictTAdapt->generateAddButtonWithStyle("button medium green");
            $TargetPlanDictTAdapt->writeActionsFormsWithoutSlide();
        } else if(array_key_exists("report_page_mode", $_GET))  {
            echo "<center>
                <table align=\"center\" border=\"0\" style=\"width:100%;heght:100%;\">
                <tr><td align=\"center\" style=\"vertical-align:top;text-align:center;width:100%;\">";
            $report_menu = new ReportMenuClass();
            $report_menu->writeMenu("acc_container_menu");
            echo "</td></tr></table></center>";
        }   else    {
            //print_r($_GET);
            if ($env_mode=="planning")  {
               
                $FCAIncomeDictTAdapt = new FinanceActDataTableAdapter($Connector, "", "FinanceActData",
                        "_account", "planning");
            }
            else    {
                
		$FCAIncomeDictTAdapt = new FinanceActDataTableAdapter($Connector, "", "FinanceActData","_account");
            }
                $prev_part_capacity=0;
                if (isset($_GET['prev_part_capacity']))
                    $prev_part_capacity=$_GET['prev_part_capacity'];
                
                if (isset($prev_part_capacity))
                    if (is_numeric($prev_part_capacity))
                        if ((int)$prev_part_capacity>0)
                            $FCAIncomeDictTAdapt->setPartCapacity( 
                                (int)$prev_part_capacity);
                        
                $FCAIncomeDictTAdapt->assignNumSuffix("_account");
                $FCAIncomeDictTAdapt->default_panel_class = "panel_brigness_green";
                $FCAIncomeDictTAdapt->default_panel_float_class = "panel_green_float";
                
                $FCAIncomeDictTAdapt->prepareFilterArray($_GET);
                //$FCAIncomeDictTAdapt->setFormsFloating(true);
		
                $FCAIncomeDictTAdapt->selectWithRelative();
                $FCAIncomeDictTAdapt->setDefTableWidth(650);
                $FCAIncomeDictTAdapt->fixed_table_width = false;
                $FCAIncomeDictTAdapt->writeActionsFormsWithoutSlide();
                
                //Вывод блока табличного адаптера с базовым набором функций (фильтры, форма правки и проч.)
                echo "<div id=\"entity_full_region\"><table border=\"0\" width=\"100%\"><tr><td class=\"default_struct_td\" 
                    style=\"padding-left:10px;padding-right:10px;\">";
                
                echo "<div class=\"panel_mate_blue\"><table border=\"0\"><tr><td>";
                //$FCAIncomeDictTAdapt->setHideFilterFormMode(true);
                $FCAIncomeDictTAdapt->generateFiltersFormWithNum($FCAIncomeDictTAdapt->class_name."_account_table_div",
                        "_account");
                echo "</td><td>";
                $FCAIncomeDictTAdapt->generatePagerFormWithNum($FCAIncomeDictTAdapt->class_name."_account_table_div", 
                    "_account");
                echo "</td></tr></table></div>";
                //$FCAIncomeDictTAdapt->generateAddButtonWithStyle("button medium green");
                echo "<div id=\"".$FCAIncomeDictTAdapt->class_name."_account_table_div"."\">";
                //echo "<span style=\"display:none;\">"; 
                $FCAIncomeDictTAdapt->generateDictHeaderWithNum(); 
                //echo "</span>";
                $FCAIncomeDictTAdapt->writeTable();
                $income_object = $FCAIncomeDictTAdapt->getLastTableGetFirstObject();
                echo "</div>";
                echo "</td><td class=\"default_struct_td\" style=\"width:250px;\">";
                $FCAIncomeDictTAdapt->generateInsertFormWithNum($income_object, 
                    " function (next_function) { ".$FCAIncomeDictTAdapt->generateSelectJSWithFilterWithNum
                    ("",0,$FCAIncomeDictTAdapt->class_name."_account_table_div","_account")." ".
                    $FCAIncomeDictTAdapt->getMasterAdaptsRefreshJS()." } ", 
                    "_account");
                echo "</td></tr><table></div>";
                //echo "<div id=\"uuuuu\">";
                
                //echo "</div></div>";
            
        }
    }
    else	{
        
        $page_id = "";
        if(isset($_GET['page_id']))
            $page_id = $_GET['page_id'];
        else    {
            if (isset($_POST['page_id'])) 
                $page_id=$_POST['page_id'];
        }    
        
        if ($page_id=="purse_stat_page")    {
            
            $purse_id=-1;
            if (isset($_GET['object_id'])) {
                $purse_id=$_GET['object_id'];
            }   else
            {
                if (isset($_POST['object_id'])) 
                    $purse_id=$_POST['object_id'];
            }

            /*echo "  <script language=\"JavaScript\" type=\"text/javascript\">
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
            <div id=\"warning_region\"></div>";*/

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
            $FCAIncomeDictTAdapt->filter_values["fca_purse_id"]=$purse_id;
            $FCAOutcomeDictTAdapt->values_filter_array = array("fca_operation_type_id"=>"(fca_operation_type_id=***___fca_operation_type_id)",
                    "fca_purse_id"=>"(fca_purse_id=***___fca_purse_id)");
            $FCAOutcomeDictTAdapt->values_filter_values["fca_operation_type_id"]=$GLOBALS['outcome_operation_type_id'];
            $FCAOutcomeDictTAdapt->values_filter_values["fca_purse_id"]=$purse_id;
            
            $FCAIncomeDictTAdapt->assignNumSuffix("_account");
            //$FCAIncomeDictTAdapt->default_panel_class = "panel_brigness_green";
            //$FCAIncomeDictTAdapt->default_panel_float_class = "panel_green_float";
                
            $FCAIncomeDictTAdapt->prepareFilterArray(array_merge($_GET, $_POST));
            //$FCAIncomeDictTAdapt->setFormsFloating(true);
            //$income_object = $FCAIncomeDictTAdapt->getObjectAdapterInstance()->getDataClassInstance();
            //$FCAIncomeDictTAdapt->selectWithRelative();
            //$FCAIncomeDictTAdapt->setDefTableWidth(650);
            //$FCAIncomeDictTAdapt->fixed_table_width = false;
            //$FCAIncomeDictTAdapt->writeActionsFormsWithoutSlide();
            
            $income_object = $FCAIncomeDictTAdapt->getObjectAdapterInstance()->getDataClassInstance();
            $income_object->fca_operation_type_id=$GLOBALS['income_operation_type_id'];
            $income_object->fca_purse_id=$purse_id;
            $outcome_object = $FCAOutcomeDictTAdapt->getObjectAdapterInstance()->getDataClassInstance();
            $outcome_object->fca_operation_type_id=$GLOBALS['outcome_operation_type_id'];
            $outcome_object->fca_purse_id=$purse_id;
            
            echo 
            "<div id=\"purse_stat_page\" data-role=\"page\">
            <div data-role=\"header\">
                <a id=\"account_stat_back\" href=\"#purse_page\" onClick=\"\" data-icon=\"back\" >Назад</a>
                <h1>Обороты на счете</h1>
            </div>
            <div data-role=\"content\">
                <div data-role=\"collapsible-set\">
                    <div data-role=\"collapsible\" data-collapsed=\"false\">
                        <h2>Приход</h2>
            <!--purse_id={$_POST['object_id']}-->
                        <div data-role=\"fieldcontainer\">
                            <label for=\"search\">Поиск:</label>
                            <input type=\"search\" id=\"search\" name=\"search\">
                        </div>
                        <div id=\"{$FCAIncomeDictTAdapt->class_name}_income_table_div\">
                        <!--<table id=\"income_table\" border=\"0\" width=\"95%\">
                            <tr><td>Дата</td><td>Контрагент</td><td>Описание</td><td>Сумма</td></tr>
                        </table>--!>";

          //$FCAIncomeDictTAdapt->selectFullWithRelative();
          $FCAIncomeDictTAdapt->selectWithRelative();
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
            </div>";
        
        }
            
        echo " ";
    }
		
 ?>