<?php

/**
 * @author Poltarokov SP
 * @copyright 2011
 */

class DbConnector
{
    protected $driver="mysql";
    protected $db=null;
    public $dbhost="localhost";
    public $dbname="";
    public $db_login="";//root";
    public $db_password="";//123456";
    protected $dbport=3306; //$dsn .= 'dbport=3306;';
    protected $charset="utf8"; //$dsn .= 'charset=utf8;';
    
    function __construct($dbhost, $dbname, $db_login, $db_password)    {
        $this->dbhost = $dbhost;
        $this->dbname = $dbname;
        $this->db_login = $db_login;
        $this->db_password = $db_password;
    }
    
    function createConnection($reconnect=false) {
        if ($reconnect)
            $this->disconnect();
        
        if (!isset($this->db))  {
        
            try {
                $db = new PDO($this->driver.":host=".$this->dbhost.
                    ";dbname=".$this->dbname.";charset=".$this->charset,
                    $this->db_login,$this->db_password);
                //$db->
                $this->db = $db;

            } catch (PDOException $e) {
                echo $e->getMessage();
                $this->db = null;
                return null;
            }
        
        }
        return $this->db;
    }
    
    function disconnect()   {
        $this->db = null;
    }
    
    function beginTransaction() {  
        try {
            $this->db->beginTransaction();
            return true;
        }
        catch ( Exception $e )
        { 
            echo "Неудачный старт транзакции : " . $e -> getMessage ();
            $this->rollBackTransaction(); 
            return false;
        } 
    }
    
    function rollBackTransaction()  {
        try {
            $this->db->rollBack();
            return true;
        }
        catch ( Exception $e )
        { 
            echo "Ошибка отката транзакции : " . $e -> getMessage ();
            return false;
        }
    }
    
    function commitTransaction()    {
        try {
            $this->db->commit();
            return true;
        }
        catch ( Exception $e )
        { 
            echo "Ошибка подтверждения транзакции : " . $e -> getMessage ();
            return false;
        }
    }
    
    function exec_by_param_result() {
        
    }
    
    function exec_with_prepare_and_params($instruction, $params)    {
        $param_keys = array_keys($params);
        foreach($param_keys as $param_key)  {
            if(strlen($params[$param_key])==0)
                $params[$param_key]=NULL;   
            //echo "--".$params[$param_key];     
        }
        
        if (array_key_exists("external_access_type", $_GET)) {  
            //echo $instruction;
        }
        try {
            //unset($params[':order_date']);
            //unset($params[':shooting_date']);
            //unset($params[':shooting_time']);
            //unset($params[':planned_child_count']);
            //unset($params[':code']);
            //unset($params[':order_comment']);
            //unset($params[':code']);
            //unset($params[':shooting_time']);
            //$params[':sur_name']=NULL;
            $stmt  = $this->db->prepare("SET NAMES 'utf8'; ".$instruction);
            //$stmt  = $this->db->prepare("SET @ord_id=NULL; call `add_update_order` (:plot_id,:kg_id,:manager_id,:stock_id,
		//      NULL,NULL,NULL, 0, NULL,@ord_id); ");
        } catch (PDOException $e) { 
            echo "Ошибка подготовки SQL-команды. Сообщение:".$e -> getMessage();
            return null; 
        } //'SELECT * FROM `table` WHERE `pole` = :value AND `pole2` = :value2;'); 
            
        try {
            $stmt -> execute($params);
            //$stmt -> execute();
            //echo "Сообщение:";
        } catch (PDOException $e) { 
            echo "Ошибка выполнения SQL-команды. Сообщение:".$e -> getMessage();
            return null; 
        } 
        
        //echo $instruction;
        //print_r($params);
        $arr = $stmt -> fetchAll(PDO :: FETCH_ASSOC);
        return "";
    }
    
