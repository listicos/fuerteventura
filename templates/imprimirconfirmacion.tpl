<link href="{$template_url}/css/reset.css" rel="stylesheet">
            <link href="{$template_url}/css/bootstrap.min.css" rel="stylesheet">
            <link href="{$template_url}/css/bootstrap-glyphicons.css" rel="stylesheet">
            <link href="{$template_url}/css/confirmacion.css" rel="stylesheet">

<div class="container content contact fullWhite">
<div class="container_confirmacion">
   <div class="row-fluid">
       <div class="container-titulo  col-md-9">
           <h3 class="text-center alert alert-info">Datos de tu reserva</h3>
       </div>
   </div>
   <div class="row-fluid">
        <div class="container-codigo well ">
           <h4 class = "text-center" > {#codigo_de_reserva#}: {$reserva->codigo} </h4>  
       </div>
   </div>
<div class="row-fluid clearfix">
   <div class="col-lg-6">
      <div class="row-fluid ">
          <div class="container-datos">
            <ul class="list-group">
              <li class="list-group-item alert alert-info"><h4 class="text-center">{#tus_datos#}</h4></li>
              <li class="list-group-item">{#nombre#}: {$reserva->usuario->nombre}</li>
              <li class="list-group-item">{#apellido#}: {$reserva->usuario->apellidoPaterno} {$reserva->usuario->apellidoMaterno}</li>
              <li class="list-group-item">{#telefono#}: {$reserva->usuario->telefono}</li>
              <li class="list-group-item">{#correo_electronico#}: {$reserva->usuario->email}</li>
            </ul>
          </div> 
      </div>
  <div class="row-fluid">
      <div class="container-evento">
          <ul class="list-group">
             <li class="list-group-item alert alert-info"><h4  class="text-center">{#datos_del_evento#}</h4></li>
             <li class="list-group-item"> 
             <p>{if $reserva->evento->direccion->calle}calle {$reserva->evento->direccion->calle}{else}{$reserva->evento->direccion->descripcion}{/if}, n°{$reserva->evento->direccion->numero} <br>{$reserva->evento->direccion->codigoPostal}.<br>{#telefono#} {$reserva->evento->telefono}</p>
             </li>
             <li class="list-group-item">
                 <p><strong>{#localizacion_gps#}:</strong><br>Latitud: {$reserva->evento->direccion->lat}<input type="hidden" name="lat" value="{$reserva->evento->direccion->lat}"><br> Longitud: {$reserva->evento->direccion->lon}<input type="hidden" name="lon" value="{$reserva->evento->direccion->lon}"><br></p>
                  <div id="mapa-container" style="width: 100%; height: 200px;">
                     <img src="http://maps.googleapis.com/maps/api/staticmap?center={$reserva->evento->direccion->lat},{$reserva->evento->direccion->lon}&zoom=15&size=350x200&sensor=true">
                 </div>
             </li>
          </ul>
       </div>
  </div>
       </div>
 <div class="col-lg-6">
       <div class="row-fluid">
            <div class="container-tarjeta">
               <ul class="list-group">
               <li class="list-group-item alert alert-info"><h5 class="text-center">{$reserva->evento->nombre}<br><p>Fuertetour</p></h5></li>
               <li class="list-group-item">{$reserva->fecha|date_format}</li>
               <li class="list-group-item">{#horario#}: {$reserva->sesion|date_format:"%H:%M"}</li>
               <li class="list-group-item">{#entradas#}: {$reserva->cantidadEntradas} {foreach from=$reserva->entradas item=entrada}/ {$entrada->entrada}:{$entrada->entradas}{/foreach}</li>
               <li class="list-group-item">{#total#}: {$reserva->precio|number_format:2:',':'.'} €</li>
               <li class="list-group-item">
                  <br />
                  <br />
                  <div class="text-center">
                      
                  </div>
               </li>  
               </ul> 
            </div> 
         </div>
     <div class="row-fluid">
       <div style="text-align: center;" class="container-codigo  col-lg-12">
           <h4 class="text-center alert alert-info">Tu código digital</h4>
           
       </div>
     </div>

   <div class="row-fluid"> 
<div class="col-lg-12">
       <div class="container-imagen text-center">
       <ul class="list-group">
       <li class="list-group-item">
      <img src="{$qrcodeurl}" ilo-full-src="http://localhost/vikatickets/cache/qrcode_reservacion_121.png">
       
       </li>
       </ul>
       </div>
       </div>
       </div>

        </div>
   </div>
</div>
 <div class="row">
       <div class="col-lg-12">
           <h4 class="text-center"><b>Gestionado por vikatickets.com</b></h4>
       </div>
   </div>
</div>
      
<script>
    window.print();
</script>