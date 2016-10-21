<?php

/**
 * @author Poltarokov SP
 * @copyright 2011
 */

include_once(dirname(__FILE__)."/data_object.class.php");

class Category extends DataObject  {
    public $category_name;
    public $parent_category_id;
    public $category_level;
    
    function __construct($category)    {
        parent::__construct($category['category_id']);
        $this->category_name = $category['category_name'];
        $this->parent_category_id = $category['parent_category_id'];
        $this->category_level = $category['category_level'];
        $this->relative_props['cat_summ'] = $category['cat_summ'];
        $this->relative_props['big_image_path'] = $category['big_image_path'];
        $this->relative_props['small_image_path'] = $category['small_image_path'];
    }
}

?>
