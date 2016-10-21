<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
?>

<script language="JavaScript" type="text/javascript">
        
    $(document).ready(function() {
        
        document.getElementById('app_status').innerHTML='Инициализация приложения Кудапотратил ВКонтакте...';
        
        VK.init(function() {
            // API initialization succeeded
            // Your code here
            //apiId: 3079318
            document.getElementById('app_status').innerHTML='Приложение Кудапотратил ВКонтакте инициализировано!';
        });
    });
        
</script>

<?php

?>