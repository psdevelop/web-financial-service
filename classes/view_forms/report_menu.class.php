<?php

/**
 * @author Poltarokov SP
 * @copyright 2011
 */

require_once("classes/view_forms/navigation_menu.class.php");

class ReportMenuClass extends NavigationMenu  {
    
    function __construct()  {
        //parent::__construct("myslidemenu", "jqueryslidemenu");
        parent::__construct("left_default_menu", "");//"shadowblockmenu");
    }
    
    function writeMenu($container_class=null)    {
	//$this->addChildItemJSAndHrefExternal("Отчет баланс", "", "", "", 
        //        "index.php?report_mode&class_name=FinanceActData&desktop_mode&tstmp=".(int)time()."#li_two");
        $this->addChildItemJSAndHrefExternal(
                "Отчет баланс", " load_main_region('', '&report_mode&class_name=FinanceActData&desktop_mode'); ", 
                "", "", "#");
        //$this->addChildItemJSAndHrefExternal("Расходы по категориям", "", "", "", 
        //        "index.php?report_mode&class_name=InOutCats&report_name=outcome_categories_diagramm&desktop_mode&tstmp=".(int)time()."#li_two");
        $this->addChildItemJSAndHrefExternal(
                "Расходы по категориям", " load_main_region('', '&report_mode&class_name=InOutCats&report_name=outcome_categories_diagramm&desktop_mode'); ", 
                "", "", "#");
        //$this->addChildItemJSAndHrefExternal("Доходы по категориям", "", "", "", 
        //        "index.php?report_mode&class_name=InOutCats&report_name=income_categories_diagramm&desktop_mode&tstmp=".(int)time()."#li_two");
        $this->addChildItemJSAndHrefExternal(
                "Доходы по категориям", " load_main_region('', '&report_mode&class_name=FinanceActData&report_name=root_income_percents_chart&desktop_mode'); ", 
                "", "", "#");
        $this->addChildItemJSAndHrefExternal(
                "Движения по категориям с детализацией", " load_main_region('', '&report_mode&class_name=FinanceActData&report_name=categorized_detailed_chart&desktop_mode'); ", 
                "", "", "#");
        echo "<div class=\"".($container_class==null?"main_menu_default":$container_class)."\">";
        $this->generateMenu();
        echo "</div>";
    }
}

?>