<?php

/**
 * @author Poltarokov SP
 * @copyright 2011
 */
 
require_once("classes/table_adapters/table_adapter.class.php");
require_once("classes/table_adapters/table_adapter.interface.php");

class PurseTableAdapter extends TableAdapter  implements TableAdapterInterface  {
    
    function __construct($dbconnector, $table_name, 
        $class_name, $context_suffix=null, $environment_mode = null)    { 
        parent::__construct($dbconnector, "purse_dictionary", 
            $class_name, "purse_view");
        $this->dict_header = "Кошельки";
        $this->id_field="purse_dictionary_id";
        $this->hide_header = true;
        $this->strong_user_relative = true;
        $this->object_adapter->desk_list_table_mode = true;
        $this->add_update_procedure_name = "add_update_person";
        $this->write_table_width = 300;
        $this->without_dict_header_mode = true;
        $this->include_custom_actions_in_float_window = true;
        $this->insert_instruction_template = "insert into `purse_dictionary`(`purse_dictionary_id`,
            `purse_name`, `user_id`, `purse_currency_id`, `purse_ptype_id`) 
            values(null,:purse_name, '{$_SESSION['user_id']}', :purse_currency_id, :purse_ptype_id);"; 
        $this->update_instruction_template = "update `purse_dictionary` SET `purse_name`=:purse_name,
            `purse_currency_id`=:purse_currency_id, `purse_ptype_id`=:purse_ptype_id where `purse_dictionary_id`=:id";
        $this->delete_instruction_template = "SET @dcount=0; call `delete_object_by_type` ('purse', :id, @dcount);";
	$this->custom_order_clause = " order by purse_name ASC ";
        $this->no_back_border_color = true;
        $this->no_use_tablesorter_class = true;
        $this->table_css_class = "left_menu_entity_table";
        $this->button_hints = array("insert"=>"Добавить кошелек", "update"=>"Изменить свойства кошелька", 
            "delete"=>"Удалить кошелек", "edit"=>"Редактировать свойства кошелька");
        
        $purses_ajax_detail_params = array("request_base"=>"index-ajax.php?desktop_mode",
            "result_container"=>"main_region", "id"=>"fca_purse_id", "eval"=>
            array("prev_part_capacity"=>"page_capacity_input_FinanceActData_account"), "next_function"=>
            " function(next_ajx_function) { linkCalendar(); initAcc2(); initSort('FinanceActData_dict_table_account'); } ");
        $this->setAjaxDetailedParams($purses_ajax_detail_params);
        
        
        $AddTranfertOperation = new Operation($dbconnector, 
                "addtrsf", 
                "FinanceActData", 
                $GLOBALS['linked_entity_append_type'], 
                "Операция добавления внутреннего перевода", 
                array("id"=>"fca_transfert_purse_id"), 
                array(), //form_input_params
                array("fca_operation_type_id"=>$GLOBALS['inner_income_transfert_operation_type_id']), 
                array(), //inline_props
                null
                );
        
        $AddPurseCorrectionOperation = new Operation($dbconnector, 
                "aprcor", 
                "FinanceActData", 
                $GLOBALS['linked_entity_append_type'], 
                "Операция добавления корректировки", 
                array("id"=>"fca_purse_id"), 
                array(), //form_input_params
                array("fca_operation_type_id"=>$GLOBALS['correction_income_operation_type_id'],
                    "fca_category_id"=>0,
                    "fca_status_id"=>$GLOBALS['conduct_fca_status_id']), 
                array(), //inline_props
                null
                );
        
        $AddPurseCorrectionOperation->acceptCustomHiddenKeys(
                array("fca_operation_type_id"=>"hidden",
                      "fca_purse_id"=>"hidden",
                      "fca_status_id"=>"hidden",
                      "fca_category_id"=>"hidden"
                    ));
        $AddTranfertOperation->acceptLocalFieldsNames(
                array("fca_purse_id"=>"На счет"));
        $AddTranfertOperation->acceptCustomHiddenKeys(
                array(  "fca_status_id"=>"hidden",
                        "fca_category_id"=>"hidden",
                        "fca_operation_type_id"=>"hidden"));
        //$MeetCallSetStatusOperation->showCustomHiddenKeys(
        //        array("meet_datetime"=>"visible"));
        
        $AddTransfertAction = new Action("Перевести", array(
            $AddTranfertOperation), "AddTrA",
            "#00FF00", $this);
        $AddPurseCorrectionAction = new Action("Коррекция", array(
            $AddPurseCorrectionOperation), "AddPCA",
            "#FF0000", $this);
        
        $this->record_actions = array($AddTransfertAction, $AddPurseCorrectionAction);
        
        $purse_action_ajax_detail_params = array("request_base"=>"index-ajax.php?desktop_mode",
                    "result_container"=>"main_region", "eval"=>"fca_purse_id", "next_function"=>
                    " function(next_ajx_function) { linkCalendar(); initAcc2(); initSort('FinanceActData_dict_table_account'); } ");
        $this->setActionsAjaxDetailedParams($purse_action_ajax_detail_params);
        
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
	
    function writeMobileListTable()	{
		$this->generateMobileListTable($GLOBALS['mobile_list_table_mode']);
	}
}

?>
