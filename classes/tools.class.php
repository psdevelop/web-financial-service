<?php

/**
 * @author Poltarokov SP
 * @copyright 2011
 */

if (!defined("ABSOLUTE_PATH"))
    define("ABSOLUTE_PATH", dirname(__FILE__)."/../");

require_once(constant("ABSOLUTE_PATH")."include/php5-utf8/ReflectionTypeHint.php");
require_once(constant("ABSOLUTE_PATH")."include/php5-utf8/UTF8.php");
require_once(constant("ABSOLUTE_PATH")."include/phpsniff_2_1_3/phpSniff.class.php");
require_once(constant("ABSOLUTE_PATH")."include/phpsniff_2_1_3/phpTimer.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/dbconnector.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/configuration.php");

class Tools
{
    protected $text_css_class_name;
    
    private $months = array (
          1 => 'january',2 => 'february',3 => 'march', 4 => 'april',
          5 => 'may',6 => 'june',7 => 'july',8 => 'august',9 => 'september',
          10 => 'october',11 => 'november', 12 => 'december');
          
    function __construct($text_css_class_name)    {
        $this->text_css_class_name = $text_css_class_name;    
    }
    
    function hashpass($password)
    {
        //$password = hash("SHA512", base64_encode(hash("SHA512", $password)));
        $password = base64_encode($password);
        return $password;
    }
    
    function generate_password($number)  
    {  
        $arr = array('a','b','c','d','e','f',  
                     'g','h','i','j','k','l',  
                     'm','n','o','p','r','s',  
                     't','u','v','x','y','z',  
                     'A','B','C','D','E','F',  
                     'G','H','I','J','K','L',  
                     'M','N','O','P','R','S',  
                     'T','U','V','X','Y','Z',  
                     '1','2','3','4','5','6',  
                     '7','8','9','0','.',',',  
                     '(',')','[',']','!','?',  
                     '&','^','%','@','*','$',  
                     '<','>','/','|','+','-',  
                     '{','}','`','~');  
        // Генерируем пароль  
        $pass = "";  
        for($i = 0; $i < $number; $i++)  
        {  
          // Вычисляем случайный индекс массива  
          $index = rand(0, count($arr) - 1);  
          $pass .= $arr[$index];  
        }  
        return $pass;  
    }
    
    function getSystemParamValue( $param_group_entity, $param_type)  {
        $param_value = null;    
        
        if ($param_group_entity=="ASSIST_PS")   {
            if ($param_type=="ORDER_COUNTER")    {
                $DBConn = new DbConnector($GLOBALS['dbhost'],
                        $GLOBALS['dbname'],$GLOBALS['dbuser'],$GLOBALS['dbpsw']);
                $DBConn->createConnection();
                $result = $DBConn->query_both_to_array(
                        "SELECT ps_order_counter FROM payment_systems WHERE payment_system_name='ASSIST_PS'");
                if(isset($result)) if (is_array($result)) if(count($result)==1)
                    $param_value = $result[0]["ps_order_counter"];
                
            }
        }
        
        return $param_value;
    }
    
