<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Inicio - Viajes</title>

        {block "style"}
            
            <link href="{$template_url}/css/reset.css" rel="stylesheet">
            <link href="{$template_url}/css/datepicker.css" rel="stylesheet">
            <link href="{$template_url}/css/bootstrap.min.css" rel="stylesheet">
            <link href="{$template_url}/css/bootstrap-glyphicons.css" rel="stylesheet">
            <link href="{$template_url}/css/bootstrap-select.css" rel="stylesheet">
            <link href="{$template_url}/css/weatherslider.css" rel="stylesheet">
            <link href="{$template_url}/css/toastr.css" rel="stylesheet">
            <link href="{$template_url}/css/validationEngine.jquery.css" rel="stylesheet">
            <link href="{$template_url}/css/styles.css" rel="stylesheet">
            <link href="{$template_url}/css/fuerteventura.css" rel="stylesheet">
        {/block} 
    </head>
    <body class="">
       <div id="blocker">
           <div>Cargando...</div>
       </div>
        <div class="container global">
            {include file="header.tpl"}

            {block "content"}{/block}

            {include file="footer.tpl"}
            
            <script type="text/javascript">
    
                BASE_URL = "{$base_url}";
                /*DISTRIBUIDOR = new Object();
                DISTRIBUIDOR.EMAIL = '{$distribuidor['email']}';
                DISTRIBUIDOR.PASSWORD = '{$distribuidor['password']}';*/
                var FECHAS_DISPONIBLES = new Array();
                var RANGOS_FECHAS_DISPONIBLES = new Array();
        
            </script>
        </div>

        {block "script"} 
            <script src="{$template_url}/js/jquery.js"></script>
            <script src="{$template_url}/js/bootstrap.min.js"></script>
            <script src="{$template_url}/js/bootstrap-dropdown.js"></script>
            <script src="{$template_url}/js/bootstrap-select.js"></script>
            <script src="{$template_url}/js/bootstrap-datepicker.js"></script>
            <script src="{$template_url}/js/bootstrap-modal.js"></script>
            <script src="{$template_url}/js/jquery-easing.js"></script>
            <script src="{$template_url}/js/toastr.js"></script>
            <script src="{$template_url}/js/jquery.validationEngine-es.js"></script>
            <script src="{$template_url}/js/jquery.validationEngine.js"></script>
            <script src="{$template_url}/js/jquery-animate-background-position.js"></script>
            <script src="{$template_url}/js/weatherslider.kreaturamedia.jquery.js"></script>
        {/block}   
        
    </body>
</html>
