<?php

/**06.05.2012
 * @author Poltarokov SP
 * @copyright 2011
 */

include_once(dirname(__FILE__)."/data_object.class.php");

class Plan extends DataObject  {
    public $plan_name;
    public $plan_summ;
    public $plan_optype_id;
    public $plan_shedule_id;
    public $apr;
    public $default_purse_id;
    public $plan_currency_id;
    public $target_date;
    
    function __construct($plan)    {
        parent::__construct($plan['plan_id'], null);
        $this->plan_name = $plan['plan_name'];
	$this->plan_summ = $plan['plan_summ'];
	$this->plan_optype_id = $plan['plan_optype_id'];
        $this->plan_shedule_id = $plan['plan_shedule_id'];
        $this->apr = $plan['apr'];
        $this->default_purse_id = $plan['default_purse_id'];
        $this->plan_currency_id = $plan['plan_currency_id'];
        $this->target_date = $plan['target_date'];
	$this->relative_props['first_payment_date'] = $plan['first_payment_date'];
        $this->relative_props['complete_month_count'] = $plan['complete_month_count'];
	$this->relative_props['complete_days_count'] = $plan['complete_days_count'];
	$this->relative_props['plan_shedule_id'] = $plan['plan_shedule_id'];
	$this->relative_props['min_payment_summ'] = $plan['min_payment_summ'];
        $this->relative_props['extra_payment'] = $plan['extra_payment'];
    }
}

?>
