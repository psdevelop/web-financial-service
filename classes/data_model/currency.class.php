<?php

/**
 * @author Poltarokov SP
 * @copyright 2011
 */

include_once(dirname(__FILE__)."/data_object.class.php");

class Currency extends DataObject  {
    public $currency_name;
    
    function __construct($currency)    {
        parent::__construct($currency['currency_id']);
        $this->dest_point = $currency['currency_name'];
        $this->relative_props['currency_rate'] = $currency['currency_rate'];
    }
}

?>
