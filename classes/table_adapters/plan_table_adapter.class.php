<?php

/**17.11.2011
 * @author Poltarokov SP
 * @copyright 2011
 */
 
require_once("classes/table_adapters/table_adapter.class.php");
require_once("classes/table_adapters/table_adapter.interface.php");

class PlanTableAdapter extends TableAdapter  implements TableAdapterInterface  {
    
    function __construct($dbconnector, $table_name, 
        $class_name, $context_suffix=null, $environment_mode = null)    { 
        parent::__construct($dbconnector, "plan_dictionary", 
            $class_name, "plan_view");
        if ($context_suffix!=null)  {
            $this->num_suffix = $context_suffix;
            $this->assignNumSuffix($context_suffix);
            //if (($environment_mode==null)&&($context_suffix=="_planning_debt")) {
            //        $environment_mode = "planning_debt_environment";
            //}
        }
        $this->dict_header = "Планирование";
        $this->id_field="plan_id";
        $this->hide_header = true;
        $this->strong_user_relative = true;
        $this->object_adapter->desk_list_table_mode = true;
        $this->write_table_width = 300;
        $this->without_dict_header_mode = true;
        $this->float_manip_forms_mode = true;
        $this->filters_array = array("plan_optype_id"=>"OperationType");
        $this->filters_values = array("plan_optype_id"=>null);
        $this->include_custom_actions_in_float_window = true;
        $this->hide_filter_form = true;
        $this->add_update_procedure_name = "add_update_person"; 
        $this->insert_instruction_template = "insert into `plan_dictionary`(`plan_id`,`plan_name`,
                        `plan_summ`,`plan_optype_id`, `apr`, `plan_shedule_id`, `default_purse_id`, 
                        `user_id`, `plan_currency_id`, `target_date`) 
                        values(null,:plan_name,:plan_summ ,:plan_optype_id, :apr, 
                        :plan_shedule_id, :default_purse_id, '{$_SESSION['user_id']}', 
                        :plan_currency_id, :target_date);"; 
        $this->update_instruction_template = "update `plan_dictionary` SET `plan_name`=:plan_name, 
                        `plan_summ`=:plan_summ, `plan_optype_id`=:plan_optype_id, `apr`=:apr,
                        `plan_shedule_id`=:plan_shedule_id, `default_purse_id`=:default_purse_id,
                        `plan_currency_id`=:plan_currency_id, `target_date`=:target_date
                        where `plan_id`=:id";
        $this->delete_instruction_template = "SET @dcount=0; call `delete_object_by_type` 
			('plan', :id, @dcount);";
        $this->no_back_border_color = true;
        $this->no_use_tablesorter_class = true;
        $this->custom_table_div_class = "left_menu_blue_gradient";
        $this->fixed_table_width = false;
        $this->table_css_class = "left_menu_entity_table";
        
