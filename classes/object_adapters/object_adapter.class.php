<?php

/**
 * @author Poltarokov SP
 * @copyright 2011
 */

if (!defined("ABSOLUTE_PATH"))
    define("ABSOLUTE_PATH", dirname(__FILE__)."/../../");
 
require_once(constant("ABSOLUTE_PATH")."classes/tools.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/configuration.php");
require_once(constant("ABSOLUTE_PATH")."classes/object_adapters/object_manip.interface.php");

abstract class ObjectAdapter extends Tools implements ObjectManipInterface {
    
    protected $table_name;
    protected $class_name;
    protected $dbconnector;
    protected $add_js_function;
    protected $edit_js_function;
    protected $delete_js_function;
    protected $td_css_style="dictionary_table_text";
    protected $tr_css_style="dictionary_table_text";
    protected $header_td_css_style="dictionary_table_text";
    protected $header_tr_css_style="dictionary_header_tr";
    protected $header_text_css_style="dictionary_table_header_text";
    public $num_suffix="";
    public $desk_list_table_mode = false;
    public $foreigen_keys=array();
    public $foreigen_keys_filters = array();
    public $select_display_field;
    public $filter_values_keys=array();
    protected $fields_width_array = array();
    protected $fields_prev_text_array = array();
    protected $manip_form_template=null;
    protected $filter_form_template=null;
    public $hidden_keys = array();
    protected $date_fields = array();
    protected $time_fields = array();
    protected $date_time_fields = array();
    protected $text_area_fields = array();
    protected $image_fields = array();
    protected $inline_input_fields = array();
    protected $mixed_with_select_choise_inputs = array();
    protected $object_tag_styles = null;
    protected $slider_fields = null;
    protected $checkbox_fields = array();
    protected $detail_info_template = null;
    protected $disabled_inputs = array();
    protected $with_button_clear_fields = array();
    protected $list_item_template = null;
    public $ids_array_fields = array();
    protected $mobile_table_row_template = null;
    protected $mobile_list_table_row_template = null;
    protected $mobile_manip_form_template = null;
    protected $desk_list_row_template;
    protected $detail_tadapters_params = array();
    protected $ajax_detail_params = array();
    protected $styled_data_fields = array();
    public $format_float_fields = array();
    protected $alternate_templates = array();
    protected $white_tr_class = "white_tr";
    protected $highlighted_tr_class = "highlighted_tr";
    protected $toggle_link_to_row = false;
    protected $use_detailed_doubleclick = false;
    protected $use_detail_ajax_doubleclick = false;
    protected $use_float_show_doubleclick = false;
    protected $use_custom_row_click_anchor = true;
    protected $class_specify_fields = array();
    protected $field_titles = array();
    protected $use_tr_link_tag = false;
    protected $td_default_link_class = "table_row_link";

    function __construct($table_name, $class_name, $td_css_style, $text_css_class_name)    {
        parent::__construct($text_css_class_name);
        $this->table_name = $table_name;
        $this->class_name = $class_name;
        //$this->table_name = $add_js_function;
        //$this->table_name = $edit_js_function;
        //$this->table_name = $delete_js_function;
        $this->td_css_style = $td_css_style;    
    }
    
    abstract function getStyleForField($object, $field_name);
    abstract function getTemplateForRow($object);
    abstract function getDerivedFieldsArray($object);
    
    function acceptLocalFieldsNames($fields_names)  {
        $fields_names_keys = array_keys($fields_names);
        foreach($fields_names_keys as $fields_names_key) {
            if(array_key_exists($fields_names_key, 
                    $this->fields_prev_text_array))   {
                $this->fields_prev_text_array[$fields_names_key]=
                        $fields_names[$fields_names_key];
            }
        }
    }
    
    function setDBConnector($dbconnector)   {
        $this->dbconnector = $dbconnector;
    }
    
    function clearTrStyles()    {
        $this->white_tr_class = "";
        $this->highlighted_tr_class = "";
    }
    
    function setDetailAdaptersParams($detail_tadapters_params)  {
        $this->detail_tadapters_params = $detail_tadapters_params;
    }
    
    function setAjaxDetailedParams($ajax_detail_params) {
        $this->ajax_detail_params = $ajax_detail_params;
    }
    
    function getDetailRefreshJS($object)   {
        $js_result = "";
        $detail_params_keys = array_keys($this->detail_tadapters_params);
        foreach ($detail_params_keys as $detail_params_key) {
            $js_result .= " setElementValueById('{$detail_params_key}', {$object->getId()}); 
                {$this->detail_tadapters_params[$detail_params_key]} ";
        }
        return $js_result;
    }
    
    function getAjaxDetailJS($object)   {
        $js_result = " constructAndGoAjax( { ";
        $counter=1;
        $obj_props = $object->getFullPropArray();
        $ajax_keys = array_keys($this->ajax_detail_params);
        foreach($ajax_keys as $ajax_key)    {
            if (($ajax_key!="next_function") && ($ajax_key!="eval")) {
                if($counter>1) 
                    $js_result .= " , ";
                if (array_key_exists($ajax_key, $obj_props) )    {
                    $js_result .= $this->ajax_detail_params[$ajax_key].":'".$obj_props[$ajax_key]."'";
                }   else 
                    $js_result .= $ajax_key.":'".$this->ajax_detail_params[$ajax_key]."'";
                $counter++;
            }
        }
        
        $js_result .= " } ";
        
        if (isset($this->ajax_detail_params['next_function']))  {
            $js_result .= " , ".$this->ajax_detail_params['next_function'];
        }
        
        if (isset($this->ajax_detail_params['eval']))  {
            if (is_array($this->ajax_detail_params['eval']))    {
                $eval_array = $this->ajax_detail_params['eval'];
                if (sizeof($eval_array)>0)  {
                    $eval_counter = 0;
                    $js_result .= " , { ";
                    $eval_keys = array_keys($eval_array);
                    foreach($eval_keys as $eval_key)    {
                        if ($eval_counter>0) 
                            $js_result .= " , ";
                        
                        $js_result .= " {$eval_key}:'{$eval_array[$eval_key]}' ";
                        
                        $eval_counter++;
                    }
                    $js_result .= " } ";
                }
            }   else
            {
                
            }
                //$js_result .= " , { ".$this->ajax_detail_params['eval'].": '{$this->getActionKeyElementId()}' }";
        }
            
        return $js_result." );";
    }
    
    function getTBODYTRATTR($object, $current_row_num) {
        $row_style=" class=\"{$this->white_tr_class}\" ";
        if(($current_row_num%2)==0) {
            //$row_style=" style=\"background-color:#7FC9FF;\" ";
            $row_style=" class=\"{$this->highlighted_tr_class}\" ";
        }
        return  " {$row_style} onmouseover=\" hideFastWindow('fast_float{$this->class_name}{$this->num_suffix}'); ".
                " \" onMouseOut=\" \" onClick=\" setSelectionId(this,'selected_row'); 
                showElementByIdVis('{$this->class_name}{$this->num_suffix}_upd_link_id'); ". 
                ($this->use_float_show_doubleclick?"":
                " showFastWindow('fast_float{$this->class_name}{$this->num_suffix}'); ").
                $this->generateEditFillScriptWithNumAndSuffix($object, $current_row_num)." ".
                ($this->use_detailed_doubleclick?"":$this->getDetailRefreshJS($object))."  ".
                ($this->use_detail_ajax_doubleclick?"":$this->getAjaxDetailJS($object)).
                " \" ondblclick=\" ".
                ($this->use_float_show_doubleclick?
                " showFastWindow('fast_float{$this->class_name}{$this->num_suffix}'); ".
                $this->generateEditFillScriptWithNumAndSuffix($object, $current_row_num)." ":"").
                ($this->use_detailed_doubleclick?$this->getDetailRefreshJS($object):"")." ".
                ($this->use_detail_ajax_doubleclick?$this->getAjaxDetailJS($object):"")." \" "
                ;
    }
    
    function writeTableRowFull($object, $linked_props, $current_row_num)    {
        echo ($this->use_tr_link_tag?"<tr><a href=\"#\" ":"<tr ").
            $this->getTBODYTRATTR($object, $current_row_num).($this->use_tr_link_tag?" >":" >");
        $this->writeTableRowExt($object, $linked_props);
        echo "<td style=\"display:none;\"><div id=\"actions_{$this->class_name}{$current_row_num}\" 
                      style=\"display:none;\"><b><!--Нет действий для объектов данного типа--></b></div></td>";
        //echo "</tr>";
        echo ($this->use_tr_link_tag?"</a></tr>":"</tr>");
     } 
     
