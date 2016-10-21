<?php

/* 19.05.2012
 * @author Poltarokov SP
 * @copyright 2012
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

require_once("classes/table_adapters/table_adapter.class.php");
require_once("classes/table_adapters/table_adapter.interface.php");

class FCAStatusTableAdapter extends TableAdapter  implements TableAdapterInterface  {
    
    function __construct($dbconnector, $table_name, 
        $class_name, $context_suffix=null, $environment_mode = null)    { 
        parent::__construct($dbconnector, "action_statuses", 
            $class_name, "action_statuses"); 
	$this->dict_header = "Статусы операций";
        $this->id_field="action_status_id";
        $this->add_update_procedure_name = ""; 
        $this->insert_instruction_template = "insert into `action_statuses`(`id`,`act_status_name`) values(null,:act_status_name);"; 
        $this->update_instruction_template = "update `action_statuses` SET `act_status_name`=:act_status_name where `id`=:id;";
        $this->delete_instruction_template = "SET @dcount=0; call `delete_object_by_type` ('action_status', :id, @dcount);";
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
