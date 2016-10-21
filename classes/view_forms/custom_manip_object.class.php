<?php

/**25.11.2011
 * @author Poltarokov SP
 * @copyright 2011
 */

class CustomManipObject 
{
    public $manip_type;
    public $manip_js;
    public $adapter_class;
    public $outher_params;
    public $container_id;
    public $manip_caption;
    
    function __construct($manip_type, $adapter_class, $outher_params, $container_id, $manip_caption) {
        $this->manip_type = $manip_type;
        $this->outher_params = $outher_params;
        $this->container_id = $container_id;
        $this->adapter_class = $adapter_class;
        $this->manip_caption = $manip_caption;
    }
    
    function getAfterJSHTML()   {
        if ($this->load_after_write_html) 
            return "<script language=\"JavaScript\" type=\"text/javascript\"> ".
                $this->load_js." </script>";
        else 
            return "";
    }
    
    function getObjectHTML($button_class, $filter_js_params, $part_num, $object, $object_num)    {
        $result_html="";
        if (($this->manip_type==$GLOBALS['fast_append_manip_type'])){
            $reflectionClass = new ReflectionClass($this->adapter_class."TableAdapter");
            $SelectDictTAdapt = $reflectionClass->newInstanceArgs(array(null,
                "", $this->adapter_class));
            $this->manip_js = $SelectDictTAdapt->getManipJSByType($this->manip_type, 
                $this->outher_params, $this->container_id, $filter_js_params, 0);
            echo "<div id=\"{$this->container_id}\"></div>";
            $SelectDictTAdapt->generate_link_button($this->manip_caption, "link_button_default",
                $this->manip_js,$this->container_id."_add_link_id");
        } else if (($this->manip_type==$GLOBALS['fast_append_list_type'])){
            $reflectionClass = new ReflectionClass($this->adapter_class."TableAdapter");
            $SelectDictTAdapt = $reflectionClass->newInstanceArgs(array(null,
                "", $this->adapter_class));
            $this->manip_js = $SelectDictTAdapt->getManipJSByTypeByObject($this->manip_type, 
                $this->outher_params, $this->container_id.$object_num, $filter_js_params, 0, $object);
            $result_html .= "<div id=\"{$this->container_id}{$object_num}\"></div>";
            $result_html .= $SelectDictTAdapt->get_link_button($this->manip_caption, $button_class,
                $this->manip_js,$this->container_id."_add_link_id");
        }   else    {
            
        }
        return $result_html;
    }
    
}

?>