    function writeTableRowFullWithoutClosedTag($object, $linked_props, $current_row_num)    {
        echo ($this->use_tr_link_tag?"<tr><a href=\"#\" ":"<tr ").
            $this->getTBODYTRATTR($object, $current_row_num).($this->use_tr_link_tag?">":">");
        $this->writeTableRowExt($object, $linked_props);
        echo ($this->use_tr_link_tag?"</a>":"");
        //echo "</tr>";
     }
     
    function  writeTableRowExt($object, $linked_props)  {
        if ($this->desk_list_table_mode)    {
            $this->write_td_ext("", 0, $object);
        }   else    {
            $this->writeTableRow($object, $linked_props);
        }
    }
     
    function getCustomizedRow($object, $customized_template)    {
        $result = "<tr><td>";
        if($customized_template!=null)    {
            $prop_array = $object->getFullPropArray();
            $result .= $this->getMeFormFromTemplate($prop_array,$customized_template);
        }   else
                $result .= "Нет шаблона вывода строки детализированной информации!";
        $result .= "</td></tr>";    
        return $result;
    } 
    
    function getDetailInfoRow($object)    {
        $result = "<tr><td>";
        if($this->detail_info_template!=null)    {
            $prop_array = $object->getFullPropArray();
            $result .= $this->getMeFormFromTemplate($prop_array,$this->detail_info_template);
        }   else
                $result .= "Нет шаблона вывода строки детализированной информации!";
        $result .= "</td></tr>";    
        return $result;
    }
	
    function getMobileListTableRow($object)	{
		$result = "";
        if($this->mobile_list_table_row_template!=null)    {
            $prop_array = $object->getFullPropArray();
            $result .= $this->getMeFormFromTemplate($prop_array,$this->mobile_list_table_row_template);
        }   else
                $result .= "Нет шаблона вывода строки детализированной информации!";
        //$result .= "</li>";    
        return $result;
	}
        
    function getMobileTableRow($object)	{
		$result = "";
        if($this->mobile_table_row_template!=null)    {
            $prop_array = $object->getFullPropArray();
            $result .= $this->getMeFormFromTemplate($prop_array,$this->mobile_table_row_template);
        }   else
                $result .= "Нет шаблона вывода строки детализированной информации!";
        //$result .= "</li>";    
        return $result;
	}
    
    function getListItemRow($object)    {
        $result = "<tr><td>";
        if($this->list_item_template!=null)    {
            $prop_array = $object->getFullPropArray();
            $result .= $this->getMeFormFromTemplate($prop_array,$this->list_item_template);
        }   else
                $result .= "Нет шаблона вывода строки списочного представления объекта!";
        $result .= "</td></tr>";    
        return $result;
    }
    
    function write_header_td($text, $width)    {
        echo "<th class=\"dictionary_header_tr\" style=\"width:{$width};\">";
        parent::write_text($text, $this->header_text_css_style);
        echo "</th>";
    }
    
    function write_td($text, $width)    {
        echo "<td style=\"width:{$width};\">";
        
        parent::write_text(($this->toggle_link_to_row?"<a class=\"{$this->td_default_link_class}\" 
                href=\"#".($this->use_custom_row_click_anchor?
                "{$this->class_name}{$this->num_suffix}_table_top_anchor":"")."\">":"").
                $text.($this->toggle_link_to_row?"</a>":""), ""); //$this->text_css_class_name
        echo "</td>";
    }
    
    function write_td_with_style($text, $width, $style)    {
        echo "<td style=\"width:{$width};{$style}\">";
        
        parent::write_text(($this->toggle_link_to_row?"<a class=\"{$this->td_default_link_class}\" href=\"#\">":"").
                $text.($this->toggle_link_to_row?"</a>":""), ""); //$this->text_css_class_name
        echo "</td>";
    }
    
    function write_td_ext($text, $width, $object)    {
        
        $prop_array = $object->getFullPropArray();
        $float_fields_keys = array_keys($this->format_float_fields);
        foreach($float_fields_keys as $float_fields_key)    {
            if(array_key_exists($float_fields_key, $prop_array)&&!isset($prop_array[$float_fields_key]))
                $prop_array[$float_fields_key] = 0.0;
            if(isset($prop_array[$float_fields_key]))
                    $prop_array[$float_fields_key] = number_format($prop_array[$float_fields_key], 2, '.', ' ');
        }
        
        $styled_fields_keys = array_keys($this->styled_data_fields);
        foreach($styled_fields_keys as $styled_fields_key)    {
            if(isset($prop_array[$styled_fields_key]))
                $prop_array[$styled_fields_key] = 
                    "<span ".$this->getStyleForField($object, $styled_fields_key)." >".
                            $prop_array[$styled_fields_key]."</span>";
        }
        
        $text_template_keys = array_keys($prop_array);
        foreach($text_template_keys as $text_template_key)  {
            if (isset($this->image_fields[$text_template_key])) {
                $prop_array[$text_template_key] = 
                    $this->getImageHTMLWithClass(
                            $prop_array[$text_template_key], 
                            $this->image_fields[$text_template_key]);
                    continue;
            }
        }
        
        if (count($this->getDerivedFieldsArray($object))>0) {
            $prop_array = array_merge($prop_array, $this->getDerivedFieldsArray($object));
        }
        
        if ($this->desk_list_table_mode)    {
            $this->write_td($this->getTextFromTemplate
                ($prop_array, 
                        (sizeof($this->alternate_templates)>0?
                            $this->getTemplateForRow($object):$this->desk_list_row_template)
                    ),75);
        }   else
        {
        //echo "<td style=\"width:{$width};\">";
        //parent::write_text($text, ""); //$this->text_css_class_name
        //echo "</td>";
            $this->write_td($text, $width);
        }
    }
    
    function write_td_with_action($text, $width, $prop_name, $id_prm)    {
        echo "<td style=\"width:{$width};\">";
        if (isset($this->slider_fields[$prop_name]))    {
            echo "<span id=\"anchor_{$this->class_name}_{$prop_name}_{$id_prm}\"></span><p class=\"slide\"><div id=\"{$this->class_name}_{$prop_name}_panel_btn{$id_prm}\" class=\"hidden_panel\" 
                                        style=\"height: {$this->slider_fields[$prop_name]}px;\">";
            parent::write_text($text, "");
            echo "</div><a id=\"{$this->class_name}_{$prop_name}_btn{$id_prm}\" href=\"#anchor_{$this->class_name}_{$id_prm}\" 
                                    class=\"btn-slide\" onclick=\" $('#{$this->class_name}_{$prop_name}_panel_btn{$id_prm}').
                                        slideToggle('slow'); $(this).toggleClass('active'); \">
                                        Подробно</a></p>";
        }   
        else
            parent::write_text($text, ""); //$this->text_css_class_name
        echo "</td>";
    }
    
    function write_td_with_styler($text, $width, $styler_criteries)    {
        if ($this->object_tag_styles==null)
            $style_code = "";
        else
            $style_code = $this->object_tag_styles->
                getStylesByTagAndObjectProps("td", $styler_criteries);
        
        echo "<td style=\" {$style_code} width:{$width};\">";
        parent::write_text($text, ""); //$this->text_css_class_name
        echo "</td>";
    }
    
    function generate_add_button()  {
        
    }
    
    function getDataClassInstance() {
        $reflectionClass = new ReflectionClass($this->class_name);
        return $reflectionClass->newInstanceArgs(array(null));
    }
    
    function writeMobileInsertEditForm($object, $select_arrays)  {
        
        $form_elements_array = array();
        
        if ($object==null)  {
            $parse_object = $this->getDataClassInstance();
        }   else    {
            $parse_object = $object;
        }
        $prop_array = $parse_object->getPropArray();
        
        
        $foreign_key_names = array_keys($this->foreigen_keys);
        $select_array_names = array_keys($select_arrays);

        foreach($foreign_key_names as $foreign_key_name)    {
            foreach($select_array_names as $select_array_name)    {
                if ($foreign_key_name==$select_array_name)  {
                    $current_select_array = $select_arrays[$select_array_name];
                    if ($this->mobile_manip_form_template==null)
                        echo $this->write_select_field($foreign_key_name, $current_select_array);
                    else    
                        $form_elements_array[$foreign_key_name] = 
                            $this->write_select_field($foreign_key_name, $current_select_array);
                    unset($prop_array[$select_array_name]);
                }
            }
        }
        
        $prop_keys = array_keys($prop_array);
        $prop_values = array_values($prop_array);
        foreach ($prop_keys as $prop_key)  {
            if ($this->mobile_manip_form_template==null)
                echo $this->write_input_text_field($prop_key, $prop_array[$prop_key]);
            else
                $form_elements_array[$prop_key] = 
                    $this->write_input_text_field($prop_key, $prop_array[$prop_key]);
        }
        
        $this->getFormFromTemplate($form_elements_array, $this->mobile_manip_form_template);
        
     }
    
