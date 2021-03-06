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

class InviteObjectAdapter extends ObjectAdapter implements ObjectManipInterface  {
     
     function __construct($table_name, $class_name)    {
        parent::__construct($table_name, $class_name, "dictionary_table_text", "dictionary_table_text");
        $this->foreigen_keys = array();
        $this->fields_prev_text_array = array("id"=>"ID","name"=>"Имя посетителя",
            "email"=>"Email посетителя");
        $this->fields_width_array = array("id"=>1,"category_name"=>75);
        $this->select_display_field = " CONCAT(name,':',email) ";
        //$this->image_fields = array("small_image_path"=>"default_image");
        $this->manip_form_template = "<table><tr><td>***___name</td><td>***___email</td><td>***___id</td></tr>
            </table>";
        $this->hidden_keys = array("id"=>"hidden");
        //$this->desk_list_row_template = "<table class=\"list_row_template\"><tr><td>***___small_image_path</td><td>***___category_name</td><td></td><td style=\"text-align: right;\"><b>По категории: </b>***___cat_summ</td></tr>
        //    </table>";
        //$this->styled_data_fields = array("category_name"=>" class=\"bold_in_list_table\" ");
        //$this->alternate_templates = array("category_header_template"=>
        //    "<table class=\"list_row_template\"><tr><td>***___small_image_path</td><td style=\"text-align: right;\">
        //        <table border=\"0\" style=\"width:100%;\"><tr><td>***___category_name</td></tr>
        //        <tr><td><b>По категории: </b>***___cat_summ</td></tr></table>
        //        </td></tr></table>");
        $this->toggle_link_to_row = true;
        $this->use_tr_link_tag = false;
        $this->td_default_link_class = "table_row_link_clear";
        $this->toggle_link_to_row = true;
        //$this->clearTrStyles();
     }
     
     function writeTableHeader($linked_props)    {
        echo "<tr>";
        parent::write_header_td("ID",25);
        parent::write_header_td("Дата",100);
        parent::write_header_td("Посетитель",250);
        parent::write_header_td("Email",120);
        echo "</tr>";
     }
     
     function writeTableRow($object, $linked_props)    {
        //echo "<tr>";
        parent::write_td($object->getId(),25);
        parent::write_td($object->relative_props['date_time'],100);
        parent::write_td($object->name,250);
        parent::write_td($object->email,120);
     }
     
     function getStyleForField($object, $field_name) {
         $result_style="";
         if($field_name=="category_name")   {
             if($object->category_level==0)
                $result_style .= " class=\"bold_in_list_table\" ";
         }
         return $result_style;
     }
     
     function getTemplateForRow($object)   {
         $result_template="";
         
         //if($object->category_level==0)
         //   $result_template = $this->alternate_templates['category_header_template'];
         //else
         //    $result_template = $this->desk_list_row_template;
         
         return $result_template;
     }
     
     function getDerivedFieldsArray($object)    {
         return array();
     }
}

?>