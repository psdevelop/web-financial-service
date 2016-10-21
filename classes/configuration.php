<?php

/**
 * @author Poltarokov SP
 * @copyright 2011
 */

$dbhost = 'localhost';
$dbname = 'finance_mgr';
$dbuser = 'root';
$dbpsw = '123456';

$HTTP_SUFFIX = "http://localhost/MyMoneyWEB";
$HTTPS_SUFFIX = "https://localhost/MyMoneyWEB";

$mobile_list_table_mode="mobile_list_table_mode";
$mobile_table_mode="mobile_table_mode";
$insert_list_manip_mode = "insert_list_manip_mode";
$insert_mtable_manip_mode = "insert_mtable_manip_mode";

$unknown_operation_type_id = 0;
$income_operation_type_id = 1;
$outcome_operation_type_id = 2;
$planned_outcome_operation_type_id = 3;
$complete_planned_outcome_operation_type_id = 4;
$planned_debt_payment_operation_type_id = 5;
$complete_planned_debt_payment_operation_type_id = 6;
$planned_income_operation_type_id = 7;
$complete_planned_income_operation_type_id = 8;
$planned_debitor_income_operation_type_id = 9;
$complete_planned_debitor_income_operation_type_id = 10;
$inner_outcome_transfert_operation_type_id=11;
$inner_income_transfert_operation_type_id=12;
$planned_target_outcome_operation_type_id = 13;
$completed_target_outcome_operation_type_id = 14;
$correction_outcome_operation_type_id = 15;
$correction_income_operation_type_id = 16;

$draft_fca_status_id = 1;
$active_fca_status_id = 2;
$conduct_fca_status_id = 3;

$unknown_credit_type = 0;
$annuitent_credit_type = 1;
$differential_credit_type = 2;

$previous_alg_order = "previous_alg_order";
$after_alg_order = "after_alg_order";

$debt_plan_calculating_algorithm = "debt_plan_calculating_algorithm";
$target_plan_calculating_algorithm = "target_plan_calculating_algorithm";

$unknown_currency_id=0;
$rouble_currency_id=1;
$euro_currency_id=2;
$dollar_currency_id=3;

$default_system_currency = $rouble_currency_id;
$cbr_currency_codes = array("RUB", "EUR", "USD");

$payment_systems_ids = array("ASSIST_PS"=>1);
$payment_system_currencies = array("ASSIST_PS"=>
        array("RUB"=>1, "EUR"=>2, "USD"=>3));

$payment_system_settings = array("ASSIST_PS"=>
        array("login"=>"kudapotratil", "password"=>"pzb73nek6v"));

$external_applications = array("vk_app"=>
        array("app_head_path"=>"vk_app_head.php",
            "app_body_path"=>"vk_app_body.php",
            "app_public_path"=>"vk_app_public.php"));

$operator_type_id=1;
$manager_type_id=2;

$document_report_mode=0;
$table_report_mode=1;
$graphical_report_mode=2;

$salary_with_taxes_cat_entity_id=97;
$salary_without_taxes_cat_entity_id=98;
$base_salary_cat_entity_id=99;

$income_categories_diagramm = 'income_categories_diagramm';
$outcome_categories_diagramm = 'outcome_categories_diagramm';
$outcome_category_segment = 'outcome_category_segment';
$balance_chart_report = "balance_chart";

$or_with_base_condition_type=1;

$out_table_php = "out_table.php";
$out_detail_php = "out_detail.php";
$out_detail_table_php = "out_detail_table.php";
$add_update_delete_php = "add_update_delete.php";

$select_mode = "select_mode";
$insert_manip_mode = "insert_manip_mode";
$update_manip_mode = "update_manip_mode";
$partial_update_manip_mode = "partial_update_manip_mode";
$delete_manip_mode = "delete_manip_mode";
$get_sel_options_mode = "get_sel_options_mode";
$fast_append_manip_mode = "fast_append_manip_mode";
$custom_action_manip_mode = "custom_action_manip_mode";
$get_list_div_mode = "get_list_div_mode";
$fast_append_field_mode = "fast_append_field_mode";
$out_report_mode = "out_report_mode";

$full_extract_type = "full_extract_type";

$dict_container_base = "_dict_table_div";
$dict_detail_base = "popup";
$dict_manip_container_base = "_dict_table_manip_res_div";
$dict_manip_form_base = "_dict_manip_form";
$dict_table_base = "_dict_table";
$dict_table_pager_base = "_dict_pager";

$active_cont_select_type = "active_cont_select_type";
$fast_append_manip_type = "fast_append_manip_type";
$active_list_div_type = "active_list_div_type";
$fast_append_list_type = "fast_append_list_type";

$linked_entity_append_type = "linked_entity_append_type";
$inline_params_update_type = "inline_params_update_type";
$external_params_update_type = "external_params_update_type";
$custom_action_type = "custom_action_type";

$global_ajax_timeout = 1;

$check_programm_platform_detected=true;

$error_ext_account_exist_query=0;
$error_create_new_external_account=1;
$external_account_exist=2;
$create_new_external_account=3;

?>