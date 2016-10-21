var fastInFocus = false;

function fillEditForm (fields_values)   {
    
    for(var key in fields_values) {
        
        try	{	
            //document.getElementById(result_container).style.visibility = "visible"; //показываем картинку
            container_object = document.getElementById(key);
            container_object.value = fields_values[key];
            
            //container_object.checked = true;
            //document.getElementById("warning_region").innerHTML = 
            //    document.getElementById("warning_region").innerHTML+container_object.type;
            try {
                if ((container_object.type=="checkbox")||
                    (container_object.type=="CHECKBOX"))    {
                        //container_object.checked = true;
                        if ((fields_values[key]==1)||(fields_values[key]=="1"))
                            container_object.checked = true;
                        else
                            container_object.checked = false;
                    }
            } catch (e) { 
                document.getElementById("warning_region").innerHTML = 
                    "Ошибка записи в элемент-checkbox!";
            }
    
                
        } catch ( e ) {
            //container_object.innerHTML = "Ошибка получения элемента-контейнера!";
            document.getElementById("warning_region").innerHTML = "Ошибка записи в элемент-контейнер!";
            return;
        }
	}   
    //document.getElementById("warning_region").innerHTML = "Ошибка записи в элемент-контейнер!"; 
}

/*****************************
**     Popup message
******************************/

//close pop-up box
function closePopup()
 {
   try {
        $('#opaco').toggleClass('hidden').removeAttr('style');
   } catch (e) { 
       document.getElementById("warning_region").innerHTML = 
                "Ошибка скрытия фона POPUP-элемента!";
   }
   try {
        $('#popup').toggleClass('hidden');
   } catch (e) { 
       document.getElementById("warning_region").innerHTML = 
                "Ошибка скрытия POPUP-элемента!";
   }
   //return false;
 }

//open pop-up
function showPopup()//popup_type)
 {
   //document.getElementById("warning_region").innerHTML = 
   //             "Старт отображения POPUP-элемента!";
   try {
        //when IE - fade immediately
        if($.browser.msie)
        {
            $('#opaco').height($(document).height()).toggleClass('hidden');
        }
        else
        //in all the rest browsers - fade slowly
        {
            $('#opaco').height($(document).height()).toggleClass('hidden').fadeTo('slow', 0.7);
        }
        //.html($('#popup_' + popup_type).html())
   } catch (e) { 
       document.getElementById("warning_region").innerHTML = 
                "Ошибка отображения фона POPUP-элемента!";
   }

   try {
   $('#popup')
     .alignCenter()
     .toggleClass('hidden');
   } catch (e) { 
       document.getElementById("warning_region").innerHTML = 
                "Ошибка отображения POPUP-элемента!";
   }

   //return false;
 }
 
 function showElement(element_class_name)   {
    try {
    list = document.getElementsByClassName(element_class_name);
    for (var i=0; i<list.length; i++) {
       list[i].style.visibility = 'visible';
        }
    } catch ( e ) {
                //document.getElementById("warning_region").innerHTML = 
               //     "Ошибка разбора списка элементов по classname!"+e.toString();
    }
 }
 
