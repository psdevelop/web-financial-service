<?php

/* 19.05.2012
 * @author Poltarokov SP
 * @copyright 2012
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

if (!defined("ABSOLUTE_PATH"))
    define("ABSOLUTE_PATH", dirname(__FILE__)."/../../");

require_once(constant("ABSOLUTE_PATH")."classes/object_adapters/object_adapter.class.php"); 
require_once(constant("ABSOLUTE_PATH")."classes/object_adapters/object_manip.interface.php");
require_once(constant("ABSOLUTE_PATH")."classes/configuration.php");

class FCAStatusObjectAdapter extends ObjectAdapter implements ObjectManipInterface  {
     
     function __construct($table_name, $class_name)    {
        parent::__construct($table_name, $class_name, "dictionary_table_text", "dictionary_table_text");
        $this->foreigen_keys = array();
        $this->fields_prev_text_array = array("id"=>"ID","act_status_name"=>"Наименование статуса");
        $this->fields_width_array = array("id"=>1,"act_status_name"=>75);
        $this->select_display_field = "act_status_name";
        $this->manip_form_template = "<table><tr><td>***___act_status_name</td><td></td><td>***___id</td></tr>
            </table>";
        $this->hidden_keys = array("id"=>"hidden");
     }
     
     function writeTableHeader($linked_props)    {
        echo "<tr>";
        parent::write_header_td("ID",25);
        parent::write_header_td("Наименование статуса",75);
        echo "</tr>";
     }
     
     function writeTableRow($object, $linked_props)    {
        //echo "<tr>";
        parent::write_td($object->getId(),25);
        parent::write_td($object->act_status_name,75);
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
