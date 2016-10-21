<?php

/**
 * @author Poltarokov SP
 * @copyright 2011
 */

if (!defined("ABSOLUTE_PATH"))
    define("ABSOLUTE_PATH", dirname(__FILE__)."/../../");
 
require_once(constant("ABSOLUTE_PATH")."classes/table_adapters/table_adapter.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/table_adapters/table_adapter.interface.php");

class NewsTableAdapter extends TableAdapter  implements TableAdapterInterface  {
    
    function __construct($dbconnector, $table_name, 
        $class_name, $context_suffix=null, $environment_mode = null)    { 
        parent::__construct($dbconnector, "news", 
            $class_name, "news"); 
	$this->dict_header = "Новости";
        $this->id_field="news_id";
        //$this->strong_user_relative = true;
        $this->write_table_width=650;
        $this->custom_table_div_class = "panel_ligth_blue_gray";
        $this->part_capacity = 10;
        $this->fixed_table_width = false;
        
        $this->insert_instruction_template = "insert into news( `news_id`, `news_head`, `news_short`,
                `news_text`, `news_event_date`, `last_edit_date`, `author_name`) 
                VALUES( NULL, :news_head, :news_short, :news_text, :news_event_date, 
                :last_edit_date, :author_name);"; 
        $this->update_instruction_template = "update `category_dictionary` SET `category_name`=:category_name where `category_id`=:id;";
        $this->delete_instruction_template = "SET @dcount=0; call `delete_object_by_type` ('category', :id, @dcount);";
        $this->custom_order_clause = " order by news_id ASC ";
        $this->default_table_cell_spacing = 0;
        $this->default_table_cell_padding = 2;
        $this->link_filter_js_to_input_changes = true;
        $this->hide_filter_button = true;
        $this->use_pager_capacity_input = true;
        
        /*$category_ajax_detail_params = array("request_base"=>"index-ajax.php?desktop_mode",
            "result_container"=>"main_region", "id"=>"fca_category_id", "next_function"=>
            " function(next_ajx_function) { linkCalendar(); initAcc2(); initSort('FinanceActData_dict_table_account'); } ");
        $this->setAjaxDetailedParams($category_ajax_detail_params);
        
        if ($context_suffix!=null)  {
            $this->setActionTableRefreshJS(
            $this->generateSelectJSWithFilterWithNum
                    ("",0,$this->class_name.$context_suffix."_table_div",$context_suffix));
        }*/
        
    }
    
    function writeTable()   {
        $this->generateTable();
    }
    
    function writeInsertForm()  {
        
    }
}

?>
