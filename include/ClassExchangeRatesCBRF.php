<?php
/*----------------------------------------------------------------------------------
Introduction:  Class ExchangeRatesCBRF receives information about currency rates from the site of 
					the Central Bank of Russian Federation. 
					GetRate method returns the rate referred to it as the currency code or obreviatury.
					
Author: Aleksey Vaganov
E-mail: avaganov@idivision.ru
Company: iDivision.ru
Created: 2010-10-24
----------------------------------------------------------------------------------*/
class ExchangeRatesCBRF
{
	var $rates;
	function __construct($date = null)
	{
		$client = new SoapClient("http://www.cbr.ru/DailyInfoWebServ/DailyInfo.asmx?WSDL"); 
		if (!isset($date)) $date = date("Y-m-d"); 
		$curs = $client->GetCursOnDate(array("On_date" => $date));
		$this->rates = new SimpleXMLElement($curs->GetCursOnDateResult->any);
	}
	
	function GetRate ($code)
	{
		$code1 = (int)$code;
		if ($code1!=0) 
		{
			$result = $this->rates->xpath('ValuteData/ValuteCursOnDate/Vcode[.='.$code.']/parent::*');
		}
		else
		{
			$result = $this->rates->xpath('ValuteData/ValuteCursOnDate/VchCode[.="'.$code.'"]/parent::*');
		}
		if (!$result)
		{
			return false; 
		}
		else 
		{
			$vc = (float)$result[0]->Vcurs;
			$vn = (int)$result[0]->Vnom;
			return ($vc/$vn);
		}

	}
}

?>