        switch($context_suffix)   {
        case "_planning_debt":
            //echo "ssssssssssssssssssssssss";
            $SetPlanSummOperation = new Operation($dbconnector, 
                    "plsumm", 
                    "Plan", 
                    $GLOBALS['inline_params_update_type'], 
                    "Операция установки суммы выплаты", 
                    array(), //id`s links
                    array(), //form_input_params
                    array(), //default values 
                    array("plan_summ"=>"plan_summ", "first_payment_date"=>"first_payment_date",
                        "complete_month_count"=>"complete_month_count",
                        "min_payment_summ"=>"min_payment_summ", "apr"=>"apr",
                        "plan_shedule_id"=>"plan_shedule_id"), //inline_props
                    $this
                    );

            $SetPlanSummAction = new Action("Параметры расчета", array(
                $SetPlanSummOperation), "PlSummSA",
                "#7FC9FF", $this);

            $SetPlanSummAction->setIdContainedOpName("plsumm");

            $this->record_actions = array($SetPlanSummAction);
            
            $FCAPlanDictTAdapt = new FinanceActDataTableAdapter($this->dbconnector, "", "FinanceActData");
            $FCAPlanDictTAdapt->assignNumSuffix("_planning");
            
            $plan_ajax_detail_params = array("request_base"=>"index-ajax.php?desktop_mode",
                    "result_container"=>"main_region", "env_mode"=>"planning", "id"=>"fca_plan_id", "next_function"=>
                    " function(next_ajx_function) { linkCalendar(); initAcc2(); initSort('FinanceActData_dict_table_account'); } ");
            $this->setAjaxDetailedParams($plan_ajax_detail_params);
            $plan_action_ajax_detail_params = array("request_base"=>"index-ajax.php?desktop_mode",
                    "result_container"=>"main_region", "eval"=>"fca_plan_id", "next_function"=>
                    " function(next_ajx_function) { linkCalendar(); initAcc2(); initSort('FinanceActData_dict_table_account'); } ");
            $this->setActionsAjaxDetailedParams($plan_action_ajax_detail_params);
            //$debt_plan_detail_params = array($FCAPlanDictTAdapt->class_name.
            //        "_filt_"."fca_plan_id".$FCAPlanDictTAdapt->class_name.
            //        $FCAPlanDictTAdapt->num_suffix=>
            //        $FCAPlanDictTAdapt->generateSelectJSWithFilterWithNum
            //        ("",0,$FCAPlanDictTAdapt->class_name."_planning_table_div","_planning"));
            //$this->setActionsDetailAdaptersParams($debt_plan_detail_params);
            //$this->setDetailAdaptersParams($debt_plan_detail_params);
            
            //print_r($debt_plan_detail_params);
            
            break;
            
        default : break;
        }
        
        if ($context_suffix!=null)  {
            $this->setActionTableRefreshJS(
            $this->generateSelectJSWithFilterWithNum
                    ("",0,$this->class_name.$context_suffix."_table_div",$context_suffix));
        }
        
        $this->entity_db_algorithms_settings = array(
          "debt_plan_calculating_algorithm"=>array("exec_order"=>$GLOBALS['previous_alg_order']) 
        );
        
