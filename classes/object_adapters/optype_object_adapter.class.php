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

class OperationTypeObjectAdapter extends ObjectAdapter implements ObjectManipInterface  {
     //protected $foreigen_keys = array("person_type_id"=>"person_types");
     
     function __construct($table_name, $class_name)    {
        parent::__construct($table_name, $class_name, "dictionary_table_text", "dictionary_table_text");
        $this->foreigen_keys = array();
        $this->fields_prev_text_array = array("id"=>"ID",
			"optype_name"=>"Наименование тина операции");
        $this->fields_width_array = array("id"=>10,"optype_name"=>25);
        $this->select_display_field = "optype_name";
        $this->manip_form_template = "<table><tr><td>***___optype_name</td><td></td><td>***___id</td></tr>
            </table>";
        $this->hidden_keys = array("id"=>"hidden");
     }
     
     function writeTableHeader($linked_props)    {
        echo "<tr>";
        parent::write_header_td("ID",25);
        parent::write_header_td("Наименование тина операции",75);
        //parent::write_header_td("Правка",70);
        echo "</tr>";
     }
     
     function writeTableRow($object, $linked_props)    {
        //echo "<tr>";
        parent::write_td($object->getId(),25);
        parent::write_td($object->optype_name,75);
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
