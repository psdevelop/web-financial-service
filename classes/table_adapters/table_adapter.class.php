<?php

/**
 * @author Poltarokov SP
 * @copyright 2011
 */

if (!defined("ABSOLUTE_PATH"))
    define("ABSOLUTE_PATH", dirname(__FILE__)."/../../");
 
require_once(constant("ABSOLUTE_PATH")."classes/configuration.php");
require_once(constant("ABSOLUTE_PATH")."classes/dbconnector.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/object_collection.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/object_adapters/fca_data_object_adapter.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/object_adapters/purse_object_adapter.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/object_adapters/category_object_adapter.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/object_adapters/optype_object_adapter.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/object_adapters/currency_object_adapter.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/object_adapters/plan_object_adapter.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/object_adapters/plan_shedule_object_adapter.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/object_adapters/fca_status_object_adapter.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/object_adapters/purse_type_object_adapter.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/object_adapters/invite_object_adapter.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/object_adapters/news_object_adapter.class.php");
//require_once("classes/object_adapters/user_object_adapter.class.php");

abstract class TableAdapter extends Tools {
    protected $dbconnector;
    public $object_adapter;
    protected $strong_user_relative=false;
    protected $select_empty_user_id=false;
    protected $selectFilter="";
    protected $table_name;
    protected $id_field="id";
    public $class_name;
    public $short_name=null;
    protected $with_relative_view_name;
    public $detail_view_name = null;
    public $num_suffix="";
    public $default_panel_class="panel_brigness_green";
    public $default_panel_float_class="panel_green_float";
    public $default_table_cell_spacing = 2;
    public $default_table_cell_padding = 4;
    protected $custom_table_div_class=null;
    public $write_table_width=959;
    public $fixed_table_width = true;
    protected $float_manip_forms_mode=false;
    protected $include_custom_actions_in_float_window=false;
    protected $hide_filter_form=false;
    protected $hide_fast_edit_button=false;
    public $without_dict_header_mode = false;
    public $select_collection = array();
    public $base_filter = "(1=1)";
    protected $filters_array = array();
    public $filters_values = array();
    protected $filters_key_filters = array();
    public $values_filter_array = array();
    public $values_filter_values = array();
    public $detail_entities = array();
    protected $add_update_procedure_name;
    protected $insert_instruction_template;
    protected $update_instruction_template;
    protected $delete_instruction_template;
    protected $custom_order_clause=null;
    protected $part_capacity = 15;
    protected $current_select_collection_part;
    protected $current_part_num;
    protected $not_show_closed=true;
    protected $all_capacity=0;
    protected $linked_entities_keys = array();
    protected $dict_header = "---";
    protected $hide_header = false;
    protected $filter_values_select_keys = array();
    protected $linked_entities_names = array();
    protected $linked_form_heights = array();
    protected $inline_input_properties = array();
    protected $detail_info_template = null;
    protected $linked_detail_entities = array();
    protected $inline_props_template = null;
    protected $aobject_sequencies = array();
    protected $fast_manip_objects = array();
    protected $fast_manip_fields = array();
    protected $base64_encode_inline_props = array();
    protected $inline_select_filters=array();
    public $default_insert_session_params = array();
    public $default_fast_append_session_params = array();
    protected $inline_external_params = array();
    protected $inline_external_template = null;
    protected $custom_action_instructions = array();
    protected $custom_action_params = array();
    protected $record_actions = array();
    public $custom_hidden_form_fields = array();
    public $base_or_condition_params = array();
    protected $addit_fast_sql_template = "";
    protected $multi_addit_instructions = array();
    protected $group_by_expression = "";
    protected $aggregate_fields = array();
    protected $additional_fields = array();
    protected $detail_tadapters_params = array();
    public $entity_db_algorithms_settings = array();
    protected $inline_update_algorithm = null;
    protected $ajax_detail_params = array();
    protected $custom_array_select_columns = null;
    protected $no_back_border_color = false;
    protected $no_use_tablesorter_class = false;
    protected $table_css_class = "default_entity_table";
    protected $link_filter_js_to_input_changes = false;
    protected $hide_filter_button = false;
    protected $use_pager_capacity_input = false;
    protected $last_query_result_size = 0;
    protected $custom_sel_array_order_clause = null;
    protected $standart_action_criteries = array();
    protected $confirm_add_operation = false;
    protected $button_hints = array("insert"=>"Добавить", "edit"=>"Редактировать",
        "update"=>"Изменить", "delete"=>"Удалить");
    protected $last_table_gen_first_object = null;
    protected $last_table_gen_first_object_id = null;

    function __construct($dbconnector, $table_name, 
        $class_name, $with_relative_view_name)    {
        $this->dbconnector = $dbconnector;

        $this->table_name = $table_name;
        $this->class_name = $class_name;
        //echo "[".$this->class_name."]";
        $this->with_relative_view_name = $with_relative_view_name;
        $this->object_adapter = $this->getObjectAdapterInstance();
        $this->object_adapter->setDBConnector($dbconnector);
        $this->object_adapter->num_suffix = $this->num_suffix;
        $hidden_fields_keys = array_keys($this->custom_hidden_form_fields);
        foreach($hidden_fields_keys as $hidden_key) {
            if(!array_key_exists($hidden_key, 
                    $this->object_adapter->hidden_keys))   {
                $this->object_adapter->hidden_keys[$hidden_key]=
                        "hidden";
            }
        }
        //$this->part_capacity = 15;
        $this->current_part_num = 0;    
    }
    
    function getLastTableGetFirstObjectId()   {
        if (isset($this->last_table_gen_first_object))
        return $this->last_table_gen_first_object->getId();
        else
            return null;
    }
    
    function getLastTableGetFirstObject()   {
        return $this->last_table_gen_first_object;
    }
    
    function getButtonHint($hint_type)  {
        if (isset($this->button_hints[$hint_type]))   {
            return $this->button_hints[$hint_type];
        }
        else return  "";
    }
    
    function getMasterAdaptsRefreshJS() {
        return " try { master_refresh_{$this->class_name}{$this->num_suffix}(); } catch(e)  { }  ";
    } 
    
    function setPartCapacity($capacity) {
        $this->part_capacity = $capacity;
    }
    
    function setHideFastEditButton($hide_fast_edit_button)  {
        $this->hide_fast_edit_button = $hide_fast_edit_button;
    }
    
    function setAjaxDetailedParams($ajax_detail_params) {
        $this->ajax_detail_params = $ajax_detail_params;
        $this->object_adapter->setAjaxDetailedParams($ajax_detail_params);
    }
    
    function setActionTableRefreshJS($js_instruction)   {
        foreach($this->record_actions as $action)   {
            $action->setActionCompleteJS($js_instruction);
        }
    }
    
    function setActionsAjaxDetailedParams($ajax_detail_params) {
        foreach($this->record_actions as $action)   {
            $action->setAjaxDetailedParams($ajax_detail_params);
        }
    }
    
    function setActionsDetailAdaptersParams($tadapt_params) {
        foreach($this->record_actions as $action)   {
            $action->setDetailAdaptersParams($tadapt_params);
        }
    }
    
    function setPlanCalculatingAlgorithm($algorithm_name)   {
        $this->inline_update_algorithm = $algorithm_name;
    }
    
    function setHideFilterFormMode($hidden) {
        $this->hide_filter_form = $hidden;
    }

    function setCustomTableDivClass($class_name)    {
        $this->custom_table_div_class = $class_name;
    }
    
    function setDetailAdaptersParams($detail_tadapters_params)  {
        $this->detail_tadapters_params = $detail_tadapters_params;
        $this->object_adapter->setDetailAdaptersParams($detail_tadapters_params);
    }
    
    function setCustomSelectViewName($view_name)    {
        $this->with_relative_view_name = $view_name;
    }
    
    function setGroupExpression($group_expression)    {
        $this->group_by_expression = $group_expression;
    }
    
    function setAggregateFields($agg_fields)    {
        $this->aggregate_fields = $agg_fields;
    }
    
    function getAggregateExpression()   {
        $result = "";
        $agg_keys = array_keys($this->aggregate_fields);
        foreach($agg_keys as $agg_key)  {
            $result .= ", ".$this->aggregate_fields[$agg_key]." AS ".$agg_key;
        }
        return $result;
    }
    
    function setAdditionalFields($addit_fields)  {
        $this->additional_fields = $addit_fields;
    }
    
    function getAddFieldsExpression()   {
        $result = "";
        $addf_keys = array_keys($this->additional_fields);
        foreach($addf_keys as $addf_key)  {
            $result .= ", ".$this->additional_fields[$addf_key]." AS ".$addf_key;
        }
        return $result;
    }
    
    function assignNumSuffix($suffix)   {
        $this->num_suffix = $suffix;
        $this->object_adapter->num_suffix = $this->num_suffix;
    }
    
    function setFormsFloating($float_mode)  {
        $this->float_manip_forms_mode=$float_mode;
    }
    
    function acceptCustomHiddenKeys($custom_hidden_form_fields)  {
        $hidden_fields_keys = array_keys($custom_hidden_form_fields);
        foreach($hidden_fields_keys as $hidden_key) {
            if(!array_key_exists($hidden_key, 
                    $this->object_adapter->hidden_keys))   {
                $this->object_adapter->hidden_keys[$hidden_key]=
                        "hidden";
            }
        }
    }
    
    function acceptLocalFieldsNames($fields_names)  {
        $this->object_adapter->acceptLocalFieldsNames($fields_names);
    }
    
    function showCustomHiddenKeys($custom_showed_form_fields)  {
        $hidden_fields_keys = array_keys($custom_showed_form_fields);
        foreach($hidden_fields_keys as $hidden_key) {
            if(array_key_exists($hidden_key, 
                    $this->object_adapter->hidden_keys))   {
                unset($this->object_adapter->hidden_keys[$hidden_key]);
            }
        }
    }
    
    function getObjectAdapterInstance()    {
        $reflectionClass = new ReflectionClass($this->class_name."ObjectAdapter");
        return $reflectionClass->newInstanceArgs(array($this->table_name, $this->class_name));
    }
    
    function getJSONData($select_type = null)   {
        if(is_null($select_type)||($select_type==$GLOBALS['full_extract_type']))   {
            
        }
    }
    
    function getSelectQueryArray($select_type = null)    {
        return $this->dbconnector->query_both_to_array(
            "SELECT * FROM ".$this->with_relative_view_name." WHERE ( ".$this->base_filter." OR ".
		$this->getBaseFilterOrClause().") AND ".$this->getFilterWhereClauseWithoutOrParams().
                ($this->strong_user_relative?" AND ".($this->select_empty_user_id?
                " (ISNULL(user_id) OR (user_id=0) OR (user_id='{$_SESSION['user_id']}')) ":
                " (user_id='{$_SESSION['user_id']}') "):"").
                ($this->custom_order_clause==null?
                        " order by ".$this->id_field." desc ":
                        $this->custom_order_clause).";");
    }
    
    function selectWithRelative()   {
        $start_limit = 0+$this->part_capacity*$this->current_part_num;
        $end_limit = $this->part_capacity;
        
        $count = $this->dbconnector->query_both_to_array(
            "SELECT COUNT(*) result_size FROM ".$this->with_relative_view_name." WHERE ( ".$this->base_filter." OR ".
		$this->getBaseFilterOrClause().") AND ".$this->getFilterWhereClauseWithoutOrParams().
                ($this->strong_user_relative?" AND ".($this->select_empty_user_id?
                " (ISNULL(user_id) OR (user_id=0) OR (user_id='{$_SESSION['user_id']}')) ":
                " (user_id='{$_SESSION['user_id']}') "):"").
                ($this->custom_order_clause==null?
                        " order by ".$this->id_field." desc ":
                        $this->custom_order_clause).";");
        
        $this->last_query_result_size = $count[0]['result_size'];
        $this->all_capacity = $count[0]['result_size'];
                
        $rows=$this->dbconnector->query_both_to_array(
            "SELECT * FROM ".$this->with_relative_view_name." WHERE ( ".$this->base_filter." OR ".
		$this->getBaseFilterOrClause().") AND ".$this->getFilterWhereClauseWithoutOrParams().
                ($this->strong_user_relative?" AND ".($this->select_empty_user_id?
                " (ISNULL(user_id) OR (user_id=0) OR (user_id='{$_SESSION['user_id']}')) ":
                " (user_id='{$_SESSION['user_id']}') "):"").
                ($this->custom_order_clause==null?
                        " order by ".$this->id_field." desc ":
                        $this->custom_order_clause)." limit {$start_limit},{$end_limit};");
        //echo (
        //    "SELECT * FROM ".$this->with_relative_view_name." WHERE ".$this->base_filter." AND ".
        //        $this->getFilterWhereClause().";");
        //print_r($rows);
        //echo (
        //    "SELECT * FROM ".$this->with_relative_view_name." WHERE ".$this->base_filter." AND ".
        //        $this->getFilterWhereClause().";");
        if ($rows!=null)    {
            //$this->all_capacity = sizeof($rows);
            $this->select_collection = new ObjectCollection($this->class_name,$rows);
        }   else    {
            //$this->all_capacity = 0;
            $this->select_collection = array();
        }
        //$this->generateTablePartByNum($this->current_part_num);
    }
    
