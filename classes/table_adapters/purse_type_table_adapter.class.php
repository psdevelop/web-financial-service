<?php

/**
 * @author Poltarokov SP
 * @copyright 2011
 */
 
require_once("classes/table_adapters/table_adapter.class.php");
require_once("classes/table_adapters/table_adapter.interface.php");

class PurseTypeTableAdapter extends TableAdapter  implements TableAdapterInterface  {
    
    function __construct($dbconnector, $table_name, 
        $class_name, $context_suffix=null, $environment_mode = null)    { 
        parent::__construct($dbconnector, "purstype_dictionary", 
            $class_name, "purstype_dictionary");
        $this->dict_header = "Типы кошельков";
        $this->id_field="purse_type_id";
        //$this->filters_array = array("state_id"=>"State");
        //$this->filters_values = array("state_id"=>null);
        $this->add_update_procedure_name = ""; 
        $this->insert_instruction_template = "insert into `purstype_dictionary`
            (`purse_type_id`,`purse_type_name`) values(null,:purse_type_name);"; 
        $this->update_instruction_template = "update `purstype_dictionary` 
            SET `purse_type_name`=:purse_type_name where `purse_type_id`=:id;";
        $this->delete_instruction_template = "SET @dcount=0; call `delete_object_by_type` ('purse_type', :id, @dcount);";
    }
    
    function writeTable()   {
        $this->generateTable();
    }
    
    function writeInsertForm()  {
        
    }
}

?>