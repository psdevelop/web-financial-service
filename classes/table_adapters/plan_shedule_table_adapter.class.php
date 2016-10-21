<?php

/**
 * @author Poltarokov SP
 * @copyright 2011
 */
 
require_once("classes/table_adapters/table_adapter.class.php");
require_once("classes/table_adapters/table_adapter.interface.php");

class PlanSheduleTableAdapter extends TableAdapter  implements TableAdapterInterface  {
    
    function __construct($dbconnector, $table_name, 
        $class_name, $context_suffix=null, $environment_mode = null)    { 
        parent::__construct($dbconnector, "plan_shedules_dictionary", 
            $class_name, "plan_shedules_dictionary");
        $this->dict_header = "Типы графиков платежей";
        $this->id_field="shedule_id";
        //$this->filters_array = array("state_id"=>"State");
        //$this->filters_values = array("state_id"=>null);
        $this->add_update_procedure_name = ""; 
        $this->insert_instruction_template = "insert into `plan_shedules_dictionary`
            (`shedule_id`,`shedule_name`) values(null,:shedule_name);"; 
        $this->update_instruction_template = "update `plan_shedules_dictionary` SET `category_name`=:category_name where `category_id`=:id;";
        $this->delete_instruction_template = "SET @dcount=0; call `delete_object_by_type` ('plan_shedule', :id, @dcount);";
    }
    
    function writeTable()   {
        $this->generateTable();
    }
    
    function writeInsertForm()  {
        
    }
}

?>