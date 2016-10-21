var first_purse_id=null;

function getXMLHttp_() {
    
    if (window.XMLHttpRequest) {
        try {
            XMLHttp = new XMLHttpRequest();
        } catch (e) { }
    } else if (window.ActiveXObject) {
        try {
            XMLHttp = new ActiveXObject("Msxml2.XMLHTTP");
        } catch (e) {
            try {
                XMLHttp = new ActiveXObject("Microsoft.XMLHTTP");
            } catch (e) { }
        }
    }
    return XMLHttp;
}

function go_go()  {
    document.getElementById("dict_table_div").innerHTML = "<img align='center' src='images/busy.gif' />";
}

function setSelectionId(object, id_class) {
    //document.getElementById("warning_region").innerHTML = 
    //            "---"; 
    if (object==null)   {
        document.getElementById("warning_region").innerHTML = 
                "Нулевой элемент выделения страницы!";
    } else    {
        try {
            //prev_sel_object = document.getElementById(id_class);
            //prev_sel_object.id = "no_selected";
            var list=object.parentNode.childNodes;
            for (var i=0; i<list.length; i++) {
                if (list[i].id!=null)
                    if (list[i].id == id_class)
                        list[i].id = "no_selected";
            }
        } catch(e)  {
            document.getElementById("warning_region").innerHTML = 
                "Ошибка получения прежнего элемента выделения страницы!";
        }
        try {
            object.id = id_class;
            //document.getElementById("warning_region").innerHTML = 
            //    "Установка!";
        } catch(e)  {
            document.getElementById("warning_region").innerHTML = 
                "Ошибка установки элемента выделения страницы!";
        }
    }
    
}

function initSort(table_id, pager_id) {

    //$("#myTable").tablesorter({widgets: ['zebra']});
    $("#"+table_id).tablesorter({widgets: ['zebra']});
    document.getElementById("warning_region").innerHTML = 
                    "Ошибка привязки календаря к результату AJAX!";
    //$("#"+table_id).tablesorterPager({container: $("#"+pager_id), positionFixed: false });
    
}

function linkCalendar() {
    //document.getElementById("warning_region").innerHTML = 
    //  document.getElementById("warning_region").innerHTML + "Привязка календаря к результату AJAX!";
    try {
    list = document.getElementsByClassName('date_time_cont_div');
    //$(".date_time_cont_div").AnyTime_picker(
    //                {format: "%z-%m-%d %H:%i", labelTitle: "Дата-Время",
    //                labelHour: "Час", labelMinute: "Минуты"} );
    for (var i=0; i<list.length; i++) {
       if (list[i].id!=null)
           {
              try {
                var dt_btn = "#"+list[i].id;
                //document.getElementById("warning_region").innerHTML = 
                //document.getElementById("warning_region").innerHTML + list[i].id;
                $(dt_btn).AnyTime_noPicker();
                $(dt_btn).AnyTime_picker(
                    {format: "%z-%m-%d %H:%i", labelTitle: "Дата-Время",
                    labelHour: "Час", labelMinute: "Минуты" , zIndex: 100} );
              } catch ( e ) {
                //document.getElementById("warning_region").innerHTML = 
                //    "Ошибка привязки календаря к результату AJAX!"+e.toString();
              }   
           }
    }
    } catch ( e ) {
                //document.getElementById("warning_region").innerHTML = 
               //     "Ошибка разбора списка элементов по classname!"+e.toString();
    } 
    
    try {
    list = document.getElementsByClassName('time_cont_div');
    for (var i=0; i<list.length; i++) {
       if (list[i].id!=null)
           {
              try {
                var dt_btn = "#"+list[i].id; 
                $(dt_btn).AnyTime_noPicker();
                $(dt_btn).AnyTime_picker(
                    {format: "%H:%i", labelTitle: "Время",
                    labelHour: "Час", labelMinute: "Минуты", zIndex: 100} );
              } catch ( e ) {
                //document.getElementById("warning_region").innerHTML = 
                //    "Ошибка привязки календаря к результату AJAX!";
              }   
           }
    }
    } catch ( e ) {
                //document.getElementById("warning_region").innerHTML = 
                //    "Ошибка разбора списка элементов по classname!";
    }
    
    $( ".date_cont_div" ).datepicker(
        {
            dateFormat:'yy-mm-dd'
        });
    
    try {
    list = document.getElementsByClassName('date_cont_div');
    for (var i=0; i<list.length; i++) {
       if (list[i].id!=null)
           {
              try {
                var dt_btn = "#"+list[i].id;  
                //$(dt_btn).AnyTime_noPicker();
                //$(dt_btn).AnyTime_picker(
                //    {format: "%z-%m-%d", labelTitle: "Дата",
                //    labelHour: "Час", labelMinute: "Минуты", zIndex: 100} );
              } catch ( e ) {
                //document.getElementById("warning_region").innerHTML = 
                //    "Ошибка привязки календаря к результату AJAX!";
              }   
           }
    }
    } catch ( e ) {
                //document.getElementById("warning_region").innerHTML = 
                //    "Ошибка разбора списка элементов по classname!";
    }
    
    
}

function initSlideOutPanels()  {
    
}

function initAccordeon()    {
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
		$('#accordion > div:visible').animate({height: 0, 'padding-top': 0, 'padding-bottom': 0}, 500, function() {$(this).hide()});
		
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
}

function initAcc2() {
    return true;
}

function initAcc3() {
    $('.acc_container').hide();
    $('.acc_trigger:first').addClass('active').next().show();
    $('.acc_trigger').click(function(){
            if( $(this).next().is(':hidden') ) {
                    //$('.acc_trigger').removeClass('active').next().slideUp();
                    $(this).toggleClass('active').next().slideDown();
            }   else    {
                $(this).toggleClass('active').next().slideUp();
            }
            return false;
    });
}

function windowHeightCross() {
                var de = document.documentElement;
                try {
                    return self.innerHeight || ( de && de.clientHeight ) || document.body.clientHeight;
                }   catch (e) { return 1500; }
            }

