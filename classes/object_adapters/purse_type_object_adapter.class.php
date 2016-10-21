<?php

/*
 * @author Poltarokov SP
 * @copyright 2011
 */

if (!defined("ABSOLUTE_PATH"))
    define("ABSOLUTE_PATH", dirname(__FILE__)."/../../");

require_once(constant("ABSOLUTE_PATH")."classes/object_adapters/object_adapter.class.php"); 
require_once(constant("ABSOLUTE_PATH")."classes/object_adapters/object_manip.interface.php");
require_once(constant("ABSOLUTE_PATH")."classes/configuration.php");

class PurseTypeObjectAdapter extends ObjectAdapter implements ObjectManipInterface  {
     
     function __construct($table_name, $class_name)    {
        parent::__construct($table_name, $class_name, "dictionary_table_text", "dictionary_table_text");
        $this->foreigen_keys = array();
        $this->fields_prev_text_array = array("id"=>"ID","purse_type_name"=>"Тип кошелька");
        $this->fields_width_array = array("id"=>10,"purse_type_name"=>25);
        $this->select_display_field = "purse_type_name";
        $this->manip_form_template = "<table><tr>
		<td>***___purse_type_name</td><td></td><td>***___id</td></tr>
            </table>";
	//$this->date_time_fields = array("source_dt"=>"2011-22-09 00:00",
        //    "dest_dt"=>"2011-22-09 00:00");
        //$this->date_fields = array("start_call_date"=>"","end_call_date"=>"");
        //$this->with_button_clear_fields = array("source_dt"=>"2011-22-09 00:00",
        //    "dest_dt"=>"2011-22-09 00:00");	
        $this->hidden_keys = array("id"=>"hidden");
        $this->filter_form_template = "<table><tr><td colspan=\"2\"></td><td></td></tr>
            </table>";
     }
     
     function writeTableHeader($linked_props)    {
        echo "<tr>";
        parent::write_header_td("ID",25);
	parent::write_header_td("Тип кошелька",100);
        echo "</tr>";
     }
     
     function writeTableRow($object, $linked_props)    {
        parent::write_td($object->getId(),25);
	parent::write_td($object->purse_type_name,100);
     }
     
     function getStyleForField($object, $field_name) {
         return "";
     }
     
     function getTemplateForRow($object)    {
         return "";
     }
     
     function getDerivedFieldsArray($object)    {
         return array();
     }
}

?>