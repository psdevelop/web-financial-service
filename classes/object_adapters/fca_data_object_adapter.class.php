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

class FinanceActDataObjectAdapter extends ObjectAdapter implements ObjectManipInterface  {
     //protected $foreigen_keys = array("person_type_id"=>"person_types");
     
     function __construct($table_name, $class_name)    {
        parent::__construct($table_name, $class_name, "dictionary_table_text", "dictionary_table_text");
        $this->foreigen_keys = array("fca_purse_id"=>"Purse", "fca_category_id"=>"Category", 
            "fca_operation_type_id"=>"OperationType", "fca_status_id"=>"FCAStatus",
            "fca_currency_id"=>"Currency", "parent_category_id"=>"Category");
        //$this->foreigen_keys_filters = array("fca_currency_id"=>
        //    "( (currency_id={$GLOBALS['income_operation_type_id']}) OR 
        //    (currency_id={$GLOBALS['outcome_operation_type_id']}) )");
        $this->filter_values_keys = array("fca_plan_id"=>30, "fca_category_id"=>30,
            "start_fca_date"=>15, "end_fca_date"=>15);
        $this->fields_prev_text_array = array("id"=>"ID","fca_date"=>"Дата",
            "fca_actor_description"=>"Контрагент", "fca_description"=>"Описание", 
            "fca_summ"=>"Сумма", "fca_category_id"=>"Категория", 
            "fca_purse_id"=>"Счет", "fca_operation_type_id"=>"Тип операции",
            "fca_transfert_purse_id"=>"Кошелек-донор", "fca_status_id"=>"Статус операции",
            "fca_currency_id"=>"Валюта операции",
            "start_fca_date"=>"С даты", "end_fca_date"=>"До даты");
        $this->field_titles = array("id"=>"ID","fca_date"=>"Дата операции",
            "fca_actor_description"=>"Контрагент", "fca_description"=>"Описание операции", 
            "fca_summ"=>"Сумма операции", "fca_category_id"=>"Категория операции", 
            "fca_purse_id"=>"Счет, которому принадлежит операция", "fca_operation_type_id"=>"Тип операции",
            "fca_transfert_purse_id"=>"Кошелек-донор", "fca_status_id"=>"Статус операции",
            "fca_currency_id"=>"Валюта операции",
            "start_fca_date"=>"С даты", "end_fca_date"=>"До даты");
        $this->fields_width_array = array("id"=>10,"fca_date"=>12, "fca_category_id"=>130, 
            "fca_summ"=>16, "fca_description"=>14, "fca_actor_description"=>15,
            "fca_purse_id"=>130, "fca_operation_type_id"=>130, "fca_status_id"=>130,
            "fca_currency_id"=>130, "start_fca_date"=>15, "end_fca_date"=>15);
        $this->select_display_field = "fca_description";
        $this->manip_form_template = "<table>
            <tr><td>***___fca_date</td></tr><tr>
            <tr><td>***___fca_purse_id</td></tr>
            <tr><td>***___fca_operation_type_id</td></tr>
            <td>***___fca_category_id</td></tr>
            <tr><td>***___fca_summ</td></tr>
            <tr><td>***___fca_description</td></tr>
            <tr><td>***___fca_status_id</td></tr>
            <tr><td>***___fca_currency_id</td></tr>
            <tr><td style=\"display:none;\">***___fca_actor_description</td></tr>
            <tr><td>***___id***___fca_transfert_purse_id</td></tr>
            </table>";
        $this->hidden_keys = array("id"=>"hidden","fca_transfert_purse_id"=>"hidden",
            "fca_currency_id"=>"hidden");
        //$this->date_time_fields = array("fca_date"=>"2011-22-09 00:00");
        $this->date_fields = array("start_fca_date"=>"","end_fca_date"=>"", "fca_date"=>"2011-22-09 00:00");
        $this->with_button_clear_fields = array("fca_date"=>"2011-22-09 00:00");
        $this->text_area_fields = array("fca_description"=>7);
        $this->checkbox_fields = array();
        $this->filter_form_template = "<table>
            <tr><td>***___start_fca_date</td>
            <td>***___end_fca_date</td></tr>
            <tr><td>***___fca_purse_id
            <span style=\"display:none;\">***___fca_plan_id***___fca_operation_type_id***___parent_category_id</span></td>
            <td>***___fca_category_id</td></tr>
            </table>";
        $this->mobile_table_row_template = "<tr><td>***___fca_date</td><td>***___fca_actor_description</td>
            <td>***___fca_description</td><td>***___fca_summ</td><td></tr>
            ";
        $this->mobile_manip_form_template = "<table><tr><td>***___fca_date</td></tr>
            <tr><td>***___fca_actor_description</td></tr>
            <tr><td>***___fca_description</td></tr>
            <tr><td>***___fca_summ</td></tr>
            <tr><td>***___fca_operation_type_id<span style=\"visibility:hidden;\">***___fca_purse_id</span>***___id</td></tr>
            </table>";
        $this->format_float_fields = array("fca_summ"=>"format_float");
        $this->use_float_show_doubleclick = true;
        $this->class_specify_fields = array("fca_summ"=>" float_input_checked");
        $this->use_tr_link_tag = false;
        $this->td_default_link_class = "table_row_link_clear";
        $this->toggle_link_to_row = true;
     }
     