    function selectFullWithRelative()   {
        
        $rows=$this->dbconnector->query_both_to_array(
            "SELECT * FROM ".$this->with_relative_view_name." WHERE ".$this->base_filter." AND (closed<>1) AND ".
                $this->getFilterWhereClause().
                ($this->strong_user_relative?" AND ".($this->select_empty_user_id?
                " (ISNULL(user_id) OR (user_id=0) OR (user_id='{$_SESSION['user_id']}')) ":
                " (user_id='{$_SESSION['user_id']}') "):"").
                        ($this->custom_order_clause==null?
                        " order by ".$this->id_field." desc ":
                        $this->custom_order_clause).";");
        if ($rows!=null)    {
            $this->all_capacity = sizeof($rows);
            $this->select_collection = new ObjectCollection($this->class_name,$rows);
        }   else    {
            $this->all_capacity = 0;
            $this->select_collection = array();
        }
    }
    
    function selectFullWithRelativeGroupMode()   {
        $rows=$this->dbconnector->query_both_to_array(
            "SELECT *".$this->getAggregateExpression().$this->getAddFieldsExpression().
                " FROM ".$this->with_relative_view_name." WHERE ".$this->base_filter." AND (closed<>1) AND ".
                $this->getFilterWhereClause()." ".
                ($this->strong_user_relative?" AND ".($this->select_empty_user_id?
                " (ISNULL(user_id) OR (user_id=0) OR (user_id='{$_SESSION['user_id']}')) ":
                " (user_id='{$_SESSION['user_id']}') "):"").
                $this->group_by_expression);
        //print_r($rows);
        if ($rows!=null)    {
            $this->all_capacity = sizeof($rows);
            $this->select_collection = new ObjectCollection($this->class_name,$rows);
        }   else    {
            $this->all_capacity = 0;
            $this->select_collection = array();
        }
        
      return $rows;  
    }
    
    function selectFullWithRelativeWithoutFilters()   {
        $rows=$this->dbconnector->query_both_to_array(
            "SELECT * FROM ".$this->with_relative_view_name." WHERE ".$this->base_filter." AND (closed<>1) ".
                ($this->strong_user_relative?" AND ".($this->select_empty_user_id?
                " (ISNULL(user_id) OR (user_id=0) OR (user_id='{$_SESSION['user_id']}')) ":
                " (user_id='{$_SESSION['user_id']}') "):"").
                ($this->custom_order_clause==null?
                        " order by ".$this->id_field." desc ":
                        $this->custom_order_clause).";");
        if ($rows!=null)    {
            $this->all_capacity = sizeof($rows);
            $this->select_collection = new ObjectCollection($this->class_name,$rows);
        }   else    {
            $this->all_capacity = 0;
            $this->select_collection = array();
        }
    }
    
    function getSelectContentFullByFilter() {
        $rows=$this->dbconnector->query_both_to_array(
            "SELECT id, ".$this->object_adapter->select_display_field.
                " as select_name FROM ".$this->with_relative_view_name." WHERE ".$this->base_filter." AND ".
                $this->getFilterWhereClause().
                ($this->strong_user_relative?" AND ".($this->select_empty_user_id?
                " (ISNULL(user_id) OR (user_id=0) OR (user_id='{$_SESSION['user_id']}')) ":
                " (user_id='{$_SESSION['user_id']}') "):"").
                " order by id desc;");
        if ($rows!=null)    {
        }   else    {
            $rows = array();
        }
        array_unshift($rows, array("id"=>-1, 
                "select_name"=>"Не выбрано"));
        return $this->generate_select_content($rows, "id", "select_name");
    }
    
    function writeActionsForms()    {
        foreach($this->record_actions as $rec_action) {
            echo $rec_action->getAbstractActionFormHTML();
        }
        echo $this->getSlidePanelId( "id_actions_panel", 
                    "id_actions_handle", "actions_panel", 
                    "actions_handle", "images/button_hor.gif",40,122,0, "true", "bottom",
                    "<div id=\"object_actions_panel\"><div class=\"current_object_identity\"></div>
                    <div id=\"actions_container_{$this->class_name}\"></div></div>");
    }
    
    function writeActionsFormsWithoutSlide()    {
        foreach($this->record_actions as $rec_action) {
            echo $rec_action->getAbstractActionFormHTML();
        }
    }
    
    function writeActionsFormsExt($panel_class)    {
        foreach($this->record_actions as $rec_action) {
            echo $rec_action->getAbstractActionFormHTML();
        }
        echo $this->getSlidePanelId( "id_actions_panel", 
                    "id_actions_handle", $panel_class, 
                    "actions_handle", "images/button_hor.gif",40,122,0, "true", "bottom",
                    "<div id=\"object_actions_panel\"><div class=\"current_object_identity\"></div>
                    <div id=\"actions_container_{$this->class_name}\"></div></div>");
    }
    
    function writeActionsFormsWithSampleSlide()    {
        foreach($this->record_actions as $rec_action) {
            echo $rec_action->getAbstractActionFormHTML();
        }
        echo "<div id=\"slideout\">
                        <img src=\"images/button_hor.gif\" alt=\"Действия\" /><br/>
                        <div id=\"slideout_inner\"><div id=\"object_actions_panel\"><div class=\"current_object_identity\"></div>
                    <div id=\"actions_container_{$this->class_name}\"></div></div>
                    </div>
                     </div>";
    }
    
    function getListDivContentFullByFilter() {
        $rows=$this->selectFullWithRelative();
        $rows = $this->select_collection;
        $result_html = "<table border=\"0\" width=\"100%\">";
        $row_num = 0;
        foreach($this->select_collection as $list_object)   {
            $list_item_content = $this->object_adapter->getListItemRow($list_object);
            foreach($this->fast_manip_fields as $fast_field)    {
                $list_item_content = str_replace("***___FAST".$fast_field->adapter_class, 
                    $fast_field->getObjectHTML("link_button_small_default",$this->getFilterJSParams(),
                            //$this->getFilterJSParams(),
                            0,$list_object, $row_num),
                    $list_item_content);
            }
            $row_num++;
            $result_html .= $list_item_content;
        }
        $result_html .= "</table>";
        return $result_html;
    }
    
