<?php

/*Poltarokov SP 30052012
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

require_once("classes/view_forms/navigation_menu.class.php");

class PlanningMenuClass extends NavigationMenu  {
    
    function __construct()  {
        //parent::__construct("myslidemenu", "jqueryslidemenu");
        parent::__construct("left_default_menu", "");//"shadowblockmenu");
    }
    
    function writeMenu($container_class=null)    {
	$this->addChildItemJSAndHrefExternal(
                "План", " load_main_region('', '&fplan_page_mode&desktop_mode'); ", 
                "", "", "#", "Обзор реализованных, запланированных и прогнозируемых операций, сводка по планированию");
        $this->addChildItemJSAndHrefExternal(
                "Доходы", " load_main_region('', '&fincomes_page_mode&desktop_mode'); ", 
                "", "", "#", "Ожидаемые, возможные доходы, выплаты заемщиков");
        $this->addChildItemJSAndHrefExternal(
                "Расходы", " load_main_region('', '&fcharges_page_mode&desktop_mode'); ", 
                "", "", "#", "Предполагаемые, вероятные расходы");
        $this->addChildItemJSAndHrefExternal(
                "Долги", " load_main_region('', '&debts_page_mode&desktop_mode'); ", 
                "", "", "#", "Непогашеные кредиты, долговые обязательства");
        $this->addChildItemJSAndHrefExternal(
                "Цели", " load_main_region('', '&targets_page_mode&desktop_mode'); ", 
                "", "", "#", "Запланированные и реализуемые цели");
        echo "<div class=\"".($container_class==null?"main_menu_default":$container_class)."\">";
        $this->generateMenu();
        echo "</div>";
    }
}

?>
