<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

require_once("classes/tools.class.php");

//echo "<!DOCTYPE html>
//    <html>
//        <head>
//            <meta http-equiv=\"content-type\" content=\"text/html; charset=utf-8\" />
//            <meta name=\"author\" content=\"\" /></head>";
//echo "<div><center><img src=\"images/redirect-ajax-loader.gif\"/>";
if(isset($_POST['redirect_type']))  {
    if ($_POST['redirect_type']=="ASSIST_PAYMENT_REQUEST")  {
        if (Tools::setSystemParamValue("ASSIST_PS", "ORDER_COUNTER")) {
            header("Location: https://test.paysecure.ru/pay/order.cfm?Merchant_ID={$_POST['Merchant_ID']}&OrderAmount={$_POST['OrderAmount']}&OrderNumber={$_POST['OrderNumber']}&OrderCurrency={$_POST['OrderCurrency']}&Delay={$_POST['Delay']}&Language={$_POST['Language']}&Email={$_POST['Email']}&OrderComment={$_POST['OrderComment']}&URL_RETURN_OK={$_POST['URL_RETURN_OK']}&URL_RETURN_NO={$_POST['URL_RETURN_NO']}&CardPayment={$_POST['CardPayment']}&WMPayment={$_POST['WMPayment']}&YMPayment={$_POST['YMPayment']}&AssistIDPayment={$_POST['AssistIDPayment']}");
        }
        else
            echo "Неудачное выполнение запроса!";
    }
}   else
    echo "Неверные параметры запроса!";
//echo "</div>"
//echo "</html>"

?>