    function writeInsertEditForm($object, $select_arrays)  {
        
        $form_elements_array = array();
        
        if ($object==null)  {
            $parse_object = $this->getDataClassInstance();
        }   else    {
            $parse_object = $object;
        }
        $prop_array = $parse_object->getPropArray();
        
        
        $foreign_key_names = array_keys($this->foreigen_keys);
        $select_array_names = array_keys($select_arrays);

        foreach($foreign_key_names as $foreign_key_name)    {
            foreach($select_array_names as $select_array_name)    {
                if ($foreign_key_name==$select_array_name)  {
                    $current_select_array = $select_arrays[$select_array_name];
                    if ($this->manip_form_template==null)
                        echo $this->write_select_field($foreign_key_name, $current_select_array);
                    else    
                        $form_elements_array[$foreign_key_name] = 
                            $this->write_select_field($foreign_key_name, $current_select_array);
                    unset($prop_array[$select_array_name]);
                }
            }
        }
        
        $prop_keys = array_keys($prop_array);
        $prop_values = array_values($prop_array);
        foreach ($prop_keys as $prop_key)  {
            if ($this->manip_form_template==null)
                echo $this->write_input_text_field($prop_key, $prop_array[$prop_key]);
            else
                $form_elements_array[$prop_key] = 
                    $this->write_input_text_field($prop_key, $prop_array[$prop_key]);
        }
        
        $this->getFormFromTemplate($form_elements_array, $this->manip_form_template);
        
     }
     
     function writeInsertEditFormWithNum($object, $select_arrays, $current_row_num)  {
        
        $form_elements_array = array();
        
        if ($object==null)  {
            $parse_object = $this->getDataClassInstance();
        }   else    {
            $parse_object = $object;
        }
        $prop_array = $parse_object->getPropArray();
        
        
        $foreign_key_names = array_keys($this->foreigen_keys);
        $select_array_names = array_keys($select_arrays);

        foreach($foreign_key_names as $foreign_key_name)    {
            foreach($select_array_names as $select_array_name)    {
                if ($foreign_key_name==$select_array_name)  {
                    $current_select_array = $select_arrays[$select_array_name];
                    if ($this->manip_form_template==null)
                        echo $this->write_select_field_with_num($foreign_key_name, $current_select_array, $current_row_num);
                    else    
                        $form_elements_array[$foreign_key_name] = 
                            $this->write_select_field_with_num($foreign_key_name, $current_select_array, $current_row_num);
                    unset($prop_array[$select_array_name]);
                }
            }
        }
        
        $prop_keys = array_keys($prop_array);
        $prop_values = array_values($prop_array);
        foreach ($prop_keys as $prop_key)  {
            if ($this->manip_form_template==null)
                echo $this->write_input_text_field_with_num($prop_key, $prop_array[$prop_key], $current_row_num);
            else
                $form_elements_array[$prop_key] = 
                    $this->write_input_text_field_with_num($prop_key, $prop_array[$prop_key], $current_row_num);
        }
        
        $this->getFormFromTemplate($form_elements_array, $this->manip_form_template);
        
     }
     
     function writeInsertEditFormWithNumWithValuesAndAutoHidden
        ($object, $select_arrays, $current_row_num, $select_values)  {
        
        $form_elements_array = array();
        
        if ($object==null)  {
            $parse_object = $this->getDataClassInstance();
        }   else    {
            $parse_object = $object;
        }
        $prop_array = $parse_object->getPropArray();
        
        
        $foreign_key_names = array_keys($this->foreigen_keys);
        $select_array_names = array_keys($select_arrays);

        foreach($foreign_key_names as $foreign_key_name)    {
            foreach($select_array_names as $select_array_name)    {
                if ($foreign_key_name==$select_array_name)  {
                    $current_select_array = $select_arrays[$select_array_name];
                    $curr_select_value = null;
                    if(isset($select_values[$foreign_key_name]))
                        $curr_select_value = $select_values[$foreign_key_name];
                    if ($this->manip_form_template==null)
                        echo $this->write_select_field_with_num_and_value($foreign_key_name, $current_select_array, $current_row_num, $curr_select_value);
                    else    
                        $form_elements_array[$foreign_key_name] = 
                            $this->write_select_field_with_num_and_value($foreign_key_name, $current_select_array, $current_row_num, $curr_select_value);
                    unset($prop_array[$select_array_name]);
                }
            }
        }
        
        $prop_keys = array_keys($prop_array);
        $prop_values = array_values($prop_array);
        foreach ($prop_keys as $prop_key)  {
            if ($this->manip_form_template==null)
                echo $this->write_input_text_field_with_num($prop_key, $prop_array[$prop_key], $current_row_num);
            else
                $form_elements_array[$prop_key] = 
                    $this->write_input_text_field_with_num($prop_key, $prop_array[$prop_key], $current_row_num);
        }
        
        $this->getFormFromTemplate($form_elements_array, $this->manip_form_template);
        
     }
     
     function getInsertEditFormWithNumWithValuesAndAutoHidden
        ($object, $select_arrays, $current_row_num, $select_values)  {
        
        $form_elements_array = array();
        $result = "";
        
        //print_r($select_values);
        
        if ($object==null)  {
            $parse_object = $this->getDataClassInstance();
        }   else    {
            $parse_object = $object;
        }
        $prop_array = $parse_object->getPropArray();
        
        
        $foreign_key_names = array_keys($this->foreigen_keys);
        $select_array_names = array_keys($select_arrays);
        //print_r($foreign_key_names);
        //print_r($select_values);

        foreach($foreign_key_names as $foreign_key_name)    {
            foreach($select_array_names as $select_array_name)    {
                if ($foreign_key_name==$select_array_name)  {
                    $current_select_array = $select_arrays[$select_array_name];
                    $curr_select_value = null;
                    if(isset($select_values[$foreign_key_name]))
                        $curr_select_value = $select_values[$foreign_key_name];
                    if ($this->manip_form_template==null)
                        $result .= $this->write_select_field_with_num_and_value($foreign_key_name, $current_select_array, $current_row_num, $curr_select_value);
                    else    
                        $form_elements_array[$foreign_key_name] = 
                            $this->write_select_field_with_num_and_value($foreign_key_name, $current_select_array, $current_row_num, $curr_select_value);
                    unset($prop_array[$select_array_name]);
                }
            }
        }
        
        $ids_array_key_names = array_keys($this->ids_array_fields);
        $select_array_names = array_keys($select_arrays);

        foreach($ids_array_key_names as $ids_array_key_name)    {
            foreach($select_array_names as $select_array_name)    {
                if ($ids_array_key_name==$select_array_name)  {
                    $current_select_array = $select_arrays[$select_array_name];
                    $curr_select_value = null;
                    if(isset($select_values[$ids_array_key_name]))
                        $curr_select_value = $select_values[$ids_array_key_name];
                    if ($this->manip_form_template==null)
                        $result .= $this->write_ids_select_field_with_num_and_value($ids_array_key_name, $current_select_array, $current_row_num, $curr_select_value);
                    else    
                        $form_elements_array[$ids_array_key_name] = 
                            $this->write_ids_select_field_with_num_and_value($ids_array_key_name, $current_select_array, $current_row_num, $curr_select_value);
                    unset($prop_array[$select_array_name]);
                }
            }
        }
        
        $prop_keys = array_keys($prop_array);
        $prop_values = array_values($prop_array);
        foreach ($prop_keys as $prop_key)  {
            if ($this->manip_form_template==null)
                $result .= $this->write_input_text_field_with_num($prop_key, $prop_array[$prop_key], $current_row_num);
            else
                $form_elements_array[$prop_key] = 
                    $this->write_input_text_field_with_num($prop_key, $prop_array[$prop_key], $current_row_num);
        }
        
        if ($this->manip_form_template==null)
            return $result;
        else
            return $this->getMeFormFromTemplate($form_elements_array, $this->manip_form_template);
        
     }
     
