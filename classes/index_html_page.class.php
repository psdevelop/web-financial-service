<?php

/**
 * @author Poltarokov SP
 * @copyright 2011
 */

if (!defined("ABSOLUTE_PATH"))
    define("ABSOLUTE_PATH", dirname(dirname(__FILE__))."/");
 
require_once(constant("ABSOLUTE_PATH")."classes/html_page.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/tools.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/dbconnector.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/auth.class.php");
require_once(constant("ABSOLUTE_PATH")."classes/configuration.php");

abstract class IndexHTMLPage extends HTMLPage
{

 function __construct($Title)
 {
    parent::__construct("КудаПотратил. Территория грамотной финансовой жизни");
 }
 
 function BodyHTML()
 { 
    //Запрос при переходе из соц. сети через сервис ulogin
    //http://kudapotratil.ru/index.php?action=external_login&external_access_type=ulogin
    //http://kudapotratil.ru/index.php?action=external_login&external_access_type=ulogin&desktop_mode 
     
    //$s = file_get_contents('http://ulogin.ru/token.php?token=' . $_POST['token'] . '&host=' . $_SERVER['HTTP_HOST']);
    //$user = json_decode($s, true);
    //$user['network'] - соц. сеть, через которую авторизовался пользователь
    //$user['identity'] - уникальная строка определяющая конкретного пользователя соц. сети
    //$user['first_name'] - имя пользователя
    //$user['last_name'] - фамилия пользователя
    
    $Connector = new DbConnector($GLOBALS['dbhost'],$GLOBALS['dbname'],$GLOBALS['dbuser'],$GLOBALS['dbpsw']);
    $UserAuth = new UserAuthentification($Connector); 
     
    if (isset($_GET['action'])&&isset($_GET['external_access_type'])) 
    {
        if (($_GET['action']=="external_login")&&($_GET['external_access_type']=="ulogin"))   {
            
            try {
                
                $s = file_get_contents('http://ulogin.ru/token.php?token='.
                    $_POST['token'].'&host='.$_SERVER['HTTP_HOST']);
                $external_user = json_decode($s, true);

                $Connector->createConnection(true);
                $ext_user_result = $UserAuth->register_external_auto($external_user['identity'], 
                    $external_user['network'], $external_user['identity'], 
                        $external_user['first_name'], $external_user['last_name']);
                
                //echo $ext_user_result;
                if ($ext_user_result==$GLOBALS['error_ext_account_exist_query'])   {
                        echo "Ошибка проверки наличия профиля!";
                        }
                else if ($ext_user_result==$GLOBALS['error_create_new_external_account'])    {
                        echo "Неудачное создание аккаунта по профилю, переданному сервисом!";
                }
                else if ($ext_user_result==$GLOBALS['external_account_exist'])  {
                        $_SESSION['login'] = $external_user['identity'];
                        $_SESSION['psw'] = $_SESSION['exist_psw'];
                }
                else if ($ext_user_result==$GLOBALS['create_new_external_account']) {
                        $_SESSION['login'] = $external_user['identity'];
                        $_SESSION['psw'] = $_SESSION['auto_generate_psw'];
                }
                else    {
                    
                }
                
            }   catch (Exception $e) {
                $sucess=false;
                //echo 'Выброшено исключение: ',  $e->getMessage(), "\n";
            }
            
        }
    }

     
    if (!isset ($_SESSION['login']))    {
        $_SESSION['login'] = "";
    }
    if (!isset ($_SESSION['psw']))  {
        $_SESSION['psw'] = "";
    }
    if (!isset ($_SESSION['enable_admin']))  {
        $_SESSION['enable_admin'] = false;
    }
    if (!isset ($_SESSION['enable_deleting']))  {
        $_SESSION['enable_deleting'] = false;
    }
    if (!array_key_exists('operator_id', $_SESSION))    {
        $_SESSION['operator_id'] = null;
    }
    if (!array_key_exists('manager_id', $_SESSION))    {
        $_SESSION['manager_id'] = null;
    }
    
    if (isset ($_POST['login']))    {
        $_SESSION['login'] = $_POST['login'];
        
    }
    if (isset ($_POST['psw'])) {
        $_SESSION['psw'] = $this->hashpass($_POST['psw']);
    }
    
    if (isset ($_GET['action']))    {
        if ($_GET['action']=="logout")  {
            $_SESSION['login'] = "";
            $_SESSION['psw'] = "";
            $_SESSION['user_id'] = null;
            $_SESSION['operator_id'] = null;
            $_SESSION['manager_id'] = null;
            $_SESSION['enable_admin'] = false;
            $_SESSION['enable_deleting'] = false;
            $_SESSION['load_visa_default_cats'] = false;
            $_SESSION['desktop_mode']="NO";
            $_SESSION['mobile_mode']="NO";
            $_SESSION['STORED_REMOTE_ADDR'] = null;
            //session_regenerate_id(true);
            //session_unset();
            //session_destroy();
            //session_start();
        }
    }
    
    $js_get_params = "";
    if (isset($_GET['class_name']))
        $js_get_params .= "&class_name=".$_GET['class_name'];
    if (isset($_GET['report_name']))
        $js_get_params .= "&report_name=".$_GET['report_name'];
    if (array_key_exists('report_mode', $_GET)) 
        $js_get_params .= "&report_mode";
    if (array_key_exists('categories_page_mode', $_GET)) 
        $js_get_params .= "&categories_page_mode";
    if (array_key_exists('report_page_mode', $_GET)) 
        $js_get_params .= "&report_page_mode";
    if (array_key_exists('import_page_mode', $_GET)) 
        $js_get_params .= "&import_page_mode";
    if (array_key_exists("desktop_mode",$_GET)||(isset($_SESSION['desktop_mode'])?($_SESSION['desktop_mode']=="YES"):false))
            $js_get_params .= "&desktop_mode";
    if (array_key_exists("mobile_mode",$_GET)||(isset($_SESSION['mobile_mode'])?($_SESSION['mobile_mode']=="YES"):false))
            $js_get_params .= "&mobile_mode";
    echo "<body";//id=\"body_id\" leftmargin=\"0\" topmargin=\"0\" rightmargin=\"0\" bottommargin=\"0\" 
    
    if(array_key_exists("desktop_mode",$_GET)||
            array_key_exists("mobile_mode",$_GET)||
            array_key_exists("test_mode",$_GET)||
            array_key_exists('reg', $_GET)||
            array_key_exists('registration_data', $_GET)) {
                echo " onLoad=\" ";
                $page_id="main_page";
                if (isset($_GET['page_id'])) {
                    $page_id=$_GET['page_id'];
                }

                if (array_key_exists('reg', $_GET)||array_key_exists('registration_data', $_GET)) {
                    $Connector->createConnection();
                }   else {

                    if ($UserAuth->checkLogin($_SESSION['login'], $_SESSION['psw']))   {
                        if (isset($_GET['action']))  {
                            if ($_GET['action']!="logout")  {
                                echo "load_main_region('{$page_id}','{$js_get_params}');";
                            }
                        }
                        else    {
                            echo "load_main_region('{$page_id}','{$js_get_params}');";
                        }    
                    }

                }
                
                echo "\" ";
            }
    
    echo ">";

    if(array_key_exists("desktop_mode",$_GET)||
            array_key_exists("mobile_mode",$_GET)||
            array_key_exists("test_mode",$_GET)) {
                echo "<div class=\"browser_info\" style=\"display:".(($_SESSION['login'] == "psdevelop")||isset($_GET['show_browser_info'])?"":"none").";\">";
                echo "<b>browser:</b> {$this->browser}; <b>browser_version:</b> {$this->browser_version}; 
                    <b>browser_ua:</b> {$this->browser_ua};";
                echo "<br/><b>Ваш браузер:</b> {$this->browser_long_name} ({$this->browser}); 
                    <b>client_platform:</b> {$this->client_platform}; <b>client_os:</b> {$this->client_os};";
                //echo "<script language=\"JavaScript\">document.write('<b>Ширина экрана:</b> '+windowWidth()+'px;');</script>"; 
                //echo $_SERVER['HTTP_USER_AGENT'];    
                echo "</div>";
                echo "<div class=\"browser_info\" style=\"display:".
                        (($_SESSION['login'] == "psdevelop")||isset($_GET['show_browser_info'])?"":"none").";\">";
                echo "[SESSION ID=".session_id()."]"; //print_r($_SESSION);
                echo "</div>";

                echo "<script language=\"JavaScript\">
                        if ((windowWidth() > 700)) {
                            document.write ('<div id=\"opaco\" class=\"hidden\"></div>'+
                            '<div id=\"confirm\" class=\"hidden\"><!--<div><input '+
                            'id=\"not_close_action_window\" type=\"checkbox\"/>'+
                            'Не закрывать окно действия</div>--><p>Подтверждаете действие?<br/>'+
                            '<input type=\"button\" class=\"gray medium\" id=\"confirm_yes\" '+
                            'name=\"confirm_yes\" value=\"Да\" /> '+
                            ' <input type=\"button\"  '+
                            'class=\"gray medium\" id=\"confirm_no\" name=\"confirm_no\" '+
                            'onclick=\"closeConfirm();\" value=\"Нет\" /></p></div>');
                            }
                      </script>";

                echo "<div id=\"warning_region\" style=\"font-size:10px; color:#CCCCCC; display:".
                        (($_SESSION['login'] == "psdevelop")?"":"none").";\"></div>";
            }
    
    if (array_key_exists('reg', $_GET)||array_key_exists('registration_data', $_GET)) {
        
        //print_r($_REQUEST);
        
        if (array_key_exists('registration_data', $_GET))   {
            
            //$captcha_message = "";
            $correct_reg_data=true;
            //$style = "background-color: #CCFF99";
                
            $correct_reg_data = $UserAuth->checkRegistrationData();

            //if ($correct_reg_data) {
            //    $captcha_message .= "Успешная предварительная проверка данных регистрации!";
            //    $style = "background-color: #CCFF99";
            //}
            //$request_captcha = htmlspecialchars($_REQUEST['captcha-form']);
            
            if (!$correct_reg_data) {
                echo "
                    <div id=\"result\" style=\"{$UserAuth->message_style}\">
                        <h2>{$UserAuth->last_reg_message}</h2>
                    </div>";
                $UserAuth->writeRegisterForm();
            }
            else
            {
                if  ($UserAuth->register($UserAuth->last_user_login, $UserAuth->last_password, 
                        $UserAuth->last_password, $UserAuth->last_email, $UserAuth->last_user_name)) {
                    echo "
                        <div id=\"db_result\" style=\"{$UserAuth->message_style}\">
                            <h2>Поздравляем, вы успешно зарегистрировались!</h2>
                            <a class=\"medium blue\" href=\"index.php?action=logout\">На главную</a>
                        </div>";
                }   else    {
                        //print_r($UserAuth->errormsg);
                        echo "<div id=\"db_result\" style=\"background-color: #FF606C\">";
                        foreach ($UserAuth->errormsg as $msg) {
                            echo "<br/>".$msg;
                        }
                        echo "</div>"; 
                        $UserAuth->writeRegisterForm();
                    }

            }
                
        }   else
            $UserAuth->writeRegisterForm();
        
    }   else {
    
    //print_r($_GET); echo "------";
    //print_r($_SESSION);
    if ($UserAuth->checkLogin($_SESSION['login'], $_SESSION['psw']))    {
        if (isset ($_GET['action']))    {
        if ($_GET['action']=="login")  {
                $UserAuth->writeUserInput($_SESSION['login']);
            }
        }
  
        if (array_key_exists('upload', $_GET)) {
            // Каталог, в который мы будем принимать файл:
            $uploaddir = 'uploads/';
            $uploadfile = $uploaddir.basename($_FILES['uploadfile']['name']);
            // Копируем файл из каталога для временного хранения файлов:
            //if (copy($_FILES['uploadfile']['tmp_name'], $uploadfile))
            //{  echo "<h3>Файл успешно загружен на сервер</h3>";  }
            //else { echo "<h3>Ошибка! Не удалось загрузить файл на сервер!</h3>"; }
            echo "<div class=\"system_attention\"><h3>Информация о загруженном на сервер файле: </h3>";
            echo "<p><b>Оригинальное имя: ".$_FILES['uploadfile']['name'].
                    ", размер в байтах: ".$_FILES['uploadfile']['size']."</b></p>";
            //echo "<p><b>Mime-тип загруженного файла: ".$_FILES['uploadfile']['type']."</b></p>";
            //echo "<p><b>Размер в байтах: ".$_FILES['uploadfile']['size']."</b></p>";
            //echo "<p><b>Временное имя файла: ".$_FILES['uploadfile']['tmp_name']."</b></p>";
        
            $FCATAdapt = new FinanceActDataTableAdapter($Connector, "", "FinanceActData");
            if(isset($_GET["upld_purse_id"]))    {
                if ((int)$_GET["upld_purse_id"]>0)
                    $FCATAdapt->loadDataFromCSVFile($_FILES['uploadfile']['tmp_name'], 
                        array( "purse_id"=>(isset($_GET["upld_purse_id"])?$_GET["upld_purse_id"]:null) )  );
                else
                    echo "Не определен кошелек";
            }
            else
                echo "Не определен кошелек";
            echo "</div>";
        }
        
        if (array_key_exists("desktop_mode",$_GET)
                ||(isset($_SESSION['desktop_mode'])?($_SESSION['desktop_mode']=="YES"):false)) {
            echo "<table class=\"inside_top\" cellpadding=\"0\" cellspacing=\"0\"><tr>
                <td style=\"width:275px;\"><div class=\"inside_top_left\">"; 
            echo "<a title=\"На главную\" class=\"\" 
                href=\"index.php?desktop_mode\">
                <img class=\"logo_image\" src=\"styles/images/Logo2.png\" /></a>";
            echo "</div></td>
                <td><div class=\"inside_top_bottom_center\">&nbsp;</div></td>
                <td style=\"width:490px;vertical-align: bottom;\"><div class=\"inside_top_right\">";
            echo "<div style=\"padding: 10px; text-align:right;\">
                <table align=\"right\" cellspacing=\"10\" border=\"0\"><tr>
                <td><a title=\"На главную\" class=\"\" 
                href=\"index.php?desktop_mode\" >
                <img src=\"styles/images/home.png\" style=\"width:20px;\" /></a></td>
                <td><a title=\"Новостная лента\" class=\"\" 
                href=\"#\" rel=\"external\">
                <img src=\"styles/images/rss.png\" style=\"width:20px;\" /></a></td>
                <td><a title=\"Поиск\" class=\"\" 
                href=\"#\" rel=\"external\">
                <img src=\"styles/images/search.png\" style=\"width:20px;\" /></a></td>
                <td><a title=\"E-mail\" class=\"\" 
                href=\"#\" rel=\"external\">
                <img src=\"styles/images/email.png\" style=\"width:20px;\" /></a></td>
                <td>Здравствуйте, ".$_SESSION['login'].
                "</td><td style=\"vertical-align: middle;\"> 
                <a title=\"Выход\" class=\"\" href=\"index.php?action=logout&desktop_mode\" rel=\"external\">
                <img src=\"styles/images/input.png\" style=\"width:20px;\"></a>
                </td></tr></table></div>";
            echo "</div></td></tr></table>";
        }
        
        $this->MainText($Connector);
        
        if (array_key_exists("desktop_mode",$_GET)
                ||(isset($_SESSION['desktop_mode'])?($_SESSION['desktop_mode']=="YES"):false)) {
            echo "<table class=\"inside_bottom\" cellpadding=\"0\" cellspacing=\"0\"><tr>
                <td style=\"width:294px;\"><div class=\"inside_bottom_left\">"; 
            echo "</div></td>
                <td><div class=\"inside_bottom_center\">&nbsp;</div></td>
                <td style=\"width:290px;vertical-align: bottom;\"><div class=\"inside_bottom_right\">";
            echo "<div style=\"padding: 15px; text-align:right;\">
                <table align=\"right\" cellspacing=\"10\" border=\"0\"><tr>
                <td style=\"vertical-align: middle;\"> 
                <a title=\"Служебная информация\" class=\"header_foother_link\" href=\"#\" rel=\"external\">
                Служебная информация</a>
                </td>
                </tr></table></div>";
            echo "</div></td></tr></table>";
        }
        
    }
    else //Общедоступная часть
    {
        if (isset ($_GET['action']))    {
        if ($_GET['action']=="login")  {
            $UserAuth->writeAttempts();
            }
        }
        
        
        
        $show_login_form=false;
        if ($show_login_form||array_key_exists("desktop_mode",$_GET)||
            array_key_exists("mobile_mode",$_GET)||
                array_key_exists("test_mode",$_GET))   {
        echo ($this->custom_page_top?"":"<br/><br/>").
        "<div style=\"text-align:center;\"><center><table class=\"".
         ($this->custom_page_top?"custom_login_form":"login_form").
         "\"><tr><td>";
        
        echo ($this->custom_page_top?"<script language=\"JavaScript\">
            if ((windowWidth() > 700)) {
                document.write('<table class=\"inside_top\" cellpadding=\"0\" cellspacing=\"0\"><tr>'+
                '<td style=\"width:275px;\"><div class=\"inside_top_left\">'+
                '<a title=\"На главную\" class=\"\" href=\"index.php?desktop_mode&browser_width='+windowWidth()+
                '\">'+'<img class=\"logo_image\" src=\"styles/images/Logo2.png\" /></a></div></td>'+
                '<td><div class=\"inside_top_bottom_center\">&nbsp;</div></td>'+
                '<td style=\"width:490px;vertical-align: bottom;\"><div class=\"inside_top_right\">'+
                '<div style=\"padding: 10px; text-align:right;\">'+
                '<table align=\"right\" cellspacing=\"10\" border=\"0\"><tr>'+
                '<td><a title=\"На главную\" class=\"\" href=\"index.php?desktop_mode\">'+
                '<img src=\"styles/images/home.png\" style=\"width:20px;\" /></a></td>'+
                '<td><a title=\"Новостная лента\" class=\"\" href=\"#\" rel=\"external\">'+
                '<img src=\"styles/images/rss.png\" style=\"width:20px;\" /></a></td>'+
                '<td><a title=\"Поиск\" class=\"\" href=\"#\" rel=\"external\">'+
                '<img src=\"styles/images/search.png\" style=\"width:20px;\" /></a></td>'+
                '<td><a title=\"E-mail\" class=\"\" href=\"#\" rel=\"external\">'+
                '<img src=\"styles/images/email.png\" style=\"width:20px;\" /></a></td><td>');
                } </script>":"");
        
        $UserAuth->writeLoginForm();
        
        echo ($this->custom_page_top?"<script language=\"JavaScript\">
            if ((windowWidth() > 700)) {
                document.write('</td></tr></table></div>'+
                '</div></td></tr></table>');
                } </script>":"");
        
        echo "</td></tr>";
        if (!$this->hide_registration_button)
          echo "<tr><td style=\"padding:10px;\">{$UserAuth->getRegistrationButton()}</td></tr>";
        echo "</table></center></div>";
        }
        else if(array_key_exists("app_mode",$_REQUEST)) {
            if(array_key_exists("app_type",$_REQUEST))
            require "apps/".$GLOBALS['external_applications'][$_REQUEST['app_type']]['app_public_path'];
        }
        else
            require "include/index-static.php";
        require "include/seo_scripts_menu_bottom.php";

    }
    
    
    }
    echo "</body>";
 }

 abstract function MainText($Connector);
 
 function writeHeaderAttachment()   {
     if(array_key_exists("desktop_mode",$_GET)||
            array_key_exists("mobile_mode",$_GET)||
            array_key_exists("test_mode",$_GET)) 
     echo "<script language=\"JavaScript\">
            function windowHeight() {
                var de = document.documentElement;
                try {
                    return self.innerHeight || ( de && de.clientHeight ) || document.body.clientHeight;
                }   catch (e) { return 1500; }
            }

            // Определение ширины видимой части страницы
            function windowWidth() {
                var de = document.documentElement;
                try {
                    return self.innerWidth || ( de && de.clientWidth ) || document.body.clientWidth;
                }   catch (e) { return 1500; }
            }
            </script>";
    else if(array_key_exists("app_mode",$_REQUEST)) {
        if ($_REQUEST['app_type']=="vk_app")    {
            
        }
    } 
    
    $this->AddCSSLinkTag("styles/jquery-ui-1.8.21.custom.css");
    
    if(array_key_exists("desktop_mode",$_GET)||
            array_key_exists("mobile_mode",$_GET)||
            array_key_exists("test_mode",$_GET)||
            array_key_exists("reg",$_GET)||
            array_key_exists('registration_data', $_GET))   {
    if ($GLOBALS['check_programm_platform_detected']&&$this->programmaticaly_detected_mobile_device)    {
        echo "<link href=\"styles/default_theme_400.css\" rel=\"stylesheet\" type=\"text/css\">
              <link href=\"styles/jquery.mobile-1.0.1.min.css\" rel=\"stylesheet\" type=\"text/css\">";
    }
    else if (!array_key_exists("desktop_mode",$_GET)
            &&!(isset($_SESSION['desktop_mode'])?($_SESSION['desktop_mode']=="YES"):false)) {	
     echo "<script language=\"JavaScript\">
                    if ((windowWidth() > 700)) {
                        document.write ('<link href=\"styles/default_theme_1024.css\" rel=\"stylesheet\" type=\"text/css\">');
                        document.write ('<link href=\"styles/jqueryslidemenu_1024.css\" rel=\"stylesheet\" type=\"text/css\">');
                    }
                    else {
                        document.write ('<link href=\"styles/default_theme_700.css\" rel=\"stylesheet\" type=\"text/css\">'); 
                        document.write ('<link href=\"styles/jqueryslidemenu_700.css\" rel=\"stylesheet\" type=\"text/css\">');
                        document.write ('<link href=\"styles/jquery.mobile-1.0.1.min.css\" rel=\"stylesheet\" type=\"text/css\">');
                    }
            </script>";
            }
    else    {
        $this->AddCSSLinkTag("styles/default_theme_1024.css");
        $this->AddCSSLinkTag("styles/jqueryslidemenu_1024.css");
    }
    $this->AddCSSLinkTag("styles/top_frame_tabs_globalnav.css");
    $this->AddCSSLinkTag("styles/jqueryslidemenu.css");
    $this->AddCSSLinkTag("styles/css3ShadowBlockMenu.css");
    $this->AddCSSLinkTag("styles/blue/style.css");
    $this->AddCSSLinkTag("styles/anytime.css");
    $this->AddCSSLinkTag("styles/left_default_menu.css");
    $this->AddCSSLinkTag("styles/buttons_nerwall.css");
    }
    else if(array_key_exists("app_mode",$_REQUEST)) {
        if ($_REQUEST['app_type']=="vk_app")    {
            $this->AddCSSLinkTag("apps/styles/vk/common.css");
        }
    }
    else    {
    $this->AddCSSLinkTag("styles/bootstrap.css");
    $this->AddCSSLinkTag("styles/main.css");
    }
    
    //print_r($_SESSION); print_r($_GET);
    
    if(array_key_exists("desktop_mode",$_GET)||
            array_key_exists("mobile_mode",$_GET)||
            array_key_exists("test_mode",$_GET)||
            array_key_exists("reg",$_GET)||
            array_key_exists('registration_data', $_GET))   {
    
    if ($GLOBALS['check_programm_platform_detected']&&$this->programmaticaly_detected_mobile_device)    {
        $this->AddJSLinkTag("jscripts/jquery-1.6.4.min.js");
        $this->AddJSLinkTag("jscripts/jquery.mobile-1.0.1.min.js");
    }
    else if (!array_key_exists("desktop_mode",$_GET)
            &&!(isset($_SESSION['desktop_mode'])?($_SESSION['desktop_mode']=="YES"):false)) {
        
        if (array_key_exists("mobile_mode",$_GET)||
                (isset($_SESSION['mobile_mode'])?($_SESSION['mobile_mode']=="YES"):false))    {
            $this->AddJSLinkTag("jscripts/jquery-1.6.4.min.js");
            $this->AddJSLinkTag("jscripts/jquery.mobile-1.0.1.min.js");
        }
        else
        echo "<script language=\"JavaScript\">

            if ((windowWidth() > 700)) {
                var thescript = document.createElement('script');
                thescript.setAttribute('type','text/javascript');
                thescript.setAttribute('src','jscripts/jquery-1.7.2.min.js');
                document.getElementsByTagName('head')[0].appendChild(thescript);
            }
            else {
                
                var thescript = document.createElement('script');
                thescript.setAttribute('type','text/javascript');
                thescript.setAttribute('src','jscripts/jquery-1.6.4.min.js');
                document.getElementsByTagName('head')[0].appendChild(thescript);
            }

	</script>";
        //$this->AddJSLinkTag("jscripts/jquery.tabslideout.v1.2.js");
            }
    else    {
        $this->AddJSLinkTag("jscripts/jquery-1.7.2.min.js");
        //$this->AddJSLinkTag("jscripts/1_7_2/jquery.min.js");
        //$this->AddJSLinkTag("https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js");
    }
    //$this->AddJSLinkTag("jscripts/jqueryslidemenu.js");
    $this->AddJSLinkTag("jscripts/jquery-ui-1.8.21.custom.min.js");
    
                $this->AddJSLinkTag("jscripts/jquery.tablesorter/jquery.tablesorter.js");
                //$this->AddJSLinkTag("jscripts/jquery.tablesorter/jquery.tablesorter.pager.js");
                //$this->AddJSLinkTag("jscripts/jscharts.js");
                
                //$this->AddJSLinkTag("jscripts/jquery.ui.datepicker.js");??????
                //$this->AddJSLinkTag("jscripts/amcharts.js");
                $this->AddJSLinkTag("jscripts/Highcharts_2_2_5/js/highcharts.js");
                $this->AddJSLinkTag("jscripts/Highcharts_2_2_5/js/modules/exporting.js");
                $this->AddJSLinkTag("jscripts/charts070912.js");
                $this->AddJSLinkTag("jscripts/anytime.js");
                $this->AddJSLinkTag("jscripts/ajax220812.js");
                $this->AddJSLinkTag("jscripts/work_managment050712.js");
    
                if ($this->show_external_logging)
                    $this->AddJSLinkTag("http://ulogin.ru/js/ulogin.js");
    }
    else if(array_key_exists("app_mode",$_REQUEST)) {
        $this->AddJSLinkTag("jscripts/jquery-1.8.0.min.js");
        if ($_REQUEST['app_type']=="vk_app")    {
            $this->AddJSLinkTag("http://vk.com/js/api/xd_connection.js?2");
            //$this->AddJSLinkTag("http://vkontakte.ru/js/api/openapi.js");
        }
    }
    else
    {   
        $this->AddJSLinkTag("jscripts/promo/TweenMax.min.js");
        $this->AddJSLinkTag("http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"); 
        $this->AddJSLinkTag("jscripts/promo/jquery.superscrollorama.js");
        $this->AddJSLinkTag("jscripts/promo/bootstrap.js");
        $this->AddJSLinkTag("jscripts/promo/easing.js");
        $this->AddJSLinkTag("jscripts/promo/form.js");
        $this->AddJSLinkTag("jscripts/promo/place.js");
        $this->AddJSLinkTag("jscripts/promo/app.js");
    }
    
    if ($GLOBALS['check_programm_platform_detected']&&$this->programmaticaly_detected_mobile_device)    {

    }
    else if (!array_key_exists("desktop_mode",$_GET)
            &&!(isset($_SESSION['desktop_mode'])?($_SESSION['desktop_mode']=="YES"):false)) {
        
        if (array_key_exists("mobile_mode",$_GET)||
                (isset($_SESSION['mobile_mode'])?($_SESSION['mobile_mode']=="YES"):false))    {

        }
        else    {
                    if(array_key_exists("desktop_mode",$_GET)||
                        array_key_exists("mobile_mode",$_GET)||
                        array_key_exists("test_mode",$_GET)||
                        array_key_exists("reg",$_GET)||
                        array_key_exists('registration_data', $_GET)) 
                    echo "<script language=\"JavaScript\">

                        if ((windowWidth() > 700)) {

                        }
                        else {
                            var mobscript = document.createElement('script');
                            mobscript.setAttribute('type','text/javascript');
                            mobscript.setAttribute('src','jscripts/jquery.mobile-1.0.1.min.js');
                            document.getElementsByTagName('head')[0].appendChild(mobscript);
                        }

                    </script>";
                    else if(array_key_exists("app_mode",$_REQUEST)) {
        
                    }
                    else
                    {
                        
                    }
                }
            }
    else    {

    }
    
 }

}
 

?>
