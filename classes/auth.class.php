<?php

if (!defined("ABSOLUTE_PATH"))
    define("ABSOLUTE_PATH", dirname(dirname(__FILE__))."/");

require_once(constant("ABSOLUTE_PATH")."classes/tools.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/configuration.php");

class UserAuthentification extends Tools
{	
        protected $dbconnector;
        public $errormsg = array();
        protected $custom_auth_form=true;
        protected $hide_registration_button=true;
        protected $programmaticaly_detected_mobile_device=false;
        protected $registration_user_name_required=false;
        protected $confirm_password_required=false;
        protected $use_captcha=false;
        protected $use_email_as_login=true;
        protected $email_with_login_reqiured=false;
        protected $show_external_logging = true;
        public $last_reg_message = "";
        public $message_style = "";
        public $last_user_name = "";
        public $last_user_login = "";
        public $last_password = "";
        public $last_email = "";

        function __construct($dbconnector)
	{
		$this->dbconnector = $dbconnector;
                $this->programmaticaly_detected_mobile_device=
                      $this->itIsMobileBrowser($this->getClientBrowserObject());  
	}
        
        function checkLogin($user_login, $user_psw)   {
            //$ip = $_SERVER['REMOTE_ADDR'];
            //$expiredate = date("Y-m-d H:i:s", strtotime("+1 month"));
            //!isset($_COOKIE["auth_session"])
            //$_SERVER['REMOTE_ADDR']
            //$user_login = $this->dbconnector->db_login;
            //$user_psw = $this->dbconnector->db_password;
            //echo $user_login."sssss".$user_psw;
            //$this->dbconnector->db_login = $GLOBALS['dbuser'];
            //$this->dbconnector->db_password = $GLOBALS['dbpsw'];
            if ($this->dbconnector->createConnection(false)!=null)   
            {
                //if (($user_login==$GLOBALS['dbuser'])&&
                // ($user_psw==$GLOBALS['dbpsw']))    {
                //    return true;
                //}  
                //else    {
                    $rows = $this->dbconnector->query_both_to_array("SELECT password, id FROM users WHERE (username='{$user_login}') and (isactive=1)");
                    $missing_user_msg = "!!!!!!!!!!Внимание нет указанного пользователя в таблице алминистрирования, возможна некорректная работа ряда операций!!!!!!!";
                    if ($rows!=null)    {
                        if (sizeof($rows)==1)    {
                            $missing_user_msg = null;
                            //if (!$pass_hashed)
                            //    $pass_hash=
                            if ($user_psw==$rows[0]['password'])    {
                                //echo "ddddddddddddddddddddd";
                                $_SESSION['user_id']=$rows[0]['id'];
                                //return true;
                                $cur_users = $this->dbconnector->query_both_to_array("SELECT  
                                        enable_admin, enable_deleting, load_visa_cats, default_currency_id FROM users WHERE (username='{$user_login}');");
                                //$this->writeUserInput($user_login);
                                if($cur_users!=null)
                                    if (sizeof($cur_users)==1)    {
                                        $cur_user = $cur_users[0];
                                        //$_SESSION['current_user_id'] = $cur_user['person_id'];
                                        //if ($cur_user['person_type_id']==$GLOBALS['operator_type_id'])
                                        //    $_SESSION['operator_id'] = $cur_user['person_id'];
                                        //if ($cur_user['person_type_id']==$GLOBALS['manager_type_id'])
                                        //    $_SESSION['manager_id'] = $cur_user['person_id'];
                                        //print_r($cur_user);
                                        if ($cur_user['enable_admin']=='1')
                                            $_SESSION['enable_admin'] = true;
                                        else
                                            $_SESSION['enable_admin'] = false;
                                        if ($cur_user['enable_deleting']=='1')
                                            $_SESSION['enable_deleting'] = true;
                                        else
                                            $_SESSION['enable_deleting'] = false;
                                        
                                        if ($cur_user['load_visa_cats']=='1')
                                            $_SESSION['load_visa_default_cats'] = 1;
                                        else
                                            $_SESSION['load_visa_default_cats'] = 0;
                                        
                                        $_SESSION['default_currency_id'] = 
                                            $cur_user['default_currency_id'];
                                        
                                        if (array_key_exists("mobile_mode",$_GET))
                                        {
                                                $_SESSION['desktop_mode']="NO";
                                                $_SESSION['mobile_mode']="YES";
                                        }
                                        
                                        if (array_key_exists("desktop_mode",$_GET))
                                        {
                                                $_SESSION['desktop_mode']="YES";
                                                $_SESSION['mobile_mode']="NO";
                                        }
                                        
                                        return true;
                                    }
                                return false;
                                
                            }
                            return false;
                                
                        }
                        return false;
                    }
                    //if ($missing_user_msg!=null)
                    //    echo $missing_user_msg;
                    return false;
                //}
            }
                    
            else
                return false;
        }
        
        function writeUserInput($username) {
            $this->dbconnector->exec_with_prepare_and_params("
                INSERT INTO sessions (uid, username, hash, expiredate, ip) 
                VALUES (0 ,:user_name, :hash, NOW(), :ip);", 
                array(":user_name"=>$username, ":hash"=>"---", ":ip"=>$_SERVER['REMOTE_ADDR']));
            
            $_SESSION['STORED_REMOTE_ADDR'] = $_SERVER['REMOTE_ADDR'];
        }
        
        function writeAttempts() {
            $this->dbconnector->exec_with_prepare_and_params("
                call `add_attempt` (:ip);", 
                array(":ip"=>$_SERVER['REMOTE_ADDR']));
        }
        
        function getExternalLoggingHTML($mobile_mode=false)   {
            //Код регистрации с других сайтов
            //<script src="http://ulogin.ru/js/ulogin.js"></script>
            //Для десктопа<div id="uLogin" x-ulogin-params="display=small;
            //fields=first_name,last_name;providers=vkontakte,odnoklassniki,
            //mailru,facebook;hidden=other;redirect_uri=http%3A%2F%2Fkudapotratil.ru
            //%2Findex.php%3Faction%3Dexternal_login%26external_access_type
            //%3Dulogin%26desktop_mode"></div>
            //<script src="http://ulogin.ru/js/ulogin.js"></script>
            if ($mobile_mode)
                return "";
            else
                return "<div id=\"uLogin\" x-ulogin-params=\"display=small;fields=first_name,last_name;providers=vkontakte,odnoklassniki,mailru,facebook;hidden=other;redirect_uri=http%3A%2F%2Fkudapotratil.ru%2Findex.php%3Faction%3Dexternal_login%26external_access_type%3Dulogin%26desktop_mode\"></div>";
        }
        
        function writeLoginForm()   {
            //echo $ua;
            if ($GLOBALS['check_programm_platform_detected']&&$this->programmaticaly_detected_mobile_device)    {
                echo "<script language=\"JavaScript\">
                document.write('<div data-role=\"page\" class=\"mobile_login_form\"><form action=\"index.php?action=login&mobile_mode&browser_width='+windowWidth()+
                '\" method=\"post\" action=\"post\" data-ajax=\"false\"><center>'+
                'Логин:<input id=\"login\" name=\"login\" type=\"TEXT\" class=\"autorize\" value=\"\" size=\"15\" /><br/>'+
                'Пароль:<input id=\"psw\" name=\"psw\" type=\"PASSWORD\" class=\"autorize\" value=\"\" /><br/>'+
                '<input class=\"blue medium\" type=\"Submit\" value=\"Войти\"></center></form></div>');  
                </script>";
            }
            else
            echo "<script language=\"JavaScript\">
            if ((windowWidth() > 700)) {
                document.write(".
                    ($this->custom_auth_form?
                    "'"."<form action=\"index.php?action=login&desktop_mode&browser_width='+windowWidth()+
                    '\" method=\"post\" action=\"post\" data-ajax=\"false\"><table><tr>'+
                    '<td><nobr>".($this->show_external_logging?$this->getExternalLoggingHTML():"")."</nobr></td>'+
                    '<td>Логин:</td><td><input id=\"login\" name=\"login\" type=\"TEXT\" class=\"custom_autorize\" value=\"\" /></td>'+
                    '<td>Пароль:</td><td><input id=\"psw\" name=\"psw\" type=\"PASSWORD\" class=\"custom_autorize\" value=\"\" /></td>'+
                    '<td><nobr>&nbsp;&nbsp;<input class=\"blue medium\" type=\"Submit\" value=\"Войти\">'+
                    '".($this->hide_registration_button?"":$this->getRegistrationButton())."</nobr></td></tr></table></form>'"
                    :"'<form action=\"index.php?action=login&desktop_mode\" method=\"post\" action=\"post\" data-ajax=\"false\"><center>'+
                    'Логин:<input id=\"login\" name=\"login\" type=\"TEXT\" class=\"autorize\" value=\"\" /><br/>'+
                    'Пароль:<input id=\"psw\" name=\"psw\" type=\"PASSWORD\" class=\"autorize\" value=\"\" /><br/>'+
                    '<input class=\"blue medium\" type=\"Submit\" value=\"Войти\"></center></form>'").
                    ");
                }
            else { document.write('<div data-role=\"page\" class=\"mobile_login_form\"><form action=\"index.php?action=login&mobile_mode&browser_width='+windowWidth()+
                '\" method=\"post\" action=\"post\" data-ajax=\"false\"><center>'+
                'Логин:<input id=\"login\" name=\"login\" type=\"TEXT\" class=\"autorize\" value=\"\" size=\"15\" /><br/>'+
                'Пароль:<input id=\"psw\" name=\"psw\" type=\"PASSWORD\" class=\"autorize\" value=\"\" /><br/>'+
                '<input class=\"blue medium\" type=\"Submit\" value=\"Войти\"></center></form></div>'); } 
            </script>";

        }
        
        function getRegistrationButton()    {
            return "&nbsp;&nbsp;<a href=\"index.php?reg&desktop_mode\" class=\"green medium\">Регистрация</a>";
        }
        
        function writeLoginFormWithStyle($login_form_style)   {
            if ($login_form_style=="simple_horizontal") 
            echo "<br/><br/><div style=\"text-align:center;\"><center><table class=\"login_form\">
                <tr><td>";
            echo "<script language=\"JavaScript\">
            if ((document.documentElement.clientWidth > 700)) {
                document.write('<form action=\"index.php?action=login&desktop_mode\" method=\"post\" action=\"post\" data-ajax=\"false\"><center>'+
                'Логин:<input id=\"login\" name=\"login\" type=\"TEXT\" class=\"autorize\" value=\"\" /><br/>'+
                'Пароль:<input id=\"psw\" name=\"psw\" type=\"PASSWORD\" class=\"autorize\" value=\"\" /><br/>'+
                '<input class=\"blue medium\" type=\"Submit\" value=\"Войти\"></center></form>');
                }
            else { document.write('<form action=\"index.php?action=login\" method=\"post\" action=\"post\" data-ajax=\"false\"><center>'+
                'Логин:<input id=\"login\" name=\"login\" type=\"TEXT\" class=\"autorize\" value=\"\" /><br/>'+
                'Пароль:<input id=\"psw\" name=\"psw\" type=\"PASSWORD\" class=\"autorize\" value=\"\" /><br/>'+
                '<input class=\"blue medium\" type=\"Submit\" value=\"Войти\"></center></form>'); } 
            </script>";
            echo "</td></tr>
                <tr><td style=\"padding:10px;\"><a class=\"medium orange\" href=\"index.php?reg\">Регистрация</a></td></tr>
                </table></center></div>";
        }
		
	function writeRegisterForm()	{
            echo "
                <center>
                <div style=\"text-align: center; width: 519px;\"><big>РЕГИСТРАЦИЯ</big>

                    <form method=\"post\" action=\"{$GLOBALS['HTTP_SUFFIX']}/index.php?registration_data\" name=\"registration\">
                        <table style=\"text-align: left; width: 100%; height: 60px;\" border=\"0\" cellpadding=\"2\" cellspacing=\"2\">
                        <tbody>
                            <tr align=\"left\">
                                <td style=\"width: 382px;\" colspan=\"2\" rowspan=\"1\"><span style=\"font-style: italic;\">
                                    Все поля обязательны для заполнения</span>
                                </td>
                            </tr>".
                            ($this->registration_user_name_required?"<tr>
                                <td style=\"text-align: right; width: 304px;\">Имя:</td>
                                <td style=\"width: 382px;\"><input size=\"30\" name=\"user_name\" value=\"psdevelop\"></td>
                            </tr>":"").
                            "<tr>
                                <td colspan=\"2\" rowspan=\"1\"><span style=\"font-weight: bold;\">
                                    Поля ниже заполняются латинскими буквами и цифрами без пробелов
                                </span></td>
                            </tr>
                            <tr>
                                <td style=\"text-align: right;\">".
                                ($this->use_email_as_login?"Эл. почта (или Логин):":"Логин:").
                                "</td>
                                <td><input size=\"30\" type=\"text\" name=\"user_login\" value=\"psdevelop\"></td>
                            </tr>
                            <tr>
                                <td style=\"text-align: right;\">Пароль:</td>
                                <td><input size=\"30\" name=\"usr_psw\" type=\"password\" value=\"1234567\"></td>
                            </tr>".
                            ($this->confirm_password_required?"<tr>
                                <td style=\"text-align: right;\">Повтор пароля:</td>
                                <td><input size=\"30\" name=\"verify_usr_psw\" type=\"password\" value=\"1234567\"></td>
                            </tr>":"").
                            ($this->email_with_login_reqiured?"<tr align=\"justify\">
                                <td colspan=\"2\" rowspan=\"1\"><span style=\"font-style: italic;\">
                                    Внимание! Очень важно указать правильный, работающий email - он 
                                    используется для восстановления пароля и обратной связи с Вами. 
                                    Поэтому мы просим Вас ввести email дважды и проверить его правильность.
                                </span></td>
                            </tr>
                            <tr>
                                <td style=\"text-align: right;\">E-mail:</td>
                                <td><input size=\"30\" name=\"e_mail\" value=\"psdevelop@yandex.ru\"></td>
                            </tr>
                            <tr>
                                <td style=\"text-align: right;\">Повтор e-mail`а:</td>
                                <td><input size=\"30\" name=\"verify_e_mail\" value=\"psdevelop@yandex.ru\"></td>
                            </tr>":"").
                            ($this->use_captcha?"<tr>
                                <td></td> 
                                <td>
                                    <img src=\"captcha.php\" id=\"captcha\" /><br/>
                                    <!-- CHANGE TEXT LINK -->
                                    <a href=\"#\" onclick=\"
                                        document.getElementById('captcha').src='captcha.php?'+Math.random();
                                        document.getElementById('captcha-form').focus();\"
                                        id=\"change-image\">Не читается? Обновить.</a><br/><br/>
                                </td>
                            </tr>
                            <tr>
                                <td style=\"text-align: right;\">
                                    Введите код с картинки:</td>
                                <td><input size=\"30\" name=\"captcha-form\" id=\"captcha-form\"></td>
                            </tr>":"").
                            "<tr align=\"center\">
                                <td><input class=\"\" value=\"Регистрация\" name=\"reg_button\" type=\"submit\"/></td>
                                <td><a class=\"medium blue\" href=\"index.php?action=logout\">Отмена</a></td>
                            </tr>
                        </tbody>
                        </table>
                    </form>

                </div>
                </center>
                ";
	}
		
        function writePasswordRestoreForm()	{
        }

        function writeLogoutConfirm()   {

        }

        function writeLogoutForOperationConfirm()   {

        }
	

        
        /*
	* Hash user's password with SHA512 and base64_encode
	* @param string $password
	* @return string $password $currpass = $this->hashpass($currpass);
			$newpass = $this->hashpass($newpass);
	*/
	
	/*
	* Register a new user into the database
	* @param string $username
	* @param string $password
	* @param string $verifypassword
	* @param string $email
	* @return boolean
	*/
        
        function checkRegistrationData()    {
                $this->last_reg_message = "";
                $correct_reg_data=true;
                $this->message_style = "background-color: #CCFF99";
                
                if ($this->use_captcha) {
                    if (empty($_REQUEST['captcha-form']) || empty($_SESSION['captcha']) || trim(strtolower($_REQUEST['captcha-form'])) != $_SESSION['captcha']) {
                        $this->last_reg_message .= "<br\>Неверно введен код с картинки";
                        $this->message_style = "background-color: #FF606C";
                        $correct_reg_data=false;
                    }
                }
                
                if ($this->registration_user_name_required) {
                    $this->last_user_name="";
                    if (!empty($_REQUEST['user_name']))   {
                        $this->last_user_name=$_REQUEST['user_name'];
                            if (strlen($user_name)<=2)    {
                                $this->last_reg_message .= "<br\>Имя пользователя должно состоять более чем из 2-х символов!";
                                $this->message_style = "background-color: #FF606C";
                                $correct_reg_data=false;
                            }   

                    }   else    {
                        $this->last_reg_message .= "<br\>Пустое имя пользователя!";
                        $this->message_style = "background-color: #FF606C";
                        $correct_reg_data=false;
                    }
                }
                
                $this->last_user_login="";
                if (!empty($_REQUEST['user_login']))   {
                    $this->last_user_login=$_REQUEST['user_login'];
    
                        if (strlen($this->last_user_login)<=2)    {
                            $this->last_reg_message .= "<br\>Электронная почта (или Логин) должны состоять более чем из 2-х символов!";
                            $this->message_style = "background-color: #FF606C";
                            $correct_reg_data=false;
                        }   else    {
                            if (preg_match( '/[^0-9a-zA-Z]/', $this->last_user_login)&&
                                    ( !$this->is_email(strtolower($this->last_user_login)) ||
                                      !$this->use_email_as_login ) )   {
                                $this->last_reg_message .= "<br\>Логин может быть адресом 
                                    Электронной почты либо содержать только цифры и латинские буквы!";
                                $this->message_style = "background-color: #FF606C";
                                $correct_reg_data=false;
                            } else {
                                $this->last_user_name=$this->last_user_login;
                                if ($this->use_email_as_login) 
                                    $this->last_email=$this->last_user_login;
                            }
                        }
                    
                }   else    {
                    $this->last_reg_message .= "<br\>Пустой логин!";
                    $this->message_style = "background-color: #FF606C";
                    $correct_reg_data=false;
                }
                
                $this->last_password="";
                if (!empty($_REQUEST['usr_psw']))   {
                    $this->last_password=$_REQUEST['usr_psw'];
                    if ($this->confirm_password_required?$this->last_password!=$_REQUEST['verify_usr_psw']:false) {
                        $this->last_reg_message .= "<br\>Неверное подтверждение пароля!";
                        $this->message_style = "background-color: #FF606C";
                        $correct_reg_data=false;
                    }   else    {
                        if (strlen($this->last_password)<=6)    {
                            $this->last_reg_message .= "<br\>Пароль должен состоять более чем из 6-ти символов!";
                            $this->message_style = "background-color: #FF606C";
                            $correct_reg_data=false;
                        }   else    {
                            if (preg_match( '/[^0-9a-zA-Z]/', $this->last_password))   {
                                $this->last_reg_message .= "<br\>Пароль может содержать только цифры и латинские буквы!";
                                $this->message_style = "background-color: #FF606C";
                                $correct_reg_data=false;
                            }
                        }
                    }
                }   else    {
                    $this->last_reg_message .= "<br\>Пустой пароль!";
                    $this->message_style = "background-color: #FF606C";
                    $correct_reg_data=false;
                }
                
                if ($this->email_with_login_reqiured)   {
                    $this->last_email="";
                    if (!empty($_REQUEST['e_mail']))    { 
                        $this->last_email=strtolower($_REQUEST['e_mail']);
                        if ($this->last_email != strtolower($_REQUEST['verify_e_mail'])) {
                            $this->last_reg_message .= "<br\>Неверное подтверждение e-mail!";
                            $this->message_style = "background-color: #FF606C";
                            $correct_reg_data=false;
                        }   else    {
                            if (!$this->is_email($this->last_email))    {
                                $this->last_reg_message .= "<br\>Неверный формат e-mail!";
                                $this->message_style = "background-color: #FF606C";
                                $correct_reg_data=false;
                            }
                        }
                    }   else    {
                        $this->last_reg_message .= "<br\>Пустой e-mail!";
                        $this->message_style = "background-color: #FF606C";
                        $correct_reg_data=false;
                    }
                }
                
                unset($_SESSION['captcha']);
                
                return $correct_reg_data;
        }
        
        function getAutoGeneratePassword()  {
            
        }
        
        function accountExist($username, $system_name=null, $email=null) {
            $account_exist = false;
            $_SESSION['exist_psw'] = null;
            
            $email_condition=" ISNULL(email) ";
            if(isset($email))
                $email_condition=" (email='{$email}') ";
                
            $system_name_condition=" ISNULL(system_name) ";
            if(isset($system_name))
                $system_name_condition=" (system_name='{$system_name}') ";
                
            $rows = $this->dbconnector->query_both_to_array("SELECT * FROM users WHERE (username='{$username}' OR {$email_condition}) AND {$system_name_condition}");
            //echo "dddd"; print_r($rows);
            if(($rows != null)||($rows))
            {
                if (sizeof($rows)==1)    {
                    // Username already exists
                    //$this->errormsg[] = "Введенный логин и/или эл. почта уже заняты!";
                    $_SESSION['exist_psw'] = $rows[0]['password'];
                    $account_exist = true;
                }
            }
            else
                return false;
            return $account_exist;
        }
        
        function register_external_auto($username, $system_name, $email, $first_name, $last_name) {
            
            $external_account_exist = $this->accountExist($username, $system_name, $email);
            //if (!isset($this->dbconnector))
            //        echo "Нет соединения с БД";
            //else
            //    echo "YES";
            $_SESSION['auto_generate_psw'] = null;
            
            $this->errormsg = array();
            //echo "[[[".$external_account_exist."]]]";
            if (!isset($external_account_exist)) {
                $this->errormsg[] = "Ошибка запроса существования пользователя!";
                return $GLOBALS['error_ext_account_exist_query'];
            }
            else    {
                $create_new_external_account = false;
                if (!$external_account_exist)   {
                    
                    $new_user_passwd = $this->generate_password(10);
                    
                    $create_new_external_account = $this->register($username, $new_user_passwd,
                            $new_user_passwd, $username, (isset($first_name)?$first_name:"").
                            (isset($last_name)?$last_name:""),true, $system_name);
                    
                    if (!$create_new_external_account)
                    {
                        $this->errormsg[] = "Неудачная регистрация нового пользователя!";
                        //print_r($this->errormsg);
                        return $GLOBALS['error_create_new_external_account'];
                    }
                    else
                    {
                      $_SESSION['auto_generate_psw'] = $this->hashpass($new_user_passwd);
                      return $GLOBALS['create_new_external_account'];
                    }
                }
                else
                    return $GLOBALS['external_account_exist'];
                
            }

        }
	
	function register($username, $password, $verifypassword, $email, $custom_name, $external_reg=false, $system_name=null)
	{
		//if(!isset($_COOKIE["auth_session"]))
		//{
                //
                        $this->errormsg = array();
			// Input Verification :
		        if(strlen($custom_name) == 0) { $this->errormsg[] = "Имя пользователя пустое!"; }
			elseif(strlen($custom_name) > 255) { $this->errormsg[] = "Имя пользователя слишком длинное!"; }
			elseif(strlen($custom_name) < 3) { $this->errormsg[] = "Имя пользователя слишком короткое!"; }
			
                        if(strlen($username) == 0) { $this->errormsg[] = "Логин пустой!"; }
			elseif(strlen($username) > 30) { $this->errormsg[] = "Логин пользователя слишком длинный!"; }
			elseif(strlen($username) < 3) { $this->errormsg[] = "Логин пользователя слишком короткий!"; }
			
                        if(strlen($password) == 0) { $this->errormsg[] = "Пустой пароль!"; }
			elseif(strlen($password) > 30) { $this->errormsg[] = "Пароль слишком длинный!"; }
			elseif(strlen($password) < 7) { $this->errormsg[] = "Пароль слишком короткий!"; }
			elseif($password !== $verifypassword) { $this->errormsg[] = "Ошибочное подтверждение пароля!"; }
			elseif(strstr($password, $username)) { $this->errormsg[] = "Пароль не должет соделжать в себе логин пользователя!"; }
			
                        if(strlen($email) == 0) { $this->errormsg[] = "Email пустой!"; }
			elseif(strlen($email) > 100) { $this->errormsg[] = "Email слишком длинный!"; }
			elseif((strlen($email) < 5)  && $this->email_with_login_reqiured) { $this->errormsg[] = "Email слишком короткий!"; }
			elseif(!filter_var($email, FILTER_VALIDATE_EMAIL) && $this->email_with_login_reqiured) { $this->errormsg[] = "Неверный адрес электронной почты!"; }
		
                        if ($external_reg) {
                            if(isset($system_name)) {
                                if(strlen($system_name) == 0) { 
                                    $this->errormsg[] = "Пустое имя внешней системы для авторегистрации!"; 
                                    }
                            }   else
                                $this->errormsg[] = "Не определено имя внешней системы для авторегистрации!";
                        }
                        
			if(count($this->errormsg) == 0)
			{
				// Input is valid
                                $account_exist = $this->accountExist($username, $system_name, $email); 
                                
                                if (!isset($account_exist)) {
                                    $this->errormsg[] = "Ошибка запроса существования пользователя!";
                                    return false;
                                }
                                
                                if ($account_exist)    {
                                    // Username already exists
                                    $this->errormsg[] = "Введенный логин и/или эл. почта уже заняты!";
                                    return false;
                                }

                                $password = $this->hashpass($password);
                                $reg_result = null;
                                $rows = null;
                                
                                if ($external_reg)  {
                                    $reg_result = 
                                        $this->dbconnector->exec_with_prepare_and_params_2ver("
                                        SET @person_id=NULL; SET @user_id=NULL; SET @sucess=NULL;
                                        call `register_external_user` ('{$username}', '{$password}', '{$email}', 
                                            '{$custom_name}', '{$system_name}',
                                            @sucess, @user_id, @person_id); ", array());
                                    $rows = $this->dbconnector->query_both_to_array
                                        ("SELECT * FROM users WHERE username='{$username}' AND system_name='{$system_name}'");
                                }   else    {
                                    $reg_result = 
                                        $this->dbconnector->exec_with_prepare_and_params_2ver("
                                        SET @person_id=NULL; SET @user_id=NULL; SET @sucess=NULL;
                                        call `register_user` ('{$username}', '{$password}', '{$email}', '{$custom_name}',
                                            @sucess, @user_id, @person_id); ", array());
                                    $rows = $this->dbconnector->query_both_to_array
                                        ("SELECT * FROM users WHERE username='{$username}' AND ISNULL(system_name)");
                                }
                                    //$this->dbconnector->exec_with_prepare_and_params_ret_success("
                                    //SET @person_id=NULL; SET @user_id=NULL; SET @sucess=NULL;
                                    //call `register_user` (:username, :password, :email, :custom_name,
                                    //    @sucess, @user_id, @person_id); 
                                    //SELECT @person_id as person_id, @user_id as user_id, @sucess as sucess;", 
                                    //array(":username"=>$username, ":password"=>$password, 
                                    //    ":email"=>$email, ":custom_name"=>$custom_name));
                                if (($reg_result!=null)&&($rows != null)) {
                                    if (count($rows)==1)
                                        return true;
                                    else
                                    {
                                        $this->errormsg[] = "Неудачная транзакция добавления пользователя!";
                                        return false;
                                    }
                                }
                                else    {
                                    $this->errormsg[] = "Неудачная транзакция добавления пользователя!";
                                    return false;
                                }
			}
			else 
			{
				return false;
			}
		//}
		//else 
		//{
			// User is logged in
		
		//	$this->errormsg[] = "You are currently logged in !";
			
		//	return false;
		//}
	}
        
        
        	/*
	* Log user in via MySQL Database
	* @param string $username
	* @param string $password
	* @return boolean
	
        function login($username, $password)
	{
		if(!isset($_COOKIE["auth_session"]))
		{
			$attcount = $this->getattempt($_SERVER['REMOTE_ADDR']);
			
			if($attcount >= 5)
			{
				$this->errormsg[] = "You have been temporarily locked out !";
				$this->errormsg[] = "Please wait 30 minutes.";
				
				return false;
			}
			else 
			{
				// Input verification :
			
				if(strlen($username) == 0) { $this->errormsg[] = "Username / Password is invalid !"; return false; }
				elseif(strlen($username) > 30) { $this->errormsg[] = "Username / Password is invalid !"; return false; }
				elseif(strlen($username) < 3) { $this->errormsg[] = "Username / Password is invalid !"; return false; }
				elseif(strlen($password) == 0) { $this->errormsg[] = "Username / Password is invalid !"; return false; }
				elseif(strlen($password) > 30) { $this->errormsg[] = "Username / Password is invalid !"; return false; }
				elseif(strlen($password) < 5) { $this->errormsg[] = "Username / Password is invalid !"; return false; }
				else 
				{
					// Input is valid
				
					$password = $this->hashpass($password);
				
					$query = $this->mysqli->prepare("SELECT isactive FROM users WHERE username = ? AND password = ?");
					$query->bind_param("ss", $username, $password);
					$query->bind_result($isactive);
					$query->execute();
					$query->store_result();
					$count = $query->num_rows;
					$query->fetch();
					$query->close();
				
					if($count == 0)
					{
						// Username and / or password are incorrect
					
						$this->errormsg[] = "Username / Password is incorrect !";
						
						$this->addattempt($_SERVER['REMOTE_ADDR']);
						
						$attcount = $attcount + 1;
						$remaincount = 5 - $attcount;
						
						$this->errormsg[] = "$remaincount attempts remaining.";
						
						return false;
					}
					else 
					{
						// Username and password are correct
						
						if($isactive == "0")
						{
							// Account is not activated
							
							$this->errormsg[] = "Account is not activated !";
							
							return false;
						}
						else
						{
							// Account is activated
						
							$this->newsession($username);				
					
							$this->successmsg[] = "You are now logged in !";
							
							return true;
						}
					}
				}
			}
		}
		else 
		{
			// User is already logged in
			
			$this->errormsg[] = "You are already logged in !";
			
			return false;
		}
	}*/
        
	
	/*
	* Creates a new session for the provided username and sets cookie
	* @param string $username
	
	
	function newsession($username)
	{
		$hash = md5(microtime());
		
		// Fetch User ID :		
		
		$query = $this->mysqli->prepare("SELECT id FROM users WHERE username=?");
		$query->bind_param("s", $username);
		$query->bind_result($uid);
		$query->execute();
		$query->fetch();
		$query->close();
		
		// Delete all previous sessions :
		
		$query = $this->mysqli->prepare("DELETE FROM sessions WHERE username=?");
		$query->bind_param("s", $username);
		$query->execute();
		$query->close();
		
		
		$expiretime = strtotime($expiredate);
		
		$query = $this->mysqli->prepare("INSERT INTO sessions (uid, username, hash, expiredate, ip) VALUES (?, ?, ?, ?, ?)");
		$query->bind_param("issss", $uid, $username, $hash, $expiredate, $ip);
		$query->execute();
		$query->close();
		
		setcookie("auth_session", $hash, $expiretime);
	}*/
	
	/*
	* Deletes the user's session based on hash
	* @param string $hash
	
	
	function deletesession($hash)
	{
		$query = $this->mysqli->prepare("SELECT username FROM sessions WHERE hash=?");
		$query->bind_param("s", $hash);
		$query->bind_result($username);
		$query->execute();
		$query->store_result();
		$count = $query->num_rows;
		$query->close();
		
		if($count == 0)
		{
			// Hash doesn't exist
		
			$this->errormsg[] = "Invalid Session Hash !";
			
			setcookie("auth_session", $hash, time() - 3600);
		}
		else 
		{
			// Hash exists, Delete all sessions for that username :
			
			$query = $this->mysqli->prepare("DELETE FROM sessions WHERE username=?");
			$query->bind_param("s", $username);
			$query->execute();
			$query->close();
			
			setcookie("auth_session", $hash, time() - 3600);
		}
	}*/
	
	/*
	* Provides an associative array of user info based on session hash
	* @param string $hash
	* @return array $session
	
	
	function sessioninfo($hash)
	{
		$query = $this->mysqli->prepare("SELECT uid, username, expiredate, ip FROM sessions WHERE hash=?");
		$query->bind_param("s", $hash);
		$query->bind_result($session['uid'], $session['username'], $session['expiredate'], $session['ip']);
		$query->execute();
		$query->store_result();
		$count = $query->num_rows;
		$query->fetch();
		$query->close();
		
		if($count == 0)
		{
			// Hash doesn't exist
		
			$this->errormsg[] = "Invalid Session Hash !";
			setcookie("auth_session", $hash, time() - 3600);
			
			return false;
		}
		else 
		{
			// Hash exists
		
			return $session;			
		}
	}
        */
	
	/* 
	* Checks if session is valid (Current IP = Stored IP + Current date < expire date)
	* @param string $hash
	* @return bool
	
	
	function checksession($hash)
	{
		$query = $this->mysqli->prepare("SELECT username, expiredate, ip FROM sessions WHERE hash=?");
		$query->bind_param("s", $hash);
		$query->bind_result($username, $db_expiredate, $db_ip);
		$query->execute();
		$query->store_result();
		$count = $query->num_rows;
		$query->fetch();
		$query->close();
		
		if($count == 0)
		{
			// Hash doesn't exist
			
			setcookie("auth_session", $hash, time() - 3600);
			
			return false;
		}
		else
		{
			if($_SERVER['REMOTE_ADDR'] != $db_ip)
			{
				// Hash exists, but IP has changed
			
				$query = $this->mysqli->prepare("DELETE FROM sessions WHERE username=?");
				$query->bind_param("s", $username);
				$query->execute();
				$query->close();
				
				setcookie("auth_session", $hash, time() - 3600);
				
				return false;
			}
			else 
			{
				$expiredate = strtotime($db_expiredate);
				$currentdate = strtotime(date("Y-m-d H:i:s"));
				
				if($currentdate > $expiredate)
				{
					// Hash exists, IP is the same, but session has expired
				
					$query = $this->mysqli->prepare("DELETE FROM sessions WHERE username=?");
					$query->bind_param("s", $username);
					$query->execute();
					$query->close();
					
					setcookie("auth_session", $hash, time() - 3600);
					
					return false;
				}
				else 
				{
					// Hash exists, IP is the same, date < expiry date
				
					return true;
				}
			}
		}
	}
	
	/*
	* Returns a random string, length can be modified
	* @param int $length
	* @return string $key
	
	
	function randomkey($length = 10)
	{
		$chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890";
		$key = "";
		
		for($i = 0; $i < $length; $i++)
		{
			$key .= $chars{rand(0, strlen($chars) - 1)};
		}
		
		return $key;
	}*/
	
}

?>