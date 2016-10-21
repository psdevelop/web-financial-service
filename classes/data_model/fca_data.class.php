<?php

/**
 * @author Poltarokov SP
 * @copyright 2011
 */

include_once(dirname(__FILE__)."/data_object.class.php");

class FinanceActData extends DataObject  {
        public $fca_purse_id;
        public $fca_category_id;
	//public $fca_actor_id;
	//public $fca_quantity;
	public $fca_summ;
        public $fca_actor_description;
        public $fca_date;
        public $fca_description;
        public $fca_operation_type_id;
        public $fca_transfert_purse_id;
        public $fca_status_id;
        public $fca_currency_id;
    
    function __construct($fca_data)    {
        parent::__construct($fca_data['fca_id']);
        $this->fca_purse_id = $fca_data['fca_purse_id'];
        $this->fca_category_id = $fca_data['fca_category_id'];
	$this->relative_props['fca_quantity'] = $fca_data['fca_quantity'];
	$this->fca_summ = $fca_data['fca_summ'];
        $this->fca_actor_description = $fca_data['fca_actor_description'];
        $this->fca_date = $fca_data['fca_date'];
        $this->fca_description = $fca_data['fca_description'];
        $this->fca_operation_type_id = $fca_data['fca_operation_type_id'];
        $this->fca_transfert_purse_id = $fca_data['fca_transfert_purse_id'];
        $this->fca_status_id = $fca_data['fca_status_id'];
        $this->fca_currency_id = $fca_data['fca_currency_id'];
        if ($this->fca_currency_id==$GLOBALS['unknown_currency_id'])
            $this->fca_currency_id=$GLOBALS['default_system_currency'];
        $this->relative_props['fca_plan_id'] = $fca_data['fca_plan_id'];
        $this->relative_props['fca_actor_id'] = $fca_data['fca_actor_id'];
	$this->relative_props['fca_operation_id'] = $fca_data['fca_operation_id'];
        $this->relative_props['category_name'] = $fca_data['category_name'];
        $this->relative_props['account_type'] = $fca_data['account_type'];//
        $this->relative_props['fca_moment_psumm'] = $fca_data['fca_moment_psumm'];
        $this->relative_props['parent_category_name'] = $fca_data['parent_category_name'];
        $this->relative_props['purse_currency_id'] = $fca_data['purse_currency_id'];
        if ($this->relative_props['purse_currency_id']==$GLOBALS['unknown_currency_id'])
            $this->relative_props['purse_currency_id']=$GLOBALS['default_system_currency'];
        $this->relative_props['parent_category_id'] = $fca_data['parent_category_id'];
    }
}

?>