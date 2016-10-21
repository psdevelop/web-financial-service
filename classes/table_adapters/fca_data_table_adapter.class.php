<?php

/**
 * @author Poltarokov SP
 * @copyright 2011
 */

//include("include/php5-utf8/UTF8.php");
require_once("classes/table_adapters/table_adapter.class.php");
require_once("classes/table_adapters/table_adapter.interface.php");

class FinanceActDataTableAdapter extends TableAdapter  implements TableAdapterInterface  {
    
    function __construct($dbconnector, $table_name, 
        $class_name, $context_suffix=null, $environment_mode = null)    { 
        parent::__construct($dbconnector, "finance_action_data_storage", 
            $class_name, "fca_view"); 
        $this->dict_header = "Список операций";
        $this->id_field="fca_id";
        $this->strong_user_relative = true;
        $this->write_table_width=650;
        $this->custom_table_div_class = "panel_ligth_blue_gray";
        $this->part_capacity = 10;
        $this->fixed_table_width = false;
        
        $this->filters_array = array("fca_purse_id"=>"Purse", 
            "fca_operation_type_id"=>"OperationType", "fca_plan_id"=>"Plan",
            "parent_category_id"=>"Category");
        $this->filters_values = array("fca_purse_id"=>null,
            "fca_operation_type_id"=>null, "fca_plan_id"=>null,
            "parent_category_id"=>null);
        $this->values_filter_array = array("fca_operation_type_id"=>"(fca_operation_type_id=***___fca_operation_type_id)",
        "fca_purse_id"=>"(fca_purse_id=***___fca_purse_id)", "fca_plan_id"=>"(fca_plan_id=***___fca_plan_id)",
            "fca_category_id"=>"((fca_category_id=***___fca_category_id) OR 
                `f_its_child_category`(fca_category_id, ***___fca_category_id) )",
            "start_fca_date"=>"(fca_date>='***___start_fca_date')",
            "end_fca_date"=>"(fca_date<='***___end_fca_date')");
        $this->filter_values_select_keys = array("fca_category_id"=>"Category");
        $this->values_filter_values = array("fca_operation_type_id"=>null, "fca_purse_id"=>null,
            "fca_plan_id"=>null, "fca_category_id"=>null, "start_fca_date"=>null,
            "end_fca_date"=>null);
        $this->add_update_procedure_name = "add_update_person"; 
        $this->insert_instruction_template = " SET @new_id=NULL; call `add_update_fca_2ver`
            (@new_id, :fca_purse_id, :fca_operation_type_id, :fca_date, :fca_actor_description, 
            :fca_description, :fca_summ, :fca_category_id, :fca_transfert_purse_id,
            '{$GLOBALS['inner_income_transfert_operation_type_id']}', 
            '{$GLOBALS['inner_outcome_transfert_operation_type_id']}', :fca_status_id, NULL); SET @tmp_id=:fca_currency_id; "; 
        $this->update_instruction_template = "update `finance_action_data_storage` SET `fca_purse_id`=:fca_purse_id,
            `fca_operation_type_id`=:fca_operation_type_id, `fca_date`=:fca_date, 
            `fca_actor_description`=:fca_actor_description, `fca_description`=:fca_description, 
            `fca_summ`=:fca_summ, `fca_category_id`=:fca_category_id, 
            `fca_transfert_purse_id`=:fca_transfert_purse_id, 
            `fca_status_id`=:fca_status_id where `fca_id`=:id; SET @tmp_id=:fca_currency_id;";
        $this->delete_instruction_template = "SET @dcount=0; call `delete_object_by_type` 
            ('fca', :id, @dcount);";
        $this->custom_order_clause = " order by fca_date DESC, fca_id DESC ";
        $this->default_table_cell_spacing = 0;
        $this->default_table_cell_padding = 2;
        $this->link_filter_js_to_input_changes = true;
        $this->hide_filter_button = true;
        $this->use_pager_capacity_input = true;
        $this->standart_action_criteries = array(
            "update_action"=>array(
                "show_confirm_critery"=>
                "(document.getElementById('fca_status_id***___class_name***___suffix').value!={$GLOBALS['conduct_fca_status_id']})"
                )
            );
        $this->button_hints = array("insert"=>"Добавить операцию", "update"=>"Изменить операцию", 
            "delete"=>"Удалить операцию", "edit"=>"Редактировать операцию");
        