// Определение ширины видимой части страницы
function windowWidthCross() {
                var de = document.documentElement;
                try {
                    return self.innerWidth || ( de && de.clientWidth ) || document.body.clientWidth;
                }   catch (e) { return 1500; }
            }

/*<table class="ajax"><input type=hidden
name="class_name" value="123"><button data-anction="add"
data-element_id="25">Добавить</button>. Обработчик
$(".ajax").on('click','button',function(){ 
data['class_name']=$(this).parent().find("input[name='class_name']").val();
data['action']= ...
$.ajax({data:data...});   })
При желании все можно разделить и не обязательно генерировать каждый
раз код JS - достаточно один раз продумать типизированный обработчик
для действий с таблицами и тд - и потом оперируя атрибутами тегов, все
будет нормально функционировать.

Формат возвращаемых ajax данных лучше сделать JSON
Например если нужно производить действия после отправки запроса при
успехе можно сделать таким образом

var ajax_success={};
в обработчике ajax централизованном function success(result) {
if(result.callback && ajax_success[result.callback]) {
ajax_success[result.callback](); } }
Все этого достаточно в коде подключаем нужный обработчик например
finanse.js где вначале написано
ajax_success['fca_callback_add_element']=function() { alert('123'); }
а в php обработчике ajax -
$res[''callback']='fca_callback_add_element';
exit(json_encode($res));*/

function sendLogoutRequest()    {
    $.ajax({
          type: "POST",
          url: "index.php",
          data: ({
              action:'logout'
            }),
          cache: false,
          dataType: "text"
    });
}

function link_class_defined_actions(class_name, entity_name) {
    if ((class_name=='')||(typeof class_name == 'undefined')||(class_name=='detailed_li_a'))
        {
            //$(function() {
 
            var data={};
            data['object_id']=$(this).attr('data-identity');
            
            $(".detailed_li_a").click(function() {
                //var theName = $.trim($("#theName").val());
                
                //
                //if(theName.length > 0)
                //{
                    $.ajax({
                      type: "POST",
                      url: "index-ajax.php",
                      data: ({
                          object_id: $(this).attr('data-identify'), 
                          page_id:'purse_stat_page',
                          mobile_mode:'yes'
                        }),
                      cache: false,
                      dataType: "text",
                      success: onSuccess
                    });
                //}
            });
 
            //$("#resultLog").ajaxError(function(event, request, settings, exception) {
            //  $("#resultLog").html("Error Calling: " + settings.url + "<br />HTPP Code: " + request.status);
            //});
 
            function onSuccess(data)
            {
                $("#main_region").html("Result: " + data);
                $.mobile.changePage($("#purse_stat_page"), {
                            transition: "slide",
                            reverse: true
                        });
            }
 
        //});
    
        }
        
      if ((class_name=='')||(typeof class_name == 'undefined')||(class_name=='float_input_checked'))
        {
            $('.float_input_checked').keypress(function(e) {
                if (!(e.which==8 || e.which==44 ||e.which==45 ||e.which==46 ||
                    (e.which>47 && e.which<58))) return false;
            });
        }

}

function initAmChart()  {
    //AmCharts.ready(function () {
    var ch1=Chart_pie.create('chart_pie');
    var ch2=Chart_line.create('chart_line');
    //});
}

function load_main_region(page_id, get_params)	{
var params="";
//alert('jjj');
if (!(typeof get_params == 'undefined'))    {
    params = get_params;
} 
    //document.getElementById("warning_region").innerHTML = "777777777";
    if ((document.documentElement.clientWidth > 700)||(params.indexOf("&desktop_mode") !== -1)) {
        if (!(typeof page_id == 'undefined'))    {
            params = params + '&page_id=' + page_id;
        }
        
        //alert(first_purse_id);
        if ((first_purse_id!=null)&&!(params.indexOf("&fca_purse_id") !== -1))
          params = params + '&fca_purse_id=' + first_purse_id;
        
        if ((params.indexOf("&mobile_mode") !== -1)&&!(params.indexOf("&desktop_mode") !== -1)) {
            
            ajaxGetSimpleRequest('index-ajax.php?browser_width=1024'+params, 'main_region', 
            function(next_ajx_function) { 
                link_class_defined_actions(); 
                afterAjaxFunction(page_id); 
            } );
        
        }
        else
            ajaxGetSimpleRequest('index-ajax.php?browser_width=1024'+params, 'main_region', 
                function(next_ajx_function) { 
                    linkCalendar();
                    link_class_defined_actions(); 
                    initAcc2();
                    initSort('FinanceActData_dict_table_account');
                    initAmChart();
                });
    }
    else if ((document.documentElement.clientWidth <= 700)&&(document.documentElement.clientWidth > 400)) {
            ajaxGetSimpleRequest('index-ajax.php?browser_width=650', 'main_region', 
                function(next_ajx_function) {
                    link_class_defined_actions();
                    afterAjaxFunction(page_id);
                } );
    }
    else if ((document.documentElement.clientWidth <= 400)&&(document.documentElement.clientWidth >= 0)) {
            ajaxGetSimpleRequest('index-ajax.php?browser_width=300', 'main_region', 
                function(next_ajx_function) {
                    link_class_defined_actions();
                    afterAjaxFunction(page_id);
                });
    }
    else { }		
}

function refreshPage(page){
      // Page refresh
      page.trigger('pagecreate');
      page.listview('refresh');
}