    function setSystemParamValue( $param_group_entity, $param_type, $param_value=null)  {
        $success = false;    
        
        if ($param_group_entity=="ASSIST_PS")   {
            if ($param_type=="ORDER_COUNTER")    {
                $DBConn = new DbConnector($GLOBALS['dbhost'],
                        $GLOBALS['dbname'],$GLOBALS['dbuser'],$GLOBALS['dbpsw']);
                $DBConn->createConnection();
                $success = $DBConn->exec_with_prepare_and_params_2ver(
                        "UPDATE payment_systems SET ps_order_counter=ps_order_counter+1 
                            WHERE payment_system_name='ASSIST_PS'", array());
                if(is_null($success))  $success = false;
                
            }
        }
        
        return $success;
    }
    
    function insertPaymentRecord($psystem_name, $payment_summ, $order_num,
            $currency_str, $order_counter)  {
        $success = false;
        
        if(isset($psystem_name) && isset($order_num) && isset($currency_str))  {
            if (isset($GLOBALS['payment_systems_ids'][$psystem_name])&&
                isset($GLOBALS['payment_system_currencies'][$psystem_name][$currency_str])&&    
                    (strlen($order_num)>0)) {
                
                $DBConn = new DbConnector($GLOBALS['dbhost'],
                        $GLOBALS['dbname'],$GLOBALS['dbuser'],$GLOBALS['dbpsw']);
                $DBConn->createConnection();
                $success = $DBConn->exec_with_prepare_and_params_2ver(
                    "INSERT INTO `user_payments` (
                      `user_payment_id`, `payment_summ`, `psystem_id`, `ps_order_number`, `approved_status`,
                      `start_datetime`, `payment_optype_id`, `payment_currency_id`, `payment_currency_code`,
                      `payment_user_id`, `order_number`, `billing_number`, `target_payment_system_name`,
                      `payment_datetime`, `approve_currency_id`) 
                        VALUES(null, :payment_summ, :psystem_id, :ps_order_number, '0', 
                        CURRENT_TIMESTAMP, '1', :payment_currency_id, :payment_currency_code,
                        '{$_SESSION['user_id']}', :order_number, NULL, NULL, 
                        CURRENT_TIMESTAMP, NULL)", array());
                if(is_null($success))  $success = false;
                
            }
        }
        
        return $success;
    }
    
    function checkCurrentUserPaymentsApproved() {
        $client = new SoapClient("https://test.paysecure.ru/orderstate/orderstate.wsdl");
        $client = new SoapClient("https://test.paysecure.ru/orderstate/orderstate.wsdl", array(
            'location' => "https://test.paysecure.ru/orderstate/orderstate.cfm",
            'trace'        => 1,
            'exceptions'  => 0,
            'style'        => SOAP_DOCUMENT,
            'use'        => SOAP_LITERAL,
            'soap_version'  => SOAP_1_1,
            'encoding'      => 'UTF-8'
         ));
         
        $order_state = $client->orderstate("A20042001_42","589490",
                $GLOBALS['payment_system_settings']['ASSIST_PS']['login'],
                $GLOBALS['payment_system_settings']['ASSIST_PS']['password'],
                "4", "2012", "08", "01", "00", "00", "2012", "08", "02",
                "00", "00"); 
        //var_dump($client->__getFunctions());
        //$order_state = $client->__call("orderstate", array("ordernumber" =>"A20042001_42",
        //    "merchant_id"=>"589490", "login"=>$GLOBALS['payment_system_settings']['ASSIST_PS']['login'], 
        //    "password"=>$GLOBALS['payment_system_settings']['ASSIST_PS']['password']));
        //Array ( [0] => result orderstate
        //        (string $ordernumber, string $merchant_id, string $login, 
        //        string $password, string $format, string $startyear, 
        //        string $startmonth, string $startday, string $starthour, 
        //        string $startmin, string $endyear, string $endmonth, 
        //        string $endday, string $endhour, string $endmin) )
	//if (!isset($date)) $date = date("Y-m-d");
        /*$params = array(
            new SOAP_Value('key', 'string', 'your google key'),
            new SOAP_Value('q', 'string', $query),
            new SOAP_Value('start', 'int', 0),
            new SOAP_Value('maxResults', 'int', 10),
            new SOAP_Value('filter', 'boolean', false),
            new SOAP_Value('restrict', 'string', ''),
            new SOAP_Value('safeSearch', 'boolean', false),
            new SOAP_Value('lr', 'string', 'lang_en'),
            new SOAP_Value('ie', 'string', ''),
            new SOAP_Value('oe', 'string', ''));*/
        //$client->orderstate("A20042001_42",
        //    "589490", $GLOBALS['payment_system_settings']['ASSIST_PS']['login'], 
        //    $GLOBALS['payment_system_settings']['ASSIST_PS']['password'],
        //    "4", "2012", "08", "01", "00", "00", "2012", "08", "02", "00", "00");
        //$client->orderstate(array("ordernumber"=>"A20042001_42",
        //    "merchant_id"=>"589490", "login"=>$GLOBALS['payment_system_settings']['ASSIST_PS']['login'], 
        //    "password"=>$GLOBALS['payment_system_settings']['ASSIST_PS']['password']));
	//$order_state = $client->result();//,
            //"format"=>null, "startyear"=>null, "startmonth"=>null, "startday"=>null, 
            //"starthour"=>null, "startmin"=>null, "endyear"=>null, "endmonth"=>null, 
            //"endday"=>null, "endhour"=>null, "endmin"=>null));
        //print_r($order_state);
	//$this->rates = new SimpleXMLElement($curs->GetCursOnDateResult->any);
    }
    
    function checkPregLastError($print_error=false)   {
        $pr_last_err_status = preg_last_error();
        if ($pr_last_err_status == PREG_NO_ERROR) {
            if ($print_error)
                print 'There is no error.';
        }
        else if ($pr_last_err_status == PREG_INTERNAL_ERROR) {
            if ($print_error)
                print 'There is an internal error!';
        }
        else if ($pr_last_err_status == PREG_BACKTRACK_LIMIT_ERROR) {
            if ($print_error)
                print 'Backtrack limit was exhausted!';
        }
        else if ($pr_last_err_status == PREG_RECURSION_LIMIT_ERROR) {
            if ($print_error)
                print 'Recursion limit was exhausted!';
        }
        else if ($pr_last_err_status == PREG_BAD_UTF8_ERROR) {
            if ($print_error)
                print 'Bad UTF8 error!';
        }
        else if ($pr_last_err_status == PREG_BAD_UTF8_ERROR) {
            if ($print_error)
                print 'Bad UTF8 offset error!';
        }
        
        return $pr_last_err_status;
        
    }
    
    function getClientBrowserObject()  {
        $GET_VARS = isset($_GET) ? $_GET : $HTTP_GET_VARS;
        $POST_VARS = isset($_POST) ? $_GET : $HTTP_POST_VARS;
        if(!isset($GET_VARS['UA'])) $GET_VARS['UA'] = '';
        if(!isset($GET_VARS['cc'])) $GET_VARS['cc'] = '';
        if(!isset($GET_VARS['dl'])) $GET_VARS['dl'] = '';
        if(!isset($GET_VARS['am'])) $GET_VARS['am'] = '';
        
        $timer =& new phpTimer();
        $timer->start('main');
        $timer->start('client1');
        $sniffer_settings = array('check_cookies'=>$GET_VARS['cc'],
            'default_language'=>$GET_VARS['dl'],
            'allow_masquerading'=>$GET_VARS['am']);
        $client =& new phpSniff($GET_VARS['UA'],$sniffer_settings);

        $timer->stop('client1');
        
        return $client;
    }
    
    function itIsMobileBrowser($client_browser) {
        $browser_ua=$client_browser->property("ua");
        if ( (substr_count($browser_ua, "iphone simulator")>0)||
                //(substr_count($browser_ua, "iphone os")>0)||
                //((substr_count($browser_ua, "iphone")>0)&&(substr_count($browser_ua, "mobile")>0))||
                //((substr_count($browser_ua, "ipad")>0)&&(substr_count($browser_ua, "mobile")>0))||
                ((substr_count($browser_ua, "android")>0)&&(substr_count($browser_ua, "mobile")>0))
                //||((substr_count($browser_ua, "ipad")>0)&&(substr_count($browser_ua, "mac os")>0))
                ) 
            return true;
        return false;
    }
    
    function strtotimef($stime,$format='')  {
        if( trim($format)=='' )
            return strtotime($stime);
        
        $artimer = array(
            'd'=>'([0-9]{2})',
            'j'=>'([0-9]{1,2})',
            'F'=>'([a-z]{3,10})',
            'm'=>'([0-9]{2})',
            'M'=>'([a-z]{3})',
            'n'=>'([0-9]{1,2})',
            'Y'=>'([0-9]{4})',
            'y'=>'([0-9]{2})',
            'i'=>'([0-9]{2})',
            's'=>'([0-9]{2})',
            'h'=>'([0-9]{2})',
            'H'=>'([0-9]{2})',
            '#'=>'\\#',
            ' '=>'\\s',
        );
        
        $arttoval = array(
            'j'=>'d',
            'f'=>'m',
            'n'=>'m',
        );
        
        $reg_format = '#'.strtr($format,$artimer).'#Uis';
        
        if( preg_match_all('#[djFmMnYyishH]#',$format,$list) and preg_match($reg_format,$stime,$list1) )    {
            $item = array('h'=>'00','i'=>'00','s'=>'00','m'=>1,'d'=>1,'y'=>1970);
            
            foreach($list[0] as $key=>$valkey){
                if( !isset($arttoval[strtolower($valkey)]) )
                    $item[strtolower($valkey)] = $list1[$key+1];
                else
                    $item[$arttoval[strtolower($valkey)]] = $list1[$key+1];
            }
            
            return strtotime($item['h'].':'.$item['i'].':'.$item['s'].' '.$item['d']
                    .' '.$item['m'].' '.$item['y']);
        }
        else 
            return false;
    }
    
    function getCurrencyRate($db_connector, $date_time_str, $relative_currency_id, $base_currency_id)    {
        $result = 1.0;
        
        $sucess=true;
        try {
            
            if (($relative_currency_id!=$base_currency_id)&&($date_time_str!=null)&&
                    ($relative_currency_id!=$GLOBALS['unknown_currency_id'])&&
                    ($base_currency_id!=$GLOBALS['unknown_currency_id'])
                    )  {
                $rates = null;

                $date_str = $this->uniStrToStrTime($date_time_str, "Y-m-d h:i:s", "Y-m-d");

                //echo $date_time_str.$date_str;

                $relative_rate = 1.0;
                $exist_relative_rates = $db_connector->query_both_to_array("SELECT `currency_rate_value` FROM 
                    `currencies_rates` WHERE `rate_date`='{$date_str}' AND `rate_currency_id`={$relative_currency_id} ");
                if (count($exist_relative_rates)==1) {
                    $relative_rate = (real)$exist_relative_rates[0]['currency_rate_value'];
                } else if (count($exist_relative_rates)>1) {
                    $relative_rate = (real)$exist_relative_rates[0]['currency_rate_value'];
                }  else
                {
                     $rates = new ExchangeRatesCBRF($date_str);
                     $relative_rate = $rates->GetRate($GLOBALS['cbr_currency_codes'][$relative_currency_id-1]);
                     $db_connector->exec_with_prepare_and_params_2ver("INSERT INTO `currencies_rates` (`currency_rate_value`, 
                         `rate_date`, `rate_currency_id`) VALUES('{$relative_rate}', '{$date_str}', '{$relative_currency_id}');", array());
                }

                $base_rate = 1.0;
                if ($base_currency_id != $GLOBALS['default_system_currency'])   {
                    $exist_base_rates = $db_connector->query_both_to_array("SELECT `currency_rate_value` FROM 
                        `currencies_rates` WHERE `rate_date`='{$date_str}' AND `rate_currency_id`={$base_currency_id} ");

                    if (count($exist_base_rates)==1) {
                        $base_rate = (real)$exist_base_rates[0]['currency_rate_value'];
                    } else if (count($exist_base_rates)>1) {
                        $base_rate = (real)$exist_base_rates[0]['currency_rate_value'];
                    }  else
                    {
                        if ($rates!=null)
                            $rates = new ExchangeRatesCBRF($date_str);
                        $base_rate = $rates->GetRate($GLOBALS['cbr_currency_codes'][$base_currency_id-1]);
                        $db_connector->exec_with_prepare_and_params_2ver("INSERT INTO `currencies_rates` (`currency_rate_value`, 
                         `rate_date`, `rate_currency_id`) VALUES('{$base_rate}', '{$date_str}', '{$base_currency_id}');", array());
                    }

                }

                $result = $relative_rate / $base_rate;

            }
        
        }   catch (Exception $e) {
            $sucess=false;
            //echo 'Выброшено исключение: ',  $e->getMessage(), "\n";
        }
        //echo "ddd".$result;
        
        return (!$sucess?(1.0):$result);
    }
    
    function checkCurrencyRate($db_connector, $date_time_str, $currency_id) {
        $rates = null;

        $date_str = $this->uniStrToStrTime($date_time_str, "Y-m-d h:i:s", "Y-m-d");
        //echo $date_time_str.$date_str;
        $result_rate = 1.0;
        
        $sucess=true;
        try {
            
            $exist_rates = $db_connector->query_both_to_array("SELECT `currency_rate_value` FROM 
                `currencies_rates` WHERE `rate_date`='{$date_str}' AND `rate_currency_id`={$currency_id} ");
            if (count($exist_relative_rates)==1) {
                $result_rate = (real)$exist_relative_rates[0]['currency_rate_value'];
            } else if (count($exist_relative_rates)>1) {
                $result_rate = (real)$exist_relative_rates[0]['currency_rate_value'];
            }  else
            {
                 $rates = new ExchangeRatesCBRF($date_str);
                 $result_rate = $rates->GetRate($GLOBALS['cbr_currency_codes'][$currency_id-1]);
                 $db_connector->exec_with_prepare_and_params_2ver("INSERT INTO `currencies_rates` (`currency_rate_value`, 
                     `rate_date`, `rate_currency_id`) VALUES('{$result_rate}', '{$date_str}', '{$currency_id}');", array());
            }
        
        }   catch (Exception $e) {
            $sucess=false;
            //echo 'Выброшено исключение: ',  $e->getMessage(), "\n";
        }
        
        return (!$sucess?false:$result_rate);
    }
    
    function checkAllCurrenciesRates($db_connector, $date_time_str) {
        $rates = null;
        $date_str = $this->uniStrToStrTime($date_time_str, "Y-m-d h:i:s", "Y-m-d");
        //echo $date_time_str.$date_str;
        $sucess=true;
        try {
            
            for($c=1;$c<count($GLOBALS['cbr_currency_codes']);$c++) {
                $result_rate = 1.0;
                $curr_rate_id = $c+1;
                $exist_rates = $db_connector->query_both_to_array("SELECT `currency_rate_value` FROM 
                    `currencies_rates` WHERE `rate_date`='{$date_str}' AND 
                    `rate_currency_id`={$curr_rate_id} ");
                if (count($exist_rates)==1) {
                    $result_rate = (real)$exist_rates[0]['currency_rate_value'];
                } else if (count($exist_rates)>1) {
                    $result_rate = (real)$exist_rates[0]['currency_rate_value'];
                }  else
                {
                     $rates = new ExchangeRatesCBRF($date_str);
                     $result_rate = $rates->GetRate($GLOBALS['cbr_currency_codes'][$c]);
                     if ($result_rate==false)
                         $sucess=false;
                     $db_connector->exec_with_prepare_and_params_2ver("INSERT INTO `currencies_rates` (`currency_rate_value`, 
                         `rate_date`, `rate_currency_id`) VALUES('{$result_rate}', '{$date_str}', '{$curr_rate_id}');", array());
                }
            }
        
        }   catch (Exception $e) {
            $sucess=false;
            //echo 'Выброшено исключение: ',  $e->getMessage(), "\n";
        }
        
        return $sucess;
        
    }
    
    function uniStrToStrTime($date_time_str, $in_format = "Y-m-d h:i:s", $out_format = "Y-m-d h:i:s")   {
        $unix_dt=null;
        $dt_value=null;
        $dt_array=null;
        //$format = '%d/%m/%Y %H:%M:%S';
        $dt_format = $in_format;

        $unix_dt = strtotime($date_time_str);
        if (!$unix_dt) {
            $unix_dt = $this->strtotimef($date_time_str, $dt_format);
            if (!$unix_dt) {

            }  else {
                //$unix_dt = mktime(null, null, null, 
                //        $dt_array['tm_mon'], $dt_array['tm_mday'], 
                //        $dt_array['tm_year']);
                $dt_value = date($out_format, $unix_dt);
                //echo "---".$dt_value;
            }
        } else {
            $dt_value = date($out_format, $unix_dt);
        }
        return $dt_value;
    }
    
    function getImageHTMLWithClass($src, $css_class)    {
        if (isset($src))    {
            if ($src!="")   
                return "<img src=\"{$src}\" class=\"{$css_class}\"/>";
            else                
                return "";
        }   else
                return "";
    }
    
    function uniStrToUnixTime($date_time_str, $format = "Y-m-d")   {
        $unix_dt=null;
        $dt_value=null;
        $dt_array=null;
        //$format = '%d/%m/%Y %H:%M:%S';
        $dt_format = $format;

        $unix_dt = strtotime($date_time_str);
        if (!$unix_dt) {
            $unix_dt = $this->strtotimef($date_time_str, $dt_format);
        }
        return $unix_dt;
    }
    
    function win_utf8 ($in_text)    { 
        $output=""; 
        $other[1025]="Ё"; 
        $other[1105]="ё"; 
        $other[1028]="Є"; 
        $other[1108]="є"; 
        $other[1030]="I"; 
        $other[1110]="i"; 
        $other[1031]="Ї"; 
        $other[1111]="ї"; 

        for ($i=0; $i<strlen($in_text); $i++)   { 
            if (ord($in_text{$i})>191)  { 
                $output.="&#".(ord($in_text{$i})+848).";"; 
            } else  { 
                if (array_search($in_text{$i}, $other)===false) { 
                    $output.=$in_text{$i}; 
                } else { 
                    $output.="&#".array_search($in_text{$i}, $other).";"; 
                } 
            } 
    } 
    
    return $output; 
    } 

    function cp1251_to_utf8($s)     {
          $c209 = chr(209); $c208 = chr(208); $c129 = chr(129);
          for($i=0; $i<strlen($s); $i++)    {
              $c=ord($s[$i]);
              if ($c>=192 and $c<=239) $t.=$c208.chr($c-48);
              elseif ($c>239) $t.=$c209.chr($c-112);
              elseif ($c==184) $t.=$c209.$c209;
              elseif ($c==168)    $t.=$c208.$c129;
              else $t.=$s[$i];
          }
          return $t;
    }
    
    function cp1251_utf8( $sInput )
    {
        $sOutput = "";

        for ( $i = 0; $i < strlen( $sInput ); $i++ )
        {
            $iAscii = ord( $sInput[$i] );

            if ( $iAscii >= 192 && $iAscii <= 255 )
                $sOutput .=  "&#".( 1040 + ( $iAscii - 192 ) ).";";
            else if ( $iAscii == 168 )
                $sOutput .= "&#".( 1025 ).";";
            else if ( $iAscii == 184 )
                $sOutput .= "&#".( 1105 ).";";
            else
                $sOutput .= $sInput[$i];
        }
    
    return $sOutput;
    }
    
    function is_email($email){
        $p = '/^[a-z0-9!#$%&*+-=?^_`{|}~]+(\.[a-z0-9!#$%&*+-=?^_`{|}~]+)*';
        $p.= '@([-a-z0-9]+\.)+([a-z]{2,3}';
        $p.= '|info|arpa|aero|coop|name|museum|mobi)$/ix';
        return preg_match($p, $email);
    }
    
    function getTabContentHeader($tabs_array, $main_container_id)   {
        $result = "";
        $result .= "<ul id=\"ul_{$main_container_id}\" class=\"tabs group\">";
        for($c=0;$c<count($tabs_array);$c++)   {
            $result .= "<li class=\"".($tabs_array[$c]["active"]?"active":"").
                    "\" onclick=\" showTabsInContainer('{$main_container_id}',
                    '".$tabs_array[$c]["container_id"]."', this); this.className='active'; \"><a href=\"#\">".$tabs_array[$c]["tab_caption"]."</a></li>";
        }

        $result .= "</ul>";
        return $result;
    }
    
    function getTextFromTemplate($elements_array, $template)  {
         if (sizeof($elements_array)>0) {
             if ($template!=null)    {
                 $form_elements_keys = array_keys($elements_array);
                 $template_modified = $template;
                 foreach($form_elements_keys as $form_elements_key) {
                     
                     $template_modified = str_replace("***___".$form_elements_key,
                             $elements_array[$form_elements_key], 
                             $template_modified);
                 }
                 
                 return $template_modified;
                 
             }  else
                    return null;
         }  else
             return null;
         
     } 
    
    function loadDataFromFileToStringArray($filepath)    {
        
        $strings_array = array();
        // Построчное чтение файла 
        $handle = fopen ($filepath, "r"); 
        while (!feof ($handle)) { 
            $buffer = fgets($handle, 4096); 
            echo $buffer; 
        } 
        fclose ($handle); 
        
        return $strings_array;
    }
    
    function DateAdd($interval, $number, $date) {

    $date_time_array = getdate($date);
    $hours = $date_time_array['hours'];
    $minutes = $date_time_array['minutes'];
    $seconds = $date_time_array['seconds'];
    $month = $date_time_array['mon'];
    $day = $date_time_array['mday'];
    $year = $date_time_array['year'];

    switch ($interval) {
    
        case 'yyyy':
            $year+=$number;
            break;
        case 'q':
            $year+=($number*3);
            break;
        case 'm':
            $month+=$number;
            break;
        case 'y':
        case 'd':
        case 'w':
            $day+=$number;
            break;
        case 'ww':
            $day+=($number*7);
            break;
        case 'h':
            $hours+=$number;
            break;
        case 'n':
            $minutes+=$number;
            break;
        case 's':
            $seconds+=$number; 
            break;            
    }
       $timestamp= mktime($hours,$minutes,$seconds,$month,$day,$year);
        return $timestamp;
    }
    
    function getSlideOutButtonJS($panel_class ,$button_class, $image, $height, $width, 
            $top_pos, $fixed, $tab_location)  {
        return "<script type=\"text/javascript\">
                    $(function(){
                        
                        $('.{$panel_class}').tabSlideOut({	//Класс панели
                            tabHandle: '.{$button_class}',	//Класс кнопки
                            pathToTabImage: '{$image}',   //Путь к изображению кнопки
                            imageHeight: '{$height}px',	//Высота кнопки
                            imageWidth: '{$width}px',         //Ширина кнопки
                            tabLocation: '{$tab_location}',       //Расположение панели top - выдвигается сверху, right - выдвигается справа, bottom - выдвигается снизу, left - выдвигается слева
                            speed: 300,                 //Скорость анимации
                            action: 'click',		//Метод показа click - выдвигается по клику на кнопку, hover - выдвигается при наведении курсора
                            topPos: '{$top_pos}px',		//Отступ сверху
                            fixedPosition: {$fixed}	//Позиционирование блока false - position: absolute, true - position: fixed
                        });
                    });
                </script>";
    }
    
    function getSlideOutButtonJSId($panel_class ,$button_class, $image, $height, $width, 
            $top_pos, $fixed, $tab_location)  {
        return "<script type=\"text/javascript\">
                    $(function(){
                        
                        $('#{$panel_class}').tabSlideOut({	//Класс панели
                            tabHandle: '#{$button_class}',	//Класс кнопки
                            pathToTabImage: '{$image}',   //Путь к изображению кнопки
                            imageHeight: '{$height}px',	//Высота кнопки
                            imageWidth: '{$width}px',         //Ширина кнопки
                            tabLocation: '{$tab_location}',       //Расположение панели top - выдвигается сверху, right - выдвигается справа, bottom - выдвигается снизу, left - выдвигается слева
                            speed: 300,                 //Скорость анимации
                            action: 'click',		//Метод показа click - выдвигается по клику на кнопку, hover - выдвигается при наведении курсора
                            topPos: '{$top_pos}px',		//Отступ сверху
                            fixedPosition: {$fixed}	//Позиционирование блока false - position: absolute, true - position: fixed
                        });
                    });
                </script>";
    }
    
    function getSlidePanel($panel_class ,$button_class, $image, $height, $width, 
            $top_pos, $fixed, $tab_location, $panel_content)    {
        return "<div class=\"{$panel_class}\" >
            <a class=\"{$button_class}\" href=\"#\">Content</a><span lang=\"ru\">".
            $panel_content."</span></div>".$this->getSlideOutButtonJS($panel_class ,$button_class, 
            $image, $height, $width, $top_pos, $fixed, $tab_location);
    }
    
    function getSlidePanelId($panel_id, $button_id, $panel_class ,$button_class, $image, $height, $width, 
            $top_pos, $fixed, $tab_location, $panel_content)    {
        return "<div id=\"{$panel_id}\" class=\"{$panel_class}\" >
            <a id=\"{$button_id}\" class=\"{$button_class}\" href=\"#\">Content</a><span lang=\"ru\">".
            $panel_content."</span></div>".$this->getSlideOutButtonJSId($panel_id , $button_id, 
            $image, $height, $width, $top_pos, $fixed, $tab_location);
    }

    function AddJSLinkTag($JSFilepath)   {
        echo "<script language=\"JavaScript\" 
            type=\"text/javascript\" src=\"".$JSFilepath."\"></script>";
    }
    
    function writeJScript($script)  {
        echo "<script language=\"JavaScript\" 
            type=\"text/javascript\">{$script}</script>";
    }
 
    function AddCSSLinkTag($CSSFilepath)   {
        echo "<link href=\"".$CSSFilepath."\" rel=\"stylesheet\" 
            type=\"text/css\">";
    }
    
    function writePager($pager_id)  {
        echo "
            <div id=\"{$pager_id}\" class=\"pager\">
	           <form>
		          <img src=\"images/first.png\" class=\"first\"/>
		          <img src=\"images/prev.png\" class=\"prev\"/>
		          <input type=\"text\" class=\"pagedisplay\"/>
		          <img src=\"images/next.png\" class=\"next\"/>
		          <img src=\"images/last.png\" class=\"last\"/>
		          <select class=\"pagesize\">
			         <option selected=\"selected\"  value=\"10\">10</option>
			         <option value=\"20\">20</option>
			         <option value=\"30\">30</option>
			         <option  value=\"40\">40</option>
		          </select>
	           </form>
            </div>
        ";
    }
    
    function cleanUserInput($array) {
        foreach ($array as $key => $value) {
            //$array[$key] = mysql_real_escape_string($value);  // not working for some reason.  blanking values
            $array[$key] = addslashes($value);
        }
    }
    
    function monthStrToNum($month_str) {
        $month_str = strtolower($month_str);
        $mon_num = array_search($month_str, $this->months);
        if( 0 !== $mon_num ) {
            return $mon_num;
        }
        return false;
    }

    function monthNumToStr($month_num) {
        foreach($this->months as $key => $value) {
            if( $key === $month_num) {
                return ucwords($this->months[$key]);
            }
        }
    }
    
    function future_years($numyrs) {
        $curryear = date('Y');
        $expyeararr = array();
        $i=$curryear;
        while($i <= ($curryear + $numyrs)){
            array_push($expyeararr, $i);
            $i++;
        }
        return $expyeararr;
    }
    
    function year_select($numyrs,$name){
        $yr = $this->future_years($numyrs);
        $out = "<select id=\"$name\" name=\"$name\">\n";
        $i = 0;
        while($i <= $numyrs){
            $out .= "  <option>$yr[$i]</option>\n";
            $i++;
        }
        $out .= "</select>";
        return $out;
    }
    
    function month_select($name){
        $out = "<select id=\"$name\" name=\"$name\">\n";
        $i=1;
        while($i <= 12){
            $out .= "  <option>$i</option>\n";
            $i++;
        }
        $out .= "</select>";
        return $out;
    }
    
    function generate_select($id, $select_array, $value_field, $name_field, $width, $prev_text) {
        //print_r($select_array);
        $out = "<table width=\"100%\"><tr><td align=\"left\">".$prev_text.
                "</td><td align=\"right\"><select id=\"{$id}\" name=\"{$id}\" class=\"default_form_element\" style=\"width:{$width}px;\">\n";
        foreach($select_array as $select_item)  {
            $out .= "  <option value=\"{$select_item[$value_field]}\">{$select_item[$name_field]}</option>\n";
        }
        $out .= "</select></td></tr></table>";
        return $out;
    }
    
    function generate_select_with_value($id, $select_array, $value_field, 
            $name_field, $width, $prev_text, $value, $title="") {
        //print_r($select_array);
        $out = "<table width=\"100%\"><tr><td align=\"left\">".$prev_text.
                "</td><td align=\"right\"><select id=\"{$id}\" title=\"{$title}\" name=\"{$id}\" 
                class=\"default_form_element\" style=\"width:{$width}px;\">\n";
        
        foreach($select_array as $select_item)  {
            $selected_code = "";
            if($value==$select_item[$value_field])
                $selected_code = " selected=\"true\" ";
            $out .= "  <option {$selected_code} value=\"{$select_item[$value_field]}\">{$select_item[$name_field]}</option>\n";
        }
        $out .= "</select></td></tr></table>";
        return $out;
    }
    
    function generate_select_with_value_with_js($id, $select_array, $value_field, 
            $name_field, $width, $prev_text, $value, $events_js) {
        //print_r($select_array);
        $on_change_js="";
        if(isset($events_js['onChange']))
            $on_change_js=$events_js['onChange'];
        $out = "<table width=\"100%\"><tr><td align=\"left\">".$prev_text.
                "</td><td align=\"right\"><select id=\"{$id}\" name=\"{$id}\" 
                class=\"default_form_element\" onchange=\" {$on_change_js} \" style=\"width:{$width}px;\">\n";
        
        foreach($select_array as $select_item)  {
            $selected_code = "";
            if($value==$select_item[$value_field])
                $selected_code = " selected=\"true\" ";
            $out .= "  <option {$selected_code} value=\"{$select_item[$value_field]}\">{$select_item[$name_field]}</option>\n";
        }
        $out .= "</select></td></tr></table>";
        return $out;
    }
    
    function generate_ids_select_with_value($id, $select_array, $value_field, 
            $name_field, $width, $prev_text, $value) {
        //print_r($select_array);
        $out = "<table width=\"100%\"><tr><td align=\"left\">".$prev_text.
                "</td></tr><tr><td><input type=\"hidden\" id=\"{$id}\" value=\"\" /></td></tr>
                <tr><td align=\"right\"><select id=\"set_vars_{$id}\" name=\"set_vars_{$id}\" 
                class=\"default_form_element\" style=\"width:{$width}px;\">\n";
        
        foreach($select_array as $select_item)  {
            $selected_code = "";
            if($value==$select_item[$value_field])
                $selected_code = " selected=\"true\" ";
            $out .= "  <option {$selected_code} value=\"{$select_item[$value_field]}\">{$select_item[$name_field]}</option>\n";
        }
        $out .= "</select><input type=\"button\" value=\"Добавить\" 
            onclick=\"addToMultiset('set_vars_{$id}', 'multiset_{$id}', '{$id}');\"/>
            <input type=\"button\" value=\"-\" 
            onclick=\"deleteFromMultiset('multiset_{$id}', '{$id}');\"/></td></tr>
            <tr><td><select id=\"multiset_{$id}\" name=\"multiset_{$id}\" class=\"multiset_list\" size=\"4\" width=\"300\" style=\"width: 300px\">
        </select></td></tr></table>";
        return $out;
    }
    
    function generate_select_content($select_array, $value_field, $name_field) {
        //print_r($select_array);
        $out = "";
        foreach($select_array as $select_item)  {
            $out .= "  <option value=\"{$select_item[$value_field]}\">{$select_item[$name_field]}</option>\n";
        }
        return $out;
    }
    
    function generate_select_hidden($id, $select_array, $value_field, $name_field, $width, $prev_text) {
        //print_r($select_array);
        $out = "<select id=\"{$id}\" name=\"{$id}\" style=\"width:{$width}px; visibility:none; \">\n";
        foreach($select_array as $select_item)  {
            $out .= "  <option value=\"{$select_item[$value_field]}\">{$select_item[$name_field]}</option>\n";
        }
        $out .= "</select>";
        return $out;
    }
    
    function generate_button($id, $on_click_js)  {
        
    }
    
    function generate_select_js($id, $select_array, $value_field, $name_field, $width, $prev_text, $on_change_js)  {
        $out = "<table width=\"100%\"><tr><td align=\"left\">".$prev_text.
                "</td><td align=\"right\"><select id=\"{$id}\" name=\"{$id}\" 
                class=\"default_form_element\" style=\"width:{$width}px;\" 
                onchange=\"{$on_change_js}\">\n";
        foreach($select_array as $select_item)  {
            $out .= "  <option value=\"{$select_item[$value_field]}\">{$select_item[$name_field]}</option>\n";
        }
        $out .= "</select></td></tr></table>";
        return $out;
    }
    
    function generate_select_js_null_value($id, $select_array, $value_field, $name_field, $width, $prev_text, $on_change_js)  {
        $out = "<table width=\"100%\"><tr><td align=\"right\">".$prev_text.
                "</td><td align=\"left\"><select id=\"{$id}\" name=\"{$id}\" 
                class=\"default_form_element\" style=\"width:{$width}px;\" 
                onchange=\"{$on_change_js}\"><option selected value=\"-1\"></option>\n";
        foreach($select_array as $select_item)  {
            $out .= "  <option value=\"{$select_item[$value_field]}\">{$select_item[$name_field]}</option>\n";
        }
        $out .= "</select></td></tr></table>";
        return $out;
    }
    
    function write_text($text, $text_css_class_name)    {
        echo $text;//"<font class=\"{$text_css_class_name}\">".."</font>";
        //echo $text;
    }
    
    function generate_link_button($text, $link_button_class, $on_click_js, $id, $title="") {
        echo "<a id=\"{$id}\" href=\"#\" class=\"{$link_button_class}\" 
        onclick=\"{$on_click_js}\" title=\"{$title}\">{$text}</a>";
    }
    
    function generate_mobile_link_button($text, $link_button_class, $on_click_js, $id) {
        echo "<a id=\"{$id}\" href=\"#\"  data-role=\"button\" data-theme=\"{$link_button_class}\" onclick=\"{$on_click_js}\">{$text}</a>";
    }
    
    function generate_link_button_with_style($text, $link_button_class, $on_click_js, $id, $style, $title="") {
        echo "<a id=\"{$id}\" href=\"#\" class=\"{$link_button_class}\" onclick=\"{$on_click_js}\" 
            style=\" {$style} \" title=\"{$title}\">{$text}</a>";
    }
    
    function generate_link_button_with_href($text, $link_button_class, $on_click_js, $id, $href, $title="") {
        echo "<a href=\"{$href}\" class=\"{$link_button_class}\" onclick=\"{$on_click_js}\" title=\"{$title}\">{$text}</a>";
    }
    
    function generate_link_button_with_href_external($text, $link_button_class, $on_click_js, $id, $href, $title="") {
        echo "<a href=\"{$href}\" class=\"{$link_button_class}\" onclick=\"{$on_click_js}\" rel=\"external\" title=\"{$title}\">{$text}</a>";
    }
    
    function get_link_button($text, $link_button_class, $on_click_js, $id) {
        return "<a href=\"#\" class=\"{$link_button_class}\" onclick=\"{$on_click_js}\">{$text}</a>";
    }
    
    function write_input_onclick_button($text, $link_button_class, $on_click_js) {
        echo "<input type='{$text}' value='Go' onclick=\"{$on_click_js}\">";
    }
    
    function write_div($id, $class, $inner_html) {
        //class=\"{$class}\"
        echo "<div id=\"{$id}\" >{$inner_html}</div>";
    }
    
    function write_input_text($id, $width, $value, $label)   {
        echo $label."<input type=\"text\" id=\"{$id}\" name=\"{$id}\" size=\"{$width}\" value=\"{$value}\" />";
    }
    
    function get_input_text($id, $width, $value, $label)   {
        return "<table width=\"100%\"><tr><td align=\"left\">".$label.
               "</td><td align=\"right\"><input type=\"text\" id=\"{$id}\" name=\"{$id}\" size=\"{$width}\" value=\"{$value}\" /></td></tr></table>";
    }
    
    function get_disabled_input_text($id, $width, $value, $label)   {
        return "<table width=\"100%\"><tr><td align=\"left\">".$label.
               "</td><td align=\"right\"><input type=\"text\" id=\"{$id}\" disabled=\"true\" name=\"{$id}\" size=\"{$width}\" value=\"{$value}\" /></td></tr></table>";
    }
    
    function get_input_checkbox($id, $width, $value, $label)   {
        $checked_value="";
        if (($value!=0)&&($value!="0"))
            $checked_value="checked=\"checked\"";
        return "<table width=\"100%\"><tr><td align=\"left\">".$label.
               "</td><td align=\"right\"><input type=\"checkbox\" {$checked_value} id=\"{$id}\" 
               name=\"{$id}\" size=\"{$width}\" value=\"{$value}\" 
               onchange=\"if(this.checked) this.value='1'; else this.value='0';\" /></td></tr></table>";
    }
    
    function get_input_text_mixed_select($id, $width, $value, $label, $select_array)   {
        $options = "";
               $field_select_keys = array_keys($select_array);
               foreach ($field_select_keys as $field_select_key)  {
                   $options .= "<option value=\"{$field_select_key}\">{$select_array[$field_select_key]}</option>";
               }
        return "<table width=\"100%\"><tr><td align=\"left\">".$label.
               "</td><td align=\"right\"><input type=\"text\" id=\"{$id}\" name=\"{$id}\" size=\"{$width}\" value=\"{$value}\" /><br/>
               Выбрать из: <select id=\"select_{$id}\" onclick=\" document.getElementById('{$id}').value=
               document.getElementById('select_{$id}').value;\" onchange=\" document.getElementById('{$id}').value=
               document.getElementById('select_{$id}').value;\" >{$options}</select></td></tr></table>";
               
    }
    
    function get_input_text_with_class_and_events($id, $width, $value, $label, $class_name, $events_js)   {
        $onKeyDown_js="";
        if(isset($events_js['onKeyDown']))
            $onKeyDown_js=$events_js['onKeyDown'];
        $onblur="";
        if(isset($events_js['onChange']))
            $onblur=$events_js['onChange'];
        return "<table width=\"100%\"><tr><td align=\"left\">".$label.
               "</td><td align=\"right\"><input type=\"text\" id=\"{$id}\" 
               name=\"{$id}\" class=\"{$class_name}\" onKeyDown=\"{$onKeyDown_js}\" 
               onblur=\"{$onblur}\" size=\"{$width}\" 
               value=\"{$value}\" /></td></tr></table>";
    }
    
    function get_input_text_with_class($id, $width, $value, $label, $class_name, $title="")   {
        return "<table width=\"100%\"><tr><td align=\"left\">".$label.
               "</td><td align=\"right\" style=\"text-align:right;\">
                <input type=\"text\" id=\"{$id}\" name=\"{$id}\" title=\"{$title}\" class=\"{$class_name}\" 
                size=\"{$width}\" value=\"{$value}\" /></td></tr></table>";
    }
    
    function get_input_text_with_class_and_placement($id, $width, $value, $label, $class_name,$placement)   {
        if ($placement=="vertical")
            return "<table width=\"100%\"><tr><td align=\"left\">".$label.
               "</td></tr><tr><td align=\"right\"><input type=\"text\" id=\"{$id}\" 
               name=\"{$id}\" class=\"{$class_name}\" size=\"{$width}\" 
               value=\"{$value}\" /></td></tr></table>";
        else
            return "<table width=\"100%\"><tr><td align=\"left\">".$label.
               "</td><td align=\"right\"><input type=\"text\" id=\"{$id}\" 
               name=\"{$id}\" class=\"{$class_name}\" size=\"{$width}\" 
               value=\"{$value}\" /></td></tr></table>";
    }
    
    function get_input_text_area($id, $width, $value, $label, $height, $title="")   {
        return "<table width=\"100%\"><tr><td align=\"left\">".$label.
               "</td><td align=\"right\"><textarea id=\"{$id}\" title=\"{$title}\" name=\"{$id}\" cols=\"{$width}\" 
               rows=\"{$height}\" >{$value}</textarea></td></tr></table>";
    }
    
    function get_input_text_hidden($id, $width, $value, $label)   {
        return "<input type=\"hidden\" id=\"{$id}\" name=\"{$id}\" size=\"{$width}\" value=\"{$value}\" />";
    }
    
    function write_input_text_hidden($id, $value)   {
        echo $label."<input type=\"hidden\" id=\"{$id}\" name=\"{$id}\" value=\"{$value}\" />";
    }
    
    function write_input_submit_button($value)   {
        echo "<input type=\"submit\" value=\"{$value}\" />";
    }
    
    function write_input_checkbox($id, $value, $label)   {
        echo "<input type=\"checkbox\" id=\"{$id}\" name=\"{$id}\" value=\"{$value}\" />".$label;
    }
    
    function write_input_select($id, $width, $values)   {
        echo "<input type=\"TEXT\" id=\"{$id}\" name=\"{$id}\" size=\"{$width}\" value=\"{$text}\" />";
    }
    
}

?>