        switch($environment_mode)   {
        case "planning":
            $this->include_custom_actions_in_float_window = true;
            $FCAPayFromPurseOperation = new Operation($dbconnector, 
                    "fcappurs", 
                    "FinanceActData", 
                    $GLOBALS['inline_params_update_type'], 
                    "Оплатить из кошелька", 
                    array(), //id`s links
                    array(), //form_input_params
                    array("fca_operation_type_id"=>
                        $GLOBALS['complete_planned_debt_payment_operation_type_id']), //default values 
                    array("fca_purse_id"=>"fca_purse_id",
                        "fca_operation_type_id"=>"fca_operation_type_id"), //inline_props
                    $this
                    );

            $FCAPayFromPurseAction = new Action("Оплатить из кошелька", array(
                $FCAPayFromPurseOperation), "FCAPurPaySA",
                "#7FC9FF", $this);

            $FCAPayFromPurseAction->setIdContainedOpName("fcappurs");

            $this->record_actions = array($FCAPayFromPurseAction);
            
            //$FCAPlanDictTAdapt = new FinanceActDataTableAdapter($this->dbconnector, "", "FinanceActData");
            //$FCAPlanDictTAdapt->assignNumSuffix("_planning");
            
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
        
    }
    
    function writeTable()   {
        $this->generateTable();
    }
    
    function writeInsertForm()  {
        
    }
    
    function writeMobileTable()	{
		$this->generateMobileListTable($GLOBALS['mobile_table_mode']);
	}
        