     function getMobileInsertEditFormWithNumWithValuesAndAutoHidden
        ($object, $select_arrays, $current_row_num, $select_values)  {
        
        $form_elements_array = array();
        $result = "";
        
        //print_r($select_values);
        
        if ($object==null)  {
            $parse_object = $this->getDataClassInstance();
        }   else    {
            $parse_object = $object;
        }
        $prop_array = $parse_object->getPropArray();
        
        
        $foreign_key_names = array_keys($this->foreigen_keys);
        $select_array_names = array_keys($select_arrays);

        foreach($foreign_key_names as $foreign_key_name)    {
            foreach($select_array_names as $select_array_name)    {
                if ($foreign_key_name==$select_array_name)  {
                    $current_select_array = $select_arrays[$select_array_name];
                    $curr_select_value = null;
                    if(isset($select_values[$foreign_key_name]))
                        $curr_select_value = $select_values[$foreign_key_name];
                    if ($this->mobile_manip_form_template==null)
                        $result .= $this->write_select_field_with_num_and_value($foreign_key_name, $current_select_array, $current_row_num, $curr_select_value);
                    else    
                        $form_elements_array[$foreign_key_name] = 
                            $this->write_select_field_with_num_and_value($foreign_key_name, $current_select_array, $current_row_num, $curr_select_value);
                    unset($prop_array[$select_array_name]);
                }
            }
        }
        
        $ids_array_key_names = array_keys($this->ids_array_fields);
        $select_array_names = array_keys($select_arrays);

        foreach($ids_array_key_names as $ids_array_key_name)    {
            foreach($select_array_names as $select_array_name)    {
                if ($ids_array_key_name==$select_array_name)  {
                    $current_select_array = $select_arrays[$select_array_name];
                    $curr_select_value = null;
                    if(isset($select_values[$ids_array_key_name]))
                        $curr_select_value = $select_values[$ids_array_key_name];
                    if ($this->mobile_manip_form_template==null)
                        $result .= $this->write_ids_select_field_with_num_and_value($ids_array_key_name, $current_select_array, $current_row_num, $curr_select_value);
                    else    
                        $form_elements_array[$ids_array_key_name] = 
                            $this->write_ids_select_field_with_num_and_value($ids_array_key_name, $current_select_array, $current_row_num, $curr_select_value);
                    unset($prop_array[$select_array_name]);
                }
            }
        }
        
        $prop_keys = array_keys($prop_array);
        $prop_values = array_values($prop_array);
        foreach ($prop_keys as $prop_key)  {
            if ($this->mobile_manip_form_template==null)
                $result .= $this->write_input_text_field_with_num($prop_key, $prop_array[$prop_key], $current_row_num);
            else
                $form_elements_array[$prop_key] = 
                    $this->write_input_text_field_with_num($prop_key, $prop_array[$prop_key], $current_row_num);
        }
        
        if ($this->mobile_manip_form_template==null)
            return $result;
        else
            return $this->getMeFormFromTemplate($form_elements_array, $this->mobile_manip_form_template);
        
     }
     