function afterAjaxFunction(page_id)  {
    //if ((document.documentElement.clientWidth<= 700))   {
    try {
        if (typeof page_id == 'undefined')    {
                        $.mobile.changePage($("#main_page"), {
                            transition: "slide",
                            reverse: true
                        });
        } else if (page_id == 'main_page')  {
                        $.mobile.changePage($("#main_page"), {
                            transition: "slide",
                            reverse: true
                        });
        } else if (page_id == 'purse_page')  {
                        $.mobile.changePage($("#purse_page"), {
                            transition: "slide",
                            reverse: true
                        });
        } else {}
    } catch ( e ) {
        document.getElementById("warning_region").innerHTML = "Ошибка установки стартовой страницы AJAX-запроса!"+e.toString();
    }

    $("#showPurseButton").click(function() {
        try {
            $.mobile.changePage($("#purse_page"), {
                transition: "slide",
                reverse: true
            });
        } catch ( e ) {
           document.getElementById("warning_region").innerHTML = "Ошибка отображения результата AJAX-запроса в контейнере!"+e.toString();
        }
    } );

    $("#showPlanningButton").click(function() {
        try {
            $.mobile.changePage($("#planned_page"), {
                transition: "slide",
                reverse: true
            });
        } catch ( e ) {
           document.getElementById("warning_region").innerHTML = "Ошибка отображения результата AJAX-запроса в контейнере!"+e.toString();
        }
    } );

    $("#showFactButton").click(function() {
        try {
            $.mobile.changePage($("#fact_page"), {
                transition: "slide",
                reverse: true
            });
        } catch ( e ) {
           document.getElementById("warning_region").innerHTML = "Ошибка отображения результата AJAX-запроса в контейнере!"+e.toString();
        }
    } );

    $("#showOtherButton").click(function() {
        try {
            $.mobile.changePage($("#other_page"), {
                transition: "slide",
                reverse: true
            });
        } catch ( e ) {
           document.getElementById("warning_region").innerHTML = "Ошибка отображения результата AJAX-запроса в контейнере!"+e.toString();
        }
    } );

    $("#logout_dialog_id").click(function() {
        try {
            $.mobile.changePage($("#logout_dialog"), {
                transition: "slide",
                reverse: true
            });
        } catch ( e ) {
           container_object.innerHTML = "Ошибка отображения результата AJAX-запроса в контейнере!"+e.toString();
        }
    } );

    $("#show_settings").click(function() {
        try {
            $.mobile.changePage($("#settings_page"), {
                transition: "slide",
                reverse: true
            });
        } catch ( e ) {
           container_object.innerHTML = "Ошибка отображения результата AJAX-запроса в контейнере!"+e.toString();
        }
    });

    /*$("#show_settings").click(function() {
        try {
            $.mobile.changePage($("#settings_page"), {
                transition: "slide",
                reverse: true
            });
        } catch ( e ) {
           document.getElementById("warning_region").innerHTML = "Ошибка отображения результата AJAX-запроса в контейнере!"+e.toString();
        }
    } );*/

    /*$("#planned_back_header").click(function() {
        try {
            $.mobile.changePage($("#main_page"), {
                transition: "slide",
                reverse: true
            });
        } catch ( e ) {
           document.getElementById("warning_region").innerHTML = "Ошибка отображения результата AJAX-запроса в контейнере!"+e.toString();
        }
    } );*/

    /*$("#fact_back_header").click(function() {
        try {
            $.mobile.changePage($("#main_page"), {
                transition: "slide",
                reverse: true
            });
        } catch ( e ) {
           document.getElementById("warning_region").innerHTML = "Ошибка отображения результата AJAX-запроса в контейнере!"+e.toString();
        }
    } );*/

    $("#other_back_header").click(function() {
        try {
            $.mobile.changePage($("#main_page"), {
                transition: "slide",
                reverse: true
            });
        } catch ( e ) {
           document.getElementById("warning_region").innerHTML = "Ошибка отображения результата AJAX-запроса в контейнере!"+e.toString();
        }
    } );

    $("#logout_dialog_id").click(function() {
        try {
            $.mobile.changePage($("#logout_dialog"), {
                transition: "slide",
                reverse: true
            });
        } catch ( e ) {
           document.getElementById("warning_region").innerHTML = "Ошибка отображения результата AJAX-запроса в контейнере!"+e.toString();
        }
    } );

    $("#logout_cancel").click(function() {
        try {
            $.mobile.changePage($("#main_page"), {
                transition: "slide",
                reverse: true
            });
        } catch ( e ) {
           document.getElementById("warning_region").innerHTML = "Ошибка отображения результата AJAX-запроса в контейнере!"+e.toString();
        }
    } );
    //}
}

function constructAndGoAjax(params_array, next_function, eval_params)   {
    try	{
        url = params_array['request_base'];
        //url = url + "&class_name=" + class_name;
        //url = url + "&request_mode=" + request_mode;
        //url = url + "&part_num=" + part_num;
                
        for(var key in params_array) {
            
            if ((key!='request_base')&&(key!='result_container'))   {
            try {
                //if (isNaN(parseInt(params_array[key]))) {
                //     prop_value = "null";
                // }
                // else   {
                     prop_value = params_array[key];
                // }
            }
            catch ( e ) {
		          //container_object.innerHTML = container_object.innerHTML+
                          //      "<br/>Ошибка получения параметра ("+key+") по ID ("+get_params_array[key]+")!";
		 prop_value = "null";
                          
            }
			// key - название свойства
            url = url + "&" + key + "=" + encodeURIComponent(prop_value);
			// object[key] - значение свойства
                    
            }            
                        
            }
            
            if (!(typeof eval_params == 'undefined'))   {
                for(var ekey in eval_params) {
                    try {
                        
                    url = url + "&" + ekey + "=" + 
                        encodeURIComponent(document.getElementById(eval_params[ekey]).value);
    
                    } catch (e) { 
    
                    }

                }
            }
            
            if (typeof next_function == 'undefined')
                        ajaxGetSimpleRequest(url, params_array['result_container'],null);
                    else
                        ajaxGetSimpleRequest(url, params_array['result_container'],next_function);
	} catch ( e ) {
		document.getElementById("warning_region").innerHTML = "Ошибка цикла разбора массива параметров!";
		return;
	}
}

