<?php

/* 17.11.2011
 * @author Poltarokov SP
 * @copyright 2011
 */

function require_once_if_exist($path)   {
    if (!file_exists($path))
        exit('Bad module PATH!');
    require_once($path);
}

if (!defined("ABSOLUTE_PATH"))
    define("ABSOLUTE_PATH", dirname(__FILE__)."/");

require_once(constant("ABSOLUTE_PATH")."classes/table_adapters/fca_data_table_adapter.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/table_adapters/purse_table_adapter.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/table_adapters/category_table_adapter.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/table_adapters/optype_table_adapter.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/table_adapters/currency_table_adapter.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/view_forms/fca_report.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/view_forms/inout_cats_report.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/table_adapters/plan_table_adapter.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/table_adapters/plan_shedule_table_adapter.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/table_adapters/fca_status_table_adapter.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/table_adapters/purse_type_table_adapter.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/table_adapters/invite_table_adapter.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/table_adapters/news_table_adapter.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/action_classess/operation.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/action_classess/action.class.php");
require_once(constant("ABSOLUTE_PATH")."include/ClassExchangeRatesCBRF.php");

?>
