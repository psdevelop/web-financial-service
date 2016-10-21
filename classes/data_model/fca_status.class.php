<?php

/* 19.05.2012
 * @author Poltarokov SP
 * @copyright 2012
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

if (!defined("ABSOLUTE_PATH"))
    define("ABSOLUTE_PATH", dirname(__FILE__)."/../../");

require_once(constant("ABSOLUTE_PATH")."classes/data_model/data_object.class.php");

class FCAStatus extends DataObject  {
    public $act_status_name;
    
    function __construct($category)    {
        parent::__construct($category['action_status_id']);
        $this->act_status_name = $category['act_status_name'];
    }
}

?>
