<?php

/* 17.11.2011
 * @author Poltarokov SP
 * @copyright 2011
 */

if (!defined("ABSOLUTE_PATH"))
    define("ABSOLUTE_PATH", dirname(__FILE__)."/../../");

require_once(constant("ABSOLUTE_PATH")."classes/object_adapters/object_adapter.class.php"); 
require_once(constant("ABSOLUTE_PATH")."classes/object_adapters/object_manip.interface.php");
require_once(constant("ABSOLUTE_PATH")."classes/configuration.php");

class PlanObjectAdapter extends ObjectAdapter implements ObjectManipInterface  {
     
     function __construct($table_name, $class_name)    {
        parent::__construct($table_name, $class_name, "dictionary_table_text", "dictionary_table_text");
        $this->foreigen_keys = array("plan_optype_id"=>"OperationType",
            "plan_shedule_id"=>"PlanShedule", "default_purse_id"=>"Purse",
            "plan_currency_id"=>"Currency");
        $this->fields_prev_text_array = array("id"=>"ID","plan_name"=>"Наименование плана",
                        "plan_optype_id"=>"Тип операций", "first_payment_date"=>"Очередная дата оплаты",
                        "complete_month_count"=>"Месяцев для погашения", 
                        "min_payment_summ"=>"Минимальная сумма платежа",
                        "plan_summ"=>"Планируемая сумма", 
                        "plan_shedule_id"=>"График платежей",
                        "apr"=>"Процентная годовая ставка, %",
                        "default_purse_id"=>"Привязанный кошелек",
                        "plan_currency_id"=>"Валюта расчета",
                        "target_date"=>"Дата реализации");
        $this->fields_width_array = array("id"=>10,"plan_name"=>25,"plan_summ"=>15,
			"plan_optype_id"=>180,"first_payment_date"=>15,"min_payment_summ"=>10,
                        "complete_month_count"=>10, "plan_shedule_id"=>180, "apr"=>10,
                        "default_purse_id"=>180, "plan_currency_id"=>180,"target_date"=>15);
        $this->select_display_field = "plan_name";
        $this->manip_form_template = "<table>
			<tr><td>***___plan_name</td><td>***___target_date***___apr</td><td>***___plan_optype_id</td></tr>
			<tr><td>***___plan_summ</td><td>***___plan_shedule_id</td><td>***___default_purse_id***___id</td></tr>
                        <tr><td></td><td>***___plan_currency_id</td><td></td></tr>
            </table>";
	//$this->date_time_fields = array("buy_datetime"=>"2011-22-09 00:00");
	$this->date_fields = array("first_payment_date"=>"2011-22-09", "target_date"=>"2011-22-09");	
        $this->with_button_clear_fields = array("first_payment_date"=>"2011-22-09");	
        $this->hidden_keys = array("id"=>"hidden", "target_date"=>"hidden");
	$this->filter_form_template = "<table><tr><td colspan=\"2\">***___plan_optype_id</td><td></td></tr>
            </table>";
        $this->desk_list_row_template = "<table class=\"list_row_template\"><tr><td>***___plan_name</td><td></td>
                <td style=\"text-align: right;\">***___plan_summ&nbsp;***___currency_label</td></tr>
            </table>";
        $this->toggle_link_to_row = true;
        $this->clearTrStyles();
        $this->format_float_fields = array("plan_summ"=>"format_float", "apr"=>"format_float",
            "min_payment_summ"=>"format_float");
        $this->alternate_templates = array("target_plan_template"=>
            "<table class=\"list_row_template\"><tr><td>***___plan_name</td><td></td>
                <td style=\"text-align: right;\">***___target_date&nbsp;***___plan_summ&nbsp;***___currency_label</td></tr>
            </table>");
        $this->use_detailed_doubleclick = true;
        $this->use_detail_ajax_doubleclick = true;
        $this->use_custom_row_click_anchor = false;
     }
     
     function writeTableHeader($linked_props)    {
        echo "<tr>";
        parent::write_header_td("ID",25);
        parent::write_header_td("Наименование плана",75);
        parent::write_header_td("Планируемая сумма",370);
        echo "</tr>";
     }
     
     function writeTableRow($object, $linked_props)    {
        //echo "<tr>";
        parent::write_td($object->getId(),25);
        parent::write_td($object->plan_name,75);
	parent::write_td($object->plan_summ,370);;
     }
     
     function getStyleForField($object, $field_name) {
         return "";
     }
     
     function getTemplateForRow($object)    {
         $result_template="";
         
         if($this->num_suffix=="_planning_target")
            $result_template = $this->alternate_templates['target_plan_template'];
         else
             $result_template = $this->desk_list_row_template;
         //if($this->num_suffix=="_planning_target")
         //echo $result_template;
         return $result_template;
     }
     
     function getDerivedFieldsArray($object)    {
         $derived_fields = array("currency_label"=>"руб.");
         
         if ($object->plan_currency_id==$GLOBALS['rouble_currency_id'])
             $derived_fields['currency_label']="руб.";
         else if ($object->plan_currency_id==$GLOBALS['euro_currency_id'])
             $derived_fields['currency_label']="EURO";
         else if ($object->plan_currency_id==$GLOBALS['dollar_currency_id'])
             $derived_fields['currency_label']="\$";
         else   {
             
         }
         
         return $derived_fields;
     }
}

?>
