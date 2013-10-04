<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Confirmación de pago</title>
        {block "style"}
            <link href="{$template_url}/css/styles.css" rel="stylesheet">
        {/block} 
        <script type="text/javascript">
          window.opener.location = '{$base_url}/confirmacion/codigo:{$order}';
          self.close();
        </script>
    </head>
    <body class="">
       <div id="blocker">
           <div>Se realizo el pago con éxito.</div>
       </div>
    </body>
</html>