    function getContentJSByType($content_type, $js_params, $container)  {
        $content_params_keys = array_keys($js_params);
        $content_js = "";
        $index = 0;
        foreach ($content_params_keys as $content_params_key)   {
            if($index>0) $content_js .= ",";
            $content_js .= " {$content_params_key}:'{$js_params[$content_params_key]}'";
            
            $index++;
        }
        //echo "[".$content_js."]";
        if($content_type==$GLOBALS['active_cont_select_type'])
            return "ajaxGetRequest('".$GLOBALS['out_table_php']."', '{$this->class_name}', 
                '{$GLOBALS['get_sel_options_mode']}', { ".$content_js." },
                '0', '{$container}');";
        else if($content_type==$GLOBALS['active_list_div_type'])
            return "ajaxGetRequest('".$GLOBALS['out_table_php']."', '{$this->class_name}', 
                '{$GLOBALS['get_list_div_mode']}', { ".$content_js." },
                '0', '{$container}');";
        else
            return "";
    }
    
    function getManipJSByType($content_type, $js_params, $container, $filter_js_params, $part_num)  {
        $content_params_keys = array_keys($js_params);
        $content_js = "";
        $index = 0;
        foreach ($content_params_keys as $content_params_key)   {
            if($index>0) $content_js .= ",";
            $content_js .= " {$content_params_key}:'{$js_params[$content_params_key]}'";
            
            $index++;
        }
        if($content_type==$GLOBALS['fast_append_manip_type'])
            return " actionConfirm(function (action_function) { closeConfirm(); ajaxGetRequest('".$GLOBALS['add_update_delete_php']."', '{$this->class_name}', 
         '{$GLOBALS['fast_append_manip_mode']}', { ".$content_js." },
         '{$part_num}', '{$container}', { ".$filter_js_params." }); } );";
        else
            return "";
    }
    
    function getManipJSByTypeByObject($content_type, $js_params, $container, $filter_js_params, $part_num, $object)  {
        $content_params_keys = array_keys($js_params);
        $content_js = "";
        $index = 0;
        foreach ($content_params_keys as $content_params_key)   {
            if($index>0) $content_js .= ",";
            $content_js .= " {$content_params_key}:'{$object->$js_params[$content_params_key]}'";
            
            $index++;
        }
        if($content_type==$GLOBALS['fast_append_list_type'])
            return " actionConfirm(function (action_function) { closeConfirm(); ajaxGetRequest('".$GLOBALS['add_update_delete_php']."', '{$this->class_name}', 
         '{$GLOBALS['fast_append_manip_mode']}', { ".$content_js." },
         '{$part_num}', '{$container}', { ".$filter_js_params." }); } );";
        else
            return "";
    }
    
    function generateAObjectsHTML() {
        foreach($this->aobject_sequencies as $aobj_sequency)    {
           echo $aobj_sequency->getSequency();
        }
    }
    
    function generateFastManipHTML() {
        foreach($this->fast_manip_objects as $fast_object)    {
           $fast_object->getObjectHTML("",$this->getFilterJSParams(),0, null);
        }
    }
    
    function getArraysByKeys($key_array, $arrays_filters)    {
        $relative_fields_array = array();
        $select_fields_keys = array_keys($key_array);
        foreach ($select_fields_keys as $select_fields_key) {
            $class_name = $key_array[$select_fields_key];
            $reflectionClass = new ReflectionClass($class_name."TableAdapter");
            $SelectDictTAdapt = $reflectionClass->newInstanceArgs(array($this->dbconnector,
                "", $class_name));
            if (isset ($arrays_filters[$select_fields_key]))   {
                $SelectDictTAdapt->base_filter = 
                        $arrays_filters[$select_fields_key];
            }
            
            $relative_fields_array[$select_fields_key] = 
                $SelectDictTAdapt->getSelectArray();
        }
        return $relative_fields_array;
    }
    
    function getSelectArrays()  {
        return $this->getArraysByKeys($this->object_adapter->foreigen_keys, $this->object_adapter->foreigen_keys_filters);
    }
    
    function getSelectArraysWithoutParentLists($parent_lists)  {
        $parent_keys = array_keys($parent_lists);
        foreach($parent_keys as $parent_key)    {
            if (isset($this->object_adapter->foreigen_keys[$parent_lists[$parent_key]]))   {
                unset($this->object_adapter->foreigen_keys[$parent_lists[$parent_key]]);
            }
        }
        if (array_count_values($this->object_adapter->ids_array_fields)>0)
            return $this->getArraysByKeys( array_merge($this->object_adapter->foreigen_keys, 
                $this->object_adapter->ids_array_fields) , $this->object_adapter->foreigen_keys_filters);
        else
            return $this->getArraysByKeys( $this->object_adapter->foreigen_keys, 
                    $this->object_adapter->foreigen_keys_filters);
    }
    
    function getAllInlineJS($inline_props, $local_prop_suffix, $with_confirm, $object, $current_row_num, $complete_function)  {
        $inline_input_properties_keys = array_keys($inline_props);
        //print_r($inline_props);
        $local_js_params = " id:'id".$local_prop_suffix."'";
        foreach($inline_input_properties_keys as $inline_input_properties_key)    {
                          
                          if (array_key_exists($inline_input_properties_key, $object->getFullPropArray())) {
                            
                            $local_manip_id = $this->class_name."_local_".$inline_input_properties_key.
                                    $current_row_num."_div";
                            $local_js_params .= ",{$inline_input_properties_key}:'{$inline_input_properties_key}{$local_prop_suffix}' ";
                                                                
                          } else    {
                              echo "Не найдено свойства для встраиваемого поля";
                          }
                              
                      }
                      
                      if ($with_confirm)
                            $result_js = $this->generateLocalUpdateJSWithFilterWithExternalRefreshJS($this->class_name.$this->num_suffix."_part_num", 
                                        "{$local_manip_id}", "{$local_js_params}", $complete_function
                                        //$this->generateSelectJSWithFilter(
                                        //    "", $this->current_part_num, $this->class_name.$GLOBALS['dict_container_base'])
                                        );
                      else
                            $result_js = $this->generateLocalUpdateJSWithFilterWithExternalRefreshJSNoConfirm($this->class_name.$this->num_suffix."_part_num", 
                                        "{$local_manip_id}", "{$local_js_params}", $complete_function
                                        //$this->generateSelectJSWithFilter(
                                        //    "", $this->current_part_num, $this->class_name.$GLOBALS['dict_container_base'])
                                        );

                      return $result_js;
    }
    
    function getInlineForm($inline_props, $inline_props_template, $object, $show_buttons, 
            $local_prop_suffix, $current_row_num)   {
        $inline_input_properties_keys = array_keys($inline_props);
        //print_r($inline_props);
        $fullArrayedObject = $object->getFullPropArray();
        $inline_content = "";
        $inline_content .= $this->object_adapter->write_input_text_field_with_num(
                                    "id", 
                                    $fullArrayedObject['id'],$local_prop_suffix);
        foreach($inline_input_properties_keys as $inline_input_properties_key)    {
                          
                          if($inline_props_template==null)
                            $inline_content .= "<td>";
                          //echo $inline_input_properties_key."!!!!!!!!!!!!!!!!!";
                          //print_r($object->getFullPropArray());
                          //prop
                          
                          if (array_key_exists($inline_input_properties_key, $object->getFullPropArray())) {
                            
                           //;
                           if(isset($this->object_adapter->foreigen_keys[$inline_input_properties_key]))    {
                               $class_arrs = $this->getSelectArrays();
                               $inline_content .= $this->object_adapter->write_select_field_with_num(
                                    $inline_input_properties_key, 
                                    $class_arrs[$inline_input_properties_key],
                                    $local_prop_suffix);
                           }
                           else   
                             $inline_content .= $this->object_adapter->write_input_text_field_with_num_and_placement(
                                    $inline_input_properties_key, 
                                    $fullArrayedObject[$inline_input_properties_key],
                                    $local_prop_suffix, "vertical");
                            
                            $local_manip_id = $this->class_name."_local_".$inline_input_properties_key.
                                    $current_row_num."_div";
                            $inline_content .= "<div id={$local_manip_id}></div>";
                            if ($show_buttons)  {
                                $local_js_params = " id:'id".$local_prop_suffix.$inline_input_properties_key."',
                                    {$inline_input_properties_key}:'{$inline_input_properties_key}{$local_prop_suffix}' ";
                                $inline_content .= $this->get_link_button("Установить", "link_button_small_default",
                                    $this->generateLocalUpdateJSWithFilterWithExternalRefreshJS($this->class_name.$this->num_suffix."_part_num", 
                                        "{$local_manip_id}", "{$local_js_params}", 
                                        $this->generateSelectJSWithFilter(
                                            "", $this->current_part_num, $this->class_name.$GLOBALS['dict_container_base'])),
                                                $this->class_name."_local_upd_link_id");
                            }
                                    ////),
                                            
                                    
                          } else    {
                              $inline_content .= "Не найдено свойства для встраиваемого поля";
                          }
                          
                          if($this->inline_props_template==null)    {
                            $inline_content .= "</td>";
                            //echo $inline_content;
                          }
                          else $inline_template_modified = str_replace("***___".$inline_input_properties_key, 
                                    $inline_content,$inline_template_modified);
                              
                      }
                      
                      if($this->inline_props_template!=null)
                        return $inline_template_modified;
                      else
                          return $inline_content;
    }
    
    function getTableInlineForm($inline_props, $inline_props_template, $object, $show_buttons, 
            $local_prop_suffix, $current_row_num)   {
        $inline_input_properties_keys = array_keys($inline_props);
        //print_r($inline_props);
        $fullArrayedObject = $object->getFullPropArray();
        $inline_content = "";
        $inline_content .= $this->object_adapter->write_input_text_field_with_num(
                                    "id", 
                                    $fullArrayedObject['id'],$local_prop_suffix);
        foreach($inline_input_properties_keys as $inline_input_properties_key)    {
                          
                          if($inline_props_template==null)
                            $inline_content .= "<td>";
                          //echo $inline_input_properties_key."!!!!!!!!!!!!!!!!!";
                          //print_r($object->getFullPropArray());
                          //prop
                          
                          if (array_key_exists($inline_input_properties_key, $object->getFullPropArray())) {
                            
                             
                             $inline_content .= $this->object_adapter->write_input_text_field_with_num_and_placement(
                                    $inline_input_properties_key, 
                                    $fullArrayedObject[$inline_input_properties_key],
                                    $local_prop_suffix, "vertical");
                            
                            $local_manip_id = $this->class_name."_local_".$inline_input_properties_key.
                                    $current_row_num."_div";
                            $inline_content .= "<div id={$local_manip_id}></div>";
                            if ($show_buttons)  {
                                $local_js_params = " id:'id".$local_prop_suffix."',
                                    {$inline_input_properties_key}:'{$inline_input_properties_key}{$local_prop_suffix}' ";
                                $inline_content .= $this->get_link_button("Установить", "link_button_small_default",
                                    $this->generateLocalUpdateJSWithFilterWithExternalRefreshJS($this->class_name.$this->num_suffix."_part_num", 
                                        "{$local_manip_id}", "{$local_js_params}", 
                                        $this->generateSelectJSWithFilter(
                                            "", $this->current_part_num, $this->class_name.$GLOBALS['dict_container_base'])),
                                                $this->class_name."_local_upd_link_id");
                            }
                                    ////),
                                            
                                    
                          } else    {
                              $inline_content .= "Не найдено свойства для встраиваемого поля";
                          }
                          
                          if($this->inline_props_template==null)    {
                            $inline_content .= "</td>";
                            //echo $inline_content;
                          }
                          else $inline_template_modified = str_replace("***___".$inline_input_properties_key, 
                                    $inline_content,$inline_template_modified);
                              
                      }
                      
                      if($this->inline_props_template!=null)
                        return $inline_template_modified;
                      else
                          return $inline_content;
    }
    
    function getExtParamsForm($ext_props, $inline_external_template, $object, $show_buttons, 
            $local_prop_suffix, $current_row_num)   {
        $inline_ext_content = "";
        //if($inline_external_template==null)
        //    $inline_ext_content .= "<td>";
        $current_arrayed_object = $object->getFullPropArray();
        //print_r($current_arrayed_object);
        //$reflectionClass = new ReflectionClass($ext_class_name."TableAdapter");
        //$ExtDictTAdapt = $reflectionClass->newInstanceArgs(array($this->dbconnector,
        //    "", $ext_class_name));
        //$ext_link_prop = $this->inline_external_params['id'];
        //$local_prop_suffix = "ext_".$this->class_name.$ext_class_name.$current_row_num;
        $ext_props_keys = array_keys($ext_props);
        
        foreach($ext_props_keys as $ext_props_key)   { 
            if (array_key_exists($ext_props_key, $current_arrayed_object)) {
                            
                if ($ext_props[$ext_props_key]=="id")  
                    $inline_ext_content .= $this->object_adapter->
                        write_input_text_field_with_num_and_placement(
                            "id", 
                            $current_arrayed_object[$ext_props_key],
                            $local_prop_suffix, "vertical");
                else
                    $inline_ext_content .= $this->object_adapter->
                        write_input_text_field_with_num_and_placement(
                            $ext_props_key, 
                            $current_arrayed_object[$ext_props_key],
                            $local_prop_suffix, "vertical");
                            
            } else    {
                $inline_ext_content .= "Не найдено свойства для встраиваемого поля";
            }
        }
                                            
        //$inline_ext_content .= "</td>";
        return $inline_ext_content;
    }
    
    function getAllExtJS($ext_props, $local_prop_suffix, $with_confirm, $object, $current_row_num, 
            $complete_function, $local_manip_id)  {
        $ext_properties_keys = array_keys($ext_props);
        //print_r($inline_props);
        $local_js_params = "";
        $index = 0;
        foreach($ext_properties_keys as $ext_properties_key)    {
                          
            if (array_key_exists($ext_properties_key, $object->getFullPropArray())) {
                            
                if ($index>0) $local_js_params .= " , ";
                if ($ext_props[$ext_properties_key]=="id")
                    $local_js_params .= " {$ext_props[$ext_properties_key]}:'id".$local_prop_suffix."'";
                else
                    $local_js_params .= " {$ext_props[$ext_properties_key]}:'".$ext_properties_key.$local_prop_suffix."'";
                                
                $index++;
                            
            } else    {
                echo "Не найдено свойства для встраиваемого внешнего поля";
            }
                              
        }
                      
        if ($with_confirm)
            $result_js = $this->generateLocalUpdateJSWithFilterWithExternalRefreshJS($this->class_name.$this->num_suffix."_part_num", 
                "{$local_manip_id}", "{$local_js_params}", $complete_function);
        else
            $result_js = $this->generateLocalUpdateJSWithFilterWithExternalRefreshJSNoConfirm($this->class_name.$this->num_suffix."_part_num", 
                "{$local_manip_id}", "{$local_js_params}", $complete_function);

        return $result_js;
    }
    
    function generateMobileListTable($mobile_table_mode)	{
		if ($mobile_table_mode==$GLOBALS['mobile_list_table_mode'])	{
			echo "<ul id=\"{$this->class_name}data-listholder\" data-role=\"listview\" data-inset=\"true\">";
                        foreach( $this->select_collection as $current_object ):
				echo $this->object_adapter->getMobileListTableRow($current_object);
			endforeach;
                        echo "</ul>";
		}
                else if ($mobile_table_mode==$GLOBALS['mobile_table_mode'])	{
			$this->object_adapter->writeMobileTableHeader();
                        foreach( $this->select_collection as $current_object ):
				echo $this->object_adapter->getMobileTableRow($current_object);
			endforeach;
                        echo "</table>";
		}
		else	{
		}
	}
        
function setDefTableWidth($width)   {
    $this->write_table_width = $width;
}        
	
