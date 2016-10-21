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

class PurseObjectAdapter extends ObjectAdapter implements ObjectManipInterface  {
     
     function __construct($table_name, $class_name)    {
        parent::__construct($table_name, $class_name, "dictionary_table_text", "dictionary_table_text");
        $this->foreigen_keys = array("purse_currency_id"=>"Currency",
            "purse_ptype_id"=>"PurseType");
        $this->fields_prev_text_array = array("id"=>"ID","purse_name"=>"Наименование кошелька",
            "purse_currency_id"=>"Валюта кошелька", "purse_ptype_id"=>"Тип кошелька");
        $this->fields_width_array = array("id"=>10,"purse_name"=>25, 
            "purse_currency_id"=>180, "purse_ptype_id"=>180);
        $this->select_display_field = "purse_name";
        $this->manip_form_template = "<table><tr><td>***___purse_name</td>
            <td>***___purse_currency_id</td><td>***___purse_ptype_id***___id</td></tr>
            </table>";
        $this->hidden_keys = array("id"=>"hidden", );
        //$this->mobile_list_table_row_template="<li><a href=\"getAccountStatistic.php?purse_id=***___id\" onClick=\"\" rel=\"external\">***___purse_name</a></li>";
        $this->mobile_list_table_row_template="<li><a href=\"#\" class=\"detailed_li_a\" data-entity=\"{$this->class_name}\" data-identify=\"***___id\" rel=\"external\">***___purse_name</a></li>";
        $this->mobile_manip_form_template = "<table><tr><td>***___purse_name</td><td></td><td>***___id</td></tr>
            </table>";
        $this->desk_list_row_template = "<table class=\"list_row_template\"><tr><td>***___purse_name</td><td>
            </td><td style=\"text-align: right;\">***___purse_summ&nbsp;***___currency_label</td></tr>
            </table>";
        $this->format_float_fields = array("purse_summ"=>"format_float");
        $this->toggle_link_to_row = true;
        $this->clearTrStyles();
        $this->use_custom_row_click_anchor = false;
     }
     
     function writeTableHeader($linked_props)    {
        echo "<tr>";
        parent::write_header_td("Кошелек",75);
        echo "</tr>";
     }
     
     function writeTableRow($object, $linked_props)    {
         parent::write_td_ext($object->purse_name,75,$object );
     }
     
     function getStyleForField($object, $field_name) {
         return "";
     }
     
     function getTemplateForRow($object)    {
         return "";
     }
     
     function getDerivedFieldsArray($object)    {
         $derived_fields = array("currency_label"=>"руб.");
         
         if ($object->purse_currency_id==$GLOBALS['rouble_currency_id'])
             $derived_fields['currency_label']="руб.";
         else if ($object->purse_currency_id==$GLOBALS['euro_currency_id'])
             $derived_fields['currency_label']="EURO";
         else if ($object->purse_currency_id==$GLOBALS['dollar_currency_id'])
             $derived_fields['currency_label']="\$";
         else   {
             
         }
         
         return $derived_fields;
     }
}

?>