function ajaxGetSimpleRequest(request_str, result_container, next_function) {
	var XMLHttp, container_object, url;
	
	try	{	
		//document.getElementById(result_container).style.visibility = "visible"; //показываем картинку
		container_object = document.getElementById(result_container);
                container_object.innerHTML = getLoaderStatusContent( "start_request", 
                        request_str, false, "select", container_object.innerHTML);

	} catch ( e ) {
        document.getElementById("warning_region").innerHTML = "Ошибка получения элемента-контейнера!";
        return;    
	}
	
	try	{
		XMLHttp = getXMLHttp_();
	} catch ( e ) {
		//alert("Ошибка получения объекта AJAX-запроса!");
                container_object.innerHTML = "Ошибка получения объекта AJAX-запроса!";
		return;
	}
	
	//var ssearch = document.getElementById("ssearch").value; //получаем значение из формы
	//составляем линк и отправляем запрос
    url = request_str;
	
	try	{
		XMLHttp.open("GET", url, true);
        //container_object.innerHTML = url;
	} catch ( e ) {
		container_object.innerHTML = "Ошибка инициализации объекта AJAX-запроса!";
		return;
	}
	XMLHttp.onreadystatechange = function()	{
            var input_field;
		try {
			if (XMLHttp.readyState != 4) {
				container_object.innerHTML = getLoaderStatusContent( "load_data", 
                                    request_str, false, "select", container_object.innerHTML);
				return;
			}
            
			if(XMLHttp.status != 200)
			{
				container_object.innerHTML = "Error invalid status: " + 
                    XMLHttp.responseText + " status: " + XMLHttp.status;
				delete XMLHttp;
				return;
			}
		} catch ( e ) {
			container_object.innerHTML = "Ошибка обработки состояния ответа сервера!";
			return;
		}
		
		try	{
                        container_object.innerHTML = XMLHttp.responseText;
                        
                        //$("#main_page").trigger('create');
                        //$("#purse_page").page();
                        
                        if (typeof next_function == 'undefined')    {
                            
                        } else {
                            next_function();
                        }

			} catch ( e ) {
			document.getElementById("warning_region").innerHTML = "1Ошибка отображения результата AJAX-запроса в контейнере!"+e.toString();
			return;
		}
	}
	try	{
		XMLHttp.send(null);
	} catch ( e ) {
		container_object.innerHTML = "Ошибка посылки AJAX-запроса!";
		return;
	}
    
    delete XMLHttp;
    
    return false;
	
}

function showAccountStatistic(accountID)    {
    $.mobile.changePage("php/getAccountStatistic.php#purse_stat_page", {
                                        transition: "slide",
                                        reverse: true
                                    });
    $.mobile.changePage($("#purse_stat_page"), {
                                        transition: "slide",
                                        reverse: true
                                    });
}

