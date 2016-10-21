<?php

/**
 * @author 
 * @copyright 2011
 */

include_once(dirname(__FILE__)."/data_object.class.php");

class Purse extends DataObject  {
    public $purse_name;
    public $purse_currency_id;
    public $purse_ptype_id;
    
    function __construct($purse)    {
        parent::__construct($purse['purse_dictionary_id']);
        $this->purse_name = $purse['purse_name'];
        $this->purse_currency_id = $purse['purse_currency_id'];
        $this->purse_ptype_id = $purse['purse_ptype_id'];
        $this->relative_props['purse_logo_img'] = $purse['purse_logo_img'];
        $this->relative_props['pd_dictionary_id'] = $purse['pd_dictionary_id'];
        $this->relative_props['purse_summ'] = $purse['purse_summ'];
        $this->relative_props['purse_currency_name'] = $purse['purse_currency_name'];
        $this->relative_props['purse_currency_id'] = $purse['purse_currency_id'];
    }
}

?>