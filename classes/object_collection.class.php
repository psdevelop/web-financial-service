<?php

/**
 * @author Poltarokov SP
 * @copyright 2011
 */

if (!defined("ABSOLUTE_PATH"))
    define("ABSOLUTE_PATH", dirname(__FILE__)."/../");
 
 require_once(constant("ABSOLUTE_PATH")."classes/data_model/fca_data.class.php");
 require_once(constant("ABSOLUTE_PATH")."classes/data_model/purse.class.php");
 require_once(constant("ABSOLUTE_PATH")."classes/data_model/category.class.php");
 require_once(constant("ABSOLUTE_PATH")."classes/data_model/optype.class.php");
 require_once(constant("ABSOLUTE_PATH")."classes/data_model/currency.class.php");
 require_once(constant("ABSOLUTE_PATH")."classes/data_model/plan.class.php");
 require_once(constant("ABSOLUTE_PATH")."classes/data_model/plan_shedule.class.php");
 require_once(constant("ABSOLUTE_PATH")."classes/data_model/fca_status.class.php");
 require_once(constant("ABSOLUTE_PATH")."classes/data_model/purse_type.class.php");
 require_once(constant("ABSOLUTE_PATH")."classes/data_model/invite.class.php");
 require_once(constant("ABSOLUTE_PATH")."classes/data_model/news.class.php");
 //require_once("classes/data_model/user.class.php");

class ObjectCollection extends ArrayIterator
{
    protected $object_class_name;
    
    function __construct($object_class_name, $data)    {
        parent::__construct($data);
        $this->object_class_name = $object_class_name;    
    }
    
    public function offsetGet( $index )
    {
        if( empty( $this->_cache[$index] ) )
        {
            // по просьбам трудящихся
            //ReflectionClass($object_class_name)->newInstanceArgs(parent::offsetGet[$index]);
            $this->_cache[$index] = new $this->object_class_name( parent::offsetGet($index));
        }
        return $this->_cache[$index];
    }

    public function current()
    {
        $index = parent::key();
        if( empty( $this->_cache[$index] ) )
        {
            // по просьбам трудящихся
            $this->_cache[$index] = new $this->object_class_name( parent::current() );
        }
        return $this->_cache[$index];
    } 
}

?>