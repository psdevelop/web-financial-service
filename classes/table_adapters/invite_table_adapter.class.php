<?php

/**
 * @author Poltarokov SP
 * @copyright 2011
 */
 
require_once("classes/table_adapters/table_adapter.class.php");
require_once("classes/table_adapters/table_adapter.interface.php");

class InviteTableAdapter extends TableAdapter  implements TableAdapterInterface  {
    
    function __construct($dbconnector, $table_name, 
        $class_name, $context_suffix=null, $environment_mode = null)    { 
        parent::__construct($dbconnector, "invite", 
            $class_name, "invite"); 
	$this->dict_header = "Приглашения";
        $this->id_field="id";
        //$this->write_table_width = 300;
        //$this->add_update_procedure_name = ""; 
        $this->float_manip_forms_mode = true;
        $this->write_table_width=650;
        //$this->custom_table_div_class = "panel_ligth_blue_gray";
        $this->part_capacity = 10;
        $this->fixed_table_width = false;
        $this->default_table_cell_spacing = 0;
        $this->default_table_cell_padding = 2;
        $this->link_filter_js_to_input_changes = true;
        $this->hide_filter_button = true;
        $this->use_pager_capacity_input = true;
        
        $this->insert_instruction_template = "call `add_update_invite`( NULL,:category_name, :parent_category_id, :category_level, '{$_SESSION['user_id']}');"; 
        $this->update_instruction_template = "update `invite` SET `category_name`=:category_name where `category_id`=:id;";
        $this->delete_instruction_template = "SET @dcount=0; call `delete_object_by_type` ('invite', :id, @dcount);";
        $this->custom_order_clause = " order by id ASC ";
        //$this->custom_array_select_columns = " {$this->id_field} as id, 
        //    if(category_level<>0,CONCAT('&nbsp;&nbsp;&nbsp;&nbsp;',".$this->object_adapter->select_display_field."), 
        //        CONCAT('<b>[',{$this->object_adapter->select_display_field},']</b>')) as select_name ";
        //$this->no_back_border_color = true;
        //$this->no_use_tablesorter_class = true;
        //$this->custom_table_div_class = "";//left_menu_blue_gradient_hor";
        //$this->fixed_table_width = false;
        //$this->table_css_class = "left_menu_entity_table";
        
        //$category_ajax_detail_params = array("request_base"=>"index-ajax.php?desktop_mode",
        //    "result_container"=>"main_region", "id"=>"fca_category_id", "next_function"=>
        //    " function(next_ajx_function) { linkCalendar(); initAcc2(); initSort('FinanceActData_dict_table_account'); } ");
        //$this->setAjaxDetailedParams($category_ajax_detail_params);
        
        //if ($context_suffix!=null)  {
        //    $this->setActionTableRefreshJS(
        //    $this->generateSelectJSWithFilterWithNum
        //            ("",0,$this->class_name.$context_suffix."_table_div",$context_suffix));
        //}
        $this->no_use_tablesorter_class = true;
        $this->custom_table_div_class = "";//left_menu_blue_gradient_hor";
        $this->fixed_table_width = false;
        $this->table_css_class = "left_menu_entity_table";
        
    }
    
    function writeTable()   {
        $this->generateTable();
    }
    
    function writeInsertForm()  {
        
    }
}

?>