        //$this->inline_update_algorithm = "debt_plan_calculating_algorithm";
        
    }
    
    function writeTable()   {
        $this->generateTable();
    }
    
    function writeInsertForm()  {
        
    }
    
    function processedEntityAlgorithm($algorithm_name, $params)  {
        //echo "---".$algorithm_name."---";
        //print_r($params);
        switch ($algorithm_name)    {
            case "debt_plan_calculating_algorithm":
                $sql_params = array(":plan_id"=>null, ":optype_id"=>null,
                    ":operation_time"=>null, ":description"=>null,
                    ":opsumm"=>null, ":currency_id"=>null, ":sync_key"=>null);
                $fca_plan_insert_sql = "call `insert_planning_fca`(:plan_id, :optype_id, 
                    :operation_time, '', :description, :opsumm, 0, 
                    :currency_id, :sync_key);";
                
                $payment_dates = array();
                $next_month_date = $this->uniStrToUnixTime($params['first_payment_date'], "Y-m-d");
                $month_count = (int)$params['complete_month_count'];
                
                $apr_value = (real)$params['apr'];
                $per_month_percent = 0;
                $annuitent_coeff = null;
                if (($apr_value!=null)&&($month_count!=null))   {
                    $per_month_percent = $apr_value / 12 / 100;
                    if ($month_count>0) {
                        $annuitent_coeff = 
                            //($per_month_percent * pow((1.0 + $per_month_percent),$month_count))/
                            //(pow((1.0+$per_month_percent),$month_count) - 1);
                            $per_month_percent/(1-pow((1+$per_month_percent),-($month_count-1)) );
                    }
                }
                
                echo "pmp".$per_month_percent."mc".$month_count."acc".$annuitent_coeff;
                
                $credit_type_id = $GLOBALS['unknown_credit_type'];
                if (isset($params['plan_shedule_id']))  {
                    if (((int)($params['plan_shedule_id']))==$GLOBALS['annuitent_credit_type'])  {
                        $credit_type_id = $GLOBALS['annuitent_credit_type'];
                    } else if (((int)($params['plan_shedule_id']))==$GLOBALS['differential_credit_type'])
                        $credit_type_id = $GLOBALS['differential_credit_type'];
                    else    {
                        
                    }
                }
                
                $sql_params[':plan_id'] = (int)$params['id'];
                $sql_params[':optype_id'] = $GLOBALS['planned_debt_payment_operation_type_id'];
                $plan_summ = (real)$params['plan_summ'];
                $diff_credit_rest = $plan_summ;
                $min_payment_summ = (real)$params['min_payment_summ'];
                if ($credit_type_id == $GLOBALS['annuitent_credit_type'])    {
                    $sql_params[':opsumm'] = $annuitent_coeff*$plan_summ;
                    //echo "---".$sql_params[':opsumm']."iii".$plan_summ;
                }   else if ($credit_type_id == $GLOBALS['differential_credit_type'])    {
                    $sql_params[':opsumm'] = $plan_summ / $month_count;
                }
                else
                    $sql_params[':opsumm'] = $plan_summ / $month_count;
                $sql_params[':currency_id'] = $GLOBALS['rouble_currency_id'];
                $tmp_date = $next_month_date;
                //print_r($sql_params);
                //$this->DateAdd('d', -1, $next_month_date)
                if ($tmp_date<mktime(0, 0, 0, date("m")  , date("d"), date("Y")))   {
                    $tmp_date = $this->DateAdd('m', 1, $tmp_date);
                }
                //$this->uniStrToStrTime($params['first_payment_date'], "Y-m-d", "Y-m-d");
                //echo $params['first_payment_date']."---------".$next_month_date;
                
                
                if (($next_month_date!=null)&&($month_count!=null)&&($plan_summ!=null)&&
                        ($sql_params[':plan_id']!=null)&&($apr_value!=null)) {
                    if (($month_count>0)&&($plan_summ>0)&&($sql_params[':plan_id']>0)
                            &&($apr_value>=0)) {
                        for($c=0;$c<$month_count;$c++)  {
                            $payment_dates[] = $tmp_date;
                            $tmp_date = $this->DateAdd('m', 1, $tmp_date);
                        }
                        $this->dbconnector->beginTransaction();
                        
                        if ($this->dbconnector->exec_with_prepare_and_params_2ver
                                ("DELETE FROM finance_action_data_storage WHERE fca_plan_id=:plan_id;", 
                                array(":plan_id"=>$sql_params[':plan_id']))==null)  {
                                    $this->dbconnector->rollBackTransaction();
                                    echo "Ошибка выполнения запроса удаления передыдущих записей!";
                                    //print_r($sql_params);
                                    return;
                            }
                            
                        $diff_percent = $apr_value/100;

                        for($c=0;$c<count($payment_dates);$c++) {
                            $sql_params[':operation_time'] = 
                                date( "Y-m-d h:i:s", $payment_dates[$c]);
                            $sql_params[':description'] = 
                                "Оплата кредита от ".date( "Y-m-d h:i:s", $payment_dates[$c]).".";
                            
                            $diff_delta = $diff_credit_rest/($month_count-$c);
                            
                            if ($credit_type_id == $GLOBALS['differential_credit_type'])
                                $sql_params[':opsumm'] = $diff_delta + ($diff_credit_rest*
                                    (real)date('t', $sql_params[':operation_time'])*$diff_percent)/
                                    (date('L', $sql_params[':operation_time'])==1?366.0:365.0);
                            
                            $diff_credit_rest = $diff_credit_rest - $diff_delta;
                            
                            if ($this->dbconnector->exec_with_prepare_and_params_2ver
                                ($fca_plan_insert_sql, $sql_params)==null)  {
                                    $this->dbconnector->rollBackTransaction();
                                    echo "Ошибка выполнения запроса! Строка ".$row.", data: ";
                                    print_r($sql_params);
                                    return;
                            }
                        }
                        $this->dbconnector->commitTransaction();
                    }
                }
                
                //for($c=0;$c<count($payment_dates);$c++)
                //    echo date( "Y-m-d h:i:s", $payment_dates[$c]);
                break;
            default :  break; 
        }
    }
    
}

?>