    function exec_with_prepare_and_params_2ver($instruction, $params)    {
        $param_keys = array_keys($params);
        foreach($param_keys as $param_key)  {
            if(strlen($params[$param_key])==0)
                $params[$param_key]=NULL;   
            //echo "--".$params[$param_key];     
        }
        
        if (array_key_exists("external_access_type", $_GET)) {  
            //echo $instruction;
        }
        //print_r($params); 
        try {
            //unset($params[':order_date']);
            //unset($params[':shooting_date']);
            //unset($params[':shooting_time']);
            //unset($params[':planned_child_count']);
            //unset($params[':code']);
            //unset($params[':order_comment']);
            //unset($params[':code']);
            //unset($params[':shooting_time']);
            //$params[':sur_name']=NULL;
            $stmt  = $this->db->prepare("SET NAMES 'utf8'; ".$instruction);
            //$stmt  = $this->db->prepare("SET @ord_id=NULL; call `add_update_order` (:plot_id,:kg_id,:manager_id,:stock_id,
		//      NULL,NULL,NULL, 0, NULL,@ord_id); ");
        } catch (PDOException $e) { 
            echo "Ошибка подготовки SQL-команды. Сообщение:".$e -> getMessage();
            return null; 
        } //'SELECT * FROM `table` WHERE `pole` = :value AND `pole2` = :value2;'); 
            
        try {
            $stmt -> execute($params);
            //$stmt -> execute();
            //echo "Сообщение:";
        } catch (PDOException $e) { 
            echo "Ошибка выполнения SQL-команды. Сообщение:".$e -> getMessage();
            return null; 
        } 
        
        //echo $instruction;
        //print_r($params);
        $arr = $stmt -> fetchAll(PDO :: FETCH_ASSOC);
        return true;
    }
    
    function exec_with_prepare_and_params_ret_success($instruction, $result_instruction)    {
        /*$param_keys = array_keys($params);
        foreach($param_keys as $param_key)  {
            if(strlen($params[$param_key])==0)
                $params[$param_key]=NULL;   
            //echo "--".$params[$param_key];     
        }
        
        //print_r($params);
        $stmt = null;
        $sucess = -1;
        try {
            //unset($params[':order_date']);
            //$params[':sur_name']=NULL;
            $stmt = $this->db->prepare("SET NAMES utf8; ".$instruction);
            $stmt->bindParam(1, $sucess, PDO::PARAM_INT|PDO::PARAM_INPUT_OUTPUT, 12);
            //$rows = $this->db->query("SET NAMES utf8; ".$instruction);
        } catch (PDOException $e) { 
            echo "Ошибка выполнения SQL-команды. Сообщение:".$e -> getMessage();
            return NULL; 
        }  
            
        try {
            $stmt->execute();
            //$stmt->query($params);
            //PDOStatement::
        } catch (PDOException $e) { 
            echo "Ошибка выполнения SQL-команды. Сообщение:".$e -> getMessage();
            return NULL; 
        }
        
        echo $sucess."ssss";*/
        
        $mysqli = new mysqli($this->dbhost, $this->db_login, $this->db_password, $this->dbname);
        $rs = $mysqli->multi_query("SET NAMES utf8; ".$instruction);
        $rs = $mysqli->query($result_instruction);
        //echo $instruction;
        //print_r($rs);
        while($row = $rs->fetch_object()) {
		print_r($row);
	}
        /*$arr = $stmt->fetchAll(PDO :: FETCH_BOTH);
        //$arr = $rows->fetchAll(PDO :: FETCH_BOTH);
        echo "dddd";
        print_r($arr);
        if (count($arr)>0)  {
            if (is_array($arr))  {
                if (array_key_exists("success", $arr[0]))  {
                    return $arr[0]["success"];
                }   else
                    return NULL;
            }   else
                return NULL;
        }   else
            return NULL;*/
    }
    
    function query_both_to_array($query_instruction)  {
        try {
            
            //if (substr_count($query_instruction,'fca_view')>0)
            //    echo $query_instruction;
            
            if (array_key_exists("external_access_type", $_GET)) {  
                //echo $query_instruction;
            }
            
            $this->exec_with_prepare_and_params("SET NAMES utf8;", array());
            $result = $this->db->query($query_instruction);
            //print_r($result);
            if ($result!=null)  {
            try {
            $rows = $result->fetchAll(PDO::FETCH_ASSOC);
            //print_r($rows);
            return $rows;
            }
            catch(PDOException $e)  {
                echo "Ошибка разбора результата выполнения SQL-команды. Сообщение:".$e -> getMessage();
                return null;
            }
            } else {
                //echo "ssssssssssssssssssssss";
                return null;
            }
        } catch (PDOException $e) { 
            echo $e -> getMessage();
            return null; 
        }    
    }
    
}

?>