function generateTable()    {
        $linked_headers = array();
        $linked_rows = array();
        echo "<div class=\"".(($this->custom_table_div_class==null)?"dict_table_default":$this->custom_table_div_class)."\" style=\"".($this->fixed_table_width?"width:{$this->write_table_width}px;":"")."\">
            <span id=\"{$this->class_name}{$this->num_suffix}_table_top_anchor\"></span>
            <input type=\"hidden\" 
                id=\"".$this->class_name.$this->num_suffix."_part_num\" size=\"8\" 
                value=\"{$this->current_part_num}\" readonly>
                <input type=\"hidden\" 
                id=\"".$this->class_name.$this->num_suffix."_next_part_num\" size=\"8\" 
                value=\"".($this->current_part_num+1)."\" readonly>
            <table id=\"".$this->class_name.$GLOBALS['dict_table_base'].$this->num_suffix
            ."\" class=\"".($this->no_use_tablesorter_class?$this->table_css_class:"tablesorter")."\" 
            border=\"0\" cellspacing=\"{$this->default_table_cell_spacing}\" 
            cellpadding=\"{$this->default_table_cell_padding}\" 
            style=\" ".($this->no_back_border_color?"":
                "background-color: #ddd; border-color: #ddd;")." width:100%;\" >";
        if (!$this->hide_header) {
            echo "<thead>";
            $linked_headers['detail_headers'] = 
                $this->detail_entities;
            $this->object_adapter->writeTableHeader($linked_headers);
            echo "</thead>";
        }
        echo "<tbody>";
        if ($this->select_collection!=null) {
        //echo "Всего: ".sizeof($this->select_collection);
        $current_row_num = 0;    
        foreach( $this->select_collection as $current_object ): 
                  $current_row_num++;
                  
                  if ($current_row_num==1)  {
                      $this->last_table_gen_first_object = 
                            $current_object;
                      $this->last_table_gen_first_object_id = 
                            $current_object->getId();
                  }
                  $linked_rows = array();
                  $linked_rows['detail_rows'] = 
                    $this->getDetailRows($current_object);
                  if ((sizeof($this->linked_entities_keys)==0)&&
                          (sizeof($this->inline_input_properties)==0)&&
                          (sizeof($this->inline_external_params)==0)&&
                          (sizeof($this->record_actions)==0))
                    $this->object_adapter->writeTableRowFull($current_object, $linked_rows, $current_row_num);
                  else  {
                      $this->object_adapter->writeTableRowFullWithoutClosedTag($current_object, $linked_rows, $current_row_num);
                      $current_arrayed_object = $current_object->getFullPropArray();
                      //echo "<td>".$this->generateDetailInfo($current_object->getFullPropArray())."</td>";
                      
                      $inline_inputs = array();
                      $inline_template_modified = $this->inline_props_template;
                      $local_prop_suffix = $this->class_name.$current_row_num;
                      echo $this->getTableInlineForm($this->inline_input_properties, $this->inline_props_template,
                              $current_object, true, $local_prop_suffix, $current_row_num);
                      
                      $inline_external_properties_keys = array_keys($this->inline_external_params);
                      $inline_extinputs = array();
                      $inline_ext_template_modified = $this->inline_external_template;
                      foreach($inline_external_properties_keys as $inline_ext_properties_key)    {
                          $inline_ext_content = "";
                          if($this->inline_external_template==null)
                            $inline_ext_content .= "<td>";
                          //print_r($current_arrayed_object);
                          $ext_class_name = $inline_ext_properties_key;
                          $reflectionClass = new ReflectionClass($ext_class_name."TableAdapter");
                          $ExtDictTAdapt = $reflectionClass->newInstanceArgs(array($this->dbconnector,
                                "", $ext_class_name));
                          //$ext_link_prop = $this->inline_external_params['id'];
                          $ext_props = $this->inline_external_params[$inline_ext_properties_key];
                          $local_prop_suffix = "ext_".$this->class_name.$ext_class_name.$current_row_num;
                          $ext_props_keys = array_keys($ext_props);
                          $local_js_params = "";
                          $index = 0;
                          foreach($ext_props_keys as $ext_props_key)   { 
                                if (array_key_exists($ext_props_key, $current_arrayed_object)) {
                            
                                if ($ext_props[$ext_props_key]=="id")  
                                    $inline_ext_content .= $ExtDictTAdapt->object_adapter->
                                        write_input_text_field_with_num_and_placement(
                                    "id", 
                                    $current_arrayed_object[$ext_props_key],
                                    $local_prop_suffix, "vertical");
                                else
                                $inline_ext_content .= $ExtDictTAdapt->object_adapter->
                                        write_input_text_field_with_num_and_placement(
                                    $ext_props_key, 
                                    $current_arrayed_object[$ext_props_key],
                                    $local_prop_suffix, "vertical");
                            
                                if ($index>0) $local_js_params .= " , ";
                                if ($ext_props[$ext_props_key]=="id")
                                    $local_js_params .= " {$ext_props[$ext_props_key]}:'id".$local_prop_suffix."'";
                                else
                                $local_js_params .= " {$ext_props[$ext_props_key]}:'".$ext_props_key.$local_prop_suffix."'";
                                
                               //{$inline_input_properties_key}:'{$inline_input_properties_key}{$local_prop_suffix}' ";
                                $index++;
               
                                    
                                } else    {
                                    $inline_ext_content .= "Не найдено свойства для встраиваемого поля";
                                }
                          }
                          
                          $local_manip_id = $this->class_name.$ext_class_name."_ext_local_".
                                    $current_row_num."_div";
                          $inline_ext_content .= "<div id={$local_manip_id}></div>";
                          $inline_ext_content .= $this->get_link_button("Установить", "link_button_small_default",
                                    $ExtDictTAdapt->generateLocalUpdateJSWithFilterWithExternalRefreshJS($this->class_name.$this->num_suffix."_part_num", 
                                        "{$local_manip_id}", "{$local_js_params}", 
                                        $this->generateSelectJSWithFilter(
                                        "", $this->current_part_num, $this->class_name.$GLOBALS['dict_container_base'])),
                                            $this->class_name."_local_ext_upd_link_id");
                          
                          //if($this->inline_external_template==null)    {
                            $inline_ext_content .= "</td>";
                            echo $inline_ext_content;
                          //}
                          //else $inline_ext_template_modified = str_replace("***___".$inline_input_properties_key, 
                          //          $inline_content,$inline_ext_template_modified);
                              
                      }
                      
                      $linked_entities_keys = array_keys($this->linked_entities_keys);
                      foreach( $linked_entities_keys as $linked_entities_key )    {
                        $class_name = $linked_entities_key;
                        $linked_entity_name = "Связ. сущности";
                        if (isset($this->linked_entities_names[$linked_entities_key]))  {
                            $linked_entity_name = $this->linked_entities_names[$linked_entities_key];
                        }
                        $linked_form_height = 200;
                        if (isset($this->linked_form_heights[$linked_entities_key]))  {
                            $linked_form_height = $this->linked_form_heights[$linked_entities_key];
                        }
                        
                        $reflectionClass = new ReflectionClass($class_name."TableAdapter");
                        $SelectDictTAdapt = $reflectionClass->newInstanceArgs(array($this->dbconnector,
                            "", $class_name));
                        
                        $linked_object_key_array = $this->linked_entities_keys[$linked_entities_key];
                        //print_r($linked_object_key_array);
                        $SelectDictTAdapt->getSelfLinkedObjectForm($linked_object_key_array, 
                                $current_row_num,
                                $this->generateSelectJSWithFilter(
                                                "", $this->current_part_num, 
                                                $this->class_name.$GLOBALS['dict_container_base']),
                                $current_arrayed_object, $linked_form_height, $linked_entity_name);
                      }
                      
                      echo "<td  style=\"display:none;\"><div id=\"actions_{$this->class_name}{$current_row_num}\" 
                      style=\"display:none;\">
                      <table border=\"0\"><tr>";
                      foreach($this->record_actions as $rec_action) {
                          echo "<td>".$rec_action->getAbsActionButton($current_object)
                                  //getActionFormHTML($current_object, $current_row_num)
                                  ."</td>";
                      }
                      echo "</tr></table></div></td>";
                      
                      echo "</tr>";
                  }
                endforeach;
        }
        echo "</tbody></table>";
        
        //$this->writePager($this->class_name.$GLOBALS['dict_table_pager_base']);
        echo "</div>";
    }
    
    function writeTableExt($without_head, $desk_list_mode)   {
        $this->hide_header = $without_head;
        $this->object_adapter->desk_list_table_mode = $desk_list_mode;
        $this->generateTable();
    }
    
    function getCurrentSelectJSWithFilter() {
        return $this->generateSelectJSWithFilter(
                                                "", $this->class_name.$this->num_suffix."_part_num", 
                                                //$this->current_part_num, 
                                                $this->class_name.$GLOBALS['dict_container_base']);
    }
    
    function getExternalParamsObjectFrom($linked_object_key_array, $current_row_num, 
            $select_js, $current_arrayed_object, $linked_form_height, $linked_entity_name)  {
        return "";
    }
    
    function getSelfLinkedObjectForm($linked_object_key_array, $current_row_num, 
            $select_js, $current_arrayed_object, $linked_form_height, $linked_entity_name)  {
        $linked_object_keys = array_keys($linked_object_key_array);
        $linked_object = $this->object_adapter->getDataClassInstance();
                        foreach ($linked_object_keys as $linked_object_key) {
                            
                            $linked_arrayed_object = (array)$linked_object;
                            
                            $current_res_div = $this->class_name.$current_row_num;
                            $current_res_div .= $linked_object_key_array[$linked_object_key]."_res_div";
                            if (isset($current_arrayed_object[$linked_object_key]))  {
                                if (array_key_exists($linked_object_key, $linked_arrayed_object))   {
                                    $linked_object_relative_key = $linked_object_key_array[$linked_object_key];
                                    
                                    $linked_object->$linked_object_relative_key = 
                                       $current_arrayed_object[$linked_object_key];
                                    $elm_suffix = $this->class_name.$current_row_num;
                                    echo "<td style=\"width:70px;\">";
                                    //echo "<div class=\"panel\"><a class=\"handle\" 
                                    //    href=\"\">Не работают JS</a><h3><span lang=\"ru\">
                                    //    Заголовок</span></h3><br><span lang=\"ru\">";
                                    echo "<span id=\"anchor_{$elm_suffix}\"></span>
                                        <p class=\"slide\"><div id=\"{$elm_suffix}_panel_btn\" class=\"hidden_panel\" 
                                        style=\"height: {$linked_form_height}px;\">";
                                    $this->object_adapter->writeInsertEditFormWithNum(
                                            $linked_object,$this->
                                            getSelectArraysWithoutParentLists($linked_object_key_array),
                                            $elm_suffix);
                                    echo "<div id=\"{$current_res_div}\"></div>";
                                    $this->generate_link_button("Добавить", "link_button_small_default",
                                        $this->generateInsertJSWithFilterWithExternalRefreshJS(0,
                                        $current_res_div,
                                        $select_js,$elm_suffix),
                                        $this->class_name."_add_link_id");
                                    
                                    echo "</div><a id=\"{$elm_suffix}_btn\" href=\"#anchor_{$elm_suffix}\" 
                                    class=\"btn-slide\" onclick=\" $('#{$elm_suffix}_panel_btn').
                                        slideToggle('slow'); $(this).toggleClass('active'); \">
                                        {$linked_entity_name}</a></p>";
                                    //echo "</span></div>"; 
                                    echo "</td>";
                                    
                                }   else    {
                                echo "В привязываемом объекте нет привязываемого поля ".$linked_object_key."!";
                                }
                            }   else    {
                                echo "В текущем объекте нет привязываемого поля ".$linked_object_key.", или оно пустое!";
                            }
                        }
    }
    
    function generateDictHeader()   {
        echo "<div class=\"dict_header_default\">Таблица: <b><span style=\"font-size:14px;\">{$this->dict_header}</span></b>. ".
                " Часть: ".($this->current_part_num+1)." [".
                        ($this->part_capacity*$this->current_part_num+1)." - ".
                        (($this->part_capacity*$this->current_part_num)+$this->part_capacity)."] <!--<input type=\"hidden\" 
                id=\"".$this->class_name.$this->num_suffix."_part_num\" size=\"8\" 
                value=\"{$this->current_part_num}\" readonly>--></div>";
    }
    
    function generateDictHeaderWithNum()   {
        echo "<div class=\"dict_header_default\"><b><span style=\"font-size:14px;\">{$this->dict_header}</span></b>. ".
                "Всего: {$this->all_capacity}. Часть: ".($this->current_part_num+1)." [".
                        ($this->part_capacity*$this->current_part_num+1)." - ".
                        (($this->part_capacity*$this->current_part_num)+$this->part_capacity)."] 
                </div>";
    }
    
    function generateReportDictHeader()   {
        echo "<div class=\"dict_header_default\">Таблица: <b><span style=\"font-size:14px;\">{$this->dict_header}</span></b>. ".
                " Всего: ".sizeof($this->select_collection).". <input type=\"hidden\" 
                id=\"".$this->class_name.$this->num_suffix."_part_num\" size=\"8\" 
                value=\"{$this->current_part_num}\" readonly></div>";
    }
    
    function generateDictDetail()   {
        echo "<br/><br/>Подчиненные таблицы:<div id=\"".$this->class_name."_detail_container"."\" class=\"dict_detail_default\"></div>";
    }
    
    function getDetailHeaders() {
        
    }
    
    function getDetailRows($object)    {
        $row_details_links = array();
        $detail_keys = array_keys($this->detail_entities);
        foreach ($detail_keys as $detail_key)   {
            $reflectionClass = new ReflectionClass($detail_key."TableAdapter");
            $DictTAdapt = $reflectionClass->newInstanceArgs(array($this->dbconnector,
                "",$detail_key));
            //if (isset(
            $values_filters_keys = array_keys($DictTAdapt->values_filter_values);
            foreach ($values_filters_keys as $values_filters_key)   {
                $DictTAdapt->values_filter_values[$values_filters_key] = null;
            }
            $DictTAdapt->filters_values[$this->detail_entities[$detail_key]['detail_id']] = 
                $object->getId();//[$this->detail_entities[$detail_key]['master_id']];
            $row_details_links[$detail_key."_".$this->detail_entities[$detail_key]['detail_id']] = 
                    array ("name"=>$this->detail_entities[$detail_key]['detail_header'],
                        "jscript"=>$DictTAdapt->generateSelectJSWithFilterTAdaptParams
                            ("",0,$this->class_name."_detail_container"));
            
        }
        //print_r($row_details_links);
        return $row_details_links;
    }
    
    function generateCurrentTablePart()   {
        //$this->current_select_collection_part 
        $start_pos = $this->part_capacity*$this->current_part_num;
        $select_limit = $this->part_capacity;
        //echo $this->all_capacity."sssss";
        if($this->all_capacity<($start_pos+1)) {
            $this->select_collection = array();
        } else {
            //if ((($this->all_capacity - $start_pos)/$this->part_capacity)>0)    {
            //    $select_limit = $this->part_capacity;
            //}
            //else
            //    $select_limit = (($this->all_capacity - $start_pos)%$this->part_capacity);
            
            //print_r($this->select_collection);
            //echo sizeof($this->select_collection)."wwwww".$select_limit;
            $this->select_collection = new LimitIterator($this->select_collection, 
                $start_pos, $select_limit);
            //echo sizeof($this->select_collection)."wwwww";
        }
            
    }
    
    function generateTablePartByNum($part_num)  {
        $this->current_part_num = $part_num;
        $this->generateCurrentTablePart();
    }
	
	function getBaseFilterOrClause()	{
		$counter = 0;
		$out = " (1=0) ";
		$or_values_filter_keys = array_keys($this->base_or_condition_params);
		if ((sizeof($this->base_or_condition_params)>0))	{
			$out = " ( ";
			
			foreach($or_values_filter_keys as $or_values_filter_key)    {
            
            if($counter>0)  {
                $out.=" OR ";
            }
            
            if (isset($this->values_filter_array[$or_values_filter_key]))  {
                if (($this->values_filter_values[$or_values_filter_key]!=null)&&
                        ($this->values_filter_values[$or_values_filter_key]!="null")&&
                        ($this->values_filter_values[$or_values_filter_key]!=-1)&&
                        ($this->values_filter_values[$or_values_filter_key]!="-1"))   {
                    
                    if ($this->values_filter_array[$or_values_filter_key]!=
                             str_replace("***___".$or_values_filter_key,
                             $this->values_filter_values[$or_values_filter_key], 
                             $this->values_filter_array[$or_values_filter_key]))
                    $out.=(" (".str_replace("***___".$or_values_filter_key,
                             $this->values_filter_values[$or_values_filter_key], 
                             $this->values_filter_array[$or_values_filter_key]).") ");
                    else $out.=" (1=0) ";    
                }
                else $out.=" (1=0) ";
            }
                else $out.=" (1=0) ";
            
            $counter++;
			}
			
			$out .= " ) ";
		}
		return $out;
	}
    
    function getFilterWhereClause()   {
        $counter = 0;
        if ($this->not_show_closed)
            $out = "(closed<>1)";
        else
            $out = "(1=1)";
        $filter_keys = array_keys($this->filters_array);
        $values_filter_keys = array_keys($this->values_filter_array);
        if ((sizeof($this->filters_array)>0)||(sizeof($this->values_filter_array)>0)) {
            
        if ($this->not_show_closed)
            $out = "(closed<>1) AND (";
        else
            $out = "(";
            
        foreach($filter_keys as $filter_key)    {
            
            if($counter>0)  {
                $out.=" AND ";
            }
            
			if (isset($this->filters_values[$filter_key]))  {
                if (($this->filters_values[$filter_key]!=null)&&
                        ($this->filters_values[$filter_key]!="null")&&
                        ($this->filters_values[$filter_key]!=-1)&&
                        ($this->filters_values[$filter_key]!="-1"))   {
                    
                    $out.=(" (".$filter_key."=".$this->filters_values[$filter_key].") ");
                }
                else $out.=" (1=1) ";
            }
                else $out.=" (1=1) ";
            
            $counter++;
        }
        
        foreach($values_filter_keys as $values_filter_key)    {
            
            if($counter>0)  {
                $out.=" AND ";
            }
            
			if (isset($this->values_filter_values[$values_filter_key]))  {
                if (($this->values_filter_values[$values_filter_key]!=null)&&
                        ($this->values_filter_values[$values_filter_key]!="null")&&
                        ($this->values_filter_values[$values_filter_key]!=-1)&&
                        ($this->values_filter_values[$values_filter_key]!="-1"))   {
                    
                    if ($this->values_filter_array[$values_filter_key]!=
                             str_replace("***___".$values_filter_key,
                             $this->values_filter_values[$values_filter_key], 
                             $this->values_filter_array[$values_filter_key]))
                    $out.=(" (".str_replace("***___".$values_filter_key,
                             $this->values_filter_values[$values_filter_key], 
                             $this->values_filter_array[$values_filter_key]).") ");
                    else $out.=" (1=1) ";    
                }
                else $out.=" (1=1) ";
            }
                else $out.=" (1=1) ";
            
            $counter++;
        }
        
        $out .= ")";
        
        }
        
        //echo $out;
            
        return $out;
    }
    
    function getFilterWhereClauseWithoutOrParams()   {
        $counter = 0;
        if ($this->not_show_closed)
            $out = "(closed<>1)";
        else
            $out = "(1=1)";
        $filter_keys = array_keys($this->filters_array);
        $values_filter_keys = array_keys($this->values_filter_array);
        if ((sizeof($this->filters_array)>0)||(sizeof($this->values_filter_array)>0)) {
            
        if ($this->not_show_closed)
            $out = "(closed<>1) AND (";
        else
            $out = "(";
            
        foreach($filter_keys as $filter_key)    {
            
            if($counter>0)  {
                $out.=" AND ";
            }
            
            if(!isset($this->base_or_condition_params[$filter_key]))	{
			if (isset($this->filters_values[$filter_key]))  {
                if (($this->filters_values[$filter_key]!=null)&&
                        ($this->filters_values[$filter_key]!="null")&&
                        ($this->filters_values[$filter_key]!=-1)&&
                        ($this->filters_values[$filter_key]!="-1"))   {
                    
                    $out.=(" (".$filter_key."=".$this->filters_values[$filter_key].") ");
                }
                else $out.=" (1=1) ";
            }
                else $out.=" (1=1) ";
			}
				else $out.=" (1=1) ";
            
            $counter++;
        }
        
        foreach($values_filter_keys as $values_filter_key)    {
            
            if($counter>0)  {
                $out.=" AND ";
            }
            
            //echo "!!!".$values_filter_key;
			if(!array_key_exists($values_filter_key, $this->base_or_condition_params))	{
			if (isset($this->values_filter_values[$values_filter_key]))  {
                if (($this->values_filter_values[$values_filter_key]!=null)&&
                        ($this->values_filter_values[$values_filter_key]!="null")&&
                        ($this->values_filter_values[$values_filter_key]!=-1)&&
                        ($this->values_filter_values[$values_filter_key]!="-1"))   {
                    
                    if ($this->values_filter_array[$values_filter_key]!=
                             str_replace("***___".$values_filter_key,
                             $this->values_filter_values[$values_filter_key], 
                             $this->values_filter_array[$values_filter_key]))
                    $out.=(" (".str_replace("***___".$values_filter_key,
                             $this->values_filter_values[$values_filter_key], 
                             $this->values_filter_array[$values_filter_key]).") ");
                    else $out.=" (1=1) ";    
                }
                else $out.=" (1=1) ";
            }
                else $out.=" (1=1) ";
			}
				else $out.=" (1=1) ";
            
            $counter++;
        }
        
        $out .= ")";
        
        }
        
        //echo $out;
            
        return $out;
    }
    
    function prepareFilterArray($params)    {
        if (isset($params['part_num'])) {
            $this->current_part_num = (int)$params['part_num'];
            //echo $this->current_part_num."sssss";
        }
        
        $param_keys = array_keys($params);
        foreach($param_keys as $param_key)  { 
            //echo "sss";
            if (array_key_exists($param_key, $this->filters_values))  {
                
                $this->filters_values[$param_key] = $params[$param_key];
            }
            
            if (array_key_exists($param_key, $this->values_filter_values))  {
                
                $this->values_filter_values[$param_key] = $params[$param_key];
            }
        }
    }
    
    function prepareCustomActionParamArray($action_name, $params) {
        if(array_key_exists($action_name, $this->custom_action_instructions)&&
                array_key_exists($action_name, $this->custom_action_params))    {
            
        }   else {
            echo "Не обнаружено соответствующего действия или его параметров!";
            return null;
        }
    }
    
    function getFilterJSParams()    {
        $counter = 0;
        $out = "";
        $filter_keys = array_keys($this->filters_array);
        foreach($filter_keys as $filter_key)    {
            if($counter>0)  {
                $out.=", ";
            }
            
            $out.=($filter_key.":'".$this->class_name."_filt_".$filter_key."'");
            
            $counter++;
        }
        
        $filter_keys = array_keys($this->values_filter_array);
        foreach($filter_keys as $filter_key)    {
            if($counter>0)  {
                $out.=", ";
            }
            
            $out.=($filter_key.":'".$this->class_name."_filt_".$filter_key."'");
            
            $counter++;
        }
        
        return $out;
    }
    
    function getFilterJSTAdaptParams()    {
        $counter = 0;
        $out = "";
        $filter_keys = array_keys($this->filters_values);
        foreach($filter_keys as $filter_key)    {
            if($counter>0)  {
                $out.=", ";
            }
            
            $out.=($filter_key.":'".$this->filters_values[$filter_key]."'");
            
            $counter++;
        }
        
        $filter_keys = array_keys($this->values_filter_values);
        foreach($filter_keys as $filter_key)    {
            if($counter>0)  {
                $out.=", ";
            }
            
            $out.=($filter_key.":'".$this->values_filter_values[$filter_key]."'");
            
            $counter++;
        }
        
        return $out;
    }
    
    function getFiltersArrays() {
        //print_r($this->filters_array);
        //print_r(array_merge ($this->filters_array, 
        //            $this->filter_values_select_keys));
        if (sizeof($this->filter_values_select_keys)==0)
            $db_filters_array = $this->getArraysByKeys($this->filters_array, $this->filters_key_filters);
        else
            $db_filters_array = $this->getArraysByKeys(array_merge ($this->filters_array, 
                    $this->filter_values_select_keys), $this->filters_key_filters);
        $filter_keys = array_keys($db_filters_array);
        $modified_filter_array = array();
        foreach($filter_keys as $filter_key)    {
            array_unshift($db_filters_array[$filter_key], array("id"=>-1, 
                "select_name"=>"Нет"));
            $modified_filter_array[$this->class_name."_filt_".$filter_key] = 
                $db_filters_array[$filter_key];    
        }
        //print_r($db_filters_array);
        return $modified_filter_array;
    }
    
    function getValuesFilterArray() {
        $filter_keys = array_keys($this->values_filter_values);
        $modified_filter_array = array();
        foreach($filter_keys as $filter_key)    {
            $modified_filter_array[$this->class_name."_filt_".$filter_key] = 
                $this->values_filter_values[$filter_key];    
        }
        //print_r($db_filters_array);
        return $modified_filter_array;
    }
    
    function resetAllFilters()  {
        $this->base_filter = " (closed<>1) ";
        
        reset($this->filters_values);
        while (list ($key, $val) = each ($this->filters_values) ) :
            $this->filters_values[$key]=null;
        endwhile;
        
        reset($this->values_filter_values);
        while (list ($key, $val) = each ($this->values_filter_values) ) :
            $this->values_filter_values[$key]=null;
        endwhile;
        //print_r($this->filters_values);
        //print_r($this->values_filter_values);
    }
    
    function generateFiltersForm($filtered_object_container)  {
        
        echo "<div id=\"dict_filter_form\" class=\"filter_form_default\">";
        if ((sizeof($this->filters_array)>0)||(sizeof($this->values_filter_array)>0)) {
        $this->object_adapter->writeFilterFormWithValues($this->getFiltersArrays(), 
                $this->getValuesFilterArray(), array_merge($this->filters_values, $this->values_filter_values));
        $this->generate_link_button("Применить фильтр", "link_button_default",
            $this->generateSelectJSWithFilter("", 0, $filtered_object_container),$this->class_name."_filter_link_id");
        }
        else
            echo "Нет параметров фильтрации";
        echo "</div>";
        
    }
    
    function generateFiltersFormWithNum($filtered_object_container, $current_num)  {
        
        echo "<div id=\"dict_filter_form\" class=\"filter_form_default\" style=\"
            ".($this->hide_filter_form?"display:none;":"")."\">";
        if ((sizeof($this->filters_array)>0)||(sizeof($this->values_filter_array)>0)) {
        $filter_js = $this->generateSelectJSWithFilterWithNum("", 0, $filtered_object_container, $current_num);
        $this->object_adapter->writeFilterFormWithValuesWithNum($this->getFiltersArrays(), 
                $this->getValuesFilterArray(), array_merge($this->filters_values, $this->values_filter_values), $this->class_name.$current_num,
                ($this->link_filter_js_to_input_changes?array("onChange"=>$filter_js,"onKeyDown"=>$filter_js):null));
        if (!$this->hide_filter_button)
            $this->generate_link_button("Применить фильтр", "button medium blue",
                $this->generateSelectJSWithFilterWithNum("", 0, $filtered_object_container, $current_num),$this->class_name."_filter_link_id",$current_num);
        }
        else
            echo "Нет параметров фильтрации";
        echo "</div>";
        
    }
    
    function generateCustomFiltersForm($filtered_object_container, $select_mode, $action_caption, $report_class, $report_name=null)  {
        
        echo "<div id=\"dict_filter_form\" class=\"filter_form_default\">";
        if ((sizeof($this->filters_array)>0)||(sizeof($this->values_filter_array)>0)) {
        $this->object_adapter->writeFilterFormWithValues($this->getFiltersArrays(), 
                $this->getValuesFilterArray(), array_merge($this->filters_values, 
                $this->values_filter_values));
        $this->generate_link_button($action_caption, "button blue",
            $this->generateSelectJSWithFilterAndModeAndRepClass("", 0, $filtered_object_container, 
                    $select_mode, $report_class, $report_name),
                $this->class_name."_filter_link_id");
        }
        else
            echo "Нет параметров фильтрации";
        echo "</div>";
        
    }
    
    function generateSelectJSWithFilterAndModeAndRepClass($filter, $load_indicator_id, $result_container_id, 
            $select_mode, $report_class, $report_name)    {
        return "ajaxGetRequest('".$GLOBALS['out_table_php']."', '{$report_class}', 
         '{$select_mode}', { ".$this->getFilterJSParams()." , report_name:'{$report_name}' },
         '{$load_indicator_id}', '{$result_container_id}');";
    }
    
    function generatePagerForm($pager_object_container)  {
        
        echo "<div id=\"dict_pager_form\" class=\"pager_form_default\">";
        //if (sizeof($this->filters_array)>0) {
        //$this->object_adapter->writeFilterForm($this->getFiltersArrays(), $this->getValuesFilterArray());
        //echo $this->current_part_num;
        $this->generate_link_button("Первые ".$this->part_capacity, "link_button_default",
            $this->generateSelectJSWithFilter("", 0, $pager_object_container),$this->class_name."_first_page_link_id");
        if ($this->current_part_num-1>=0)   {
            $this->generate_link_button("Пред. ".$this->part_capacity, "link_button_default",
                $this->generateSelectJSWithFilter("", $this->current_part_num-1, $pager_object_container),$this->class_name."_prev_page_link_id");
        }
        $this->generate_link_button("След. ".$this->part_capacity, "link_button_default",
            $this->generateSelectJSWithFilter("", $this->current_part_num+1, $pager_object_container),$this->class_name."_next_page_link_id");
        //}
        //else
        //    echo "Нет параметров фильтрации";
        echo "</div>";
        
    }
    
    function generatePagerFormWithNum($pager_object_container, $current_num)  {
        
        echo "<div id=\"dict_pager_form\" class=\"pager_form_default\">";
        //if (sizeof($this->filters_array)>0) {
        //$this->object_adapter->writeFilterForm($this->getFiltersArrays(), $this->getValuesFilterArray());
        //echo $this->current_part_num;
        echo "<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\"><tr><td>";
        $this->generate_link_button("<img src=\"images/one_bit/onebit_29.png\" style=\"width:17px;\" />", "button small blue",
            $this->generateSelectJSWithFilterWithNum("", 0, $pager_object_container, $current_num),
            $this->class_name."_first_page_link_id", "Вернуться к первой порции операций");
        echo "</td>";
        if ($this->current_part_num-1>=0)   {
            echo "<td>";
            $this->generate_link_button("Пред. ".$this->part_capacity, "button small blue",
                $this->generateSelectJSWithFilterWithNum("", 
                        $this->current_part_num-1, $pager_object_container, $current_num),
                $this->class_name."_prev_page_link_id", "Предыдущая порция операций");
        
            echo "</td>";
        }
        if ($this->use_pager_capacity_input)    {
            echo "<td>";
            echo "<input id=\"page_capacity_input_{$this->class_name}{$this->num_suffix}\" 
                type=\"text\" value=\"{$this->part_capacity}\" style=\"width:30px;text-align:center;\" 
                onkeydown=\" if(event.keyCode==13) { ".
                $this->generateSelectJSWithFilterWithNum("", $this->class_name.$this->num_suffix."_part_num", $pager_object_container, $current_num)." } \" 
                title=\"Размер извлекаемой порции операций\"    />";
            echo "</td>";
        }
        echo "<td>";
        $this->generate_link_button("<img src=\"images/one_bit/onebit_27.png\" style=\"width:17px;\" />", "button small blue",
            $this->generateSelectJSWithFilterWithNum("", 
                    $this->class_name.$this->num_suffix."_next_part_num", 
                    $pager_object_container, $current_num),
            $this->class_name."_next_page_link_id", "Следующая порция операций");
        echo "</td>";
        echo "</tr></table>";
        //}
        //else
        //    echo "Нет параметров фильтрации";
        echo "</div>";
        
    }
    
    function generateInsertForm() {
        echo "<div id=\"dict_manip_form\" class=\"manip_form_default\">
            <div class=\"current_object_identity\"></div>";
        $this->object_adapter->writeInsertEditForm(null,$this->getSelectArrays());
        $this->write_div("dict_table_manip_res_div","","");
        echo "<br/>";
        $this->generate_link_button("Добавить", "link_button_default",
            $this->generateInsertJSWithFilter(0, "dict_table_manip_res_div", ""),$this->class_name."_add_link_id");
        $this->generate_link_button_with_style("Изменить", "change_button_default",
            $this->generateUpdateJSWithFilter($this->class_name.$this->num_suffix."_part_num", "dict_table_manip_res_div", ""),
            $this->class_name."_upd_link_id", "visibility: hidden;");
        if ($_SESSION['enable_deleting'])
            $this->generate_link_button_with_style("Удаление", "change_button_default",
                $this->generateDeleteJSWithFilter($this->class_name.$this->num_suffix."_part_num", "dict_table_manip_res_div", ""),
                    $this->class_name."_del_link_id", "visibility: hidden;");
        echo "</div>";
    }
    
    function generateFastActionsFloatWindow($current_num, $after_ajax_js)   {
        $result="";
        echo "<div id=\"fast_float{$this->class_name}{$this->num_suffix}\" 
            class=\"fast_float_window\" onmouseout=\" \" 
                \" style=\"visibility: hidden;left:0;top:0;\">
                <table><tr>";
        if ($this->float_manip_forms_mode)
            echo "  <td><a href=\"#\"><img src=\"images/one_bit/onebit_20.png\" onclick=\" hideElementByIdVis('{$this->class_name}{$this->num_suffix}_add_link_id'); 
                    showElementByIdVis('{$this->class_name}{$this->num_suffix}_upd_link_id');
                    showDivModalVis('dict_manip_form{$this->class_name}{$this->num_suffix}'); \" 
                    style=\"width:16px;\"/ title=\"{$this->getButtonHint("edit")}\"></a></td>";
        echo "  <td><a href=\"#\"><img src=\"images/one_bit/onebit_35.png\" onclick=\"".
                        $this->generateDeleteJSWithFilterWithNum($this->class_name.$this->num_suffix."_part_num", 
                        "dict_table_manip_res_div{$this->class_name}{$this->num_suffix}", 
                        $after_ajax_js, $current_num)."\" 
                        style=\"width:16px;\" title=\"{$this->getButtonHint("delete")}\"/></a></td>
                <td><a href=\"#\"><img src=\"images/one_bit/onebit_39.png\" onclick=\"\" 
                    style=\"width:16px;\"/></a></td>";
        if ($this->include_custom_actions_in_float_window)  {
            echo "<td><div id=\"actions_container_{$this->class_name}{$this->num_suffix}\"></div></td>";
        }
        echo "</tr></table>";
        echo "</div>";
    }
    
    function generateInsertFormWithNum($form_object, $after_ajax_js, $current_num) {
        echo "<div id=\"dict_manip_form{$this->class_name}{$this->num_suffix}\" class=\"".
            ($this->float_manip_forms_mode?$this->default_panel_float_class:$this->default_panel_class).
            "\" style=\"display:".($this->float_manip_forms_mode?"none":"").";\">
            <div id=\"dict_manip_form\" class=\"".($this->float_manip_forms_mode?
            "manip_form_default":"visible_manip_form_default")."\">
            <div class=\"current_object_identity\"></div>";
        echo $this->object_adapter->getInsertEditFormWithNumWithValuesAndAutoHidden($form_object,
                $this->getSelectArrays(),$this->class_name.$current_num, ($form_object==null?$form_object:$form_object->getFullPropArray()));
        $this->write_div("dict_table_manip_res_div{$this->class_name}{$this->num_suffix}","","");
        echo "<br/>";
        //echo "----".$this->getButtonHint("insert");
        $this->generate_link_button_with_style("Добавить", "button medium blue add",
            $this->generateInsertJSWithFilterWithNum(0, 
                    "dict_table_manip_res_div{$this->class_name}{$this->num_suffix}", 
                    $after_ajax_js, $current_num),
            $this->class_name.$this->num_suffix."_add_link_id", 
            "visibility: visible;", $this->getButtonHint("insert"));
        $this->generate_link_button_with_style("Изменить", "button medium blue edit",
            $this->generateUpdateJSWithFilterWithNum($this->class_name.$this->num_suffix."_part_num", 
                    "dict_table_manip_res_div{$this->class_name}{$this->num_suffix}", 
                    $after_ajax_js, $current_num),
            $this->class_name.$this->num_suffix."_upd_link_id", 
            "visibility: hidden;", $this->getButtonHint("update"));
        if ($this->float_manip_forms_mode)
        $this->generate_link_button("Отмена", "button medium blue",
            " closeDivModalVis('dict_manip_form{$this->class_name}{$this->num_suffix}'); ",
                    $this->class_name.$this->num_suffix."_cancel_link_id");
        
        //if ($_SESSION['enable_deleting'])
        //    $this->generate_link_button_with_style("Удаление", "change_button_default",
        //        $this->generateDeleteJSWithFilter($this->class_name."_part_num", "dict_table_manip_res_div", ""),
        //            $this->class_name."_del_link_id", "");
        echo "</div></div>";
        $this->generateFastActionsFloatWindow($current_num, $after_ajax_js);
    }
    
    function generateAddButtonWithStyle($class) {
        $this->generate_link_button("Добавить", $class,
            " showElementByIdVis('{$this->class_name}{$this->num_suffix}_add_link_id'); 
                hideElementByIdVis('{$this->class_name}{$this->num_suffix}_upd_link_id'); 
            showDivModalVis('dict_manip_form{$this->class_name}{$this->num_suffix}');",
            $this->class_name."_add_link_id", $this->getButtonHint("insert"));
    }
    
    function getFilterJSParamsWithNum($current_num)    {
        $counter = 0;
        $out = "";
        $filter_keys = array_keys($this->filters_array);
        foreach($filter_keys as $filter_key)    {
            if($counter>0)  {
                $out.=", ";
            }
            
            $out.=($filter_key.":'".$this->class_name."_filt_".$filter_key.$current_num."'");
            
            $counter++;
        }
        
        $filter_keys = array_keys($this->values_filter_array);
        foreach($filter_keys as $filter_key)    {
            if($counter>0)  {
                $out.=", ";
            }
            
            $out.=($filter_key.":'".$this->class_name."_filt_".$filter_key.$current_num."'");
            
            $counter++;
        }
        
        if ($this->use_pager_capacity_input)    {
            if($counter>0)  {
                $out.=", ";
            }
            
            $out.=("page_capacity_val".":'"."page_capacity_input_{$this->class_name}{$this->num_suffix}"."'");
        }
        
        return $out;
    }
    
    function getFilterJSTAdaptParamsWithNum($current_num)    {
        $counter = 0;
        $out = "";
        $filter_keys = array_keys($this->filters_values);
        foreach($filter_keys as $filter_key)    {
            if($counter>0)  {
                $out.=", ";
            }
            
            $out.=($filter_key.":'".$this->filters_values[$filter_key].$current_num."'");
            
            $counter++;
        }
        
        $filter_keys = array_keys($this->values_filter_values);
        foreach($filter_keys as $filter_key)    {
            if($counter>0)  {
                $out.=", ";
            }
            
            $out.=($filter_key.":'".$this->values_filter_values[$filter_key].$current_num."'");
            
            $counter++;
        }
        
        return $out;
    }
    
    function getCriteriesJSParams($action_name) {
        $result="null";
        if (isset($this->standart_action_criteries[$action_name]))  {
            
            $criteries_array = $this->standart_action_criteries[$action_name];
            if (sizeof($criteries_array))   {
                $criteries_keys = array_keys($criteries_array);
                $critery_count=0;
                $result = " { ";
                foreach($criteries_keys as $critery_key)    {
                    if ($critery_count>0)
                        $result.=" , ";
                    
                    $result.=$critery_key.":(".
                        str_replace("***___class_name",$this->class_name,
                        str_replace("***___suffix",$this->num_suffix,
                                $criteries_array[$critery_key])).
                            ")";
                    
                    $critery_count++;
                }
                $result.=" } ";
            }
            
        }
        return $result;
    }
    
    function generateInsertJSWithFilterWithNum($load_indicator_id, $result_container_id, $refresh_after_js, $current_num)  {
        return ($this->confirm_add_operation?" actionConfirm(function (action_function) { closeConfirm(); ":"")
                ." ajaxGetRequest('".$GLOBALS['add_update_delete_php']."', '{$this->class_name}', 
         '{$GLOBALS['insert_manip_mode']}', { ".$this->object_adapter->
         generateAddInsertJSParamsWithNum($GLOBALS['insert_manip_mode'], $this->class_name.$current_num)." },
         '{$load_indicator_id}', '{$result_container_id}', { ".$this->getFilterJSParamsWithNum($this->class_name.$current_num)." }, ".
         " "."{$refresh_after_js}, '{$current_num}' ); ".
         ($this->confirm_add_operation?" } )":"");
    }
    
    function generateUpdateJSWithFilterWithNum($load_indicator_id, $result_container_id, $refresh_after_js, $current_num)  {
        return " actionConfirmExt(function (action_function) { closeConfirm(); ajaxGetRequest('".$GLOBALS['add_update_delete_php']."', '{$this->class_name}', 
         '{$GLOBALS['update_manip_mode']}', { ".$this->object_adapter->generateAddInsertJSParamsWithNum($GLOBALS['update_manip_mode'], $this->class_name.$current_num)." },
         '{$load_indicator_id}', '{$result_container_id}', { ".$this->getFilterJSParamsWithNum($this->class_name.$current_num)." }, {$refresh_after_js}, '{$current_num}' ); } , ".
                 $this->getCriteriesJSParams("update_action")."  );";
    }
    
    function generateDeleteJSWithFilterWithNum($load_indicator_id, $result_container_id, $refresh_after_js, $current_num)  {
        return " actionConfirm(function (action_function) { closeConfirm(); ajaxGetRequest('".$GLOBALS['add_update_delete_php']."', '{$this->class_name}', 
         '{$GLOBALS['delete_manip_mode']}', { ".$this->object_adapter->generateAddInsertJSParamsWithNum($GLOBALS['delete_manip_mode'], $this->class_name.$current_num)." },
         '{$load_indicator_id}', '{$result_container_id}', { ".$this->getFilterJSParamsWithNum($this->class_name.$current_num)." }, {$refresh_after_js}, '{$current_num}' ); } );";
    }
    
    function generateSelectJSWithFilterTAdaptParamsWithNum($filter, $load_indicator_id, $result_container_id, $current_num)    {
        return "ajaxGetRequest('".$GLOBALS['out_table_php']."', '{$this->class_name}', 
         '{$GLOBALS['select_mode']}', { ".$this->getFilterJSTAdaptParamsWithNum($this->class_name.$current_num)." },
         '{$load_indicator_id}', '{$result_container_id}', null, null, '{$current_num}');";
    }
    
    function generateSelectJSWithFilterWithNum($filter, $load_indicator_id, $result_container_id, $current_num, $show_algo=true)    {
        return ($this->float_manip_forms_mode?"closeDivModalVis('dict_manip_form{$this->class_name}{$this->num_suffix}');":"")." ".
                "ajaxGetRequest('".$GLOBALS['out_table_php']."', '{$this->class_name}', 
         '{$GLOBALS['select_mode']}', { ".$this->getFilterJSParamsWithNum($this->class_name.$current_num)." },
         '{$load_indicator_id}', '{$result_container_id}', null, null, '{$current_num}');";
    }
    
    function generateMobileListInsertForm() {
        echo "<div id=\"dict_manip_form\" class=\"mobile_manip_form_default\">
            <div class=\"current_object_identity\"></div>";
        $this->object_adapter->writeMobileInsertEditForm(null,$this->getSelectArrays());
        $this->write_div("dict_table_manip_res_div","","");
        echo "<br/>";
        $this->generate_mobile_link_button("Добавить", "b",
            $this->generateMobileListInsertJSWithFilter(0, "dict_table_manip_res_div", ""),$this->class_name."_add_link_id");
        //$this->generate_link_button_with_style("Изменить", "change_button_default",
        //    $this->generateUpdateJSWithFilter($this->class_name."_part_num", "dict_table_manip_res_div", ""),
        //    $this->class_name."_upd_link_id", "visibility: hidden;");
        //if ($_SESSION['enable_deleting'])
        //    $this->generate_link_button_with_style("Удаление", "change_button_default",
        //        $this->generateDeleteJSWithFilter($this->class_name."_part_num", "dict_table_manip_res_div", ""),
        //            $this->class_name."_del_link_id", "visibility: hidden;");
        echo "</div>";
    }
    
    function generateMobileListInsertJSWithFilter($load_indicator_id, $result_container_id, $refresh_after_js)  {
        return " ajaxGetMobileRequest('".$GLOBALS['add_update_delete_php']."', '{$this->class_name}', 
         '{$GLOBALS['insert_list_manip_mode']}', { ".$this->object_adapter->generateAddInsertJSParams($GLOBALS['insert_manip_mode'])." },
         '{$load_indicator_id}', '{$result_container_id}', { ".$this->getFilterJSParams()." });";
    }
    
    function generateMobileListInsertJSWithFilterWithNum($load_indicator_id, $result_container_id, $refresh_after_js, $current_num)  {
        return " ajaxGetMobileRequest('".$GLOBALS['add_update_delete_php']."', '{$this->class_name}', 
         '{$GLOBALS['insert_mtable_manip_mode']}', { ".$this->object_adapter->
         generateAddInsertJSParamsWithNum($GLOBALS['insert_manip_mode'], $current_num)." },
         '{$load_indicator_id}', '{$result_container_id}', { ".$this->getFilterJSParams()." }, {$refresh_after_js} );";
    }
    
    function generateMobileSelectJSWithFilterTAdaptParams($filter, $load_indicator_id, $result_container_id)    {
        return "ajaxGetMobileRequest('".$GLOBALS['out_table_php']."', '{$this->class_name}', 
         '{$GLOBALS['mobile_table_mode']}', { ".$this->getFilterJSTAdaptParams()." },
         '{$load_indicator_id}', '{$result_container_id}');";
    }
    
    function generateMobileListInsertFormWithNum($form_object, $after_ajax_js, $current_num) {
        echo "<div id=\"dict_manip_form\" class=\"mobile_manip_form_default\">
            <div class=\"current_object_identity\"></div>";
        echo $this->object_adapter->getMobileInsertEditFormWithNumWithValuesAndAutoHidden($form_object,
                $this->getSelectArrays(),$current_num, array());
        $this->write_div("dict_table_manip_res_div","","");
        echo "<br/>";
        $this->generate_mobile_link_button("Добавить", "b",
            $this->generateMobileListInsertJSWithFilterWithNum(0, "dict_table_manip_res_div", $after_ajax_js, $current_num),
            $this->class_name."_add_link_id");
        //$this->generate_link_button_with_style("Изменить", "change_button_default",
        //    $this->generateUpdateJSWithFilter($this->class_name."_part_num", "dict_table_manip_res_div", ""),
        //    $this->class_name."_upd_link_id", "visibility: hidden;");
        //if ($_SESSION['enable_deleting'])
        //    $this->generate_link_button_with_style("Удаление", "change_button_default",
        //        $this->generateDeleteJSWithFilter($this->class_name."_part_num", "dict_table_manip_res_div", ""),
        //            $this->class_name."_del_link_id", "visibility: hidden;");
        echo "</div>";
    }
    
    function generateDictContainer()    {
        
    }
    
    function generateSelectJS($filter, $load_indicator_id, $result_container_id)    {
        return "ajaxGetRequest('".$GLOBALS['out_table_php']."', '{$this->class_name}', 
         '{$GLOBALS['select_mode']}', { },
         '{$load_indicator_id}', '{$result_container_id}');";
    }
    
    function generateSelectJSWithFilter($filter, $load_indicator_id, $result_container_id)    {
        return "ajaxGetRequest('".$GLOBALS['out_table_php']."', '{$this->class_name}', 
         '{$GLOBALS['select_mode']}', { ".$this->getFilterJSParams()." },
         '{$load_indicator_id}', '{$result_container_id}');";
    }
    
    function generateSelectJSWithFilterAndMode($filter, $load_indicator_id, $result_container_id, $select_mode)    {
        return "ajaxGetRequest('".$GLOBALS['out_table_php']."', '{$this->class_name}', 
         '{$select_mode}', { ".$this->getFilterJSParams()." },
         '{$load_indicator_id}', '{$result_container_id}');";
    }
    
    function generateSelectJSWithFilterTAdaptParams($filter, $load_indicator_id, $result_container_id)    {
        return "ajaxGetRequest('".$GLOBALS['out_detail_table_php']."', '{$this->class_name}', 
         '{$GLOBALS['select_mode']}', { ".$this->getFilterJSTAdaptParams()." },
         '{$load_indicator_id}', '{$result_container_id}');";
    }
    
    function generateInsertJS($load_indicator_id, $result_container_id, $refresh_after_js)  {
        return " actionConfirm(function (action_function) { closeConfirm(); ajaxGetRequest('".$GLOBALS['add_update_delete_php']."', '{$this->class_name}', 
         '{$GLOBALS['insert_manip_mode']}', { ".$this->object_adapter->generateAddInsertJSParams($GLOBALS['insert_manip_mode'])." },
         '{$load_indicator_id}', '{$result_container_id}'); } );";
    }
    
    function generateUpdateJS($load_indicator_id, $result_container_id, $refresh_after_js)  {
        return " actionConfirm(function (action_function) { closeConfirm(); ajaxGetRequest('".$GLOBALS['add_update_delete_php']."', '{$this->class_name}', 
         '{$GLOBALS['update_manip_mode']}', { ".$this->object_adapter->generateAddInsertJSParams($GLOBALS['update_manip_mode'])." },
         '{$load_indicator_id}', '{$result_container_id}'); } );";
    }
    
    function generateDeleteJS($load_indicator_id, $result_container_id, $refresh_after_js)  {
        return " actionConfirm(function (action_function) { closeConfirm(); ajaxGetRequest('".$GLOBALS['add_update_delete_php']."', '{$this->class_name}', 
         '{$GLOBALS['delete_manip_mode']}', { ".$this->object_adapter->generateAddInsertJSParams($GLOBALS['delete_manip_mode'])." },
         '{$load_indicator_id}', '{$result_container_id}'); } );";
    }
    
    function generateInsertJSWithFilter($load_indicator_id, $result_container_id, $refresh_after_js)  {
        return " actionConfirm(function (action_function) { closeConfirm(); ajaxGetRequest('".$GLOBALS['add_update_delete_php']."', '{$this->class_name}', 
         '{$GLOBALS['insert_manip_mode']}', { ".$this->object_adapter->generateAddInsertJSParams($GLOBALS['insert_manip_mode'])." },
         '{$load_indicator_id}', '{$result_container_id}', { ".$this->getFilterJSParams()." }); } );";
    }
    
    function generateInsertJSWithFilterWithExternalRefreshJS($load_indicator_id, $result_container_id, $refresh_after_js, $current_row_num)  {
        return " actionConfirm(function (action_function) { closeConfirm(); ajaxGetRequest('".$GLOBALS['add_update_delete_php']."', '{$this->class_name}', 
         '{$GLOBALS['insert_manip_mode']}', { ".
         $this->object_adapter->generateAddInsertJSParamsWithNum($GLOBALS['insert_manip_mode'],$current_row_num)." },
         '{$load_indicator_id}', '{$result_container_id}', null, function (next_function) { return ".$refresh_after_js." } ); } );";
    }
    
    function generateInsertJSWithFilterWithExternalRefreshJSNoConfirm($load_indicator_id, $result_container_id, $refresh_after_js, $current_row_num)  {
        return " ajaxGetRequest('".$GLOBALS['add_update_delete_php']."', '{$this->class_name}', 
         '{$GLOBALS['insert_manip_mode']}', { ".
         $this->object_adapter->generateAddInsertJSParamsWithNum($GLOBALS['insert_manip_mode'],$current_row_num)." },
         '{$load_indicator_id}', '{$result_container_id}', null, function (next_function) { return ".$refresh_after_js." } ); ";
    }
    
    function generateUpdateJSWithFilter($load_indicator_id, $result_container_id, $refresh_after_js)  {
        return " actionConfirm(function (action_function) { closeConfirm(); ajaxGetRequest('".$GLOBALS['add_update_delete_php']."', '{$this->class_name}', 
         '{$GLOBALS['update_manip_mode']}', { ".$this->object_adapter->generateAddInsertJSParams($GLOBALS['update_manip_mode'])." },
         '{$load_indicator_id}', '{$result_container_id}', { ".$this->getFilterJSParams()." }); } );";
    }
    
    function generateLocalUpdateJS($load_indicator_id, $result_container_id, $partial_js_params)  {
        return " actionConfirm(function (action_function) { closeConfirm(); ajaxGetRequest('".$GLOBALS['add_update_delete_php']."', '{$this->class_name}', 
         '{$GLOBALS['partial_update_manip_mode']}', { ".$partial_js_params." },
         '{$load_indicator_id}', '{$result_container_id}'); } );";
    }
    
    function generateLocalUpdateJSWithFilterWithExternalRefreshJS($load_indicator_id, $result_container_id, $partial_js_params, $refresh_after_js)  {
        return " actionConfirm(function (action_function) { closeConfirm(); ajaxGetRequest('".$GLOBALS['add_update_delete_php']."', '{$this->class_name}', 
         '{$GLOBALS['partial_update_manip_mode']}', { ".$partial_js_params." },
         '{$load_indicator_id}', '{$result_container_id}', null, function (next_function) { return ".$refresh_after_js." }, ".
                 ($this->num_suffix==null?"null":"'{$this->num_suffix}'").", ".
                 ($this->inline_update_algorithm==null?"null":"'{$this->inline_update_algorithm}'")." ); } );";
    }
    
    function generateLocalUpdateJSWithFilterWithExternalRefreshJSNoConfirm($load_indicator_id, $result_container_id, $partial_js_params, $refresh_after_js)  {
        return " ajaxGetRequest('".$GLOBALS['add_update_delete_php']."', '{$this->class_name}', 
         '{$GLOBALS['partial_update_manip_mode']}', { ".$partial_js_params." },
         '{$load_indicator_id}', '{$result_container_id}', null, 
         function (next_function) { return ".$refresh_after_js." }, ".
                 ($this->num_suffix==null?"null":"'{$this->num_suffix}'").", ".
                 ($this->inline_update_algorithm==null?"null":"'{$this->inline_update_algorithm}'")."); ";
    }
    
    function generateDeleteJSWithFilter($load_indicator_id, $result_container_id, $refresh_after_js)  {
        return " actionConfirm(function (action_function) { closeConfirm(); ajaxGetRequest('".$GLOBALS['add_update_delete_php']."', '{$this->class_name}', 
         '{$GLOBALS['delete_manip_mode']}', { ".$this->object_adapter->generateAddInsertJSParams($GLOBALS['delete_manip_mode'])." },
         '{$load_indicator_id}', '{$result_container_id}', { ".$this->getFilterJSParams()." }); } );";
    }
    
    function insertDataObject($get_params)  {
        $additional_instruction = "";
        
        if (array_count_values($this->multi_addit_instructions)>0)  {
            //
            $addit_instr_keys = array_keys($this->multi_addit_instructions);
            foreach ($addit_instr_keys as $addit_instr_key) {
                if (isset($get_params[$addit_instr_key]))   {
                    $search_str=$get_params[$addit_instr_key];
                    print_r($get_params);
                    while (true) {
                        if (substr_count($search_str,"***___")>0) {
                            $pref_marker_end_pos = strpos($search_str, "***___")+6;
                            //echo ">".$pref_marker_end_pos;
                            $search_str = substr($search_str, $pref_marker_end_pos);
                            //echo ">>".$search_str;
                            if (strlen($search_str)>0)  {
       
                                if (substr_count($search_str,"***___")>0) {
                                    $next_prev_marker_start = strpos($search_str, "***___");
                                    //echo ">>>".$next_prev_marker_start;
                                    if ($next_prev_marker_start>0)  {
                                        $cut_value = substr($search_str, 0,$next_prev_marker_start);
                                        $search_str = substr($search_str, $next_prev_marker_start);
                                    }
                                    else    {
                                        $cut_value="";
                                        continue;
                                    }
                                    //
                                }
                                else    {
                                    $cut_value = $search_str;
                                    $search_str = "";
                                }
                                
                                //echo ">>>>".$cut_value;
                                //echo ">>>>>".$search_str;
                                
                                if (strlen($cut_value)>0)   {
                                    $num_len = strspn($cut_value, "1234567890");
                                    //echo ">>>>>>".$num_len;
                                    if($num_len>0)  {
                                        
                                        $cut_value = substr($cut_value, 0,$num_len);
                                        //echo ">>>>>>>".$cut_value;
                                        $template_modified = $this->
                                                multi_addit_instructions[$addit_instr_key];
                                        if ($template_modified!=str_replace("***___{$addit_instr_key}", 
                                            $cut_value,$template_modified)) {
                                                $template_modified = str_replace("***___{$addit_instr_key}", 
                                                    $cut_value,$template_modified);
                                                $additional_instruction .= $template_modified;
                                            }
                                         else
                                             break;
                                    }   
                                    else
                                        break;
                                }
                                    
                            }   else
                                break;
                            
                        }
                        else
                            break;
                    }
                }
            }
        }
        return $this->dbconnector->exec_with_prepare_and_params($this->
                insert_instruction_template.$additional_instruction, $get_params);
    }
    
    function updateDataObject($get_params)  {
        return $this->dbconnector->exec_with_prepare_and_params($this->update_instruction_template, $get_params);
    }
    
    function deleteDataObject($get_params)  {
        return $this->dbconnector->exec_with_prepare_and_params($this->delete_instruction_template, $get_params);
    }
    
    function fastObjAppend($get_params)   {
        $update_instruction = "INSERT INTO `".$this->table_name."` ( ";
        $template_modified = $this->addit_fast_sql_template;
        if ($template_modified==null)
            $template_modified = "";
        if (isset($get_params['id']))   {
            unset($get_params['id']);
        }
            $get_params_keys = array_keys($get_params);
            $update_prop_count = sizeof($get_params);
            $instruction_params = array();
            
            foreach($get_params_keys as $get_params_key)    {
                
                $instruction_params[":".$get_params_key] = $get_params[$get_params_key];
                $update_instruction .= " `{$get_params_key}` ";
                if ($update_prop_count>1)   
                    $update_instruction .= ", ";
                else
                    $update_instruction .= " ";
                $update_prop_count--;
            }
            
            $update_instruction .= ") VALUES( ";
            $update_prop_count = sizeof($get_params);
            
            foreach($get_params_keys as $get_params_key)    {
                $update_instruction .= " :{$get_params_key} ";
                if ($update_prop_count>1)   
                    $update_instruction .= ", ";
                else
                    $update_instruction .= " ";
                $update_prop_count--;
            }
            
            $update_instruction .= ");";
            //echo $update_instruction;
            //print_r($instruction_params);
            return "Выполнено ".$this->dbconnector->
                    exec_with_prepare_and_params($update_instruction.$template_modified, $instruction_params);
    }
    
    function updateObjectPartial($get_params)   {
        $update_instruction = "UPDATE `".$this->table_name."` SET ";
        if (isset($get_params['id']))   {
            $update_id = $get_params['id'];
            unset($get_params['id']);
            $get_params_keys = array_keys($get_params);
            $update_prop_count = sizeof($get_params);
            $instruction_params = array();
            foreach($get_params_keys as $get_params_key)    {
                if(array_key_exists($get_params_key, $this->base64_encode_inline_props))
                    $instruction_params[":".$get_params_key] = base64_encode($get_params[$get_params_key]);
                else
                    $instruction_params[":".$get_params_key] = $get_params[$get_params_key];
                $update_instruction .= "`{$get_params_key}`=:{$get_params_key} ";
                if ($update_prop_count>1)   
                    $update_instruction .= ", ";
                else
                    $update_instruction .= " ";
                $update_prop_count--;
            }
            
            $update_instruction .= " WHERE {$this->id_field}={$update_id}";
            return "Выполнено ".$this->dbconnector->exec_with_prepare_and_params($update_instruction, $instruction_params);
        }
        else
            return "Не задан ключ изменяемого объекта!";
    }
    
    function getSelectArray()   {
        //echo "SELECT ".($this->custom_array_select_columns==null?
       //         "{$this->id_field} as id, ".$this->object_adapter->select_display_field." as select_name ":
       //             $this->custom_array_select_columns).
       //             " FROM ".$this->with_relative_view_name." WHERE ".$this->base_filter.
       //             ($this->strong_user_relative?" AND ".($this->select_empty_user_id?
        //            " (ISNULL(user_id) OR (user_id=0) OR (user_id='{$_SESSION['user_id']}')) ":
       //             " (user_id='{$_SESSION['user_id']}') "):"")." AND (closed<>1);";
        $select_rows=$this->dbconnector->query_both_to_array(
            "SELECT ".($this->custom_array_select_columns==null?
                "{$this->id_field} as id, ".$this->object_adapter->select_display_field." as select_name ":
                    $this->custom_array_select_columns).
                    " FROM ".$this->with_relative_view_name." WHERE ".$this->base_filter.
                    ($this->strong_user_relative?" AND ".($this->select_empty_user_id?
                    " (ISNULL(user_id) OR (user_id=0) OR (user_id='{$_SESSION['user_id']}')) ":
                    " (user_id='{$_SESSION['user_id']}') "):"")." AND (closed<>1) ".
                    ($this->custom_sel_array_order_clause==null?
                    ($this->custom_order_clause==null?" order by ".$this->id_field." desc ":
                    $this->custom_order_clause):$this->custom_sel_array_order_clause).";");
                //AND ".$this->getFilterWhereClause().";");
        //print_r($select_rows);
        return $select_rows;
    }
    
    function getClassSelectElement($id, $prev_text)    {
        return $this->generate_select($id, $this->getSelectArray(), 
                "id", "select_name", 200, $prev_text);
    }
    
    function getClassSelectElementJS($id, $prev_text, $on_change_js)    {
        return $this->generate_select_js_null_value($id, $this->getSelectArray(), 
                "id", "select_name", 200, $prev_text, $on_change_js);
    }
    
    function generateDetailInfoTable()  {
        $result = "<div class=\"dict_detail_default\" style=\"\">
            <table id=\""
            .$this->class_name.$GLOBALS['dict_table_base']
            ."\" class=\"tablesorter\" border=\"0\">";

        if ($this->select_collection!=null) {
        //echo "Всего: ".sizeof($this->select_collection);
            $current_row_num = 0;    
            foreach( $this->select_collection as $current_object )  {
                $result .= $this->object_adapter->getDetailInfoRow($current_object);
            }
        }
        $result .= "</table></div>";
        return $result;
    }
    
    function generateDetailInfo($detail_keys)   {
        //print_r($detail_keys);
        if(isset($detail_keys['id'])) {
            if($this->detail_info_template!=null) {
                $template_modified = $this->detail_info_template;
                $linked_detail_keys=array_keys($this->linked_detail_entities);
                //print_r($this->linked_detail_entities);
                $this->base_filter="(id={$detail_keys['id']})";
                if ($this->detail_view_name!=null)
                    $this->with_relative_view_name = $this->detail_view_name;
                $this->selectFullWithRelativeWithoutFilters();
                $template_modified = str_replace("***___SELF", 
                    $this->generateDetailInfoTable(),$template_modified);
                foreach($linked_detail_keys as $linked_detail_key)  {
                    $reflectionClass = new ReflectionClass($linked_detail_key."TableAdapter");
                    $DictTAdapt = $reflectionClass->newInstanceArgs(array($this->dbconnector,
                        "",$linked_detail_key));
                    //echo $linked_detail_key."TableAdapter";
                    $dict_link_array = $this->linked_detail_entities[$linked_detail_key];
                    $dict_linked_keys = array_keys($dict_link_array);
                    foreach($dict_linked_keys as $dict_linked_key)  {
                        if (isset($detail_keys[$dict_linked_key]))  {
                            $DictTAdapt->base_filter = str_replace("***___".$dict_linked_key,
                             $detail_keys[$dict_linked_key], $dict_link_array[$dict_linked_key]);
                            if ($DictTAdapt->detail_view_name!=null)
                                $DictTAdapt->with_relative_view_name = $DictTAdapt->detail_view_name;
                            $DictTAdapt->selectFullWithRelativeWithoutFilters();
                            
                            $template_modified = str_replace("***___".$linked_detail_key, 
                                    $DictTAdapt->generateDetailInfoTable(),$template_modified);
                        } else echo "Нет ключа связанной сущности для детализированного отображения!";
                    }
                    //return $template_modified;
                }
                return "<input type=\"button\" value=\"Закрыть\" 
            onclick=\"closePopup(); return false;\" />".$template_modified;
            }   else
                return "Пустой шаблон вывода детализированной информации!";
        }   else
            return "Не указан ключ для вывода детализированной информации!";
    }
    
    function generateRelatedDetailInfo($detail_keys)   {
        if(isset($detail_keys['id'])) {
            
        }   else
            return "Не указан ключ для вывода детализированной информации!";
    }
    
    //abstract function loadDataFromFile($filepath);
    
}

?>