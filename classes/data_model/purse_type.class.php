<?php

/**
 * @author 
 * @copyright 2011
 */

include_once(dirname(__FILE__)."/data_object.class.php");

class PurseType extends DataObject  {
    public $purse_type_name;
    //public $purse_logo_img;
    
    function __construct($purse_type)    {
        parent::__construct($purse_type['purse_type_id']);
        $this->purse_type_name = $purse_type['purse_type_name'];
    }
}

?>
