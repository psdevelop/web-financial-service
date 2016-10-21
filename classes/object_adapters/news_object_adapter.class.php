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

class NewsObjectAdapter extends ObjectAdapter implements ObjectManipInterface  {
     //protected $foreigen_keys = array("person_type_id"=>"person_types");
     
     function __construct($table_name, $class_name)    {
        parent::__construct($table_name, $class_name, "dictionary_table_text", "dictionary_table_text");
        $this->foreigen_keys = array();
        //$this->foreigen_keys_filters = array("fca_currency_id"=>
        //    "( (currency_id={$GLOBALS['income_operation_type_id']}) OR 
        //    (currency_id={$GLOBALS['outcome_operation_type_id']}) )");
        $this->filter_values_keys = array();
        $this->fields_prev_text_array = array("id"=>"ID","news_head"=>"Заголовок новости",
            "news_short"=>"Краткий текст новости", "news_text"=>"Полный текст новости", 
            "news_event_date"=>"Дата события", "last_edit_date"=>"Дата последней правки", 
            "author_name"=>"Имя автора");
        $this->field_titles = array("id"=>"ID","news_head"=>"Заголовок новости",
            "news_short"=>"Краткий текст новости", "news_text"=>"Полный текст новости", 
            "news_event_date"=>"Дата события", "last_edit_date"=>"Дата последней правки", 
            "author_name"=>"Имя автора");
        $this->fields_width_array = array("id"=>10,"news_head"=>12, "news_short"=>13, 
            "news_event_date"=>16, "news_text"=>14, "last_edit_date"=>15,
            "author_name"=>15);
        $this->select_display_field = "news_short";
        $this->manip_form_template = "<table>
            <tr><td>***___news_event_date</td></tr><tr>
            <tr><td>***___author_name</td></tr>
            <tr><td>***___last_edit_date</td></tr>
            <td>***___news_head</td></tr>
            <tr><td>***___news_short</td></tr>
            <tr><td>***___news_text</td></tr>
            </table>";
        $this->hidden_keys = array("id"=>"hidden");
        //$this->date_time_fields = array("fca_date"=>"2011-22-09 00:00");
        $this->date_fields = array("news_event_date"=>"","last_edit_date"=>"");
        $this->with_button_clear_fields = array("fca_date"=>"2011-22-09 00:00");
        $this->text_area_fields = array("news_text"=>7);
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
        parent::write_header_td("Добавлена",75);
        parent::write_header_td("Автор",70);
        parent::write_header_td("Заголовок",75);
	parent::write_header_td("Краткое содержание",80);
        echo "</tr>";
     }
     
     function writeTableRow($object, $linked_props)    {
        //echo "<tr>";
        //parent::write_td($object->getId(),25);
        parent::write_td($object->news_event_date,75);
        parent::write_td($object->author_name,70); //last_edit_date 
        parent::write_td($object->news_head,75); //
        parent::write_td($object->news_short,80);
        
        //parent::write_td_with_style("<nobr>".number_format($object->relative_props['fca_moment_psumm'], 2, '.', ' ').
        //        "</nobr>",70,"text-align:right;");
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
