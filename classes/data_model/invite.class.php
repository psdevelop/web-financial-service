<?php

/**
 * @author Poltarokov SP
 * @copyright 2011
 */

include_once(dirname(__FILE__)."/data_object.class.php");

class Invite extends DataObject  {
    public $name;
    public $email;
    
    function __construct($category)    {
        parent::__construct($category['id']);
        $this->name = $category['name'];
        $this->email = $category['email'];
        $this->relative_props['date_time'] = $category['date_time'];
    }
}

?>
