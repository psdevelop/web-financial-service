<?php

/**
 * @author Poltarokov SP
 * @copyright 2011
 */

include_once(dirname(__FILE__)."/data_object.class.php");

class OperationType extends DataObject  {
    public $optype_name;
    //public $account_type;
    
    function __construct($optype)    {
        parent::__construct($optype['optype_id']);
        $this->optype_name = $optype['optype_name'];
        $this->relative_props['account_type'] = $optype['account_type'];
    }
}

?>