    function loadDataFromCSVFile($filepath, $params)    {
        
        $data1_counter=0;
        $data2_counter=0;
        $str_count=0;
        $delimeter=null;
        $detect_encoding=null;
        if (($handle = fopen($filepath, "r")) !== FALSE) {
            while (!feof($handle)) {
                
                $buffer = fgets($handle, 4096);
                if (strlen($buffer)>0) {
                    
                    $str_count++;
                    if ($str_count==1)
                        $detect_encoding=mb_detect_encoding($buffer);
                    
                    $data1 = str_getcsv($buffer,';');
                    $data2 = str_getcsv($buffer,',');
                    if (count($data1)>=4) {
                        $data1_counter++;
                    }   else if (count($data2)>=4) {
                        $data2_counter++;
                    } else  {
                        
                    }
                }
                
            }
            
            if ($data1_counter>($str_count / 2)) {
                $delimeter=';';
            }   else if ($data2_counter>($str_count / 2)) {
                $delimeter=',';
            }   
            else    {
                
            }
            
            fclose($handle);
        }
        
        //ASCII является частью любого ANSI 
        //ANSI не является частью ASCII
        //mb_detect_encoding = ASCII and UTF-8 then iconv('WINDOWS-1251', 'UTF-8', $data);
        $encode_str="";
        $row = 1;
        $has_header=false;
        $it_is_operation_str=false;
        
        $operation_time_col_index=array();
        $currency_id_col_index=array();
        $optype_id_col_index=array();
        $opsumm_col_index=array();
        $description_col_index=array();
        
        $account_col_index=null;
        $place_col_index=null;
        
        $sources_sql_templates = array(
            "RSB"=>
                "call `insert_external_fca`(:purse_id, :optype_id, 
                :operation_time, '', :description, :opsumm, 0, 
                :currency_id, :sync_key);", 
            "AB"=>
                "call `insert_external_fca`(:purse_id, :optype_id, 
                :operation_time, '', :description, :opsumm, 0, 
                :currency_id, :sync_key);", 
            "VTB24"=>
                "call `insert_external_fca`(:purse_id, :optype_id, 
                :operation_time, '', :description, :opsumm, 0, 
                :currency_id, :sync_key);",
            "VTB24_2VAR_RUB"=>
                "call `insert_external_fca`(:purse_id, :optype_id, 
                :operation_time, '', :description, :opsumm, 0, 
                :currency_id, :sync_key);",
            "CITY_BANK"=>
                "call `insert_external_fca`(:purse_id, :optype_id, 
                :operation_time, '', :description, :opsumm, 0, 
                :currency_id, :sync_key);");
        $sources_variants_names = array("RSB"=>"Банк Русский Стандарт", 
            "AB"=>"Альфа-Банк", "VTB24"=>"Банк ВТБ24", "VTB24_2VAR_RUB"=>"Банк ВТБ24 шаблон 2",
            "CITY_BANK"=>"СИТИ-Банк");
        $row_keys_compositions = array("RSB"=>array(0,1,2,3,4,5,6,7,8,9), 
            "AB"=>array(0,1,2,3,4,5,6,7), "VTB24"=>array(0,1,2,3,4,5,6,7),
            "VTB24_2VAR_RUB"=>array(0, 1, 2, 3, 4), "CITY_BANK"=>array(0, 1, 2, 3));
        $row_keys_composition=null;
        
        $operation_time_col_names_variants=array("RSB"=>"timestamp", 
            "AB"=>"Дата операции", "VTB24"=>"\"Дата операции\"");
        $currency_col_names_variants = array("RSB"=>"currency", "AB"=>"Валюта", 
            "VTB24"=>"\"Валюта транзакции\"");
        $optype_col_names_variants = array("RSB"=>"type", "AB"=>array("Приход", "Расход"), 
            "VTB24"=>"\"Сумма транзакции\"");
        $description_col_names_variants = array("RSB"=>"description", "AB"=>"Описание операции", 
            "VTB24"=>"\"Основание\"");
        $summ_col_names_variants = array("RSB"=>"amount", "AB"=>array("Приход", "Расход"),
            "VTB24"=>"\"Сумма транзакции\"");
        //$account_col_names_variants = array("RSB"=>array(), "AB"=>array(0,1,2,3,4,5,6,7),
        //    "VTB24"=>array(0,1,2,3,4,5,6,7));
        
        $col_names_variants = array(
            "RSB"=>
                array(
                "date_format"=>"Y-m-d\TH:i:sP",
                "header_equals_count"=>0,
                "fact_rels"=>array("operation_time"=>null,
                    "currency_id"=>array(),
                    "optype_id"=>array(),
                    "opsumm"=>array(),
                    "description"=>array()),
                "rels"=>array("operation_time"=>array("timestamp"),
                    "currency_id"=>array("currency"),
                    "optype_id"=>array("type"),
                    "opsumm"=>array("amount"),
                    "description"=>array("description"))),
            "AB"=>
                array(
                "header_equals_count"=>0,
                "fact_rels"=>array("operation_time"=>array(),
                    "currency_id"=>array(),
                    "optype_id"=>array(),
                    "opsumm"=>array(),
                    "description"=>array()),
                "rels"=>array("operation_time"=>array("Дата операции"),
                    "currency_id"=>array("Валюта"),
                    "optype_id"=>array("Приход", "Расход"),
                    "opsumm"=>array("Приход", "Расход"),
                    "description"=>array("Описание операции"))),
            "VTB24"=>
                array(
                "header_equals_count"=>0,
                "fact_rels"=>array("operation_time"=>array(),
                    "currency_id"=>array(),
                    "optype_id"=>array(),
                    "opsumm"=>array(),
                    "description"=>array()),
                "rels"=>array("operation_time"=>array("\"Дата операции\"", "Дата операции"),
                    "currency_id"=>array("\"Валюта транзакции\"", "Валюта транзакции"),
                    "optype_id"=>array("\"Итого по счету (RUR)\"", "Итого по счету (RUR)"),
                    "opsumm"=>array("\"Итого по счету (RUR)\"", "Итого по счету (RUR)"),
                    "description"=>array("\"Основание\"", "Основание"))),
            "VTB24_2VAR_RUB"=>
                array(
                "header_equals_count"=>0,
                "fact_rels"=>array("operation_time"=>array(),
                    "currency_id"=>array(),
                    "optype_id"=>array(),
                    "opsumm"=>array(),
                    "description"=>array()),
                "rels"=>array("operation_time"=>array("\"Дата\"", "Дата"),
                    "currency_id"=>array("\"Номер распоряжения\"", "Номер распоряжения"),
                    "optype_id"=>array("\"Сумма(RUR)\"", "Сумма(RUR)"),
                    "opsumm"=>array("\"Сумма(RUR)\"", "Сумма(RUR)"),
                    "description"=>array("\"Основание\"", "Основание"))),
            "CITY_BANK"=>
                array(
                "preg_match"=>true,
                "without_headers"=>true, 
                "date_format"=>"d/m/Y",
                "header_equals_count"=>0,
                "fact_rels"=>array("operation_time"=>array(),
                    "currency_id"=>array(1),
                    "optype_id"=>array(),
                    "opsumm"=>array(),
                    "description"=>array()),
                "rels"=>array("operation_time"=>array("/\\\"(\d{1,2})\/(\d{1,2})\/(19|20)(\d{2})\\\"/",
                                                        "/(\d{1,2})\/(\d{1,2})\/(19|20\d{2})/"),
                    "currency_id"=>array(),
                    "optype_id"=>array("/\\\"(-?\d+)\.(\d{2})\\\"/", "/(-?\d+)\.(\d{2})/"),
                    "opsumm"=>array("/\\\"(-?\d+)\.(\d{2})\\\"/", "/(-?\d+)\.(\d{2})/"),
                    "description"=>array(array("/\\\"\'\d{4}XXXXXXXX\\d{4}\'\\\"/",1),
                                        array("/\'\d{4}XXXXXXXX\\d{4}\'/", 1))
                    )
                ),
            );
        
        
        
        //CITYBANK CSV
        //1 column '/"(\d{1,2})\/(\d{1,2})\/(19|20)(\d{2})"/'
        //3 column '/"(\d+)\.(\d{2})"/
        //4 column '/"\'(\d{4})XXXXXXXX\(\d{4})\'"/
        
        //single matches
        //1 column '/"\d{1,2}\/\d{1,2}\/19|20\d{2}"/'
        //3 column '/"\d+\.\d{2}"/
        //4 column '/"\'\d{4}XXXXXXXX\\d{4}'"/
        
        //Основные обязательные атрибуты
        $operation_time=null;
        $currency_id=null;
        $optype_id=null;
        $opsumm=null;
        $description="";
        
        //Необязательные но желательные
        $category_desc="";
        $place_info=null;
        
        $max_equals_src_key=null;
        $rels=null;
        $fact_rels=null;
        $sql_template=null;
        $template_dateformat="Y-m-d";
        
        //echo "Кодировка ".$detect_encoding;
        if ($delimeter<>null)   {
        if (($handle = fopen($filepath, "r")) !== FALSE) {
            while (($data = fgetcsv($handle, 0, $delimeter)) !== FALSE) {
                $num = count($data);
                //echo $num.$has_header;
                if ($num>=4) {

                    for ($c=0; $c < $num; $c++) {
                        //if(!UTF8::is_utf8($data[$c], true))
                        //$data[$c] = trim(UTF8::convert_from($data[$c],"cp1251"));
                        $data[$c] = trim(iconv('WINDOWS-1251', 'UTF-8', $data[$c]));

                        //$this->dbconnector->exec_with_prepare_and_params_2ver
                        //        ("insert into test_table (`str_field`) 
                        //            values('{$data[$c]}');", array());
                        //$this->cp1251_utf8($sInput)
						//$data[$c] = trim($this->cp1251_utf8($data[$c]));
						//echo "[".$data[$c]."]---[".mb_detect_encoding($data[$c])."] ";                
                        }
                        
                        //$data[$c] = trim($this->cp1251_to_utf8($data[$c]));
                    //print_r($data);

                    $max_src_equal_value=0;
                    if (!$has_header)   {
                        //echo "---";
                        $src_keys = array_keys($col_names_variants);
                        foreach ($src_keys as $src_key) {
                            $src_variant = $col_names_variants[$src_key]["rels"];
                            $its_preg_match = (array_key_exists("preg_match",$col_names_variants[$src_key])?
                                    $col_names_variants[$src_key]["preg_match"]:false);
                            $its_without_headers = (array_key_exists("its_without_headers",$col_names_variants[$src_key])?
                                    $col_names_variants[$src_key]["its_without_headers"]:false);
                            $template_dateformat = (array_key_exists("date_format",$col_names_variants[$src_key])?
                                    $col_names_variants[$src_key]["date_format"]:"Y-m-d");
                            
                            $col_vars_keys = array_keys($src_variant);
                            foreach ($col_vars_keys as $col_vars_key) {
                                $col_names = $src_variant[$col_vars_key];
                                $names_count = count($col_names);
                                //print_r($data); print_r($col_names);
                                for ($n=0;$n<$names_count;$n++) {
                                    $col_name = $col_names[$n];
                                    
                                    for ($c=0; $c < $num; $c++) {
                                        //echo "[".$data[$c]."]---[".$col_name."] ".
                                        //        mb_detect_encoding($data[$c]).
                                        //        "-".mb_detect_encoding($col_name);
                                        
                                        if  (($data[$c]==$col_name)&&!$its_preg_match)  {
                                            
                                            $col_names_variants[$src_key]
                                                ["header_equals_count"]++;
                                            $col_names_variants[$src_key]
                                                ["fact_rels"][$col_vars_key][]=$c;
                                        }   
                                        else if (($col_name!=null)&&$its_preg_match) {
                                            $matches_array = array();
                                            $assign_col_index=null;
                                            $col_pattern=$col_name;
                                            if(is_array($col_name)) {
                                                $assign_col_index=$col_name[1];
                                                $col_pattern=$col_name[0];
                                                //echo ">>>".$assign_col_index."===".$col_pattern;
                                            }
                                            //echo "&&&".$assign_col_index;
                                            if (preg_match($col_pattern, $data[$c], $matches_array)==1)    {
                                                
                                                if ($matches_array[0]==$data[$c])   {
                                                    $col_names_variants[$src_key]
                                                        ["header_equals_count"]++;
                                                    $col_names_variants[$src_key]
                                                        ["fact_rels"][$col_vars_key][]=
                                                        (isset($assign_col_index)?$assign_col_index:$c);
                                                    //if (isset($assign_col_index))
                                                        
                                                        
                                                }
                                            }
                                            //echo " [".$data[$c].">>>>>".$col_name."]";
                                            //print_r($matches_array);
                                        }
                                    }
                                }
                            }
                            
                            //echo $col_names_variants[$src_key]
                            //    ["header_equals_count"];
                            if (($col_names_variants[$src_key]
                                ["header_equals_count"]>$max_src_equal_value)&&
                                    (
                                        ($col_names_variants[$src_key]["header_equals_count"]>4)
                                        ||
                                        ($its_preg_match
                                        &&($col_names_variants[$src_key]["header_equals_count"]>=3))
                                    )
                                )   {
                                    $max_src_equal_value = $col_names_variants[$src_key]
                                        ["header_equals_count"];
                                    $max_equals_src_key = $src_key;
                            }
                            
                        }
                        
                       if  ($max_equals_src_key!=null)  {
                            $rels = $col_names_variants[$max_equals_src_key]["rels"];
                            $fact_rels = $col_names_variants[$max_equals_src_key]["fact_rels"];
                            
                            
                            
                            $sql_template = $sources_sql_templates[$max_equals_src_key];
                            //print_r($fact_rels);
                            $row_keys_composition = 
                                $row_keys_compositions[$max_equals_src_key];
                            
                            $has_header=true;
                            echo "Наиболее подходящим для распознавания определен шаблон <b>[".
                               $sources_variants_names[$max_equals_src_key]."]</b>";
                            
                            //print_r($fact_rels);
                            if (!$its_without_headers)
                                continue;
                            //$col_vars_keys = array_keys($src_variant);
                            //foreach ($col_vars_keys as $col_vars_key) {
                            //    $($col_vars_key."_col_index")=
                            //        $src_variant["fact_rels"][$col_vars_key];
                            //}
                       }    else    {
                           continue;
                       }
                        
                    }   
                    
                    if ($has_header)   {  //Найден заголовок и определен шаблон
                        $params_array = $fact_rels;
                        $fact_keys = array_keys($fact_rels);
                        //echo $sql_template;
                        
                        foreach($fact_keys as $fact_key)    {
                            $params_array[$fact_key] = null;
                            if($fact_key=="operation_time") {
                                if ((sizeof($fact_rels[$fact_key])>1) || (sizeof($fact_rels[$fact_key])==0))
                                    echo "Непредусмотренная ситуация при поиске значения поля ".$fact_key;
                                else    {
                                    $date_time_str=$data[$fact_rels[$fact_key][0]];
                                    //echo "---".$date_time_str."---";
                                    $unix_dt=null;
                                    $dt_value=null;
                                    $dt_array=null;
                                    //$format = '%d/%m/%Y %H:%M:%S';
                                    $dt_format = "d.m.Y";
                                    
                                    //$unix_dt = strtotime($date_time_str);
                                    //echo "[[[".$date_time_str."]]]";
                                    
                                    if (!$unix_dt) {
                                        //echo "ddd";
                                        $unix_dt = DateTime::createFromFormat($dt_format, $date_time_str);
                                        ////$this->strtotimef($date_time_str, $dt_format);
                                        if (!$unix_dt) {
                                            //echo "sss";
                                            $unix_dt =
                                                DateTime::createFromFormat("d/m/Y", $date_time_str);
                                                //$this->strtotimef($date_time_str, 
                                                //    "d/m/Y");//$template_dateformat);
                                            if (!$unix_dt) {
                                                $unix_dt = strtotime($date_time_str);
                                                if (!$unix_dt) {
                                                    
                                                } else {
                                                    $dt_value = date('Y-m-d h:i:s', $unix_dt);
                                                }
                                            }
                                            else
                                              $dt_value = $unix_dt->format('Y-m-d h:i:s');
                                            ////date('Y-m-d h:i:s', $unix_dt);  
                                        }  else {
                                            //$unix_dt = mktime(null, null, null, 
                                            //        $dt_array['tm_mon'], $dt_array['tm_mday'], 
                                            //        $dt_array['tm_year']);
                                            $dt_value = $unix_dt->format('Y-m-d h:i:s');
                                            ////date('Y-m-d h:i:s', $unix_dt);
                                            //echo "---".$dt_value;
                                        }
                                    } else {
                                        $dt_value = $unix_dt->format('Y-m-d h:i:s');
                                        ////date('Y-m-d h:i:s', $unix_dt);
                                    }
                                    
                                    //try {
                                    //echo "[[[".$dt_value."]]]";
                                    $this->checkAllCurrenciesRates($this->dbconnector, $dt_value);
                                    //} Exception::
                                    
                                    $params_array[$fact_key] = $dt_value;
                                }
                            } else if($fact_key=="currency_id") {
                                if ((count($fact_rels[$fact_key])>1) || (count($fact_rels[$fact_key])==0))
                                    echo "Непредусмотренная ситуация при поиске значения поля {$fact_key}";
                                else    {
                                    //echo $data[$fact_rels[$fact_key][0]]."+";
                                    if ((substr_count($data[$fact_rels[$fact_key][0]], "RUR")>0)||
                                            ($max_equals_src_key=="VTB24") || ($max_equals_src_key=="VTB24_2VAR_RUB"))   {
                                        $params_array[$fact_key] = 
                                            $GLOBALS['rouble_currency_id'];
                                    //    echo "==";
                                    }   else if (substr_count($data[$fact_rels[$fact_key][0]], "USD")>0)   {
                                        $params_array[$fact_key] = 
                                            $GLOBALS['dollar_currency_id'];
                                        echo "---";
                                    }   else if (substr_count($data[$fact_rels[$fact_key][0]], "EUR")>0)   {
                                        $params_array[$fact_key] = 
                                            $GLOBALS['euro_currency_id'];
                                    } else {
                                        $params_array[$fact_key] = 
                                            $GLOBALS['unknown_currency_id'];
                                    }
                                }
                            } else if($fact_key=="optype_id") {
                                $params_array[$fact_key] = $GLOBALS['unknown_operation_type_id'];
                                if ((count($fact_rels[$fact_key])>2) || (count($fact_rels[$fact_key])==0))
                                    echo "Непредусмотренная ситуация при поиске значения поля {$fact_key}";
                                else if (count($fact_rels[$fact_key])==2)   {
                                    $pval =  
                                            abs((real)
                                            str_replace("\"","",
                                            str_replace(",",".",$data[$fact_rels[$fact_key][0]])
                                            ))-
                                        abs((real)
                                            str_replace("\"","",
                                            str_replace(",",".",$data[$fact_rels[$fact_key][1]]
                                            )
                                            )
                                            ) ;
                                    //echo $pval."---";
                                    if($pval<0) {
                                        $params_array[$fact_key] = $GLOBALS['outcome_operation_type_id'];
                                    } else if($pval>0) {
                                        $params_array[$fact_key] = $GLOBALS['income_operation_type_id'];
                                    }   else    {
                                        
                                    }
                                }
                                else    {
                                    if ($fact_rels[$fact_key][0]==0)    {
                                        
                                    }   else    {
                                    $pval = 
                                         (real)
                                                str_replace("\"","",
                                                str_replace(",",".",
                                                $data[$fact_rels[$fact_key][0]]
                                                )
                                                );
                                    
                                    if($pval<0) {
                                        $params_array[$fact_key] = $GLOBALS['outcome_operation_type_id'];
                                    } else if($pval>0) {
                                        $params_array[$fact_key] = $GLOBALS['income_operation_type_id'];
                                    }   else    {
                                        
                                    }
                                    
                                    }
                                }
                            } else if($fact_key=="opsumm") {
                                $params_array[$fact_key] = 0.0;
                                if ((count($fact_rels[$fact_key])>2) || (count($fact_rels[$fact_key])==0))
                                    echo "Непредусмотренная ситуация при поиске значения поля {$fact_key}";
                                else if (count($fact_rels[$fact_key])==2)   {
                                    $pval = abs( 
                                        abs((real)
                                            str_replace("\"","",
                                            str_replace(",",".",$data[$fact_rels[$fact_key][0]])
                                            ))-
                                        abs((real)
                                            str_replace("\"","",
                                            str_replace(",",".",$data[$fact_rels[$fact_key][1]]
                                            )
                                            )
                                            ) );
                                    $params_array[$fact_key] = $pval;
                                }
                                else    {
                                    $params_array[$fact_key] = 
                                        abs( (real)
                                                str_replace("\"","",
                                                str_replace(",",".",
                                                $data[$fact_rels[$fact_key][0]]
                                                )
                                                ) );
                                }
                            } else if($fact_key=="description") {
                                if ((count($fact_rels[$fact_key])>1) || (count($fact_rels[$fact_key])==0))
                                    echo "Непредусмотренная ситуация при поиске значения поля {$fact_key}";
                                else    {
                                    $params_array[$fact_key] = $data[$fact_rels[$fact_key][0]];
                                            //str_replace("\"","&quot;",
                                            //str_replace("\n","<br>", 
                                            //addslashes($data[$fact_rels[$fact_key][0]])));
                                }
                                
                            }   else    {
                                echo "Непредусмотренное поле ".$fact_key." для csv-анализатора!";
                            }
                        }
                        
                        $sync_key="";
                        for($kc=0;$kc<count($row_keys_composition);$kc++)  {
                            $sync_key .= $data[$row_keys_composition[$kc]];
                        }
                        
                        //$str_val="";
                        //$pkeys = array_keys($params_array);
                        //foreach($pkeys as $pkey)
                        //    $str_val .= $params_array[$pkey];
                        
                        //$this->dbconnector->exec_with_prepare_and_params_2ver
                        //        ("insert into test_table (`str_field`) 
                        //            values('{$str_val}');", array());
                        //$append_instruction = 
                        //    $this->getTextFromTemplate(
                        $all_params = array_merge(
                                array_merge($params_array, $params), array("sync_key"=>$sync_key));
			$all_params_keys = array_keys($all_params);
                        foreach($all_params_keys as $all_params_key)    {
                            $all_params[":".$all_params_key] = 
                                    $all_params[$all_params_key];
                            unset($all_params[$all_params_key]);
                        }
                        //print_r($all_params);
								
                        //        , $sql_template);
                        
                        //echo $append_instruction;
                        //echo $sql_template;
                        //print_r($all_params);
                        if ($this->dbconnector->exec_with_prepare_and_params_2ver
                                ($sql_template, $all_params)==null)  {
                            echo "Ошибка выполнения запроса! Строка ".$row.", data: ";
                            print_r($data);
                            return;
                        }   
                        
                        $row++;
                        
                    }
                }
                
                //$row++;
                //for ($c=0; $c < $num; $c++) 
                //    $data[$c] = "[".iconv('WINDOWS-1251', 'UTF-8', $data[$c])."] ";
                //echo "<br />\n";
            }
            
            if (!$has_header) 
                echo "Не найдено подходящего шаблона распознавания для файла!";

            fclose($handle);
        }
        }   else    {
            echo "<h3>Невозможно прочитать файл. Системная ошибка: <b>не определен символ разделитель</b>!</h3>";
        }

    }
}

?>