function hideElement(element_class_name)   {
    try {
    list = document.getElementsByClassName(element_class_name);
    for (var i=0; i<list.length; i++) {
       list[i].style.visibility = 'hidden';
        }
    } catch ( e ) {
                //document.getElementById("warning_region").innerHTML = 
               //     "Ошибка разбора списка элементов по classname!"+e.toString();
    }
 }
 
 function showEditButtons()    {
     hideElement('button medium blue add');
     showElement('button medium blue edit');
 }
 
 function showAddButtons()    {
     hideElement('button medium blue edit');
     showElement('button medium blue add');
 }
 
 function showElementByClassById(element_class_name, element_id)    {
     try {
    list = document.getElementsByClassName(element_class_name);
    for (var i=0; i<list.length; i++) {
       if (list[i].id==element_id)
            list[i].style.visibility = 'visible';
        }
    } catch ( e ) {
                //document.getElementById("warning_region").innerHTML = 
               //     "Ошибка разбора списка элементов по classname!"+e.toString();
    }
 }
 
 function hideElementByClassById(element_class_name, element_id)    {
    try {
    list = document.getElementsByClassName(element_class_name);
    for (var i=0; i<list.length; i++) {
       if (list[i].id==element_id) 
            list[i].style.visibility = 'hidden';
        }
    } catch ( e ) {
                //document.getElementById("warning_region").innerHTML = 
               //     "Ошибка разбора списка элементов по classname!"+e.toString();
    }
 }
 
 function showElementByIdVis(element_id)    {
     try {
            elm = document.getElementById(element_id);
            elm.style.visibility = 'visible';
    } catch ( e ) {
                //document.getElementById("warning_region").innerHTML = 
                //    "Ошибка !"+e.toString();
    }
 }
 
 function hideElementByIdVis(element_id)    {
    try {
            //document.getElementById(element_id).style.visibility = 'hidden';
            elm = document.getElementById(element_id);
            elm.style.visibility = 'hidden';
    } catch ( e ) {
                //document.getElementById("warning_region").innerHTML = 
                //    "Ошибка !"+e.toString();
    }
 }

 
 function closeConfirm()
 {
   try {
        $('#opaco').toggleClass('hidden').removeAttr('style');
   } catch (e) { 
       document.getElementById("warning_region").innerHTML = 
                "Ошибка скрытия фона POPUP-элемента!";
   }
   try {
        $('#confirm').addClass('hidden');
   } catch (e) { 
       document.getElementById("warning_region").innerHTML = 
                "Ошибка скрытия POPUP-элемента!";
   }
   //return false;
 }
 
 function showConfirm(action_function)//popup_type)
 {
   //document.getElementById("warning_region").innerHTML = 
   //             "Старт отображения POPUP-элемента!";
   try {
        //when IE - fade immediately
        if($.browser.msie)
        {
            $('#opaco').height($(document).height()).toggleClass('hidden');
        }
        else
        //in all the rest browsers - fade slowly
        {
            $('#opaco').height($(document).height()).toggleClass('hidden').fadeTo('slow', 0.7);
        }
        //.html($('#popup_' + popup_type).html())
   } catch (e) { 
       document.getElementById("warning_region").innerHTML = 
                "Ошибка отображения фона POPUP-элемента!";
   }

   try {
   $('#confirm')
     .alignCenter()
     .toggleClass('hidden');
     
     $('#confirm_yes').focus();
         
     //$('#confirm_no').keypress(function(e) {
     //                if (e.which==9) {
//                    $('#confirm_yes').focus();
//                }
//            });
     //document.getElementById("confirm_yes").
     document.getElementById("confirm_no").onkeydown = function()  {
         if(event.keyCode==9) {
     //       alert(e.which);
     //       if (e.which==9) { 
     //           return false;
     //       }
             $('#confirm_yes').focus();
             return false;
        }
     }
     document.getElementById("confirm_yes").onclick = function() { 
         action_function();}
   } catch (e) { 
       document.getElementById("warning_region").innerHTML = 
                "Ошибка отображения POPUP-элемента!";
   }

   //return false;
 }
 
 function actionConfirm(action_function)    {
     showConfirm(action_function);
 }
 
 function actionConfirmExt( action_function, exec_params)    {
 var no_confirm=false;    
     if (!(typeof exec_params == 'undefined'))  {
        if (exec_params!=null) {
            if (typeof(exec_params) == 'object')
            {
                for(var key in exec_params) {
                    if (key=='show_confirm_critery')    {
                        if (exec_params[key])   {
                            action_function();
                            no_confirm=true;
                        }

                    }
                } 
            }
            else {
                if(exec_params) {
                    action_function();
                    no_confirm=true;
                }
            }
        }
     }

     if (!no_confirm)
        showConfirm(action_function);
 }
 
 function showDivModal(modal_id)//popup_type)
 {
   //document.getElementById("warning_region").innerHTML = 
   //             "Старт отображения POPUP-элемента!";
   
   try {
        //when IE - fade immediately
        if($.browser.msie)
        {
            $('#opaco').height($(document).height()).toggleClass('hidden');
        }
        else
        //in all the rest browsers - fade slowly
        {
            $('#opaco').height($(document).height()).toggleClass('hidden').fadeTo('slow', 0.7);
        }
        //.html($('#popup_' + popup_type).html())
   } catch (e) { 
       document.getElementById("warning_region").innerHTML = 
                "Ошибка отображения фона POPUP-элемента!";
   }

   try {
       
   //$('#'+modal_id).style.z-index=20;
   var div_id = '#'+modal_id;
   //document.getElementById("warning_region").innerHTML = ;
   //$(div_id).style.visibility = "visible";
   //document.getElementById(modal_id).style.visibility = "visible";
    $(div_id).alignCenterAbs(); 
	$(div_id).toggleClass('hidden');//.alignCenter()
       
     //$('#confirm_yes')
     //document.getElementById("confirm_yes").onclick = function() { 
     //    action_function(); }
   } catch (e) { 
       document.getElementById("warning_region").innerHTML = 
                "Ошибка отображения POPUP-элемента!"+div_id;
   }
   
   

   //return false;
 }
 
  function showDivModalVis(modal_id)//popup_type)
 {
   //document.getElementById("warning_region").innerHTML = 
   //             "Старт отображения POPUP-элемента!";
   
   try {
        //when IE - fade immediately
        if($.browser.msie)
        {
            $('#opaco').height($(document).height()).toggleClass('hidden');
        }
        else
        //in all the rest browsers - fade slowly
        {
            $('#opaco').height($(document).height()).toggleClass('hidden').fadeTo('slow', 0.7);
        }
        //.html($('#popup_' + popup_type).html())
   } catch (e) { 
       document.getElementById("warning_region").innerHTML = 
                "Ошибка отображения фона POPUP-элемента!";
   }

   try {
       
   //$('#'+modal_id).style.z-index=20;
   var div_id = '#'+modal_id;
   //document.getElementById("warning_region").innerHTML = ;

   $(div_id).alignCenterAbs();
   document.getElementById(modal_id).style.display = "";
       
   } catch (e) { 
       document.getElementById("warning_region").innerHTML = 
                "Ошибка отображения POPUP-элемента!"+div_id;
   }
   
   //return false;
 }
 
 function closeDivModalVis(modal_id)//popup_type)
 {
   var not_close_action_window = false;  
     
   try {
    not_close_action_window = 
        document.getElementById("not_close_action_window").checked; 
   } catch (e) { 
       not_close_action_window = false;
   } 
     
   if (!not_close_action_window)    {
   try {
        $('#opaco').toggleClass('hidden').removeAttr('style');
   } catch (e) { 
       document.getElementById("warning_region").innerHTML = 
                "Ошибка скрытия фона POPUP-элемента!";
   }  
     
   try {
       
     var div_id = '#'+modal_id;
     document.getElementById(modal_id).style.display = "none";
     //$(div_id).toggleClass('hidden');//.alignCenter()

   } catch (e) { 
       document.getElementById("warning_region").innerHTML = 
                "Ошибка скрытия POPUP-элемента!"+div_id;
   }
   }
   
 }
 
 function cancelNonCloseAction()    {
     try {
        document.getElementById("not_close_action_window").checked=false; 
     } catch (e) { 
        //not_close_action_window = false;
     }
 }
 
 function closeDivModal(modal_id)//popup_type)
 {
   var not_close_action_window = false;  
     
   try {
    not_close_action_window = 
        document.getElementById("not_close_action_window").checked; 
   } catch (e) { 
       not_close_action_window = false;
   } 
     
   if (!not_close_action_window)    {
   try {
        $('#opaco').toggleClass('hidden').removeAttr('style');
   } catch (e) { 
       document.getElementById("warning_region").innerHTML = 
                "Ошибка скрытия фона POPUP-элемента!";
   }  
     
   try {
       
     var div_id = '#'+modal_id;

     $(div_id).toggleClass('hidden');//.alignCenter()

   } catch (e) { 
       document.getElementById("warning_region").innerHTML = 
                "Ошибка скрытия POPUP-элемента!"+div_id;
   }
   }
   
 }
 
 function actionCompleteFunction( act_counter, complete_function)  {
     act_counter[0]--;
     if (act_counter[0]<=0) {
         complete_function();
     }
 }
 
 function fillContainer(source_id, dest_id, slider_panel_id) {
     if ((source_id!=null)&&(dest_id!=null))    {
         try {
                document.getElementById(dest_id).innerHTML = 
                    document.getElementById(source_id).innerHTML;
            } catch (e) { 
                document.getElementById("warning_region").innerHTML = 
                    "Ошибка копирования контента!";
            }
     }
 }
 
 function setInnerHtmlByClass(class_name, html_content) {
    try {
    list = document.getElementsByClassName(class_name);

    for (var i=0; i<list.length; i++) {
            list[i].innerHTML = html_content;
        }
    } catch ( e ) {
        document.getElementById("warning_region").innerHTML = 
            "Ошибка установки содержимого контейнеров по classname!"+e.toString();
    }
 }
 
  function addToMultiset(val_list_id, dest_id, multiset_id)    {
     try {
        val_list = document.getElementById(val_list_id);
        dest = document.getElementById(dest_id);
        multiset = document.getElementById(multiset_id);
        if ((val_list!=null)&&(dest!=null)&&(multiset!=null))   {
            var oOption = document.createElement("option");
            oOption.appendChild(document.createTextNode(val_list.
                options[val_list.selectedIndex].innerHTML));
            oOption.setAttribute("value", val_list.
                options[val_list.selectedIndex].value);
            
            dest.appendChild(oOption);
            
            var multiset_val="";
            for (var i=0; i < dest.options.length; i++)
            {
                //if (dest.options[i].value>0) {
                    multiset_val = multiset_val+"***___"+dest.options[i].value;
                //}
            }
            multiset.value = multiset_val;
        }
        else
            document.getElementById("warning_region").innerHTML = 
            "Ошибка установки содержимого multiset-поля!";
     } catch ( e ) {
        document.getElementById("warning_region").innerHTML = 
            "Ошибка установки содержимого multiset-поля!"+e.toString();
    }
 }
 
 function deleteFromMultiset(dest_id, multiset_id)    {
     try {
        dest = document.getElementById(dest_id);
        multiset = document.getElementById(multiset_id);
        if ((dest!=null)&&(multiset!=null))   {
            
            //if ((dest.options[dest.selectedIndex].value!=-1)&&
            //    (dest.options[dest.selectedIndex].value!="-1")) {
                    dest.removeChild(dest.options[dest.selectedIndex]);
           //     }
            
            var multiset_val="";
            for (var i=0; i < dest.options.length; i++)
            {
                //if (dest.options[i].value>0) {
                    multiset_val = multiset_val+"***___"+dest.options[i].value;
                //}
            }
            multiset.value = multiset_val;
        }
        else
            document.getElementById("warning_region").innerHTML = 
            "Ошибка установки содержимого multiset-поля!";
     } catch ( e ) {
        document.getElementById("warning_region").innerHTML = 
            "Ошибка установки содержимого multiset-поля!"+e.toString();
    }
 }
 
 function clearMultiSetsAndKeys()  {
     //document.getElementById("warning_region").innerHTML = 
     //               "qqqqqqqqqqqqqqqqq!"+e.toString();
     try {
    list = document.getElementsByClassName('multiset_list');
    //$(".date_time_cont_div").AnyTime_picker(
    //                {format: "%z-%m-%d %H:%i", labelTitle: "Дата-Время",
    //                labelHour: "Час", labelMinute: "Минуты"} );
    for (var i=0; i<list.length; i++) {
              try {
                while (list[i].childNodes.length>0)
                    {
                        list[i].removeChild(list[i].childNodes[0]);
                    }
              } catch ( e ) {
                document.getElementById("warning_region").innerHTML = 
                    "Ошибка разбора списка элементов по classname!"+e.toString();
              }   
    }
    } catch ( e ) {
                document.getElementById("warning_region").innerHTML = 
                    "Ошибка разбора списка элементов по classname!"+e.toString();
    }
 }
 
 function showTabsInContainer(main_container_id, active_tab_id, li_obj) {
    try {
        
        ul_object = document.getElementById('ul_'+main_container_id);
        
        if (ul_object!=null) {
            list = ul_object.childNodes;
            for (var i=0; i<list.length; i++)   
                list[i].className = null;
            //li_obj.addClass("active");
        } else
            document.getElementById("warning_region").innerHTML = 
                    "Не найден корень списка элемента табуляции! id=ul_"+
                    main_container_id;
    } catch (e) { 
        document.getElementById("warning_region").innerHTML = 
                    "Не найден корень списка элемента табуляции! id="+
                    main_container_id+". Ошибка:"+e.toString();
    }

     
     try    {
        mcont_object = document.getElementById(main_container_id);
        
        if (mcont_object!=null) {
            list = mcont_object.childNodes;
            try {
                for (var i=0; i<list.length; i++)   
                    list[i].style.display = "none";
                for (var i=0; i<list.length; i++) {
                    if (list[i].id==active_tab_id)  {
                        list[i].style.display = "";
                    }
                }
            } catch ( e ) {
                document.getElementById("warning_region").innerHTML = 
                    "Ошибка заполнения контейнера элемента табуляции!"+e.toString();
            }
        } else
            document.getElementById("warning_region").innerHTML = 
                    "Не найден главный контейнер элемента табуляции! id="+
                    main_container_id;
                
        } catch ( e ) {
                document.getElementById("warning_region").innerHTML = 
                    "Не найден главный контейнер элемента табуляции! id="+
                    main_container_id+". Ошибка:"+e.toString();
    }
 }
 
 function hidePic(){
	myalt.style.visibility="hidden";
	myalt.innerHTML="";
	myalt.style.top=0;
	myalt.style.left=0;
	hide=true;
}