function ajaxGetMobileRequest(request_base, class_name, request_mode, get_params_array, load_indicator, result_container, next_select_params, 
    next_function, entity_suffix, algorithm_id) {
	var XMLHttp, container_object, url, prop_value, part_num, list_name;
        part_num=0;
        //setSelectionId(this,'selected_row');
        //document.getElementById("warning_region").innerHTML = "-----!"+class_name;
        //hideElement('change_button_default');
        if (isNaN(parseInt(load_indicator))) {
            try {
                part_num_object = document.getElementById(load_indicator);
                if (isNaN(parseInt(part_num_object.value))) {
                    document.getElementById("warning_region").innerHTML = "Нечисловая величина элемента-номера страницы!";
                } else    {
                    part_num = part_num_object.value;
                }
                
            } catch(e)  {
                document.getElementById("warning_region").innerHTML = "Ошибка получения элемента-номера страницы!";
            }
            
        }
        else    {
            part_num = load_indicator;
        }
        
	try	{	
		//document.getElementById(result_container).style.visibility = "visible"; //показываем картинку
		container_object = document.getElementById(result_container);
                
		if ((request_base=="out_table.php")||(request_base=="out_detail_table.php")||
                    (request_base=="out_detail.php"))    {
                    
                    container_object.innerHTML = "<img align='center' src='images/busy.gif' />";
                } else if(request_base=="add_update_delete.php")  {
                    container_object.innerHTML = "<img align='center' src='images/ajax-loader.gif' />";
                } else    {
                    
                }
	} catch ( e ) {
		//container_object.innerHTML = "Ошибка получения элемента-контейнера!";
                try {
                    container_object = document.getElementById("detail_container");
                    if ((request_base=="out_table.php")||(request_base=="out_detail_table.php")||
                        (request_base=="out_detail.php"))    {
                        container_object.innerHTML = "<img align='center' src='images/busy.gif' />";
                    } else if(request_base=="add_update_delete.php")  {
                        container_object.innerHTML = "<img align='center' src='images/ajax-loader.gif' />";
                    } else    {
                    
                    }
                } catch (e) { 
                    document.getElementById("warning_region").innerHTML = "Ошибка получения элемента-контейнера!";
                    return;
                }

                
	}
    try	{
		XMLHttp = getXMLHttp_();
	} catch ( e ) {
		//alert("Ошибка получения объекта AJAX-запроса!");
                container_object.innerHTML = "Ошибка получения объекта AJAX-запроса!";
		return;
	}
	
	//var ssearch = document.getElementById("ssearch").value; //получаем значение из формы
	//составляем линк и отправляем запрос
	try	{
        url = request_base+"?";
        url = url + "&class_name=" + class_name;
        url = url + "&request_mode=" + request_mode;
        url = url + "&part_num=" + part_num;
                
        for(var key in get_params_array) {
            
            try {
                if (request_base=="out_detail.php") {
                    prop_value=get_params_array[key];
                } else
                prop_value=document.getElementById(get_params_array[key]).value;
            }
            catch ( e ) {
		          //container_object.innerHTML = container_object.innerHTML+
                          //      "<br/>Ошибка получения параметра ("+key+") по ID ("+get_params_array[key]+")!";
		 if (isNaN(parseInt(get_params_array[key]))) {
                     prop_value = "null";
                 }
                 else   {
                     prop_value = get_params_array[key];
                 }
                          
            }
			// key - название свойства
			url = url + "&" + key + "=" + encodeURIComponent(prop_value);
			// object[key] - значение свойства
            }
	} catch ( e ) {
		container_object.innerHTML = "Ошибка цикла разбора массива параметров!";
		return;
	}

//document.getElementById("warning_region").innerHTML = "-----!"+url;
	try	{
		XMLHttp.open("GET", url, true);
        //container_object.innerHTML = url;
	} catch ( e ) {
		container_object.innerHTML = "Ошибка инициализации объекта AJAX-запроса!";
		return;
	}
	XMLHttp.onreadystatechange = function()	{
            var input_field;
		try {
			if (XMLHttp.readyState != 4) {
				container_object.innerHTML = "<img align='center' src='images/busy.gif' /><br/>"+
                    "<center>Получение данных, статус: "+XMLHttp.readyState+"</center>";
				return;
			}
            
			if(XMLHttp.status != 200)
			{
				container_object.innerHTML = "Error invalid status: " + 
                    XMLHttp.responseText + " status: " + XMLHttp.status;
				delete XMLHttp;
				return;
			}
		} catch ( e ) {
			container_object.innerHTML = "Ошибка обработки состояния ответа сервера!";
			return;
		}
		
		try	{
                            //document.getElementById("warning_region").innerHTML = "-----!"+XMLHttp.responseText;
                            //document.getElementById("warning_region").innerHTML = 
                            //    document.getElementById("warning_region").innerHTML+">";
                            container_object.innerHTML = XMLHttp.responseText;
                            if (request_base=="out_table.php")    {
                            //Здесь процедура обновления списка
                            //if($("#data-listholder:visible").length){
                            try {
                                 list_name = "#"+class_name+"data-listholder";
                                 $(list_name).listview();    
                                 $(list_name).listview('refresh');
                                 } catch ( e ) {
                                document.getElementById("warning_region").innerHTML = "Ошибка обновления списка!"+e.toString();
                                return;
                                }
                            //    }    
                            //    try {
                            //        initSort(class_name+"_dict_table", class_name+"_dict_pager");
                            //    } catch ( e ) {
                            //        document.getElementById("warning_region").innerHTML = "Ошибка сортировки и деления таблицы после запроса!";
                            //    }
                            //    linkCalendar();
                            }
                            /*else if (request_base=="out_detail_table.php") {
                                for(var key in get_params_array) {
            
                                    try {
                                        input_field=document.getElementById(
                                            class_name+"_filt_"+key);
                                        if (isNaN(parseInt(get_params_array[key]))) {
                                            prop_value = "null";
                                        }
                                        else   {
                                            prop_value = parseInt(get_params_array[key]);
                                            //document.getElementById("warning_region").innerHTML = 
                                            //    document.getElementById("warning_region").innerHTML + "kkkk"+key+
                                            //    "ssssss"+prop_value+"aaaa"+input_field.value;
                                            input_field.value = prop_value;
                                        }
                                    }
                                    catch ( e ) {
                                        //container_object.innerHTML = container_object.innerHTML+
                                        //      "<br/>Ошибка получения параметра ("+key+") по ID ("+get_params_array[key]+")!";
                                        
                                        prop_value = "null";
                                    }
                                    // key - название свойства
                                    //url = url + "&" + key + "=" + encodeURIComponent(prop_value);
                                    // object[key] - значение свойства
                                }
                                
                                try {
                                    initSort(class_name+"_dict_table", class_name+"_dict_pager");
                                } catch ( e ) {
                                    document.getElementById("warning_region").innerHTML = "Ошибка сортировки и деления таблицы после запроса!";
                                } 
                                linkCalendar();
                            }*/ 
                            else if((request_base=="add_update_delete.php")&&true)  {
                                    try {
                                        if (typeof next_function == 'undefined')    {
                                            if (typeof next_select_params == 'undefined') {
                                                if (request_mode=='partial_update_manip_mode')  {
                                                    
                                                } else    {
                                                    if (request_mode=='insert_list_manip_mode')
                                                        ajaxGetRequest("out_table.php", class_name, "mobile_list_table_mode", {}, "", class_name+"_dict_table_div")
                                                    else
                                                        ajaxGetRequest("out_table.php", class_name, "mobile_table_mode", {}, "", class_name+"_dict_table_div");
                                                }
                                            }
                                            else    {
                                                if (request_mode=='insert_list_manip_mode')
                                                        ajaxGetMobileRequest("out_table.php", class_name, "mobile_list_table_mode", {}, "", class_name+"_dict_table_div")
                                                    else
                                                ajaxGetMobileRequest("out_table.php", class_name, "mobile_table_mode", next_select_params, load_indicator, class_name+"_dict_table_div");
                                            }
                                        }
                                        else    {
                                            if (next_function!=null)    {
                                                next_function();
                                            }
                                        }
                                    } catch ( e ) {
                                        document.getElementById("warning_region").innerHTML = "Ошибка обновления таблицы после манипуляции!";
                                    }
                                    
                            } else    {
                                
                            }
		} catch ( e ) {
			container_object.innerHTML = "Ошибка отображения результата AJAX-запроса в контейнере!";
			return;
		}
	}
	try	{
		XMLHttp.send(null);
	} catch ( e ) {
		container_object.innerHTML = "Ошибка посылки AJAX-запроса!";
		return;
	}
    
    delete XMLHttp;
    
    return false;
}

