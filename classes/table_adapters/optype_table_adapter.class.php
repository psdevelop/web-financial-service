<?php

/**
 * @author Poltarokov SP
 * @copyright 2011
 */
 
require_once("classes/table_adapters/table_adapter.class.php");
require_once("classes/table_adapters/table_adapter.interface.php");

class OperationTypeTableAdapter extends TableAdapter  implements TableAdapterInterface  {
    
    function __construct($dbconnector, $table_name, 
        $class_name, $context_suffix=null, $environment_mode = null)    { 
        parent::__construct($dbconnector, "optype_dictionary", 
            $class_name, "optype_dictionary");
	$this->dict_header = "Типы операций";
        $this->id_field="optype_id";
        $this->add_update_procedure_name = ""; 
        $this->custom_order_clause = " order by optype_id ASC ";
        $this->insert_instruction_template = "insert into `optype_dictionary`(`id`,`country_name`) values(null,:country_name);"; 
        $this->update_instruction_template = "update `countries` SET `country_name`=:country_name where `id`=:id;";
        $this->delete_instruction_template = "SET @dcount=0; call `delete_object_by_type` ('optype', :id, @dcount);";
    }
    
    function writeTable()   {
        $this->generateTable();
    }
    
    function writeInsertForm()  {
        
    }
}

?>
