$(document).ready(function(){
   //$('.d_text').css('margin-top', 220 - $(this).height()) 
   function equalWidth(group) {
        group.each(function() {
            if($(this).height() < 220){
                $(this).css('margin-top', (220 - $(this).height())/2)
            }
             
        });
   }
   equalWidth($('.d_text'))
   
   $('#onep').css('margin-top', (362-$('#onep').height())/2)
   
   stop = false;
   i = 1;
   function slide(){
       
            
                if(stop == false){
                 $('#s'+i).animate({
                    marginLeft: '100%',
                     opacity: 0
                 }, 1500, 'easeInExpo' , function(){
                     $('#s'+i).hide()
                     i++;

                      if(i==3) i = 1

                      $('#s'+i).css({marginLeft: '-100%', opacity: 0})
                      $('#s'+i).show()
                      $('#s'+i).animate({
                          marginLeft: '20px',
                          opacity: 1
                      }, 1500, 'easeOutExpo');
                 });


}
               
       
       
   }
   
   setInterval(function(){
                if(stop == false){
                  slide();  
                }
   }, 7000)
   
   window.onfocus = function() {stop = false}
   window.onblur = function() {stop = true}
   
   
   $('.m_button').click(function(){
       $('.in_slider .text').fadeOut(500,function(){
           $('.in_slider .form').fadeIn()
       })
       
       stop = true;
       
       yaCounter16640023.reachGoal('click')
       return false
   })
   $('.back').click(function(){
       $('.in_slider .form').fadeOut(500,function(){
           $('.in_slider .text').fadeIn(function(){
               $('.suc').hide();
               $('form').show();
           })
       })
       
       stop = false;
       
       
       return false
   })
   
   $('.form_submit').click(function(){
       
       if($(this).parents('form').children(".name").val() != ''){
           
           $(this).parents('form').children(".name").css({
                    'border-color': "#cccccc"
                });
                
                
           var email = $(this).parents('form').children(".email").val();

            if(email != 0)
            {
                $(this).parents('form').children(".email").css({
                    'border-color': "#cccccc"
                });
                if(isValidEmailAddress(email))
                {
                    $(this).parent('form').submit();
                    $(this).parent('form').hide();
                    $('.suc').fadeIn();
                } else {
                    $(this).parents('form').children(".email").css({
                        'border-color': "red"
                    });
                }
            }else {
              $(this).parents('form').children(".email").css({
                        'border-color': "red"
                    });  
            }
       } else {
          $(this).parents('form').children(".name").css({
                    'border-color': "red"
                });
       }
       
        return false;
       
   })
   
   
   
   $('form').ajaxForm(function() { });
   
   $('form').submit(function(){
       yaCounter16640023.reachGoal('sendform')
   })
   $('.get_fo').click(function(){
       $('#onep').fadeOut(500, function(){
           $('#form_bottom').fadeIn();
       })
       return false;
   })
   
   $('#form_bottom .back').click(function(){
       $('#form_bottom').fadeOut(500, function(){
           $('#onep').fadeIn();
       })
       return false;
   })
   
   var controller = $.superscrollorama();

       

   
                               
   
    initScrollAnimations()
                                
                                
                              
   function initScrollAnimations() {
        if($('#d1').position().top > $('body').height()-100) {
            controller.addTween($('#d1'), TweenMax.from( $('#d1'), 1, {css:{opacity: '0', rotation: 360}, ease:Expo.easeOut}),0,-350);
            controller.addTween($('#d1'), TweenMax.from( $('#text1'), 1, {
                css:{opacity: '0', marginLeft: '-100%;'}, 
                ease:Expo.easeOut
            }),0,-350);
            controller.addTween($('#d2'), TweenMax.from( $('#str1'), .5, {
                css:{height: '1px'}, 
                ease:Expo.easeOut
            }),0,-350);
        }
        
        if($('#d2').position().top > $('body').height()-100) {
            controller.addTween($('#d2'), TweenMax.from( $('#d2'), 1, {css:{opacity: '0', rotation: 360}, ease:Expo.easeOut}),0,-350);
            controller.addTween($('#d2'), TweenMax.from( $('#text2'), 1, {css:{opacity: '0', marginLeft: '-100%;'}, ease:Expo.easeOut}),0,-350); 
            controller.addTween($('#d3'), TweenMax.from( $('#str2'), .5, {
                css:{height: '1px'}, 
                ease:Expo.easeOut
            }),0,-350);
        }

        controller.addTween($('#d3'), TweenMax.from( $('#d3'), 1, {css:{opacity: '0', rotation: 360}, ease:Expo.easeOut}),0,-350);
        controller.addTween($('#d4'), TweenMax.from( $('#d4'), 1, {css:{opacity: '0', rotation: 360}, ease:Expo.easeOut}),0,-350);
        controller.addTween($('#d5'), TweenMax.from( $('#d5'), 1, {css:{opacity: '0', rotation: 360}, ease:Expo.easeOut}),0,-350);
        controller.addTween($('#d6'), TweenMax.from( $('#d6'), 1, {css:{opacity: '0', rotation: 360}, ease:Expo.easeOut}),0,-350); 
        controller.addTween($('#d7'), TweenMax.from( $('#d7'), 1, {css:{opacity: '0', rotation: 360}, ease:Expo.easeOut}),0,-350); 
        
        
        
        
        
        controller.addTween($('#d4'), TweenMax.from( $('#str3'), .5, {
            css:{height: '1px'}, 
            ease:Expo.easeOut
        }),0,-350);
        controller.addTween($('#d5'), TweenMax.from( $('#str4'), .5, {
            css:{height: '1px'}, 
            ease:Expo.easeOut
        }),0,-350);
        controller.addTween($('#text6'), TweenMax.from( $('#str5'), .5, {
            css:{height: '1px'}, 
            ease:Expo.easeOut
        }),0,-350);
        
        
        controller.addTween($('#d3'), TweenMax.from( $('#text3'), 1, {css:{opacity: '0', marginLeft: '-100%;'}, ease:Expo.easeOut}),0,-350);
        controller.addTween($('#d4'), TweenMax.from( $('#text4'), 1, {css:{opacity: '0', marginLeft: '-100%;'}, ease:Expo.easeOut}),0,-350); 
        controller.addTween($('#d5'), TweenMax.from( $('#text5'), 1, {css:{opacity: '0', marginLeft: '-100%;'}, ease:Expo.easeOut}),0,-350); 
        controller.addTween($('#text6'), TweenMax.from( $('#text6'), 1, {css:{opacity: '0', marginLeft: '-100%;'}, ease:Expo.easeOut}),0,-350);
        controller.addTween($('#d6'), TweenMax.from( $('#text7'), 1, {css:{opacity: '0', marginLeft: '-100%;'}, ease:Expo.easeOut}),0,-350);
        controller.addTween($('#d7'), TweenMax.from( $('#text8'), 1, {css:{opacity: '0', marginLeft: '-100%;'}, ease:Expo.easeOut}),0,-350);
   }
   
   function str_show(str){
       str.show()
   }
   
   
   $('input[placeholder], textarea[placeholder]').placeholder();

});

function isValidEmailAddress(emailAddress) {
    var pattern = new RegExp(/^(("[\w-\s]+")|([\w-]+(?:\.[\w-]+)*)|("[\w-\s]+")([\w-]+(?:\.[\w-]+)*))(@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][0-9]\.|1[0-9]{2}\.|[0-9]{1,2}\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\]?$)/i);
    return pattern.test(emailAddress);
    }