function getLoaderStatusContent( status, request_str, mobile_mode, request_mode, prev_inner_html)   {
    var loader_html="";
    var basic_ajax_loader="images/ajax-loader5.gif";
    //alert(request_str);
    
    
    if (status=="start_request")    {
        if (request_str.indexOf("class_name=FinanceActData") !== -1) {
            if (request_mode=="select")
                loader_html="<center><img align='center' src='images/ajax-loader-fca.gif' /></center>";
            else
                loader_html="<center><img align='center' src='"+
                    basic_ajax_loader+"' /></center>";
        } 
        else if (request_str.indexOf("index-ajax.php") !== -1) {
            if (request_mode=="select")
                loader_html="<center><img align='center' src='images/ajax-loader-fca.gif' /></center>";
            else
                loader_html="<center><img align='center' src='"+
                    basic_ajax_loader+"' /></center>";
        }
        else  {
            if (request_mode=="select")
                loader_html="<center><img align='center' src='"+
                    basic_ajax_loader+"' /></center><br/>"+
                    prev_inner_html
            else
                loader_html="<center><img align='center' src='"+
                    basic_ajax_loader+"' /></center>";
        }
    }
    
    if (status=="load_data")  {
        loader_html=//'<center>Получение данных...</center><br/>'+
            prev_inner_html;
    }
    
    return loader_html;
}

function ajaxGetRequest(request_base, class_name, request_mode, get_params_array, load_indicator, result_container, next_select_params, 
    next_function, entity_suffix, algorithm_id) {
	var XMLHttp, container_object, url, prop_value, part_num;
        part_num=0;
        //setSelectionId(this,'selected_row');
        //document.getElementById("warning_region").innerHTML = "-----!"+class_name;
        hideElement('change_button_default');
        if (isNaN(parseInt(load_indicator))) {
            try {
                part_num_object = document.getElementById(load_indicator);
                if (isNaN(parseInt(part_num_object.value))) {
                    document.getElementById("warning_region").innerHTML = "Нечисловая величина элемента-номера страницы!";
                } else    {
                    part_num = part_num_object.value;
                }
                
            } catch(e)  {
                document.getElementById("warning_region").innerHTML = "Ошибка получения элемента-номера страницы!";
            }
            
        }
        else    {
            part_num = load_indicator;
        }
        
	try	{	
		//document.getElementById(result_container).style.visibility = "visible"; //показываем картинку
		container_object = document.getElementById(result_container);
                
		if ((request_base=="out_table.php")||(request_base=="out_detail_table.php")||
                    (request_base=="out_detail.php"))    {
                    
                    container_object.innerHTML = getLoaderStatusContent( "start_request", 
                        '&class_name='+class_name, false, "select", container_object.innerHTML);
                } else if(request_base=="add_update_delete.php")  {
                    container_object.innerHTML = getLoaderStatusContent( "start_request", 
                        '&class_name='+class_name, false, "manip", container_object.innerHTML);
                } else    {
                    
                }
	} catch ( e ) {
		//container_object.innerHTML = "Ошибка получения элемента-контейнера!";
                try {
                    container_object = document.getElementById("detail_container");
                    if ((request_base=="out_table.php")||(request_base=="out_detail_table.php")||
                        (request_base=="out_detail.php"))    {
                        container_object.innerHTML = getLoaderStatusContent( "start_request", 
                            '&class_name='+class_name, false, "select", container_object.innerHTML);
                    } else if(request_base=="add_update_delete.php")  {
                        container_object.innerHTML = getLoaderStatusContent( "start_request", 
                            '&class_name='+class_name, false, "manip", container_object.innerHTML);
                    } else    {
                    
                    }
                } catch (e) { 
                    document.getElementById("warning_region").innerHTML = "Ошибка получения элемента-контейнера!";
                    return;
                }

                
	}
    try	{
		XMLHttp = getXMLHttp_();
	} catch ( e ) {
		//alert("Ошибка получения объекта AJAX-запроса!");
                container_object.innerHTML = "Ошибка получения объекта AJAX-запроса!";
		return;
	}
	
	//var ssearch = document.getElementById("ssearch").value; //получаем значение из формы
	//составляем линк и отправляем запрос
	try	{
        url = request_base+"?";
        url = url + "&class_name=" + class_name;
        url = url + "&request_mode=" + request_mode;
        url = url + "&part_num=" + part_num;
        
        if (!(typeof entity_suffix == 'undefined'))    {
            url = url + "&entity_suffix=" + entity_suffix;
        }
        
        if (!(typeof algorithm_id == 'undefined'))    {
            url = url + "&algorithm_id=" + algorithm_id;
        }
                
        for(var key in get_params_array) {
            
            try {
                if (request_base=="out_detail.php") {
                    prop_value=get_params_array[key];
                } else
                prop_value=document.getElementById(get_params_array[key]).value;
            }
            catch ( e ) {
		          //container_object.innerHTML = container_object.innerHTML+
                          //      "<br/>Ошибка получения параметра ("+key+") по ID ("+get_params_array[key]+")!";
		 if (isNaN(parseInt(get_params_array[key]))) {
                    if (request_mode=="out_report_mode")
                        prop_value = get_params_array[key];
                    else
                        prop_value = "null";
                 }
                 else   {
                     prop_value = get_params_array[key];
                 }
                          
            }
			// key - название свойства
			url = url + "&" + key + "=" + encodeURIComponent(prop_value);
			// object[key] - значение свойства
            }
	} catch ( e ) {
		container_object.innerHTML = "Ошибка цикла разбора массива параметров!";
		return;
	}

//document.getElementById("warning_region").innerHTML = "-----!"+url;
	try	{
		XMLHttp.open("GET", url, true);
        //container_object.innerHTML = url;
	} catch ( e ) {
		container_object.innerHTML = "Ошибка инициализации объекта AJAX-запроса!";
		return;
	}
	XMLHttp.onreadystatechange = function()	{
            var input_field;
		try {
			if (XMLHttp.readyState != 4) {
                                if(request_base=="add_update_delete.php")
                                    container_object.innerHTML = getLoaderStatusContent( "load_data", 
                                        '&class_name='+class_name, false, "manip", 
                                        container_object.innerHTML)
                                else
                                    container_object.innerHTML = getLoaderStatusContent( "load_data", 
                                        '&class_name='+class_name, false, "select", 
                                        container_object.innerHTML);
				return;
			}
            
			if(XMLHttp.status != 200)
			{
				container_object.innerHTML = "Error invalid status: " + 
                                    XMLHttp.responseText + " status: " + XMLHttp.status;
				delete XMLHttp;
				return;
			}
		} catch ( e ) {
			container_object.innerHTML = "Ошибка обработки состояния ответа сервера!";
			return;
		}
		
		try	{
                            //document.getElementById("warning_region").innerHTML = "-----!"+XMLHttp.responseText;
                            //document.getElementById("warning_region").innerHTML = 
                            //    document.getElementById("warning_region").innerHTML+">";
                            container_object.innerHTML = XMLHttp.responseText;
                            if (request_base=="out_table.php")    {
                                try {
                                    initSort(class_name+"_dict_table"+entity_suffix, class_name+"_dict_pager");
                                } catch ( e ) {
                                    document.getElementById("warning_region").innerHTML = "Ошибка сортировки и деления таблицы после запроса!";
                                }
                                linkCalendar();
                            }
                            else if (request_base=="out_detail_table.php") {
                                for(var key in get_params_array) {
            
                                    try {
                                        input_field=document.getElementById(
                                            class_name+"_filt_"+key);
                                        if (isNaN(parseInt(get_params_array[key]))) {
                                            prop_value = "null";
                                        }
                                        else   {
                                            prop_value = parseInt(get_params_array[key]);
                                            //document.getElementById("warning_region").innerHTML = 
                                            //    document.getElementById("warning_region").innerHTML + "kkkk"+key+
                                            //    "ssssss"+prop_value+"aaaa"+input_field.value;
                                            input_field.value = prop_value;
                                        }
                                    }
                                    catch ( e ) {
                                        //container_object.innerHTML = container_object.innerHTML+
                                        //      "<br/>Ошибка получения параметра ("+key+") по ID ("+get_params_array[key]+")!";
                                        
                                        prop_value = "null";
                                    }
                                    // key - название свойства
                                    //url = url + "&" + key + "=" + encodeURIComponent(prop_value);
                                    // object[key] - значение свойства
                                }
                                
                                try {
                                    initSort(class_name+"_dict_table"+entity_suffix, class_name+"_dict_pager");
                                } catch ( e ) {
                                    document.getElementById("warning_region").innerHTML = "Ошибка сортировки и деления таблицы после запроса!";
                                } 
                                linkCalendar();
                            } else if((request_base=="add_update_delete.php")&&true)  {
                                    try {
                                        if (typeof next_function == 'undefined')    {
                                            
                                            if (typeof next_select_params == 'undefined') {
                                                if (request_mode=='partial_update_manip_mode')  {
                                                    
                                                } else    {
                                                    if (!(typeof entity_suffix == 'undefined'))    
                                                        ajaxGetRequest("out_table.php", class_name, "select_mode", {}, "", class_name+"_dict_table_div",{}, null, entity_suffix);
                                                    else
                                                        ajaxGetRequest("out_table.php", class_name, "select_mode", {}, "", class_name+"_dict_table_div");
                                                }
                                            }
                                            else    {
                                                if (!(typeof entity_suffix == 'undefined')) 
                                                    ajaxGetRequest("out_table.php", class_name, "select_mode", next_select_params, load_indicator, class_name+"_dict_table_div", null, entity_suffix);
                                                else
                                                    ajaxGetRequest("out_table.php", class_name, "select_mode", next_select_params, load_indicator, class_name+"_dict_table_div");
                                            }
                                            
                                        }
                                        else    {
                                            if (next_function!=null)    {
                                                next_function();
                                            }
                                        }
                                    } catch ( e ) {
                                        document.getElementById("warning_region").innerHTML = "Ошибка обновления таблицы после манипуляции!";
                                    }
                                    
                            } else    {
                                
                            }
		} catch ( e ) {
			container_object.innerHTML = "Ошибка отображения результата AJAX-запроса в контейнере!";
			return;
		}
	}
	try	{
		XMLHttp.send(null);
	} catch ( e ) {
		container_object.innerHTML = "Ошибка посылки AJAX-запроса!";
		return;
	}
    
    delete XMLHttp;
    
    return false;
}

