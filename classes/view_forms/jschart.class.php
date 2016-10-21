<?php
/**
 * Обертка над JSCharts
 *
 * @author     Gar|k
 * @version    1.0
 * @package kudapotratil.ru
 */

/* DEBUG
ini_set('display_errors', true);
ini_set('scream.enabled', true);
error_reporting(E_ALL | E_STRICT);
// ---------------------------------*/

class JSCharts {
    private $js;
    private $name_chart;
    static private $inc_flag;

    public function __construct($dom_id,$type) {

	if(!self::$inc_flag)
	{
	    self::$inc_flag=1;
	    echo '<script type="text/javascript" src="sources/jscharts.js"></script>';
	}

	$this->name_chart='myChart'.rand(0,100);
	$this->js="var ".$this->name_chart." = new JSChart('".$dom_id."', '".$type."');\n";

	}

    public function draw()
    {
	$this->js.=$this->name_chart.".draw();\n";
	echo "<script type=\"text/javascript\">\n".$this->js."\n</script>";
    }

    public function __call($name, $arguments)
    {
	if(!is_array($arguments)) $arguments=array($arguments);
	foreach($arguments as &$arg)
	    {
	    if(is_string($arg)) $arg="'".$arg."'";
	    if(is_array($arg)) $arg=$this->js_array($arg);
	    }


	$this->js.=$this->name_chart.".".$name."(".implode(',',$arguments).");\n";
    }

    private function js_array($array)
    {
	$js=array();
	$assoc=false;

	foreach($array as $key=>$value)
	{
	    if(is_string($key)) $assoc=true;
	    if(is_array($value)) $value=js_array($value);
	    if(is_string($value)) $value="'".$value."'";


	    $js[]=$assoc?"['".$key."', ".$value."]" : $value;
	}

	return $assoc ? 'new Array('.implode(', ',$js).')':'['.implode(', ',$js).']';
    }
}

?>
