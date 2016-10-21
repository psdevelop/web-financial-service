<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

require_once("classes/view_forms/navigation_menu.class.php");

class ManageMenuClass extends NavigationMenu  {
    
    function __construct()  {
        //parent::__construct("myslidemenu", "jqueryslidemenu");
        parent::__construct("left_default_menu", "");//"shadowblockmenu");
    }
    
    function writeMenu($container_class=null)    {
	$this->addChildItemJSAndHrefExternal(
                "Отчеты", " load_main_region('', '&report_page_mode&desktop_mode'); ", 
                "", "", "#", "Формирование отчетов");
        $this->addChildItemJSAndHrefExternal(
                "Категории", " load_main_region('', '&categories_page_mode&desktop_mode'); ", 
                "", "", "#", "Управление справочником категорий");
        $this->addChildItemJSAndHrefExternal(
                "Импорт", " load_main_region('', '&import_page_mode&desktop_mode'); ", 
                "", "", "#", "Загрузка данных об операциях из электронных выписок банков");
        if (($_SESSION['login'] == "psdevelop")||($_SESSION['login'] == "dvmaslennikov"))   {
            $this->addChildItemJSAndHrefExternal(
                    "Приглашения", " load_main_region('', '&invites_page_mode&desktop_mode'); ", 
                    "", "", "#", "Заявки на приглашения к регистрации");
            $this->addChildItemJSAndHrefExternal(
                    "Новости", " load_main_region('', '&news_page_mode&desktop_mode'); ", 
                    "", "", "#", "Панель управления новостями");
        }
        echo "<div class=\"".($container_class==null?"main_menu_default":$container_class)."\">";
        $this->generateMenu();
        echo "</div>";
    }
}

?>
