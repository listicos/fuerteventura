
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>Deteatros.com</title>
    {block "script"}  
        <script type="text/javascript" src="{$template_url}/js/jquery.js"></script>

        <script type="text/javascript" src="{$template_url}/js/jquery.validate.js"></script>
        <script type="text/javascript" src="{$template_url}/js/jquery.validate-es.js"></script>
        <script type="text/javascript" src="{$template_url}/js/rotate.js"></script>
        
        <script type="text/javascript" src="{$template_url}/js/colorbox.js"></script>
        <script type="text/javascript" src="{$template_url}/js/jquery.nyroModal.2.0.min.js"></script>
        <script type="text/javascript" src="{$template_url}/js/registro.js"></script>
        
       <script type="text/javascript" src="{$template_url}/js/jquery-ui/jquery.ui.js"></script>
       <script type="text/javascript" src="{$template_url}/js/toastr.js"></script>
        
 {/block}   
    {block "style"}        
        <link rel="stylesheet" href="{$template_url}/css/style.css" type="text/css">

        <link rel="stylesheet" href="{$template_url}/css/nyroModal.css" type="text/css">
        <link rel="stylesheet" type="text/css" href="{$template_url}/css/registro.css" />  
        <link rel="stylesheet" type="text/css" href="{$template_url}/css/jquery.validate.css" />
        <link rel="stylesheet" type="text/css" href="{$template_url}/css/colorbox.css" />
        <link rel="stylesheet" type="text/css" href="{$template_url}/css/theme.css" />
        <link rel="stylesheet" type="text/css" href="{$template_url}/css/registro_response.css" />
        
        <link rel="stylesheet" type="text/css" href="{$template_url}/css/jquery-ui/jquery.ui.all.css"/>
        <link rel="stylesheet" type="text/css" href="{$template_url}/css/toastr.css"/>
 {/block}   
    </head>
    <body>
        <div class="gradienteFondo">
            <div class="reflectores_container">
                <div class="reflector_right"></div>
                <div class="reflector_left"></div>
            </div>
            <div class="fondoFormRegistro"></div>
            <div class="textLogoDeTeatros">
                <div class="imgTextDeTeatros">
                    <a href="/"><img title="DeTeatros.com" alt="DeTeatros.com" src="{$template_url}/images/textBanner.png" /></a>
                </div>
                <div class="main_container_template">
                    {block "main_content"}{/block}
                </div>
            </div>
        </div>
    </body>
</html>