<?php

/**
 * @author Poltarokov SP
 * @copyright 2011
 */
 
require_once("classes/table_adapters/table_adapter.class.php");
require_once("classes/table_adapters/table_adapter.interface.php");

class CurrencyTableAdapter extends TableAdapter  implements TableAdapterInterface  {
    
    function __construct($dbconnector, $table_name, 
        $class_name, $context_suffix=null, $environment_mode = null)    { 
        parent::__construct($dbconnector, "currency_dictionary", 
            $class_name, "currency_dictionary"); 
	$this->dict_header = "Валюты";
        $this->id_field="currency_id";
        $this->add_update_procedure_name = ""; 
        $this->custom_order_clause = " order by currency_id ASC ";
        $this->insert_instruction_template = "insert into `companies`(`id`,`company_name`) values(null,:company_name);"; 
        $this->update_instruction_template = "update `companies` SET `company_name`=:company_name where `id`=:id;";
        $this->delete_instruction_template = "SET @dcount=0; call `delete_object_by_type` ('currency', :id, @dcount);";
        //$this->custom_action_instructions = array("append_call_repeat_status"=>"insert into `call_statuses_rels`(`id`,`call_id`,`call_status_id`, `call_date`) 
        //    values(null,:call_id,'{$GLOBALS['repeat_call_status_id']}',CURRENT_TIMESTAMP());");
        //$this->custom_action_params = array("append_call_repeat_status"=>array("call_id"=>"call_id"));
        //$this->short_name = "CSS";
    }
    
    function writeTable()   {
        $this->generateTable();
    }
    
    function writeInsertForm()  {
        
    }
}

?>