function movePic(word){
    
    myalt.innerHTML=word;
    _x=window.event.clientX;
    _y=window.event.clientY;//сохранение координат курсора мыши в переменные
    _dx=50;//смещение подскаки вправо и влево относительно координат мыши
    //Определение, помещается ли подсказка между курсором и краями экрана
    left=false;
    right=false;
    
    if  (_dx+_x+myalt.clientWidth>document.body.clientWidth)  {
        _x=document.body.clientWidth-myalt.clientWidth-_dx;
        left=true;
    }
    if  (_dx+_y+myalt.clientHeight>document.body.clientHeight)    {
        _y=document.body.clientHeight-myalt.clientHeight-_dx;
        right=true;
    }
    //если объект в нижнем правом углу, подсказка всплывает над курсором
    if(left&&right)_y=document.body.clientHeight-myalt.clientHeight-_dx*4;
    //помещение подсказки в найденные коородинаты
    myalt.style.left=_x+20;
    myalt.style.top=_y+document.body.scrollTop+20;//смещение подскази в зависимости от высоты прокрученной части документа
    myalt.style.visibility="visible";
    
}

function hideFastWindow(win_id){
var _x, _y, left, right, _dx;
//if(!fastInFocus)
    try {

        myalt = document.getElementById(win_id);
    
        if (myalt!=null)    {
            
            //myalt.innerHTML=word;
            _x=window.event.clientX;
            _y=window.event.clientY;//сохранение координат курсора мыши в переменные
            _dx=10;//смещение подскаки вправо и влево относительно координат мыши
            //Определение, помещается ли подсказка между курсором и краями экрана
            left=false;
            right=false;
    
            if  (_dx+_x+myalt.clientWidth>document.body.clientWidth)  {
                _x=document.body.clientWidth-myalt.clientWidth-_dx;
                left=true;
            }
            
            if  (_dx+_y+myalt.clientHeight>document.body.clientHeight)    {
                _y=document.body.clientHeight-myalt.clientHeight-_dx;
                right=true;
            }
    
            //если объект в нижнем правом углу, подсказка всплывает над курсором
            if(left&&right)
                _y=document.body.clientHeight-myalt.clientHeight-_dx*4;
            
            //помещение подсказки в найденные коородинаты
            if ((Math.abs(parseInt(myalt.style.left)-(_x))>10)||
                (Math.abs(parseInt(myalt.style.top)-(_y+document.body.scrollTop))>10))
                    myalt.style.visibility="hidden";

        } else
            document.getElementById("warning_region").innerHTML = 
                    "Не найден элемент всплывающего окна операций!";
    
    } catch ( e ) {
                document.getElementById("warning_region").innerHTML = 
                    "Неудачное отображение всплывающего окна операций!"+
                    ". Ошибка:"+e.toString();
    }
    
}

