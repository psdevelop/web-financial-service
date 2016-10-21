<?php

/**
 * @author Poltarokov SP
 * @copyright 2011
 */

include_once(dirname(__FILE__)."/data_object.class.php");

class PlanShedule extends DataObject  {
    public $shedule_name;
    
    function __construct($shedule)    {
        parent::__construct($shedule['shedule_id']);
        $this->shedule_name = $shedule['shedule_name'];
    }
}
?>
