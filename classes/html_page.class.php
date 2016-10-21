<?php

/**
 * @author Poltarokov SP
 * @copyright 2011
 */

if (!defined("ABSOLUTE_PATH"))
    define("ABSOLUTE_PATH", dirname(dirname(__FILE__))."/");

require_once(constant("ABSOLUTE_PATH")."classes/tools.class.php");

abstract class HTMLPage extends Tools
{
    protected $Title = "";
    protected $browser_client_object=null;
    protected $browser = "browser not detected";
    protected $browser_long_name = "browser not detected";
    protected $browser_version = "browser not detected";
    protected $browser_ua = "browser not detected";
    protected $client_platform = "platform not detected";
    protected $client_os = "OS not detected";
    protected $client_IP = null;
    protected $client_language="language not detected";
    protected $programmaticaly_detected_mobile_device=false;
    protected $custom_page_top=true;
    protected $hide_registration_button=true;
    protected $show_external_logging = true;
    
function __construct($Title)    {
    $this->Title = $Title;
    
    $client=$this->getClientBrowserObject();
    
    $this->browser=$client->property("browser");
    $this->browser_long_name=$client->property("long_name");
    $this->browser_version=$client->property("version");
    $this->browser_ua=$client->property("ua");
    $this->client_platform=$client->property("platform");
    $this->client_os=$client->property("os");
    $this->client_IP=$client->property("ip");
    $this->programmaticaly_detected_mobile_device=
            $this->itIsMobileBrowser($client);
}

function BeginHTML()
 {
    
    session_start();
    
    //print_r($_SESSION);
    
    if (isset ($_GET['action']))    {
        if ($_GET['action']=="logout")  {
            session_regenerate_id(true);
            //session_destroy();
        }
    }
    if (isset ($_POST['action']))    {
        if ($_POST['action']=="logout")  {
            session_regenerate_id(true);
            //session_destroy();
        }
    }
    
    date_default_timezone_set('Europe/Moscow');
    
    if (isset ($_POST['action']))    {
        if ($_POST['action']=="logout")  {
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
            session_unset();
            session_destroy();
        }
    }
    
    echo "<!DOCTYPE html>
		<html xmlns:og=\"http://ogp.me/ns#\">
        <head>
            
            <meta property=\"og:title\" content=\"КудаПотратил. Территория грамотной финансовой жизни\"/>
            <meta property=\"og:type\" content=\"website\"/>
            <meta property=\"og:url\" content=\"http://kudapotratil.ru/\"/>
            <meta property=\"og:image\" content=\"http://kudapotratil.ru/img/logo.png\"/>
            <meta property=\"og:site_name\" content=\"Kudapotratil.ru\"/>
            <meta property=\"og:description\" content=\"Личные финансы. Для тех кто хочет управлять своим бюджетом, а не наоборот. Для тех кто уже планировал, откладывал, считал и для тех кто хочет, но не знает с чего начать.\"/>
            
            <title>{$this->Title}</title>
            <meta http-equiv=\"content-type\" content=\"text/html; charset=utf-8\" />
            <meta name=\"author\" content=\"\" />
            <meta name=\"description\" content=\"КудаПотратил. Территория грамотной финансовой жизни\">  
            ";
            
    if(isset($_GET['browser_width']))
        $_SESSION['LAST_BROWSER_WIDTH']=$_GET['browser_width'];
            
    $this->writeHeaderAttachment();
            
    if(array_key_exists("desktop_mode",$_GET)||
            array_key_exists("mobile_mode",$_GET)||
            array_key_exists("test_mode",$_GET)) 
    echo "
    <script language=\"JavaScript\" type=\"text/javascript\">
        
        $(document).ready(function() {
        
            try {
            initAcc3(); }
            catch(e)    {
            }
              
            //align element in the middle of the screen
            $.fn.alignCenter = function() {
                //get margin left
                var marginLeft = Math.max(40, parseInt($(window).width()/2 - $(this).width()/2)) + 'px';
                //get margin top
                var marginTop = Math.max(40, parseInt($(window).height()/2 - $(this).height()/2)) + 'px';
                //return updated element
                return $(this).css({'margin-left':marginLeft, 'margin-top':marginTop});
            };
            
            $.fn.alignCenterAbs = function() {
                //get left
                var marginLeft = Math.max(40, parseInt($(window).width()/2 - $(this).width()/2)) + 'px';
                //get top
                var marginTop = Math.max(40, parseInt($(window).height()/2 - $(this).height()/2)) + 'px';
                //return updated element
                return $(this).css({'left':marginLeft, 'top':marginTop});
            };
            
            //window.onbeforeunload = function (e) {
            //    alert('dddd');
            //    sendLogoutRequest();
            //};

        });
        
        //$(document).unload(function() {
        //    alert('dddd');
        //    sendLogoutRequest();
        //
        //});

        
        
        var root = window.addEventListener || window.attachEvent ? window : document.addEventListener ? document : null;
            if(root) {
                //alert('Handler for .unload() called - linked.');
                root.onbeforeunload=function () { 
                    //sendLogoutRequest();
                    //alert('Exit?'); 
                    };
            }

        $(window).unload(function() {
            //sendLogoutRequest();
            //alert('Handler for .unload() called.');
        });
        
        // Когда страница полностью загружена
        $(window).ready(function()
        {
                // запоминаем высоту и отступы каждого блока
                $('#accordion > div').each(function()
                {
                        $(this).data('height', $(this).height());
                        $(this).data('padding-top', $(this).css('padding-top'));
                        $(this).data('padding-bottom', $(this).css('padding-bottom'));
                });

                // Скрываем все секции кроме первой
                $('#accordion > div:not(:first)').hide();
                // Делаем первую секцию активной
                $('#accordion h3:first, #accordion div:first').addClass('active');
                // Если пользователь кликнул на секцию
                $('#accordion > h3').click(function()
                {
                        // Сбрасываем все секции
                        $('#accordion > h3').removeClass('active');
                        $('#accordion > div:visible').animate({height: 0, 'padding-top': 0, 'padding-bottom': 0}, 500, function() { $(this).hide() });

                        // Делаем активной на которую кликнули
                        $(this).addClass('active');
                        box = $(this).next().addClass('active');
                        $(box).animate(
                        {
                                height: $(box).data('height'), 
                                'padding-top': $(box).data('padding-top'), 
                                'padding-bottom': $(box).data('padding-bottom')
                        }, 500);
                });
        });
        
        </script>";
    else if(array_key_exists("app_mode",$_REQUEST)) {
        if(array_key_exists("app_type",$_REQUEST))
            require "apps/".$GLOBALS['external_applications'][$_REQUEST['app_type']]['app_head_path'];
    }
    require "include/end_head_scripts.php";
    echo  "</head>";
 }
 
 abstract function BodyHTML();
 abstract function writeHeaderAttachment();
 
 function EndHTML()
 {
    echo "
    </html>";
 }  
 
 function Write()
 {
    $this->BeginHTML();
    $this->BodyHTML();
    $this->EndHTML();
 }    
  
}

?>