function showFastWindow(win_id){
var _x, _y, left, right, _dx;  
    //fastInFocus = false;
    try {

        myalt = document.getElementById(win_id);
    
        if (myalt!=null)    {
           if (myalt.style.visibility!="visible")   {
            //myalt.innerHTML=word;
            _x=window.event.clientX;
            _y=window.event.clientY;//сохранение координат курсора мыши в переменные
            _dx=10;//смещение подскаки вправо и влево относительно координат мыши
            //Определение, помещается ли подсказка между курсором и краями экрана
            left=false;
            right=false;
    
            if  (_dx+_x+myalt.clientWidth>document.body.clientWidth)  {
                _x=document.body.clientWidth-myalt.clientWidth-_dx;
                left=true;
            }
            
            if  (_dx+_y+myalt.clientHeight>document.body.clientHeight)    {
                _y=document.body.clientHeight-myalt.clientHeight-_dx;
                right=true;
            }
    
            //если объект в нижнем правом углу, подсказка всплывает над курсором
            if(left&&right)
                _y=document.body.clientHeight-myalt.clientHeight-_dx*4;
            
            //помещение подсказки в найденные коородинаты
            //if (Math.abs(parseInt(myalt.style.left)-(_x+document.body.scrollLeft))>20)
            myalt.style.left=(_x+document.body.scrollLeft+5)+'px';
            //if (Math.abs(parseInt(myalt.style.top)-(_y+document.body.scrollTop))>20)
            myalt.style.top=(_y+document.body.scrollTop+5)+'px';//смещение подскази в зависимости от высоты прокрученной части документа
            myalt.style.visibility="visible";
           }
           else
               hideFastWindow(win_id);
        } else
            document.getElementById("warning_region").innerHTML = 
                    "Не найден элемент всплывающего окна операций!";
    
    } catch ( e ) {
                document.getElementById("warning_region").innerHTML = 
                    "Неудачное отображение всплывающего окна операций!"+
                    ". Ошибка:"+e.toString();
    }
    
}

function setElementValueById(elm_id, val){
    try {

        modified_elm = document.getElementById(elm_id);
    
        if (modified_elm!=null)    {
                modified_elm.value = val;
        } else
            document.getElementById("warning_region").innerHTML = 
                    "Не найден элемент для установки значения по id!";
    
    } catch ( e ) {
                document.getElementById("warning_region").innerHTML = 
                    "Неудачный поиск элемента для установки значения по id!"+
                    ". Ошибка:"+e.toString();
    }
    
}

function setElementValueByIdFromId(elm_id, src_id){
    try {

        modified_elm = document.getElementById(elm_id);
        src_elm = document.getElementById(src_id);
    
        if ((modified_elm!=null)&&(src_elm!=null))    {
                modified_elm.value = src_elm.value;
        } else
            document.getElementById("warning_region").innerHTML = 
                    "Не найден элемент для установки или извлечения значения по id!";
    
    } catch ( e ) {
                document.getElementById("warning_region").innerHTML = 
                    "Неудачный поиск элемента для установки или извлечения значения по id!"+
                    ". Ошибка:"+e.toString();
    }
    
}