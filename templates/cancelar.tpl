{extends file="index.tpl"}


{block name="style" append}
    <link href="{$template_url}/css/confirmacion.css" rel="stylesheet">
{/block}

{block name="script" append}
    <script src="http://maps.googleapis.com/maps/api/js?sensor=false&amp;libraries=places"></script>
    <script type="text/javascript" src="{$template_url}/js/confirmacion.js"></script> 
{/block}

{block name="content" append}

<div class="container content contact fullWhite">
<div class="container_confirmacion">
   <div class="row-fluid">
       <div class="container-titulo  col-md-9">
           <h3 class="text-center alert alert-info">{$reserva->usuario->nombre} {#tu_reserva_ha_sido_cancelada#}</h3>
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
                      <h4>{#tu_reserva_ha_sido_cancelada#}</h4>
                  </div>
               </li>  
               </ul> 
            </div> 
         </div>
     <div class="row-fluid">
       <div class="container-codigo  col-lg-12" style="text-align: center;">
           <h4 class="text-center alert alert-info">{#tu_codigo_digital#}</h4>
           
       </div>
     </div>

   <div class="row-fluid"> 
<div class="col-lg-12">
       <div class="container-imagen text-center">
       <ul class="list-group">
       <li class="list-group-item">
      <img src="{$qrcodeurl}">
       <p> {#te_hemos_enviado_la_cancelacion_por_mail_a#}  <a href="mailto:{$reserva->usuario->email}">{$reserva->usuario->email}</a></p>
       <button id="imprimir_reserva_btn" type="button" class="btn btn-primary">{#imprimir#}</button>
       </li>
       </ul>
       </div>
       </div>
       </div>

        </div>
   </div>
       <div class="row-fluid clearfix text-center">
           <button id="finalizar_btn" type="button" class="btn btn-primary">Finalizar</button>
       </div>
</div>
 <div class="row">
       <div class="col-lg-12">
           <h4 class="text-center"><b>{#gestionado_por#} vikatickets.com</b></h4>
       </div>
   </div>
</div>
</div>
{/block}