     function write_input_text_field_with_num_and_value($prop_key, $value, $row_num) {
        $inp_width = 50;
        $prev_text = $prop_key;
        if (isset($this->fields_prev_text_array[$prop_key]))
            $prev_text = $this->fields_prev_text_array[$prop_key];
        if (isset($this->fields_width_array[$prop_key]))
            $inp_width = $this->fields_width_array[$prop_key];
        
        $title_text="";
        if (isset($this->field_titles[$prop_key]))
            $title_text = $this->field_titles[$prop_key];
            
        $picker_script = "";
        $cont_div = "";
        $clear_button_code = "";
        if (array_key_exists($prop_key, $this->with_button_clear_fields))   {
            $clear_button_code = "<span id=\"anchor".$prop_key.$row_num."\">
            </span><a href=\"#anchor".$prop_key.$row_num."\" onClick=\" document.
            getElementById('".$prop_key.$row_num."').value='';\"><img src=\"images/clear.jpg\" style=\"width:18px;\" /></a>";
        }
        if (isset ($this->date_fields[$prop_key]))  {
            $picker_script = "
                <script>
                    $(\"#".$prop_key.$row_num."\").AnyTime_noPicker();
                    AnyTime.picker( \"".$prop_key.$row_num."\",
                        { format: \"%z-%m-%d\", firstDOW: 1 } );
                </script>";
            $cont_div = "date_cont_div";
        }
        
        if (isset ($this->time_fields[$prop_key]))  {
            $picker_script = "
                <script>
                    $(\"#".$prop_key.$row_num."\").AnyTime_noPicker();
                    $(\"#".$prop_key.$row_num."\").AnyTime_picker(
                        { format: \"%H:%i\", labelTitle: \"Время\",
                            labelHour: \"Час\", labelMinute: \"Минуты\" } );
                </script>";
            $cont_div = "time_cont_div";
        }
        
        if (isset ($this->date_time_fields[$prop_key]))  {
            $picker_script = "
                <script>
                    $(\"#".$prop_key.$row_num."\").AnyTime_noPicker();
                    $(\"#".$prop_key.$row_num."\").AnyTime_picker(
                        { format: \"%z-%m-%d %H:%i\", labelTitle: \"Время\",
                            labelHour: \"Час\", labelMinute: \"Минуты\" } );
                </script>";
            $cont_div = "date_time_cont_div";
            //if ($value==null)   {
            //    $value=date('Y-m-d H:i',time());
            //}
        }
        
        //$picker_script = "";
        
        if (isset($this->class_specify_fields[$prop_key]))
                $cont_div .= $this->class_specify_fields[$prop_key];
        
        if (isset($this->hidden_keys[$prop_key]))   {
            return $this->get_input_text_hidden($prop_key.$row_num, $inp_width, $value, $prev_text);
        }   else    {
            if (isset($this->text_area_fields[$prop_key]))   {
                    return $this->get_input_text_area($prop_key.$row_num, $inp_width, $value, 
                            $prev_text,$this->text_area_fields[$prop_key]).$picker_script;
            }
            else    {
                    if (isset($this->mixed_with_select_choise_inputs[$prop_key]))
                        return $this->get_input_text_mixed_select($prop_key.$row_num, $inp_width, $value, $prev_text, 
                            $this->mixed_with_select_choise_inputs[$prop_key]).$picker_script;
                    else if (isset($this->checkbox_fields[$prop_key]))
                        return $this->get_input_checkbox($prop_key.$row_num, $inp_width, 
                                $value, $prev_text).$picker_script;
                    else    {
                                if (isset($this->disabled_inputs[$prop_key]))
                                    return $this->get_disabled_input_text($prop_key.$row_num, $inp_width, $value, $prev_text).$picker_script;
                                else 
                                    return "<table border=\"0\"><tr><td>".$this->get_input_text_with_class($prop_key.$row_num, 
                                        $inp_width, $value, $prev_text,$cont_div, $title_text)."</td><td>".
                                        $clear_button_code."</td></tr></table>".$picker_script; 
                        
                            }
            }
        }
       
     }
     
     function writeFilterForm($select_arrays, $filter_values_array)   {
         
         $form_elements_array = array();
         
         $foreign_key_names = array_keys($this->foreigen_keys);
         $select_array_names = array_keys($select_arrays);

         foreach($foreign_key_names as $foreign_key_name)    {
            foreach($select_array_names as $select_array_name)    {
                if ($this->class_name."_filt_".$foreign_key_name==$select_array_name)  {
                    $current_select_array = $select_arrays[$select_array_name];
                    if ($this->filter_form_template==null) {
                        echo $this->write_filter_select_field($select_array_name, 
                                $foreign_key_name, $current_select_array);
                    
                        //print_r($current_select_array);
                    }
                    else    
                        $form_elements_array[$foreign_key_name] = 
                            $this->write_filter_select_field($select_array_name, 
                                    $foreign_key_name, $current_select_array);
                }
            }
         }
         
         $filter_values_names = array_keys($this->filter_values_keys);
         $values_array_names = array_keys($filter_values_array);

         foreach($values_array_names as $values_array_name)    {
             foreach($filter_values_names as $filter_values_name)   {
                 if ($this->class_name."_filt_".$filter_values_name==$values_array_name)  {
                        if ($this->filter_form_template==null)  {
                            if (isset($select_arrays[$values_array_name]))  {
                                echo $this->write_filter_select_field($values_array_name, 
                                    $filter_values_name, $select_arrays[$values_array_name]);
                            }
                            else
                                echo $this->write_input_text_field_filter($filter_values_name, 
                                    $filter_values_array[$values_array_name], $values_array_name);
                            }
                        else    {
                            if (isset($select_arrays[$values_array_name]))  {
                                $form_elements_array[$filter_values_name] = 
                                    $this->write_filter_select_field($values_array_name, 
                                        $filter_values_name, $select_arrays[$values_array_name]);
                            }
                            else
                                $form_elements_array[$filter_values_name] = 
                                    $this->write_input_text_field_filter($filter_values_name, 
                                        $filter_values_array[$values_array_name], $values_array_name);
                        }
                 }
             }
         }
        
         $this->getFormFromTemplate($form_elements_array, $this->filter_form_template);
        
     }
     
     function writeFilterFormWithValues($select_arrays, $filter_values_array, $select_values)   {
         
         $form_elements_array = array();
         
         $foreign_key_names = array_keys($this->foreigen_keys);
         $select_array_names = array_keys($select_arrays);

         foreach($foreign_key_names as $foreign_key_name)    {
            foreach($select_array_names as $select_array_name)    {
                if ($this->class_name."_filt_".$foreign_key_name==$select_array_name)  {
                    $current_select_array = $select_arrays[$select_array_name];
                    $curr_select_value = null;
                    if(isset($select_values[$foreign_key_name]))
                        $curr_select_value = $select_values[$foreign_key_name];
                    if ($this->filter_form_template==null) {
                        echo $this->write_filter_select_field_with_value($select_array_name, 
                                $foreign_key_name, $current_select_array, $curr_select_value);
                    
                        //print_r($current_select_array);
                    }
                    else    
                        $form_elements_array[$foreign_key_name] = 
                            $this->write_filter_select_field_with_value($select_array_name, 
                                    $foreign_key_name, $current_select_array, $curr_select_value);
                }
            }
         }
         
         $filter_values_names = array_keys($this->filter_values_keys);
         $values_array_names = array_keys($filter_values_array);

         foreach($values_array_names as $values_array_name)    {
             foreach($filter_values_names as $filter_values_name)   {
                 if ($this->class_name."_filt_".$filter_values_name==$values_array_name)  {
                        $curr_select_value = null;
                        if(isset($select_values[$filter_values_name]))
                            $curr_select_value = $select_values[$filter_values_name];
                        if ($this->filter_form_template==null)  {
                            if (isset($select_arrays[$values_array_name]))  {
                                echo $this->write_filter_select_field_with_value($values_array_name, 
                                    $filter_values_name, $select_arrays[$values_array_name], 
                                        $curr_select_value);
                            }
                            else
                                echo $this->write_input_text_field_filter($filter_values_name, 
                                    $filter_values_array[$values_array_name], $values_array_name);
                            }
                        else    {
                            if (isset($select_arrays[$values_array_name]))  {
                                $form_elements_array[$filter_values_name] = 
                                    $this->write_filter_select_field_with_value($values_array_name, 
                                        $filter_values_name, $select_arrays[$values_array_name], 
                                        $curr_select_value);
                            }
                            else
                                $form_elements_array[$filter_values_name] = 
                                    $this->write_input_text_field_filter($filter_values_name, 
                                        $filter_values_array[$values_array_name], $values_array_name);
                        }
                 }
             }
         }
        
         $this->getFormFromTemplate($form_elements_array, $this->filter_form_template);
        
     }
     
     function write_filter_select_field_with_value_with_js($filter_key_name, $foreign_key_name, 
             $select_array, $value, $events_js)  {
        $inp_width = 50;
        $prev_text = $foreign_key_name;
        if (isset($this->fields_prev_text_array[$foreign_key_name]))
            $prev_text = $this->fields_prev_text_array[$foreign_key_name];
        if (isset($this->fields_width_array[$foreign_key_name]))
            $inp_width = $this->fields_width_array[$foreign_key_name];
        
        return $this->generate_select_with_value_with_js($filter_key_name, $select_array, "id", "select_name", 
                $inp_width, $prev_text, $value, $events_js);
        //print_r($select_array);
     }
     
     function writeFilterFormWithValuesWithNum($select_arrays, $filter_values_array, $select_values, $current_num, $filter_js)   {
         
         $form_elements_array = array();
         
         //print_r($filter_values_array);
         
         $foreign_key_names = array_keys($this->foreigen_keys);
         $select_array_names = array_keys($select_arrays);

         foreach($foreign_key_names as $foreign_key_name)    {
            foreach($select_array_names as $select_array_name)    {
                if ($this->class_name."_filt_".$foreign_key_name==$select_array_name)  {
                    $current_select_array = $select_arrays[$select_array_name];
                    $curr_select_value = null;
                    if(isset($select_values[$foreign_key_name]))
                        $curr_select_value = $select_values[$foreign_key_name];
                    if ($this->filter_form_template==null) {
                        echo $this->write_filter_select_field_with_value_with_js($select_array_name.$current_num, 
                                $foreign_key_name, $current_select_array, $curr_select_value, $filter_js);
                    
                        //print_r($current_select_array);
                    }
                    else    
                        $form_elements_array[$foreign_key_name] = 
                            $this->write_filter_select_field_with_value_with_js($select_array_name.$current_num, 
                                    $foreign_key_name, $current_select_array, $curr_select_value, $filter_js);
                }
            }
         }
         
         $filter_values_names = array_keys($this->filter_values_keys);
         $values_array_names = array_keys($filter_values_array);

         foreach($values_array_names as $values_array_name)    {
             foreach($filter_values_names as $filter_values_name)   {
                 if ($this->class_name."_filt_".$filter_values_name==$values_array_name)  {
                        $curr_select_value = null;
                        if(isset($select_values[$filter_values_name]))
                            $curr_select_value = $select_values[$filter_values_name];
                        if ($this->filter_form_template==null)  {
                            if (isset($select_arrays[$values_array_name]))  {
                                echo $this->write_filter_select_field_with_value_with_js($values_array_name.$current_num, 
                                    $filter_values_name, $select_arrays[$values_array_name], 
                                        $curr_select_value, $filter_js);
                            }
                            else
                                echo $this->write_input_text_field_filter($filter_values_name, 
                                    $filter_values_array[$values_array_name], $values_array_name.$current_num, $filter_js);
                            }
                        else    {
                            if (isset($select_arrays[$values_array_name]))  {
                                $form_elements_array[$filter_values_name] = 
                                    $this->write_filter_select_field_with_value_with_js($values_array_name.$current_num, 
                                        $filter_values_name, $select_arrays[$values_array_name], 
                                        $curr_select_value, $filter_js);
                            }
                            else
                                $form_elements_array[$filter_values_name] = 
                                    $this->write_input_text_field_filter($filter_values_name, 
                                        $filter_values_array[$values_array_name], $values_array_name.$current_num, $filter_js);
                        }
                 }
             }
         }
        
         $this->getFormFromTemplate($form_elements_array, $this->filter_form_template);
        
     }
     
     function getFormFromTemplate($elements_array, $template)  {
         if (sizeof($elements_array)>0) {
             if ($template!=null)    {
                 $form_elements_keys = array_keys($elements_array);
                 $template_modified = $template;
                 foreach($form_elements_keys as $form_elements_key) {
                     $template_modified = str_replace("***___".$form_elements_key,
                             $elements_array[$form_elements_key], $template_modified);
                 }
                 
                 echo $template_modified;
                 
             }
         }
         
     } 
     
     function getMeFormFromTemplate($elements_array, $template)  {
         if (sizeof($elements_array)>0) {
             if ($template!=null)    {
                 $form_elements_keys = array_keys($elements_array);
                 $template_modified = $template;
                 foreach($form_elements_keys as $form_elements_key) {
                     $template_modified = str_replace("***___".$form_elements_key,
                             $elements_array[$form_elements_key], $template_modified);
                 }
                 
                 return $template_modified;
                 
             }  else
                    return "";
         }  else
             return "";
         
     } 
     
     function generateAddInsertJSParamsWithNum($manip_mode, $current_row_num) {
        $result="";
        $prop_array = $this->getParamArray($manip_mode);
        
        $prop_keys = array_keys($prop_array);
        $prop_values = array_values($prop_array);
        $limit=0;
        foreach ($prop_keys as $prop_key)  {
            if ($limit>0)
               $result = $result.", "; 
            $result = $result.$prop_key.":'".$prop_key.$current_row_num."'";
            
            $limit++;
        }
        return $result;
     }
     
     function generateAddInsertJSParams($manip_mode) {
        $result="";
        $prop_array = $this->getParamArray($manip_mode);
        
        $prop_keys = array_keys($prop_array);
        $prop_values = array_values($prop_array);
        $limit=0;
        foreach ($prop_keys as $prop_key)  {
            if ($limit>0)
               $result = $result.", "; 
            $result = $result.$prop_key.":'".$prop_key."'";
            
            $limit++;
        }
        return $result;
     }
     
     function generateEditFillScript($object)   {
        //$action_fill_js = " fillContainer(); ";
        $result=" showElement('change_button_default'); fillEditForm({ ";
        $prop_array = $object->getPropArray();
        
        $prop_keys = array_keys($prop_array);
        //$prop_values = array_values();
        $limit=0;
        foreach ($prop_keys as $prop_key)  {
            if ($limit>0)
               $result = $result.", ";
            if (array_key_exists($prop_key, $this->format_float_fields))
                 $prop_array[$prop_key]=number_format($prop_array[$prop_key], 2, '.', '');   
            $result = $result.$prop_key.":'".str_replace("\"","&quot;",str_replace("\n","<br>", addslashes($prop_array[$prop_key])))."'";
            
            $limit++;
        }
        $result = $result." });";
        return $result;
     }
     
     function generateEditFillScriptWithSuffix($object)   {
        //$action_fill_js = " fillContainer(); ";
        $result=" showElement('change_button_default'); fillEditForm({ ";
        $prop_array = $object->getPropArray();
        
        $prop_keys = array_keys($prop_array);
        //$prop_values = array_values();
        $limit=0;
        foreach ($prop_keys as $prop_key)  {
            if ($limit>0)
               $result = $result.", "; 
            if (array_key_exists($prop_key, $this->format_float_fields))
                 $prop_array[$prop_key]=number_format($prop_array[$prop_key], 2, '.', '');  
            $result = $result.$prop_key.$this->class_name.$this->num_suffix.":'".str_replace("\"","&quot;",str_replace("\n","<br>", addslashes($prop_array[$prop_key])))."'";
            
            $limit++;
        }
        $result = $result." });";
        return $result;
     }
     
     function generateEditFillScriptWithNum($object, $current_row_num)   {
        $set_currently_name_js = "";
        if (isset($object->relative_props['identity_name']))    {
            $set_currently_name_js = " setInnerHtmlByClass('current_object_identity','<b>Объект: </b>".
                str_replace("\"","&quot;",str_replace("\n","<br>", 
                addslashes($object->relative_props['identity_name'])))."');";
        }
        $action_fill_js = " fillContainer( 'actions_{$this->class_name}{$current_row_num}','actions_container_{$this->class_name}'); ";
        $result=" showElement('change_button_default'); {$action_fill_js} fillEditForm({ ";
        $prop_array = $object->getPropArray();
        
        $prop_keys = array_keys($prop_array);
        //$prop_values = array_values();
        $limit=0;
        foreach ($prop_keys as $prop_key)  {
            if ($limit>0)
               $result = $result.", "; 
            if (array_key_exists($prop_key, $this->format_float_fields))
                 $prop_array[$prop_key]=number_format($prop_array[$prop_key], 2, '.', '');  
            $result = $result.$prop_key.":'".str_replace("\"","&quot;",str_replace("\n","<br>", addslashes($prop_array[$prop_key])))."'";
            
            $limit++;
        }
        $result = $result." }); {$set_currently_name_js} ";
        return $result;
     }
     
     function generateEditFillScriptWithNumAndSuffix($object, $current_row_num)   {
        $set_currently_name_js = "";
        if (isset($object->relative_props['identity_name']))    {
            $set_currently_name_js = " setInnerHtmlByClass('current_object_identity','<b>Объект: </b>".
                str_replace("\"","&quot;",str_replace("\n","<br>", 
                addslashes($object->relative_props['identity_name'])))."');";
        }
        $action_fill_js = " fillContainer( 'actions_{$this->class_name}{$current_row_num}','actions_container_{$this->class_name}{$this->num_suffix}'); ";
        $result=" showElement('change_button_default'); {$action_fill_js} fillEditForm({ ";
        $prop_array = $object->getPropArray();
        
        $prop_keys = array_keys($prop_array);
        //$prop_values = array_values();
        $limit=0;
        foreach ($prop_keys as $prop_key)  {
            if ($limit>0)
               $result = $result.", ";
            //if (array_key_exists($prop_key, $this->format_float_fields))
            //     $prop_array[$prop_key]=number_format ($prop_array[$prop_key], 2, '.', ' ');  
            $result = $result.$prop_key.$this->class_name.$this->num_suffix.":'".str_replace("\"","&quot;",str_replace("\n","",str_replace("\r\n","", addslashes((isset($this->format_float_fields[$prop_key])?number_format($prop_array[$prop_key], 2, '.', ''):$prop_array[$prop_key])))))."'";
            
            $limit++;
        }
        $result = $result." }); {$set_currently_name_js} ";
        return $result;
     }
     
     function generateDetailFillScript($object)   {
        $detail_params=" { ";
        $prop_array = $object->getFullPropArray();
        
        $prop_keys = array_keys($prop_array);
        //$prop_values = array_values();
        $limit=0;
        foreach ($prop_keys as $prop_key)  {
            if ($limit>0)
               $detail_params .= ", "; 
            $detail_params .= ("{$prop_key}:'".str_replace("\n","<br>",addslashes($prop_array[$prop_key]))."'");
            
            $limit++;
        }
        $detail_params .= " }";
        $result_container_id = $GLOBALS['dict_detail_base'];
        return " showPopup(); ajaxGetRequest('".$GLOBALS['out_detail_php']."', '{$this->class_name}', 
         '{$GLOBALS['select_mode']}', {$detail_params}, '0', '{$result_container_id}');";
     }
     
     function getObjectIntAddrParams($object)   {
         $addr_params = "";
         $prop_array = $object->getFullPropArray();
         $props_keys = array_keys($prop_array);
         foreach($props_keys as $props_key)  {
             
             if(strcmp((int)$prop_array[$props_key],$prop_array[$props_key])==0)    {
                 //echo $props_key;
                 $addr_params .= "&{$props_key}={$prop_array[$props_key]}";
             }
         }
         return $addr_params;
     }
     
     function generateBlankDetailHREF($object)   {
        return "<a href=\"out_detail.php?class_name={$this->class_name}".
                $this->getObjectIntAddrParams($object)."\" target=\"_blank\">В отд. окне</a>";
     }
     
     function getParamArray($manip_mode) {
        $parse_object = $this->getDataClassInstance();
        if ($manip_mode==$GLOBALS['partial_update_manip_mode'])
            $prop_array = $parse_object->getFullPropArray();
        else
            $prop_array = $parse_object->getPropArray();
        if ($manip_mode==$GLOBALS['insert_manip_mode']) {
            unset($prop_array['id']);
        }
        if ($manip_mode==$GLOBALS['delete_manip_mode']) {
            $del_prop_array = array();
            $del_prop_array['id'] = $prop_array['id'];
            $prop_array = $del_prop_array;
        }
        return $prop_array;
     }
     
     function prepareParamArray($get_array, $manip_mode) {
        $requre_params=$this->getParamArray($manip_mode);
        $get_param_array = array();
        $get_keys_array = array_keys($get_array);
        $require_keys_array = array_keys($requre_params);
        foreach ($get_keys_array as $get_key)   {
            foreach($require_keys_array as $require_key)    {
                if(($get_key==$require_key))    {
                    if (($manip_mode==$GLOBALS['partial_update_manip_mode'])||
                        ($manip_mode==$GLOBALS['fast_append_manip_mode'])){
                        $get_param_array[$get_key] = $get_array[$get_key];
                    }
                    else
                        $get_param_array[":".$get_key] = $get_array[$get_key];
                }
            }
        }
        return $get_param_array;
     }
     
     function write_input_text_field_filter($prop_key, $value, $filter_key, $events = null) {
        $inp_width = 50;
        $prev_text = $prop_key;
        if (isset($this->fields_prev_text_array[$prop_key]))
            $prev_text = $this->fields_prev_text_array[$prop_key];
        if (isset($this->filter_values_keys[$prop_key]))
            $inp_width = $this->filter_values_keys[$prop_key];
            
        $picker_script = "";
        $cont_div = "";
        if (isset ($this->date_fields[$prop_key]))  {
            $picker_script = "
                <script>
                    AnyTime.picker( \"{$filter_key}\",
                        { format: \"%z-%m-%d\", firstDOW: 1 } );
                </script>";
            $cont_div = "date_cont_div";
        }
        
        if (isset ($this->time_fields[$prop_key]))  {
            $picker_script = "
                <script>
                    $(\"#{$filter_key}\").AnyTime_picker(
                        { format: \"%H:%i\", labelTitle: \"Время\",
                            labelHour: \"Час\", labelMinute: \"Минуты\" } );
                </script>";
            $cont_div = "time_cont_div";
        }
        
        if (isset ($this->date_time_fields[$prop_key]))  {
            $picker_script = "
                <script>
                    $(\"#{$filter_key}\").AnyTime_picker(
                        { format: \"%z-%m-%d %H:%i\", labelTitle: \"Время\",
                            labelHour: \"Час\", labelMinute: \"Минуты\" } );
                </script>";
            $cont_div = "date_time_cont_div";
        }
        
        if ($events==null)  
        return  $this->get_input_text_with_class($filter_key, 
                                            $inp_width, $value, $prev_text,$cont_div).$picker_script;
        else
            return $this->get_input_text_with_class_and_events ($filter_key, 
                                            $inp_width, $value, $prev_text,$cont_div, $events).$picker_script;
        ////$this->get_input_text($filter_key, $inp_width, $value, $prev_text).$picker_script;
       
     }
     
     function write_input_text_field($prop_key, $value) {
        $inp_width = 50;
        $prev_text = $prop_key;
        if (isset($this->fields_prev_text_array[$prop_key]))
            $prev_text = $this->fields_prev_text_array[$prop_key];
        if (isset($this->fields_width_array[$prop_key]))
            $inp_width = $this->fields_width_array[$prop_key];
            
        $picker_script = "";
        $clear_button_code = "";
        if (array_key_exists($prop_key, $this->with_button_clear_fields))   {
            $clear_button_code = "<span id=\"anchor{$prop_key}\">
            </span><a href=\"#anchor{$prop_key}\" onClick=\" document.
            getElementById('{$prop_key}').value='';\"><img src=\"images/clear.jpg\" style=\"width:18px;\" /></a>";
        }
        if (isset ($this->date_fields[$prop_key]))  {
            $picker_script = "
                <script>
                    AnyTime.picker( \"{$prop_key}\",
                        { format: \"%z-%m-%d\", firstDOW: 1 } );
                </script>";
        }
        
        if (isset ($this->time_fields[$prop_key]))  {
            $picker_script = "
                <script>
                    $(\"#{$prop_key}\").AnyTime_picker(
                        { format: \"%H:%i\", labelTitle: \"Время\",
                            labelHour: \"Час\", labelMinute: \"Минуты\" } );
                </script>";
        }
        
        if (isset ($this->date_time_fields[$prop_key]))  {
            $picker_script = "
                <script>
                    $(\"#{$prop_key}\").AnyTime_picker(
                        { format: \"%z-%m-%d %H:%i\", labelTitle: \"Время\",
                            labelHour: \"Час\", labelMinute: \"Минуты\" } );
                </script>";
        }
        
        $picker_script = $picker_script;
        
        if (isset($this->hidden_keys[$prop_key]))   {
            return $this->get_input_text_hidden($prop_key, $inp_width, $value, $prev_text);
        }   else    {
            if (isset($this->text_area_fields[$prop_key]))   {
                    return $this->get_input_text_area($prop_key, $inp_width, $value, 
                            $prev_text,$this->text_area_fields[$prop_key]).$picker_script;
            }
            else    {
                if (isset($this->mixed_with_select_choise_inputs[$prop_key]))
                    return $this->get_input_text_mixed_select($prop_key, $inp_width, $value, $prev_text, 
                            $this->mixed_with_select_choise_inputs[$prop_key]).$picker_script;
                else if (isset($this->checkbox_fields[$prop_key]))
                    return $this->get_input_checkbox($prop_key, $inp_width, $value, $prev_text).$picker_script;
                else
                {
                    if (isset($this->disabled_inputs[$prop_key]))
                        return $this->get_disabled_input_text($prop_key, $inp_width, $value, $prev_text).$picker_script;
                    else            
                        return "<table border=\"0\"><tr><td>".
                            $this->get_input_text($prop_key, $inp_width, $value, $prev_text)."</td><td>".
                                        $clear_button_code."</td></tr></table>".$picker_script;
                }
            }
        }
       
     }
     
     function write_input_text_field_with_num($prop_key, $value, $row_num) {
        $inp_width = 50;
        $prev_text = $prop_key;
        if (isset($this->fields_prev_text_array[$prop_key]))
            $prev_text = $this->fields_prev_text_array[$prop_key];
        if (isset($this->fields_width_array[$prop_key]))
            $inp_width = $this->fields_width_array[$prop_key];
        
        $title_text="";
        if (isset($this->field_titles[$prop_key]))
            $title_text = $this->field_titles[$prop_key];
            
        $picker_script = "";
        $cont_div = "";
        $clear_button_code = "";
        if (array_key_exists($prop_key, $this->with_button_clear_fields))   {
            $clear_button_code = "<span id=\"anchor".$prop_key.$row_num."\">
            </span><a href=\"#anchor".$prop_key.$row_num."\" onClick=\" document.
            getElementById('".$prop_key.$row_num."').value='';\"><img src=\"images/clear.jpg\" style=\"width:16px;\" /></a>";
        }
        if (isset ($this->date_fields[$prop_key]))  {
            $picker_script = "
                <script>
                    $(\"#".$prop_key.$row_num."\").AnyTime_noPicker();
                    AnyTime.picker( \"".$prop_key.$row_num."\",
                        { format: \"%z-%m-%d\", firstDOW: 1 } );
                </script>";
            $cont_div = "date_cont_div";
        }
        
        if (isset ($this->time_fields[$prop_key]))  {
            $picker_script = "
                <script>
                    $(\"#".$prop_key.$row_num."\").AnyTime_noPicker();
                    $(\"#".$prop_key.$row_num."\").AnyTime_picker(
                        { format: \"%H:%i\", labelTitle: \"Время\",
                            labelHour: \"Час\", labelMinute: \"Минуты\" } );
                </script>";
            $cont_div = "time_cont_div";
        }
        
        if (isset ($this->date_time_fields[$prop_key]))  {
            $picker_script = "
                <script>
                    $(\"#".$prop_key.$row_num."\").AnyTime_noPicker();
                    $(\"#".$prop_key.$row_num."\").AnyTime_picker(
                        { format: \"%z-%m-%d %H:%i\", labelTitle: \"Время\",
                            labelHour: \"Час\", labelMinute: \"Минуты\" } );
                </script>";
            $cont_div = "date_time_cont_div";
            //if ($value==null)   {
            //    $value=date('Y-m-d H:i',time());
            //}
        }
        
        //$picker_script = "";
        if (isset($this->class_specify_fields[$prop_key]))
                $cont_div .= $this->class_specify_fields[$prop_key];
        
        if (isset($this->hidden_keys[$prop_key]))   {
            return $this->get_input_text_hidden($prop_key.$row_num, $inp_width, $value, $prev_text);
        }   else    {
            if (isset($this->text_area_fields[$prop_key]))   {
                    return $this->get_input_text_area($prop_key.$row_num, $inp_width, $value, 
                            $prev_text,$this->text_area_fields[$prop_key], $title_text).$picker_script;
            }
            else    {
                    if (isset($this->mixed_with_select_choise_inputs[$prop_key]))
                        return $this->get_input_text_mixed_select($prop_key.$row_num, $inp_width, $value, $prev_text, 
                            $this->mixed_with_select_choise_inputs[$prop_key]).$picker_script;
                    else if (isset($this->checkbox_fields[$prop_key]))
                        return $this->get_input_checkbox($prop_key.$row_num, $inp_width, 
                                $value, $prev_text).$picker_script;
                    else    {
                                if (isset($this->disabled_inputs[$prop_key]))
                                    return $this->get_disabled_input_text($prop_key.$row_num, $inp_width, $value, $prev_text).$picker_script;
                                else 
                                    if (strlen($clear_button_code)>0)
                                        return "<table border=\"0\" style=\"width:100%;\" 
                                            cellspacing=\"0\" cellpadding=\"0\"><tr><td>".
                                            $this->get_input_text_with_class($prop_key.$row_num, 
                                            $inp_width, $value, $prev_text,$cont_div, $title_text)."</td><td>".
                                            $clear_button_code."</td></tr></table>".$picker_script; 
                                    else
                                        return 
                                            $this->get_input_text_with_class($prop_key.$row_num, 
                                            $inp_width, $value, $prev_text,$cont_div, $title_text).$picker_script;
                            }
            }
        }
       
     }
     
     function write_input_text_field_with_num_and_placement($prop_key, $value, $row_num, $placement) {
        $inp_width = 50;
        $prev_text = $prop_key;
        if (isset($this->fields_prev_text_array[$prop_key]))
            $prev_text = $this->fields_prev_text_array[$prop_key];
        if (isset($this->fields_width_array[$prop_key]))
            $inp_width = $this->fields_width_array[$prop_key];
            
        $picker_script = "";
        $cont_div = "";
        if (isset ($this->date_fields[$prop_key]))  {
            $picker_script = "
                <script>
                    $(\"#".$prop_key.$row_num."\").AnyTime_noPicker();
                    AnyTime.picker( \"".$prop_key.$row_num."\",
                        { format: \"%z-%m-%d\", firstDOW: 1 } );
                </script>";
            $cont_div = "date_cont_div";
        }
        
        if (isset ($this->time_fields[$prop_key]))  {
            $picker_script = "
                <script>
                    $(\"#".$prop_key.$row_num."\").AnyTime_noPicker();
                    $(\"#".$prop_key.$row_num."\").AnyTime_picker(
                        { format: \"%H:%i\", labelTitle: \"Время\",
                            labelHour: \"Час\", labelMinute: \"Минуты\" } );
                </script>";
            $cont_div = "time_cont_div";
        }
        
        if (isset ($this->date_time_fields[$prop_key]))  {
            $picker_script = "
                <script>
                    $(\"#".$prop_key.$row_num."\").AnyTime_noPicker();
                    $(\"#".$prop_key.$row_num."\").AnyTime_picker(
                        { format: \"%z-%m-%d %H:%i\", labelTitle: \"Время\",
                            labelHour: \"Час\", labelMinute: \"Минуты\" } );
                </script>";
            $cont_div = "date_time_cont_div";
            //if ($value==null)   {
            //    $value=date('Y-m-d H:i',time());
            //}
        }
        
        //$picker_script = "";
        
        if (isset($this->class_specify_fields[$prop_key]))
                $cont_div .= $this->class_specify_fields[$prop_key];
        
        if (isset($this->hidden_keys[$prop_key]))   {
            return $this->get_input_text_hidden($prop_key.$row_num, $inp_width, $value, $prev_text);
        }   else    {
            if (isset($this->text_area_fields[$prop_key]))   {
                    return $this->get_input_text_area($prop_key.$row_num, $inp_width, $value, 
                            $prev_text,$this->text_area_fields[$prop_key]).$picker_script;
            }
            else    {
                    if (isset($this->mixed_with_select_choise_inputs[$prop_key]))
                        return $this->get_input_text_mixed_select($prop_key.$row_num, $inp_width, $value, $prev_text, 
                            $this->mixed_with_select_choise_inputs[$prop_key]).$picker_script;
                    else if (isset($this->checkbox_fields[$prop_key]))
                        return $this->get_input_checkbox($prop_key.$row_num, $inp_width, 
                                $value, $prev_text).$picker_script;
                    else    
                        return $this->get_input_text_with_class_and_placement($prop_key.$row_num, 
                            $inp_width, $value, $prev_text,$cont_div,$placement).$picker_script;
            }
        }
       
     }
     
     function write_select_field($foreign_key_name, $select_array)  {
        $inp_width = 50;
        $prev_text = $foreign_key_name;
        if (isset($this->fields_prev_text_array[$foreign_key_name]))
            $prev_text = $this->fields_prev_text_array[$foreign_key_name];
        if (isset($this->fields_width_array[$foreign_key_name]))
            $inp_width = $this->fields_width_array[$foreign_key_name];
        
        if (isset($this->hidden_keys[$foreign_key_name]))   {
            return $this->generate_select_hidden($foreign_key_name, $select_array, "id", "select_name", 
                $inp_width, $prev_text);
        }   else
            return $this->generate_select($foreign_key_name, $select_array, "id", "select_name", 
                $inp_width, $prev_text);
        //print_r($select_array);
     }
     
     function write_select_field_with_num($foreign_key_name, $select_array, $row_num)  {
        $inp_width = 50;
        $prev_text = $foreign_key_name;
        if (isset($this->fields_prev_text_array[$foreign_key_name]))
            $prev_text = $this->fields_prev_text_array[$foreign_key_name];
        if (isset($this->fields_width_array[$foreign_key_name]))
            $inp_width = $this->fields_width_array[$foreign_key_name];
        
        if (isset($this->hidden_keys[$foreign_key_name]))   {
            return $this->generate_select_hidden($foreign_key_name.$row_num, $select_array, "id", "select_name", 
                $inp_width, $prev_text);
        }   else
            return $this->generate_select($foreign_key_name.$row_num, $select_array, "id", "select_name", 
                $inp_width, $prev_text);
        //print_r($select_array);
     }
     
     function write_select_field_with_num_and_value($foreign_key_name, $select_array, $row_num, $value)  {
        $inp_width = 50;
        $prev_text = $foreign_key_name;
        if (isset($this->fields_prev_text_array[$foreign_key_name]))
            $prev_text = $this->fields_prev_text_array[$foreign_key_name];
        if (isset($this->fields_width_array[$foreign_key_name]))
            $inp_width = $this->fields_width_array[$foreign_key_name];
        
        $title_text="";
        if (isset($this->field_titles[$foreign_key_name]))
            $title_text = $this->field_titles[$foreign_key_name];
        
        if (isset($this->hidden_keys[$foreign_key_name]))   {
            return $this->get_input_text_hidden($foreign_key_name.$row_num,
                ////generate_select_hidden($foreign_key_name.$row_num, $select_array, "id", "select_name", 
                $inp_width, $value, $prev_text);
        }   else
            return $this->generate_select_with_value($foreign_key_name.$row_num, $select_array, "id", "select_name", 
                $inp_width, $prev_text, $value, $title_text);
        //print_r($select_array);
     }
     
     function write_ids_select_field_with_num_and_value($foreign_key_name, $select_array, $row_num, $value)  {
        $inp_width = 50;
        $prev_text = $foreign_key_name;
        if (isset($this->fields_prev_text_array[$foreign_key_name]))
            $prev_text = $this->fields_prev_text_array[$foreign_key_name];
        if (isset($this->fields_width_array[$foreign_key_name]))
            $inp_width = $this->fields_width_array[$foreign_key_name];
        
        if (isset($this->hidden_keys[$foreign_key_name]))   {
            return $this->get_input_text_hidden($foreign_key_name.$row_num,
                ////generate_select_hidden($foreign_key_name.$row_num, $select_array, "id", "select_name", 
                $inp_width, $value, $prev_text);
        }   else
        return $this->generate_ids_select_with_value($foreign_key_name.$row_num, $select_array, "id", "select_name", 
           $inp_width, $prev_text, $value);
        //print_r($select_array);
     }
     
     function write_filter_select_field($filter_key_name, $foreign_key_name, $select_array)  {
        $inp_width = 50;
        $prev_text = $foreign_key_name;
        if (isset($this->fields_prev_text_array[$foreign_key_name]))
            $prev_text = $this->fields_prev_text_array[$foreign_key_name];
        if (isset($this->fields_width_array[$foreign_key_name]))
            $inp_width = $this->fields_width_array[$foreign_key_name];
        
        return $this->generate_select($filter_key_name, $select_array, "id", "select_name", 
                $inp_width, $prev_text);
        //print_r($select_array);
     }
     
     function write_filter_select_field_with_value($filter_key_name, $foreign_key_name, 
             $select_array, $value)  {
        $inp_width = 50;
        $prev_text = $foreign_key_name;
        if (isset($this->fields_prev_text_array[$foreign_key_name]))
            $prev_text = $this->fields_prev_text_array[$foreign_key_name];
        if (isset($this->fields_width_array[$foreign_key_name]))
            $inp_width = $this->fields_width_array[$foreign_key_name];
        
        return $this->generate_select_with_value($filter_key_name, $select_array, "id", "select_name", 
                $inp_width, $prev_text, $value);
        //print_r($select_array);
     }
    
}

?>