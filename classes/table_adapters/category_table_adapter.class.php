<?php

/**
 * @author Poltarokov SP
 * @copyright 2011
 */
 
require_once("classes/table_adapters/table_adapter.class.php");
require_once("classes/table_adapters/table_adapter.interface.php");

class CategoryTableAdapter extends TableAdapter  implements TableAdapterInterface  {
    
    function __construct($dbconnector, $table_name, 
        $class_name, $context_suffix=null, $environment_mode = null)    { 
        $cat_view = "(select 
            `ctg`.`category_id` AS `category_id`,
            `ctg`.`category_name` AS `category_name`,
            `ctg`.`closed` AS `closed`,
            `ctg`.`parent_category_id` AS `parent_category_id`,
            `ctg`.`category_level` AS `category_level`,
            `ctg`.`user_id` AS `user_id` 
            ,`f_get_cat_summ`(`ctg`.`category_id`, '{$_SESSION['user_id']}') AS `cat_summ`  
        from 
            `category_dictionary` `ctg`) cview ";
        parent::__construct($dbconnector, "category_dictionary", 
            $class_name, "category_view"); 
	$this->dict_header = "Категории";
        $this->id_field="category_id";
        $this->write_table_width = 300;
        $this->add_update_procedure_name = ""; 
        $this->float_manip_forms_mode = true;
        $this->hide_header = true;
        $this->object_adapter->desk_list_table_mode = true;
        $this->strong_user_relative = true;
        $this->select_empty_user_id = true;
        $this->default_table_cell_spacing = 1;
        $this->default_table_cell_padding = 2;
        $this->insert_instruction_template = "call `add_update_category`( NULL,:category_name, :parent_category_id, :category_level, '{$_SESSION['user_id']}');"; 
        $this->update_instruction_template = "update `category_dictionary` SET `category_name`=:category_name where `category_id`=:id;";
        $this->delete_instruction_template = "SET @dcount=0; call `delete_object_by_type` ('category', :id, @dcount);";
        $this->custom_order_clause = " order by category_id ASC ";
        $this->custom_array_select_columns = " {$this->id_field} as id, 
            if(category_level<>0,CONCAT('&nbsp;&nbsp;&nbsp;&nbsp;',".$this->object_adapter->select_display_field."), 
                CONCAT('<b>[',{$this->object_adapter->select_display_field},']</b>')) as select_name ";
        $this->no_back_border_color = true;
        $this->no_use_tablesorter_class = true;
        $this->custom_table_div_class = "";//left_menu_blue_gradient_hor";
        $this->fixed_table_width = false;
        $this->table_css_class = "left_menu_entity_table";
        
        $category_ajax_detail_params = array("request_base"=>"index-ajax.php?desktop_mode",
            "result_container"=>"main_region", "id"=>"fca_category_id", "next_function"=>
            " function(next_ajx_function) { linkCalendar(); initAcc2(); initSort('FinanceActData_dict_table_account'); } ");
        $this->setAjaxDetailedParams($category_ajax_detail_params);
        
        if ($context_suffix!=null)  {
            $this->setActionTableRefreshJS(
            $this->generateSelectJSWithFilterWithNum
                    ("",0,$this->class_name.$context_suffix."_table_div",$context_suffix));
        }
        
    }
    
    function writeTable()   {
        $this->generateTable();
    }
    
    function writeInsertForm()  {
        
    }
}

?>