     function writeTableHeader($linked_props)    {
        echo "<tr>";
        //parent::write_header_td("ID",25);
        parent::write_header_td("Дата",75);
        parent::write_header_td("Статус",70);
        parent::write_header_td("Категория",70);
        //parent::write_header_td("Тип",70);
        //parent::write_header_td("Валюта",70);
	parent::write_header_td("Описание",300);
	parent::write_header_td("Сумма",70);
        //parent::write_header_td("В осн. вал.",70);
        parent::write_header_td("Остаток",70);
        echo "</tr>";
     }
     
     function writeTableRow($object, $linked_props)    {
        //echo "<tr>";
        //parent::write_td($object->getId(),25);
        parent::write_td("<nobr>".$this->uniStrToStrTime($object->fca_date, "Y-m-d h:i:s", "Y-m-d")."</nobr>",75);
        
        if($object->fca_status_id==$GLOBALS['draft_fca_status_id'])    {
            //parent::write_td("<nobr>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img alt=\"Черновик\" 
            //    src=\"images/one_bit/onebit_39.png\" style=\"width:16px;\"/>
            //    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</nobr>",70);
            parent::write_td("<nobr>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type=\"checkbox\" disabled />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</nobr>",70);
        }   
        //else if($object->fca_status_id==$GLOBALS['active_fca_status_id'])    {
            //parent::write_td("<nobr>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img alt=\"Рабочая\" 
            //    src=\"images/one_bit/onebit_24.png\" style=\"width:16px;\"/>
            //    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</nobr>",70);
        //}   
        else if($object->fca_status_id==$GLOBALS['conduct_fca_status_id'])    {
            //parent::write_td("<nobr>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img alt=\"Проведена\" 
            //    src=\"images/one_bit/onebit_23.png\" style=\"width:16px;\"/>
            //    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</nobr>",70);
            parent::write_td("<nobr>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type=\"checkbox\" checked=\"true\" disabled />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</nobr>",70);
        }   else    {
            parent::write_td("<nobr>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img 
                src=\"images/one_bit/onebit_37.png\" style=\"width:16px;\"/>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</nobr>",70);
        }
        
        parent::write_td((isset($object->relative_props['parent_category_name'])
                ?(strlen($object->relative_props['parent_category_name'])>0?
                $object->relative_props['parent_category_name']."/ ":""):"").
                $object->relative_props['category_name'],70);
        /*if($object->fca_operation_type_id==$GLOBALS['income_operation_type_id'])    {
            parent::write_td("<nobr>&nbsp;&nbsp;&nbsp;&nbsp;<img src=\"images/one_bit/onebit_31.png\" 
                style=\"width:16px;\"/>&nbsp;&nbsp;&nbsp;&nbsp;</nobr>",70);
        } else if($object->fca_operation_type_id==$GLOBALS['outcome_operation_type_id'])    {
            parent::write_td("<nobr>&nbsp;&nbsp;&nbsp;&nbsp;<img src=\"images/one_bit/onebit_32.png\" 
                style=\"width:16px;\"/>&nbsp;&nbsp;&nbsp;&nbsp;</nobr>",70);
        }  else if($object->fca_operation_type_id==$GLOBALS['complete_planned_debt_payment_operation_type_id'])    {
            parent::write_td("<nobr>&nbsp;&nbsp;&nbsp;&nbsp;<img src=\"images/one_bit/onebit_32.png\" 
                style=\"width:16px;\"/>&nbsp;&nbsp;&nbsp;&nbsp;</nobr>",70);
        }  else if($object->fca_operation_type_id==$GLOBALS['complete_planned_outcome_operation_type_id'])    {
            parent::write_td("<nobr>&nbsp;&nbsp;&nbsp;&nbsp;<img src=\"images/one_bit/onebit_32.png\" 
                style=\"width:16px;\"/>&nbsp;&nbsp;&nbsp;&nbsp;</nobr>",70);
        }  else if($object->fca_operation_type_id==$GLOBALS['inner_outcome_transfert_operation_type_id'])    {
            parent::write_td("<nobr>&nbsp;&nbsp;&nbsp;&nbsp;<img src=\"images/one_bit/onebit_30.png\" 
                style=\"width:16px;\"/>&nbsp;&nbsp;&nbsp;&nbsp;</nobr>",70);
        }  else if($object->fca_operation_type_id==$GLOBALS['inner_income_transfert_operation_type_id'])    {
            parent::write_td("<nobr>&nbsp;&nbsp;&nbsp;&nbsp;<img src=\"images/one_bit/onebit_28.png\" 
                style=\"width:16px;\"/>&nbsp;&nbsp;&nbsp;&nbsp;</nobr>",70);
        }  else    {
            parent::write_td("<nobr>&nbsp;&nbsp;&nbsp;&nbsp;<img src=\"images/one_bit/onebit_37.png\" 
                style=\"width:16px;\"/>&nbsp;&nbsp;&nbsp;&nbsp;</nobr>",70);
        }
         */
        
        /*if($object->fca_currency_id==$GLOBALS['rouble_currency_id'])  {
            parent::write_td("<nobr>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img alt=\"Рубли\" 
                src=\"images/currencies/100Rouble_black.png\" style=\"width:16px;\"/>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</nobr>",70);
        } else if($object->fca_currency_id==$GLOBALS['euro_currency_id'])  {
            parent::write_td("<nobr>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img alt=\"Евро\" 
                src=\"images/currencies/currency_euroblue.png\" style=\"width:16px;\"/>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</nobr>",70);
        } else if($object->fca_currency_id==$GLOBALS['dollar_currency_id'])  {
            parent::write_td("<nobr>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img alt=\"Доллар\" 
                src=\"images/currencies/currency_dollargreen.png\" style=\"width:16px;\"/>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</nobr>",70);
        } else    {
            parent::write_td("<nobr>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img 
                src=\"images/one_bit/onebit_37.png\" style=\"width:16px;\"/>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</nobr>",70);
        }*/
        
        /*if($object->fca_currency_id==$GLOBALS['rouble_currency_id'])  {
            parent::write_td("<nobr>руб.</nobr>",70);
        } else if($object->fca_currency_id==$GLOBALS['euro_currency_id'])  {
            parent::write_td("<nobr>EUR</nobr>",70);
        } else if($object->fca_currency_id==$GLOBALS['dollar_currency_id'])  {
            parent::write_td("<nobr>USD</nobr>",70);
        } else    {
            parent::write_td("<nobr>-</nobr>",70);
        }*/
        
	//parent::write_td($object->fca_actor_description,70);
        $not_null_currs = false;
        $not_null_currs = ($object->relative_props['purse_currency_id']!=null)&&
                ($object->fca_currency_id!=null);
        parent::write_td($object->fca_description,300);
        parent::write_td_with_style("<nobr>".number_format($object->fca_summ, 2, '.', ' ')."</nobr>",70,
                ($not_null_currs&&($object->relative_props['purse_currency_id']!=$object->fca_currency_id)?
                    "color:#00A4EA;"
                    :($object->relative_props['account_type']==1?"color:#7DC64A;":(
                        $object->relative_props['account_type']==0?"color:#e95555;":"")))."text-align:right;");
        /*parent::write_td_with_style("<nobr>".number_format($object->fca_summ*
                $this->getCurrencyRate($this->dbconnector, $object->fca_date, 
                        $object->fca_currency_id, 
                        (isset($_SESSION['default_currency_id'])?
                            ($_SESSION['default_currency_id']!=$GLOBALS['unknown_currency_id']?
                                $_SESSION['default_currency_id']:$GLOBALS['default_system_currency']):
                                $GLOBALS['default_system_currency'])
                        ), 2, '.', ' ')."</nobr>",70,
                        ($object->relative_props['account_type']==1?"color:#7DC64A;":(
                            $object->relative_props['account_type']==0?"color:#e95555;":"")));*/
        parent::write_td_with_style("<nobr>".number_format($object->relative_props['fca_moment_psumm'], 2, '.', ' ').
                "</nobr>",70,"text-align:right;");
     }
     
     function writeMobileTableHeader()  {
         echo "<table id=\"income_table\" border=\"0\" width=\"95%\">
             <tr><td>Дата</td><td>Контрагент</td><td>Описание</td><td>Сумма</td></tr>";
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
