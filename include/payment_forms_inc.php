<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

//https://test.paysecure.ru/pay/order.cfm
$ASSIST_ORDER_COUNTER = Tools::getSystemParamValue("ASSIST_PS", "ORDER_COUNTER");

echo "<div class=\"payment_system_block\">Платежная система ASSIST";
if(isset($ASSIST_ORDER_COUNTER))    {
//$ASSIST_ORDER_COUNTER = 2004200128+$ASSIST_ORDER_COUNTER;
$COUNTER_PART1 = 20042001;//round($ASSIST_ORDER_COUNTER/100);
$COUNTER_PART2 = $ASSIST_ORDER_COUNTER+35;//%100;
echo "<FORM ACTION=\"redirect_page.php\" METHOD=\"POST\" target=\"_blank\">
    <INPUT TYPE=\"HIDDEN\" NAME=\"Merchant_ID\" VALUE=\"589490\">
    <INPUT TYPE=\"HIDDEN\" NAME=\"OrderNumber\" VALUE=\"A{$COUNTER_PART1}_{$COUNTER_PART2}\">
    <INPUT TYPE=\"HIDDEN\" NAME=\"OrderAmount\" VALUE=\"300.00\">
    <INPUT TYPE=\"HIDDEN\" NAME=\"OrderCurrency\" VALUE=\"RUB\">
    <INPUT TYPE=\"HIDDEN\" NAME=\"Delay\" VALUE=\"0\">
    <INPUT TYPE=\"HIDDEN\" NAME=\"Language\" VALUE=\"RU\">
    <INPUT TYPE=\"HIDDEN\" NAME=\"Email\" VALUE=\"test@test.ru\">
    <INPUT TYPE=\"HIDDEN\" NAME=\"OrderComment\" VALUE=\"Оплата заказа A-{$COUNTER_PART2}\">
    <INPUT TYPE=\"HIDDEN\" NAME=\"URL_RETURN_OK\" VALUE=\"http://www.URL.ru/yes\">
    <INPUT TYPE=\"HIDDEN\" NAME=\"URL_RETURN_NO\" VALUE=\"http://www.URL.ru/no\">
    <INPUT TYPE=\"HIDDEN\" NAME=\"CardPayment\" VALUE=\"1\">
    <INPUT TYPE=\"HIDDEN\" NAME=\"WMPayment\" VALUE=\"0\">
    <INPUT TYPE=\"HIDDEN\" NAME=\"YMPayment\" VALUE=\"0\">
    <INPUT TYPE=\"HIDDEN\" NAME=\"AssistIDPayment\" VALUE=\"0\">
    <INPUT TYPE=\"HIDDEN\" NAME=\"redirect_type\" VALUE=\"ASSIST_PAYMENT_REQUEST\">
    <INPUT TYPE=\"SUBMIT\" NAME=\"Submit\" VALUE=\"пополнить счет\">
    </FORM>";
} else {
    echo "Неудачное формирование заказа на оплату!!!";
}
echo "</div>";

?>