function ajaxGetRequestExtended( direct_params, orderby_params, request_base, class_name, request_mode, get_params_array, load_indicator, result_container, next_select_params, 
    next_function) {
	var XMLHttp, container_object, url, prop_value, part_num;
        part_num=0;
        //setSelectionId(this,'selected_row');
        //document.getElementById("warning_region").innerHTML = "-----!"+class_name;
        hideElement('change_button_default');
        if (isNaN(parseInt(load_indicator))) {
            try {
                part_num_object = document.getElementById(load_indicator);
                if (isNaN(parseInt(part_num_object.value))) {
                    document.getElementById("warning_region").innerHTML = "Нечисловая величина элемента-номера страницы!";
                } else    {
                    part_num = part_num_object.value;
                }
                
            } catch(e)  {
                document.getElementById("warning_region").innerHTML = "Ошибка получения элемента-номера страницы!";
            }
            
        }
        else    {
            part_num = load_indicator;
        }
        
	try	{	
		//document.getElementById(result_container).style.visibility = "visible"; //показываем картинку
		container_object = document.getElementById(result_container);
                
		if ((request_base=="out_table.php")||(request_base=="out_detail_table.php")||
                    (request_base=="out_detail.php"))    {
                    
                    container_object.innerHTML = "<img align='center' src='images/busy.gif' />";
                } else if(request_base=="add_update_delete.php")  {
                    container_object.innerHTML = "<img align='center' src='images/ajax-loader.gif' />";
                } else    {
                    
                }
	} catch ( e ) {
		//container_object.innerHTML = "Ошибка получения элемента-контейнера!";
                try {
                    container_object = document.getElementById("detail_container");
                    if ((request_base=="out_table.php")||(request_base=="out_detail_table.php")||
                        (request_base=="out_detail.php"))    {
                        container_object.innerHTML = "<img align='center' src='images/busy.gif' />";
                    } else if(request_base=="add_update_delete.php")  {
                        container_object.innerHTML = "<img align='center' src='images/ajax-loader.gif' />";
                    } else    {
                    
                    }
                } catch (e) { 
                    document.getElementById("warning_region").innerHTML = "Ошибка получения элемента-контейнера!";
                    return;
                }

                
	}
    try	{
		XMLHttp = getXMLHttp_();
	} catch ( e ) {
		//alert("Ошибка получения объекта AJAX-запроса!");
                container_object.innerHTML = "Ошибка получения объекта AJAX-запроса!";
		return;
	}
	
	//var ssearch = document.getElementById("ssearch").value; //получаем значение из формы
	//составляем линк и отправляем запрос
	try	{
        url = request_base+"?";
        url = url + "&class_name=" + class_name;
        url = url + "&request_mode=" + request_mode;
        url = url + "&part_num=" + part_num;
                
        for(var key in get_params_array) {
            
            try {
                if (request_base=="out_detail.php") {
                    prop_value=get_params_array[key];
                } else
                prop_value=document.getElementById(get_params_array[key]).value;
            }
            catch ( e ) {
		          //container_object.innerHTML = container_object.innerHTML+
                          //      "<br/>Ошибка получения параметра ("+key+") по ID ("+get_params_array[key]+")!";
		 if (isNaN(parseInt(get_params_array[key]))) {
                     prop_value = "null";
                 }
                 else   {
                     prop_value = get_params_array[key];
                 }
                          
            }
			// key - название свойства
			url = url + "&" + key + "=" + encodeURIComponent(prop_value);
			// object[key] - значение свойства
            }
	} catch ( e ) {
		container_object.innerHTML = "Ошибка цикла разбора массива параметров!";
		return;
	}

//document.getElementById("warning_region").innerHTML = "-----!"+url;
	try	{
		XMLHttp.open("GET", url, true);
        //container_object.innerHTML = url;
	} catch ( e ) {
		container_object.innerHTML = "Ошибка инициализации объекта AJAX-запроса!";
		return;
	}
	XMLHttp.onreadystatechange = function()	{
            var input_field;
		try {
			if (XMLHttp.readyState != 4) {
				container_object.innerHTML = "<img align='center' src='images/busy.gif' /><br/>"+
                    "<center>Получение данных, статус: "+XMLHttp.readyState+"</center>";
				return;
			}
            
			if(XMLHttp.status != 200)
			{
				container_object.innerHTML = "Error invalid status: " + 
                    XMLHttp.responseText + " status: " + XMLHttp.status;
				delete XMLHttp;
				return;
			}
		} catch ( e ) {
			container_object.innerHTML = "Ошибка обработки состояния ответа сервера!";
			return;
		}
		
		try	{
                            //document.getElementById("warning_region").innerHTML = "-----!"+XMLHttp.responseText;
                            container_object.innerHTML = XMLHttp.responseText;
                            if (request_base=="out_table.php")    {
                                try {
                                    initSort(class_name+"_dict_table", class_name+"_dict_pager");
                                } catch ( e ) {
                                    document.getElementById("warning_region").innerHTML = "Ошибка сортировки и деления таблицы после запроса!";
                                }
                                linkCalendar();
                            }
                            else if (request_base=="out_detail_table.php") {
                                for(var key in get_params_array) {
            
                                    try {
                                        input_field=document.getElementById(
                                            class_name+"_filt_"+key);
                                        if (isNaN(parseInt(get_params_array[key]))) {
                                            prop_value = "null";
                                        }
                                        else   {
                                            prop_value = parseInt(get_params_array[key]);
                                            //document.getElementById("warning_region").innerHTML = 
                                            //    document.getElementById("warning_region").innerHTML + "kkkk"+key+
                                            //    "ssssss"+prop_value+"aaaa"+input_field.value;
                                            input_field.value = prop_value;
                                        }
                                    }
                                    catch ( e ) {
                                        //container_object.innerHTML = container_object.innerHTML+
                                        //      "<br/>Ошибка получения параметра ("+key+") по ID ("+get_params_array[key]+")!";
                                        
                                        prop_value = "null";
                                    }
                                    // key - название свойства
                                    //url = url + "&" + key + "=" + encodeURIComponent(prop_value);
                                    // object[key] - значение свойства
                                }
                                
                                try {
                                    initSort(class_name+"_dict_table", class_name+"_dict_pager");
                                } catch ( e ) {
                                    document.getElementById("warning_region").innerHTML = "Ошибка сортировки и деления таблицы после запроса!";
                                } 
                                linkCalendar();
                            } else if((request_base=="add_update_delete.php")&&true)  {
                                    try {
                                        if (typeof next_function == 'undefined')    {
                                            if (typeof next_select_params == 'undefined') {
                                                if (request_mode=='partial_update_manip_mode')  {
                                                    
                                                } else    {
                                                    ajaxGetRequest("out_table.php", class_name, "select_mode", {}, "", class_name+"_dict_table_div");
                                                }
                                            }
                                            else    {
                                                ajaxGetRequest("out_table.php", class_name, "select_mode", next_select_params, load_indicator, class_name+"_dict_table_div");
                                            }
                                        }
                                        else    {
                                            if (next_function!=null)    {
                                                next_function();
                                            }
                                        }
                                    } catch ( e ) {
                                        document.getElementById("warning_region").innerHTML = "Ошибка обновления таблицы после манипуляции!";
                                    }
                                    
                            } else    {
                                
                            }
		} catch ( e ) {
			container_object.innerHTML = "Ошибка отображения результата AJAX-запроса в контейнере!";
			return;
		}
	}
	try	{
		XMLHttp.send(null);
	} catch ( e ) {
		container_object.innerHTML = "Ошибка посылки AJAX-запроса!";
		return;
	}
    
    delete XMLHttp;
    
    return false;
}
 
function getAjaxHandlerFunction() {
	//если завершено то прячем картинку и выводим результат в слой result
	if (XMLHttp.readyState == 4) {
		//document.getElementById("find").style.visibility = "hidden";
		//document.getElementById("result").innerHTML = XMLHttp.responseText;
	}
}