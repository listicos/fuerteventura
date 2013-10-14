{extends file="index.tpl"}


{block name="style" append}
    <link href="{$template_url}/css/detalle.css" rel="stylesheet">
{/block}

{block name="script" append}
    <script src="http://maps.googleapis.com/maps/api/js?sensor=false&amp;libraries=places"></script>
    <script type="text/javascript" src="http://www.google.com/recaptcha/api/js/recaptcha_ajax.js"></script>
    <script type="text/javascript" src="{$template_url}/js/home.js"></script> 
    <script type="text/javascript" src="{$template_url}/js/detalle.js"></script> 
    <script type="text/javascript" src="{$template_url}/js/jquery.creditCardValidator.js"></script>
    <script type="text/javascript" src="{$template_url}/js/jquery.raty.min.js"></script>
{/block}

{block name="content" append}
<div class="wrapper_box content home fullWhite" style="font-size: 14px;">
    <div class="row-fluid">
        <div class="col-lg-12 mrg-btn-20">
            <div class="row-fluid">
                
                <div class="row">
                    <div class="col-lg-6">

                        <div id="parthenon-slider" class="carousel slide">
                            <div class="carousel-inner detalle_carousel_inner">
                                {if $excursion->imagenes}
                                {foreach name=loop_imagenes from=$excursion->imagenes item=imagen}
                                <div class="item {if $smarty.foreach.loop_imagenes.first}active{/if}">
                                    <img src="{$imagen->ruta}" alt="Photo {$smarty.foreach.loop_imagenes.iteration}">
                                    <div class="carousel-caption">

                                    </div>
                                </div>
                                {/foreach}
                                {else}
                                    <div class="item active">
                                        <img src="{$template_url}/imagenes/slider1.jpg" alt="Photo 1">
                                        <div class="carousel-caption">

                                        </div>
                                    </div>
                                {/if}
                                
                            </div>
                            <div class="back-images layer-1"></div>
                            <div class="back-images layer-2"></div>

                            <a class="left carousel-control" href="#parthenon-slider" data-slide="prev">
                                <span class="icon-prev"></span>
                            </a>
                            <a class="right carousel-control" href="#parthenon-slider" data-slide="next">
                                <span class="icon-next"></span>
                            </a>
                        </div>

                    </div>
                    <div class="col-lg-6">
                        <div class="content-title">
                            <input type="hidden" name="fechaSeleccionada" value="{$fechaSeleccionada}">
                            <input type="hidden" name="onRequest" value="{$excursion->onRequest}">
                            <h3>
                                <div style="float:left;">                                
                                    <i style="float:left;">{$excursion->nombre}</i>
                                </div>
                                <div class="tabla float-right">
                                    <div>
                                        {if $excursion->enlaces->facebook || $excursion->enlaces->twitter || $excursion->enlaces->youtube || $excursion->enlaces->skype }

                                            <div class="social-links">
                                                {if $excursion->enlaces->facebook}
                                                    <a href="{$excursion->enlaces->facebook}" class="facebook" title="Facebook" target="_blank"></a>
                                                {/if}
                                                {if $excursion->enlaces->youtube}
                                                    <a href="{$excursion->enlaces->youtube}" class="youtube" title="Youtube" target="_blank"></a>
                                                {/if}
                                                {if $excursion->enlaces->web}
                                                    <a href="{$excursion->enlaces->web}" class="web" title="Web oficial" target="_blank"></a>
                                                {/if}
                                            </div>

                                        {/if}
                                        {if $excursion->rating > -1}

                                            <div class="excursion-rating" puntuacion="{$excursion->rating}"></div>

                                        {/if}
                                    </div>
                                </div>
                                <hr class="for_double">
                            </h3>
                                    
                        </div>
                        <div id="descripcion-excursion">
                            <ul class="parthenon-caption">
                                
                                <li>
                                    <div class="icon-map-marker"></div>
                                    <strong>{#destino#}</strong> {$excursion->direccion->descripcion}
                                </li>
                                
                                <li>
                                    <div class="icon-tag"></div>
                                    <strong>{#precio#}</strong> {#a_partir_de#} <strong>{$excursion->precio->precio|number_format:2:',':'.'}&euro;</strong>
                                </li>
                                {if !$excursion->duracionIndefinida}
                                <li>
                                    <div class="icon-time"></div>
                                    <strong>{#duracion#}</strong> {if $excursion->dias eq 0}{$excursion->duracion|date_format:"%H:%M"}hrs{else}{$excursion->dias}días{/if}
                                </li>
                                {/if}
                                <input type="hidden" name="lat" value="{$excursion->direccion->lat}">
                                <input type="hidden" name="lon" value="{$excursion->direccion->lon}">
                            </ul>
                                                
                        </div>
                    </div>
                    <p class="sinopsis-excursion">
                        {if $excursion->sinopsis->$lang}
                            {$excursion->sinopsis->$lang}
                        {else}
                            {$excursion->sinopsis->es}
                        {/if}
                    </p>
                </div>
                <div class="col-lg-8">
                    <div class="borderBoxBlue form_reservation clearfix">
                        <form id="payment-register-form" method="POST">
                            <input type="hidden" name="action" value="insertReservacion">
                            <input type="hidden" name="eventoId" value="{$excursion->id}">
                            <input type="hidden" name="current_url" value=''>
                            <h5 class="card-message">{#complete_los_datos_de_la_reservacion#}</h5>
                            <div class="form-group row">
                                <div class="col-lg-6">
                                    <div id="fecha"></div>
                                    <input class="btn-box-text hidden" type="text" name="fecha" value="{$fechaSeleccionada|date_format:"%d/%m/%Y"}" />
                                    <select name="fechas" id="fechas" class="hidden">
                                        {foreach from=$excursion->tarifas item=tarifa}
                                            {foreach name=fechas from=$tarifa->fechas item=fecha}
                                                <option value="{$fecha->fecha|date_format:"%m/%d/%Y"}" tarifa-id="{$tarifa->id}">{$fecha->fecha|date_format:"%m/%d/%Y"}</option>
                                            {/foreach}
                                        {/foreach}
                                    </select>
                                </div>
                                <div class="col-lg-6 calendar2">
                                    <div class="alert alert-success">
                                        <h4>{#cuando_quieres_ir#}</h4>
                                        <p class="seleccionaFecha">← {#seleccione_una_fecha_disponible#}</p>
                                        <p class="fechaSeleccionada"><img src="{$template_url}/imagenes/mini_checkList.png"> <span></span></p>
                                        <p class="horaSeleccionada"><img src="{$template_url}/imagenes/mini_checkList.png"> ¿A qu&eacute; hora? <span><select name="sesion" id="sesion"></select></span></p>
                                        <p class="completaAhora">{#completa_los_datos_de_tu_reserva#}</p>
                                    </div> 
                                </div>
                                </div>

                        <div class="row-fluid second_step_information col-lg-12">

                                <div class="row-fluid">
                                    <div id="tarifas-table" class="form-group tarifas-table form-horizontal">
                                      
                                      <div class=" row">  
                                        {foreach from=$excursion->tarifas item=tarifa}
                                            {foreach from=$tarifa->zonas item=zona name=zonas}

                                                    <div class=" tarifa_container" tarifa-id="{$tarifa->id}">
                                                        {if !$excursion->ventaSimultaneaTickets}
                                                            <div class="select-tickets">
                                                                <input type="radio" name="ticket">
                                                            </div>
                                                        {/if}
                                                        <div class=" content-right">
                                                            <label class="precio" for="entradas[{$zona->entrada->id}]">
                                                                [{$zona->entrada->descripcion}] <strong>{$zona->entrada->nombre}</strong>
                                                           </label>
                                                           </div>
                                                           <div class="select-cell no-padding">
                                                            <select name="entradas[{$zona->id}]" precio="{$zona->total}" class="form-control" style="width:82px">
                                                                {foreach from=$cantidades item=c} 
                                                                    {if !$zona->entrada->limitacionVenta || $zona->entrada->limitacionVenta >= $c}
                                                                    <option value="{$c}" {if ($c eq 1 && $smarty.foreach.zonas.first) || ($c eq 0 && !$smarty.foreach.zonas.first)}selected=""{/if} >{$c}</option>            
                                                                    {/if}
                                                                {/foreach}
                                                            </select>

                                                        </div>

                                                        <div class="subtotal-cell no-padding content-center">
                                                             <label class="precioConDescuento"><strong></strong></label> 
                                                             <label class="totalEntradas"><strong></strong></label>
                                                        </div>

                                                    </div>
                                            {/foreach}
                                        {/foreach}

                                         </div>
                                    </div>
                                    <div class="cupon_total_container">
                                        <div class="row-fluid cupon-container">
                                            <div>
                                                <div>
                                                    <div class=" content-right">
                                                        <label class="cupon">{#tienes_un_cupon_promocional#}</label>
                                                    </div>
                                                    <div class="select-cell content-right no-padding">
                                                        <input style="margin: 0; width: 90px; padding: 7px 4px;" class="btn-box-text " type="text" name="cupon"  />
                                                    </div>
                                                    <div class="subtotal-cell content-center no-padding">
                                                        <a id="validar_cupon" class="btn btn-warning" href="javascript:void(0)">{#validar#}</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row-fluid tota_container">
                                            <div class=" text-right no-padding">
                                                <div>
                                                    <div>&nbsp;</div>
                                                    <div class="select-cell">
                                                    <label>{#total#}:</label>
                                                    </div>
                                                    <div class="subtotal-cell content-center" ><label class="precioConDescuento"><strong></strong></label>
                                                    <label class="precio_total"><strong></strong></label>
                                                    <div>{#impuestos_incluidos#}</div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <select name="tarifaId" id="tarifa" class="btn-box-text hidden">
                                        <option selected disabled>{#seleccione_tarifa#}</option>
                                        {foreach from=$excursion->tarifas item=tarifa}                                    
                                            <option value="{$tarifa->id}">{$tarifa->nombre}</option>                                    
                                        {/foreach}
                                    </select>
                                
                            </div>

                           <h5 class="card-message" style="clear: both;">{#completa_los_datos_de_su_cuenta#}</h5>
                           <div class="form-group row">
                                <div class="col-lg-6 form-group">
                                    <label for="nombre">{#nombre#}</label>
                                    <input class="form-control validate[required]" type="text" name="nombre" id="nombre" placeholder="{#nombre#}"  x-webkit-speech/>
                                </div>

                                <div class="col-lg-6 form-group">
                                    <label for="apellido">{#apellido#}</label>
                                    <input class="form-control validate[required]" type="text" name="apellidoPaterno" id="apellido" placeholder="{#apellido#}" x-webkit-speech />
                                </div>

                            
                                <div class="col-lg-6 form-group">
                                    <label>{#correo_electronico#}</label>
                                    <input class="form-control validate[required, custom[email]]" type="text" name="email" x-autocompletetype="email" placeholder="{#correo_electronico#}" />
                                </div>

                                <div class="col-lg-6 form-group">
                                    <label>{#repita_el_correo_electronico#}</label>
                                    <input class="form-control validate[required, custom[confirmationEmail]" type="text" name="repiteEmail" placeholder="{#repita_el_correo_electronico#}" />
                                </div>

                                <div class="col-lg-6 form-group">
                                    <label>{#telefono_movil#}</label>
                                    <input class="form-control validate[required]" type="text" name="telefono" placeholder="{#telefono_movil_incidencias#}" />
                                </div>

                                <div class="col-lg-6 form-group">
                                    <label>País de residencia</label>
                                    <select class="form-control validate[required]" name="nacionalidad">
                                        {foreach from=$countries key=key item=country}
                                            <option value="{$key}" {if $key eq "ES"}selected="selected"{/if}>{$country}</option>
                                        {/foreach}
                                    </select>
                                </div>
                                    <div class="delimiter"></div>
                                <div class="col-lg-12 form-group">
                                    <label for="hotel">{#donde_te_hospedas#}</label>
                                    <input class="form-control validate[required]" type="text" name="hotel" id="hotel" placeholder="{#nombre_hotel#}" x-webkit-speech />
                                </div>
                                    
                                {if $excursion->cobro->forma eq 'Offline'}
                                <div class="col-lg-12">
                                    <div id="captchadiv"></div>
                                </div>
                                {/if}
                            </div>
                            

                            {if $excursion->cobro->forma eq 'Online'}

                                <!--<h5 class="card-message" style="clear: both;">{#completa_datos_tarjeta#}</h5>-->
                                
                                <div class="datos-tarjeta-container col-lg-12 alert alert-info">
                                    <div class="col-lg-12">
                                        <p>{#te_enviaremos_tu_reserva#}: <span id="enviaremos-email"></span></p>
                                        <input type="hidden" class="amount" name="amount" value='0'>
                                        <input type="hidden" id="forma_pago" value="{$excursion->cobro->forma}">
                                        <div class="delimiter"></div>
                                        <hr class="double">
                                   
                                        <p>
                                            {if $excursion->restriccionesTpv->$lang}
                                                {$excursion->restriccionesTpv->$lang}
                                            {else}
                                                {$excursion->restriccionesTpv->es}
                                            {/if}
                                        </p>
                                        
                                        <div class="delimiter"></div>
                                        <hr class="double">

                                        <div class="content-right clearfix"><strong class="resaltar_texto_total">{#total_de_reserva#} <span id="confirmar-total"></span></strong>
                                        </div>
                                       
                                        <div class="content-right clearfix"><strong class="resaltar_texto_total">Total a pagar ahora [<span id="porcientoAdelanto">{$excursion->cobro->porcentajeAdelanto}</span>%] <span id="pagoAdelantado"></span></strong></div>
                                    </div>
                                    
                                </div>
                            {else}
                            
                            <div class="form-group row recomendaciones_container">
                                <div class="col-lg-12">
                                   <div class="padding-left-15 alert alert-info">
                                       <p>{#te_enviaremos_tu_reserva#}: <span id="enviaremos-email"></span></p>
                                       <input type="hidden" id="forma_pago" value="{$excursion->cobro->forma}">
                                       <hr class="double">
                                       <p>
                                           {if $excursion->restriccionesTpv->$lang}
                                                {$excursion->restriccionesTpv->$lang}
                                            {else}
                                                {$excursion->restriccionesTpv->es}
                                            {/if}
                                       </p>
                                       <hr class="double">
                                        <div class="content-right clearfix"><strong>{#total_de_reserva#} <span id="confirmar-total"></span></strong>
                                        </div>
                                   </div>
                               </div>
                            </div>
                            {/if}
                            <div class="form-group row">
                                <div class="col-lg-12">
                                   <div class="checkbox">
                                       <input type="checkbox" name="aceptoPoliticas" class="validate[required]">
                                       {#entiendo_acepto#} <a id="privacy_policies" href="javascript:void(0)">{#politicas_privacidad#}</a> {#y_las#} <a id="book_conditions" href="javascript:void(0)">{#condiciones_reserva#}</a>
                                   </div>

                                </div>
                            </div>    
                            <div class="credit-card-section">
                                <div class="form-group text-right">
                                    <a id="reset-reserva" class="btn btn-default" href="javascript:void(0)">{#cancelar#}</a>
                                    <input id="total_reservar_button" class="btn btn-warning" type="submit" name="" value="✓ Finalizar reserva" />
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="question-button-container clearfix">
                        <a id="btn-make-question" class="btn btn-default col-lg-12" href="javascript:void(0)">{#tienes_una_pregunta#}</a>
                    </div>

                    <div class="form-group clearfix" id="question-container">
                        <form id="make-question-form">
                            <div class="row contact-for-inner">
                                <input type="hidden" name="action" value="enviarPregunta">
                                <input type="hidden" name="eventoId" value="{$excursion->id}">
                                <div class="col-lg-12"><div class="form-group"><input class="validate[required]" type="text" name="name" x-webkit-speech placeholder="{#nombre#}"></div></div>
                                <div class="col-lg-12"><div class="form-group"><input class="validate[required, custom[email]]" type="text" name="email" placeholder="{#correo_electronico#}"></div></div>
                                <div class="col-lg-12"><div class="form-group"><textarea class="validate[required]" name="message" placeholder="{#mensaje#}"></textarea></div></div>
                                <div class="col-lg-3"></div>
                                <div class="col-lg-9"><a id="btn-make-question-close" class="btn btn-default " href="javascript:void(0)">{#cerrar#}</a>
                                <a id="btn-make-question-send" class="btn btn-warning" href="javascript:void(0)">{#enviar_pregunta#}</a></div>
                            </div>
                        </form>
                    </div>
                    {if $excursion->rating > -1}
                    <div id="opiniones">
                        {if $excursion->opiniones}
                        
                        <div>
                            <div class="header-opiniones">
                                <span>{#puntuacion#}</span>
                                <span class="puntuacion">{$excursion->puntuacion}</span>
                                <span class="evaluacion">
                                    {if $excursion->puntuacion >= 4.6}
                                        {#exelente#}
                                        {elseif $excursion->puntuacion >= 4 }
                                        {#muy_buena#}
                                        {elseif $excursion->puntuacion >= 3 }
                                        {#buena#}
                                        {elseif $excursion->puntuacion >= 2 }
                                        {#aceptable#}
                                        {else}
                                        {#mala#}
                                    {/if}
                                </span>
                            </div>
                            {foreach from=$excursion->opiniones item=opinion}
                            <div class="row">
                                <div class="puntuacion pull-left text-center">{$opinion->puntuacion}</div>
                                <div class="opinion_text pull-left">
                                {$opinion->opinion}
                                </div>
                            </div>

                            {/foreach}
                        </div>
                            {else}
                            <label>{#aun_no_cuenta_con_opiniones#}.</label>
                        {/if}
                        <div class="delimiter"></div>
                        <hr class="for_double">
                    </div>
                    
                    {/if}

                    <div id="mapa">
                        <div id="details-map-location"></div>
                        <div id="details-location" class="borderBoxBlue">
                            <span><strong>{#direccion#}: </strong>{$excursion->direccion->descripcion}</span><br/>
                            <span><strong>{#telefono#}: </strong>{$excursion->telefono}</span>
                        </div>
                    </div>
                    

                    {if $otraexcursion}
                    <div class="sugerencia col-lg-12">
                        <h5 class="card-message">Quiz&aacute; te pueda interesar</h5>
                        <div id="parthenon-slider-2" class="carousel slide">
                            <div class="carousel-inner detalle_carousel_inner">
                                {if $otraexcursion->imagenes}
                                {foreach name=loop_imagenes from=$otraexcursion->imagenes item=imagen}
                                <div class="item {if $smarty.foreach.loop_imagenes.first}active{/if}">
                                    <img src="{$imagen->ruta}" alt="Photo {$smarty.foreach.loop_imagenes.iteration}">
                                    <div class="carousel-caption">

                                    </div>
                                </div>
                                {/foreach}
                                {else}
                                    <div class="item active">
                                        <img src="{$template_url}/imagenes/slider1.jpg" alt="Photo 1">
                                        <div class="carousel-caption">

                                        </div>
                                    </div>
                                {/if}
                                
                            </div>
                            <div class="back-images layer-1"></div>
                            <div class="back-images layer-2"></div>

                            <a class="left carousel-control" href="#parthenon-slider-2" data-slide="prev">
                                <span class="icon-prev"></span>
                            </a>
                            <a class="right carousel-control" href="#parthenon-slider-2" data-slide="next">
                                <span class="icon-next"></span>
                            </a>
                        </div>
                        <div>
                            <div class="content-title">
                                
                                <h3>
                                    <i style="float:left;">{$otraexcursion->nombre}</i>
                                        {if $otraexcursion->rating > 0}
                                        <div class="excursion-rating" puntuacion="{$otraexcursion->rating}"></div>
                                        {/if}
                                        
                                        <br />
                                </h3>
                            </div>
                            <div id="descripcion-excursion">
                                <ul class="parthenon-caption">
                                    <li>
                                        <div class="icon-map-marker"></div>
                                        <strong>{#destino#}</strong> {$otraexcursion->direccion->descripcion}
                                    </li>

                                    <li>
                                        <div class="icon-tag"></div>
                                        <strong>{#precio#}</strong> {#a_partir_de#} <strong>{$otraexcursion->precio->precio|number_format:2:',':'.'}&euro;</strong>
                                    </li>
                                    {if !$otraexcursion->duracionIndefinida}
                                    <li>
                                        <div class="icon-time"></div>
                                        <strong>{#duracion#}</strong> {if $otraexcursion->dias eq 0}{$otraexcursion->duracion}hrs{else}{$otraexcursion->dias}días{/if}
                                    </li>
                                    {/if}
                                    <li>
                                        {if $otraexcursion->sinopsisCorta->$lang}
                                            {$otraexcursion->sinopsisCorta->$lang}
                                        {else}
                                            {$otraexcursion->sinopsisCorta->es}
                                        {/if}
                                    </li>
                                </ul>                    
                            </div>
                        </div>
                        <div>
                            <a href="{$base_url}/detalle/id:{$otraexcursion->id}/{$otraexcursion->tituloSeo}" class="btn btn-warning" >¡Lo quiero!</a>
                        </div>
                    </div>
                    {/if}
                </div>
            </div>
        </div>
        <div class="col-lg-12 form_container_main">
        
        <div class="col-lg-4">
                   
        </div>
        
       <div class="col-lg-6" style="display:none;">
            {foreach from=$excursion->tarifas item=tarifa}
            <table class="table-bordered table-accomodation">
                <thead>
                    <tr>
                        <th>{$tarifa->nombre}</th>
                        <th>Horarios</th>
                        <th>Servicios</th>
                        <th>Cupo</th>
                        <th>Precio</th>
                        <th>Descuento</th>
                        <th>Total</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td rowspan="{count($tarifa->zonas)}" class="fechasTarifas" tarifa-id="{$tarifa->id}">
                            {foreach name=fechas from=$tarifa->fechas item=fecha}
                                {if !$smarty.foreach.fechas.first}, {/if}{$fecha->fecha|date_format:"%e/%m/%Y"}
                            {/foreach}
                        </td>
                        <td rowspan="{count($tarifa->zonas)}" class="sesionesTarifas" tarifa-id="{$tarifa->id}">
                            {foreach name=sesiones from=$tarifa->sesiones item=sesion}
                                {if !$smarty.foreach.sesiones.first}, {/if}{$sesion->hora|date_format:"%H:%M"}
                            {/foreach}
                        </td>
                        {foreach name=filas from=$tarifa->zonas item=zona}
                        {if !$smarty.foreach.filas.first}
                            <tr>
                        {/if}
                        <td>{$zona->entrada->nombre}</td>
                        <td>{$zona->entradas}</td>
                        <td>&euro; {$zona->precio|number_format:2:',':'.'}&euro;</td>
                        <td>{$zona->descuento} {$zona->descuentoTipo}</td>
                        <td class="total">{$zona->total|number_format:2:',':'.'}&euro;</td>
                        
                        </tr>
                        {/foreach}
                        
                    </tr>
                </tbody>
            </table>
            <hr class="space">
            {/foreach}
        </div>
        </div>
    </div>    
</div>

<div class="container content space-between-rows">
    <div class="row"></div>
</div>

<form name="compra" id="caixa_pago_form" action="https://sis-t.redsys.es:25443/sis/realizarPago" method="POST" target="tpv">
    <!--Empieza caixa pago-->
    <input type="hidden" class="amount" name="Ds_Merchant_Amount" value='0'>
    <input type="hidden" name="Ds_Merchant_Currency" value='978'>
    <input type="hidden" class="order" name="Ds_Merchant_Order"  value='2'>
    <input type="hidden" name="Ds_Merchant_MerchantCode" value='329490981'>
    <input type="hidden" name="Ds_Merchant_MerchantName" value='www.fuertetour.com'>
    <input type="hidden" name="Ds_Merchant_ProductDescription" value='{$excursion->nombre}'>
    <input type="hidden" name="Ds_Merchant_Terminal" value='1'>
    <input type="hidden" name="Ds_Merchant_TransactionType" value='0'>
    <!--<input type="hidden" name="Ds_Merchant_MerchantURL" value=''>-->
    <input type="hidden" class="signature" name="Ds_Merchant_MerchantSignature" value="">
    <!--Termina caixa pago-->
</form>

<div class="modal fade" id="privacy_policies_modal">
    <div class="modal-dialog">
        <div class="modal-content">
             <div class="modal-header">
                 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                 <h4 class="modal-title">Pol&iacute;ticas de privacidad</h4>
            </div>
            <div class="modal-body">
<div style="overflow-y: auto; max-height: 400px">
    <p><b>Nuestro compromiso por cumplir la Ley</b></p>
    <p>
        Esta Política de Privacidad únicamente afecta a aquellos datos que aportes a vikatickets.com, bien a través de los formularios, bien a través de cualquier otro medio a tu disposición. Al aceptar esta Política de Privacidad, das tu consentimiento para que vikatickets.com trate tus datos personales para los fines que se indican a continuación.
    </p>
    
    <p><b>¿Qué información recopilaremos?</b></p>
    <p>
        Al realizar una reserva, te pediremos datos personales identificativos (nombre, apellido, dirección...) así como en su caso, el medio de pago para realizar la reserva, por lo que podríamos solicitar tus datos de tarjeta bancaria para gestionar los pagos. También puedes aportarnos datos a través de encuestas y formularios en la web.
        <br>
        Además, por el uso que hagas de vikatickets.com podrás ir aportando diversa información personal, incluido (sin carácter excluyente) comentarios, tus gustos y preferencias a la hora de realizar reservas, etc.
        <br>
        El Usuario se compromete a facilitar sus datos de forma veraz y real en los procesos de reserva establecidos en la Página.
    </p>
    
    <p><b>¿Para qué utilizaremos tus datos?</b></p>
    <p>
        Cuando sea información aportada directamente por ti, la utilizaremos para realizar nuestros servicios: gestionar tu reserva y contestar a las dudas y preguntas que nos formules, permitir la utilización de servicios de comentarios, etc. 
        <br>
        Cuando se obtenga información automáticamente por tu uso de la Página, la utilizaremos para elaborar estadísticas y, en caso de usar esas estadísticas, disociaremos en todo caso tus datos. Es decir, que la información no hará referencia ti nunca. Estas estadísticas las utilizaremos para mejorar los servicios de vikatickets.com ofreciéndote un servicio más personalizado, así como para ofrecer información segmentada a nuestros asociados y también para mejorar la publicidad que recibas.
        <br>
        También utilizaremos tus datos, siempre que nos lo hayas permitido de forma previa, para enviarte ofertas relacionadas con los servicios de vikatickets.com, especialmente por correo electrónico. Estas comunicaciones pueden incluir publicidad de terceros ajenos a vikatickets.com, pero estarán relacionados con los servicios que ofrecemos (venta de productos similares, organización de ferias o eventos relacionados, etc). En caso de que no desees recibir comunicaciones comerciales de este tipo cuando efectúes una reserva podrás marcar la casilla de no recibir publicidad, escríbenos a info@vikatickets.com o haz clic en el botón habilitado para ello en los correos que recibas.
    </p>
    
    <p><b>Comunicación de tus datos a terceros</b></p>
    <p>
        Para la consecución de la prestación del servicio de reserva de entradas, ten en cuenta que será necesario comunicar tus datos al Promotor o a las empresas que gestione el evento, para la correcta gestión de la reserva. Esta comunicación es necesaria para la prestación del servicio. 
        En cualquier caso, los datos comunicados serán los imprescindibles para esta gestión. 
        <br>
        Fuera de estos casos, no comunicaremos tus datos personales a terceros sin tu consentimiento. 
    </p>
    
    <p><b>Seguridad de los datos</b></p>
    <p>
        Toda la parte de reserva en vikatickets.com estará protegida mediante un protocolo de seguridad SSL, para que tus datos y tus fotos estén seguras. De esta forma evitamos que terceras personas puedan acceder a ellos, pues ponemos todos los esfuerzos razonables para ello.
    </p>
    
    <p><b>Cookies</b></p>
    <p>
        vikatickets.com puede disponer de tecnología para la implantación de archivos denominados "cookies" en el equipo que utilices para acceder. Las cookies que se emplean únicamente son técnicas y se utilizarán para que el usuario, cada vez que haga clic en un enlace, no tenga que introducir de nuevo la contraseña. Además, cuando el usuario cierra el navegador, la cookie se borrará.
        <br>
        Puedes desactivar la instalación de estas cookies a través de las opciones de configuración de tu navegador. También puedes borrar las cookies una vez hayas terminado de usar vikatickets.com. 
        <br>
        vikatickets.com también puede emplear otros mecanismos informáticos de obtención de información de navegación para la comprobación del tráfico y las estadísticas. A través de ellos sólo se obtendrían datos de tráfico, nunca tus datos personales.
    </p>
    
    <p><b>Tus derechos</b></p>
    <p>
        Puedes ejercer tus derechos de acceso, rectificación, cancelación y oposición según la ley enviándonos una petición escrita a Booking DeTeatros S.L. Urbanización las Margaritas 43, 35660 Corralejo, (Fuerteventura-España), o a info@vikatickets.com.  Tienes que acompañar una fotocopia de tu DNI u otro documento oficial que te identifique, pues por seguridad, tenemos que comprobar que eres tú para no dar tus datos a otra persona.
    </p>
    
    <p><b>Idioma</b></p>
    <p>
        El idioma aplicable a esta Política de Privacidad es el español. Si se te han ofrecido versiones de esta Política de Privacidad en otros idiomas, ha sido para tu comodidad y aceptas expresamente que las mismas se regirán siempre por la versión en español.
        <br>
        Si hay alguna contradicción entre lo que dice la versión en español de esta Política de Privacidad y lo que dice la traducción, en todo caso prevalecerá la versión en español.
    </p>
    
    <p><b>Dudas y consultas</b></p>
    <p>
        Por supuesto, si tienes dudas o consultas sobre la protección de tus datos en vikatickets.com, podrás enviarnos un email a info@vikatickets.com. Trataremos de solucionarte lo antes posible tus dudas.
    </p>
    </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>
        
<div class="modal fade" id="book_conditions_modal">
    <div class="modal-dialog">
        <div class="modal-content">
             <div class="modal-header">
                 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                 <h4 class="modal-title">Condiciones de reserva</h4>
            </div>
            <div class="modal-body">
        <div style="overflow-y: auto; max-height: 400px">
        <p><b>Condiciones generales de compra</b></p><p></p><p><b>3. Obligaciones del usuario</b></p><p>Como Usuario, por la mera visita o navegación por la web, debes:
                   - Utilizar la Página y sus servicios y funcionalidades respetando la legislación aplicable (en especial las de propiedad intelectual e industrial y las leyes de protección de datos de carácter personal), así como la moral y buenas costumbres generalmente aceptadas, el orden público y las presentes Condiciones Generales de Uso.
                   - Utilizar la Página de una forma diligente, correcta y lícita.
                   - Si hacemos cambios en estas Condiciones Generales de Uso o en la Política de Privacidad, revísalos: pueden ser importantes.
                   - En su caso, revisa también las notificaciones que te enviemos, pueden contener información importante.
               Asimismo, como usuario, te comprometes a respetar vikatickets.com y cumplir con las siguientes condiciones:
                - No incumplir estas Condiciones Generales de Uso ni ninguna de sus condiciones ni de las obligaciones asumidas en ellas.
                - No infringir ningún derecho o interés de vikatickets.com ni de terceros, tales como derechos de propiedad intelectual o industrial (patentes, marcas, secretos comerciales, derechos de copyright u otros derechos  de nuestra propiedad).
                - No utilizar la Página para recabar información y contenidos para prestar cualquier servicio que, a criterio de vikatickets.com, le correspondan o compitan con el mismo.
                - No introducir por cualquier medio virus informáticos, gusanos, troyanos o cualquier otra clase de códigos maliciosos dirigidos a interrumpir, destruir o limitar la funcionalidad de vikatickets.com.
                - No utilizar técnicas de ingeniería inversa y/o descompilar o descifrar o utilizar cualquier otro sistema para conocer el código fuente de la Página o de cualquier elemento sujeto a copyright o propiedad intelectual subyacente.
                - No modificar la Página de ninguna forma o manera posible.
                - No dañar, deshabilitar, sobrecargar o dificultar el servicio (o la red o las redes conectadas al servicio), o interferir en el uso y disfrute del servicio por parte de cualquier usuario.
                - No realizar acciones o utilizar medios para simular la apariencia o función de vikatickets.com con cualquier finalidad</p><p><b>9. Legislación y fuero</b></p><p>Las relaciones entre vikatickets.com con los Usuarios de sus servicios telemáticos, presentes en la web, se encuentran sometidas a la legislación española. Las partes, con renuncia expresa a cualquier fuero que pudiera corresponderles, se someten a la jurisdicción de los Juzgados y Tribunales de Madrid.</p><p><b>1. Identificación de las Partes. Objeto y Duración</b></p><p>Las presentes Condiciones de Contratación, son suscritas:
De una parte por Booking DeTeatros S.L., (en adelante vikatickets.com), con domicilio social en Urbanización las Margaritas 43, 35660 Corralejo, (Fuerteventura-España) y CIF B76153725, registrado en el Registro Mercantil de Las Palmas, Tomo 159, Folio 84, Sección 8, H IFolio 7103, I/A 1ª, titular de la Página Web http://www.vikatickets.com, (en adelante, la Página), 
De otra parte, por el Promotor, entendido como toda persona física o jurídica dedicada a la organización de espectáculos artísticos o actividades escénicas, como teatro, cine, danza, conciertos, etc., que se registre en la Página con el fin de establecer una relación con vikatickets.com para la intermediación y promoción por parte de éste de entradas y reservas de entradas para los eventos o espectáculos del Promotor a través de Internet, así como la puesta a disposición del Promotor de herramientas de compra de entradas a través de Internet.
El Promotor, al marcar la casilla de verificación del consentimiento correspondiente a estas Condiciones Generales declara conocer las características esenciales de la Página y las presentes Condiciones Particulares y someterse a las mismas, sin perjuicio de la aplicación de otras condiciones particulares vigentes entre las partes. 
vikatickets.com pone a disposición del Promotor un servicio de atención de consultas a través del correo electrónico info@vikatickets.com por el que el usuario podrá solicitar información. 
El Promotor contrata los servicios de vikatickets.com con duración indefinida. Las Partes podrán resolver el Contrato en cualquier momento, y acuerdan comunicar tal voluntad con la antelación de un (1) mes, en consonancia con la buena fe contractual.
</p><p><b>2. Qué es vikatickets.com (desplegable)</b></p><p>El principal servicio de vikatickets.com es la intermediación del Promotor con los Usuarios de Internet, ofreciendo a éstos un sistema de contratación de entradas o reservas de entradas por Internet fácil y sencillo. Además, vikatickets.com ofrece al Promotor una herramienta de control y gestión de eventos y espectáculos, una fórmula para promocionar adecuadamente sus servicios y una central de reservas para los casos en los que el usuario o comprador quiera adquirir entradas a través de medios telefónicos o telemáticos al propio Promotor.
De forma general, vikatickets.com permite a los Teatros:
a) Añadir y suprimir eventos que vayan a celebrarse en cada recinto cuya cuenta gestione el Promotor y cuyas entradas éste puede poner a disposición del público a través de vikatickets.com. 
b) Esto se hace de manera muy sencilla a través de la sección “Panel de control” que, además,  permite introducir todo tipo de datos relativos a los eventos (nombre, precio/s y tarifas, fechas, género, artistas que intervienen, formato, sinopsis...), fotografías y enlaces a vídeos, imágenes y redes sociales así como, si la hubiera.
c) A medida que los usuarios de vikatickets.com vayan reservando entradas, desde el Panel de Control el Promotor puede obtener información de las reservas (datos personales del usuario que efectúe la reserva, evento, localizador, butaca/s, fecha, forma de pago elegida...) y aprobar o denegar las mismas. 
d) Es importante ofrecer al público información acerca del recinto y de las obras o espectáculos por lo que, también desde el Panel de Control, el Promotor cuenta con secciones destinadas a tal efecto: dirección, formas y medios de contacto, descripción, condiciones de compra, imágenes, datos sobre las salas...).
e) Además, el Promotor, podrá establecer Condiciones Particulares para la venta o reserva de entradas para sus eventos o espectáculos.
f) Gestionar la venta de entradas o reservas a través de un TPV virtual de forma que el Promotor pueda cobrar y controlar las ventas de sus entradas a través de Internet de forma fácil y segura. 
g) vikatickets.com cuenta, además, con una herramienta que te permite ver la facturación de cada evento o espectáculo.
</p><p><b>3. Obligaciones del Promotor (desplegable)</b></p><p>3.1. Para contratarse con vikatickets.com, el Promotor debe registrarse en la Página a través de un formulario de contacto. vikatickets.com, verificará los datos y enviará un correo electrónico informando al Promotor de cómo completar el proceso de contratación.
3.2. Es requisito para poder Registrarse en vikatickets.com:
a) Estar autorizado para representar y comprometerse tanto sí mismo como a la sociedad a la que represente.
b) La exactitud y veracidad de todos los datos aportados.
c) Tener cocimiento de la finalidad y uso de la Página así como de la plataforma de control de reservas y control de información, (en adelante la Plataforma).
d) Tener capacidad legal y de obrar para obligarse según estas Condiciones. 
3.3. Aceptando estas Condiciones Generales de Contratación, reconoces que cumples las anteriores condiciones y que eres el único responsable de las consecuencias derivadas de no cumplirlas.
3.4. El Promotor se obliga a pagar a vikatickets.com las comisiones correspondientes por las labores de promoción e intermediación de la venta o reserva de entradas y por la utilización de la Plataforma.
3.5. El Promotor se compromete a ofrecer a vikatickets.com, a efecto de su uso en la Página, unas tarifas iguales o mejores a las que ofrezca directamente, o ponga a disposición de otros intermediarios o de cualquier tercero, incluidas empresas pertenecientes a su mismo grupo
3.6. El Promotor se obliga a incorporar a sus propios procedimientos de reserva y venta de entradas, la gestión de las entradas o reservas contratadas por los Usuarios de Internet a través de vikatickets.com.
3.7. Asimismo, el Promotor se obliga a prestar los servicios que le sean contratados por los Usuarios de Internet a través de vikatickets.com. En caso de que, por cualquier causa, no pueda cumplir con estas obligaciones, lo pondrá de inmediato en conocimiento de vikatickets.com, y realizará los esfuerzos que resulten razonables para procurar a los usuarios servicios alternativos, de calidad igual o superior a los reservados.
A todos los efectos, la recepción de la reserva por el Promotor vinculará a éste tanto en lo relativo a precios y condiciones como en el resto de condiciones legales o contractuales con el Comprador, no teniendo vikatickets.com ninguna responsabilidad.
3.8. En caso de cambios o cancelaciones en los eventos o espectáculos ofertados, el Promotor se obliga a comunicar a los Compradores estos cambios o cancelaciones. También podrá comunicarlos a vikatickets.com para que, como intermediario, realice la comunicación a los Compradores. No obstante, vikatickets.com, no será responsable de estos cambios o cancelaciones ni de los daños y perjuicios que se deriven de los mismos para el Promotor. 
3.9. El Promotor a los efectos de este Contrato, se compromete, además a:
a) No utilizar o intentar utilizar la cuenta de otro Establecimiento sin autorización.
b) Ser el único responsable de todas las actividades que se realicen desde tu cuenta de Establecimiento.
c) Velar para que tus datos de acceso sean confidenciales. Serás responsable de cualquier daño que sufras tú o terceros por incumplir estas Condiciones Generales de Contratación.
d) También eres responsable de lo que suceda en tu cuenta de Promotor de vikatickets.com mientras no la canceles o demuestres que la seguridad de la misma se ha visto comprometida por causas ajenas a ti. En especial deberás:
?   Mantener tu cuenta actualizada.
?   Mantener tu contraseña de forma confidencial.
?   Controlar quién utiliza la cuenta, conforme a la cláusula de confidencialidad.
?   No vender, comercializar o transferir tu cuenta a un tercero.
?   No utilizar las cuentas de terceros sin su consentimiento.
?   Facilitar datos reales mediante tu cuenta de Promotor en vikatickets.com. Eres el único responsable de hacerlo y eximes a vikatickets.com de cualquier responsabilidad derivada de  ello.   
e) En particular, sobre los contenidos que publiques y compartas, asumes y te obligas a:
?   Facilitar la información necesaria de manera exacta, completa y actualizada y, en especial, la relativa a disponibilidad, tarifas, ofertas y condiciones de reserva que sean publicadas en la Página.
?   No publicar contenido ilegal, inapropiado, inexacto, injurioso, discriminatorio u ofensivo. Por supuesto, no acosar, abusar o dañar a otra persona o Establecimiento a través de vikatickets.com.
?   No incluir ningún tipo de publicidad o realizar acciones de marketing directo a otros usuarios o terceros para cualquier fin.
?   Publicar contenidos adecuados y que no vulneren ningún tipo de cuestión contenida en estas Condiciones Generales de Contratación. En tal sentido asumes que vikatickets.com puede no controlar ni aprobar el contenido que publiques o proporciones a través de la Página y, en consecuencia, no se responsabiliza por la misma.
f) El Promotor será en todo caso responsable de lo que publique y comparta así como de las consecuencias que de ello se deriven. En especial, será responsable de las violaciones de derechos de propiedad intelectual o industrial que infrinja con ocasión de las funciones y servicios disponibles en su cuenta de Promotor en vikatickets.com. 
g) Toda vez que detectemos o seamos informados de cualquier hecho que pueda ser contrario a lo establecido en este apartado, nos facultará para bloquear el acceso a la Página o Plataforma y retirar contenidos de la cuenta de Promotor sin derecho a indemnización alguna.
h) El Establecimiento se abstendrá de remitir comunicaciones comerciales, por cualquier medio, a los clientes que reciba a través de vikatickets.com o de la Plataforma.
i) Permitir a vikatickets.com realizar campañas publicitarias u otras acciones promocionales en espacios diferentes de la Página para ofrecer mayor visibilidad a las ofertas y servicios de la Página. 
El coste de las acciones previstas en el párrafo anterior será, salvo acuerdo entre las Partes, por cuenta de vikatickets.com, excepto que el presente contrato sea resuelto por el Promotor o finalice por cualquier causa imputable a éste, dentro del período de desarrollo de una campaña publicitaria o acción promocional. En tal caso, el Promotor deberá abonar a vikatickets.com el coste íntegro de la referida campaña o acción.
</p><p><b>4. Obligaciones de vikatickets.com (desplegable)</b></p><p>vikatickets.com se obliga a:
a) vikatickets.com gestionará la información y promoverá, conforme a su leal saber y entender, los servicios del Promotor en la Página y, de esta forma, los Usuarios de la misma puedan contratar los servicios del Promotor.
b) Ofrecer los servicios de vikatickets.com descritos y velar porque los mismos sean duraderos en el tiempo, así como mejorarlos y expandirlos, de tal forma que el Promotor pueda acceder en cada momento, tal y como se muestre  la Página y la Plataforma y según su disponibilidad y limitaciones.
c) Ofrecer un sistema de TPV virtual (pasarela de pago) segura, habida cuenta el estado de la tecnología, aplicando los sistemas adecuados para la protección de la información de los Compradores.
d) Velar porque el sistema de contratación por el que los Usuarios de Internet pueden adquirir entradas o reservar entradas para eventos o espectáculos de los Pomotores se ajuste a la legalidad vigente.
e) Asimismo, se obliga a ofrecer al Usuario de Internet y Comprador, la información adecuada para la compra, entre ella, los precios y condiciones generales aplicables.
f) También se obliga a informar de aquellas Condiciones Particulares que el Promotor quiera aplicar a cada uno de sus eventos, etc. Para ello, vikatickets.com ha creado una herramienta en la Plataforma para que el Promotor pueda crear estas condiciones y puedan ser introducidas automáticamente en la Página.
</p><p><b>5. Condiciones económicas (desplegable)</b></p><p>vikatickets.com, por su labor de intermediación y promoción de la venta de entradas y reservas a través de la Página, así como por la puesta a disposición de la Plataforma a disposición del Promotor, percibirá como contraprestación una comisión variable según el evento a promocionar, la cual se estipula en el alta del evento.
En caso de no estipular una comisión determinada, se aplica una comisión por defecto del 10%. 

Los anteriores porcentajes se liquidarán mensualmente, para la determinación de los mismos, vikatickets.com utilizará los datos de reservas y compras efectuados a través de su Página y TPV virtual.
</p><p><b>6. Exclusión de responsabilidad (desplegable)</b></p><p>6.1. vikatickets.com no tiene más obligación que lo contenido en estas Condiciones Generales de Contratación. No obstante, pueden existir otras condiciones legales especiales, en cuyo caso, también sean de aplicación.
6.2. vikatickets.com no será en ningún caso responsables de cómo el Promotor utilice la Página ni la Plataforma, de cómo se relacione con los Compradores, ni de cualquier eventualidad que acontezca en los recintos o durante los espectáculos relacionada con los Compradores de las entradas a través de vikatickets.com.
6.3. El vikatickets.com, en lo referente a los servicios ofrecidos en la Página, se configura como un mero intermediador entre el Promotor que vende y reserva entradas para espectáculos y eventos y el usuario de Internet como Comprador o adquirente de las mismas. En tal sentido, no será responsable por la información facilitada por el Promotor, ni por las reclamaciones de ningún tipo efectuadas por los Compradores respecto a los bienes o servicios del Promotor adquiridos a través de la Página.
En tal sentido, la información que aparece en vikatickets.com es publicada por los Promotores, por lo que, conforme al artículo 16 de la Ley 34/2004, de 11 de julio, de servicios de la sociedad de la información y del comercio electrónico, vikatickets.com se configura a los efectos de prestar este servicio como un prestador de servicios de alojamiento o almacenamiento de datos. En consecuencia, no se hace responsable de la ilegalidad, falsedad o inexactitud de los contenidos publicados por sus Teatros dado que el servicio opera de forma automática. En particular, no se hace responsable por infracciones de derechos de propiedad intelectual, industrial o de imagen. Si crees que algún contenido no es conforme con la Ley o que existen errores, por favor comunícanoslo a info@vikatickets.com.
6.4. El Promotor asumirá cualquier reclamación que reciba el vikatickets.com, manteniéndole indemne de toda responsabilidad o gasto que se pudiere generar, por cualesquiera de las siguientes causas:
a. Las derivadas de cualquier inexactitud, error u omisión en relación con la información facilitada por el Promotor;
b. Las relacionadas con la propiedad intelectual o industrial de la información, documentación o contenidos literarios, gráficos, audiovisuales o de cualquier tipo facilitados por el Promotor para su incorporación a la Página;
c. Las ocasionadas con motivo de la carencia, por parte del Promotor, de los permisos, autorizaciones o licencias oficiales necesarios para el desarrollo de la actividad de alojamiento turístico.
d. Las relacionadas con la prestación de los servicios reservados por los usuarios o el incumplimiento de las condiciones contratadas con los mismos; o
e. Las ocasionadas por la cancelación unilateral de reservas por el Promotor.
6.5. vikatickets.com no será responsable de los actos u omisiones de los Usuarios que reserven los servicios de Promotor a través de la Página, incluyendo expresamente el denominado “no-show” y las cantidades debidas formal y definitivamente no pagadas por aquéllos.
6.6. El Promotor garantiza que desarrollará las obligaciones asumidas en las presentes Condiciones conforme a la buena fe y con lealtad para con vikatickets.com.
6.7. Las partes acuerdan que la responsabilidad que asume vikatickets.com frente al Promotor, derivada del presente contrato, en ningún caso incluye el lucro cesante y se limitará, en cualquier caso, como máximo y por cualquier concepto, al importe total percibido por vikatickets.com del Promotor en concepto de honorarios por la prestación de los servicios objeto del presente contrato.
6.8. vikatickets.com no garantiza la absoluta continuidad del servicio o la ausencia de virus informáticos en los servicios prestados a través de su red, que puedan producir alteraciones en los programas o documentos almacenados en sus sistemas de información, si bien llevará a cabo los mejores esfuerzos para evitar que se produzcan estas circunstancias. Dado que el servicio es gratuito, y vikatickets.com únicamente cobra comisiones por las efectivas ventas de reservas o entradas a través de la Página, no será responsable ni indemnizará al Promotor por la falta de servicio de la Página.
</p><p><b>7. Propiedad intelectual e industrial (desplegable</b></p><p>Los derechos de propiedad intelectual del contenido de las páginas web, su diseño gráfico y códigos son de vikatickets.com en exclusiva o cuenta con los oportunos derechos y/o autorizaciones para su publicación en la Página y, por tanto, queda prohibida su reproducción, distribución, comunicación pública, transformación o cualquier otra actividad que se pueda realizar con los contenidos de sus páginas web ni aún citando las fuentes, salvo consentimiento por escrito de vikatickets.com o del titular en exclusiva del derecho.
El Establecimiento, como titular de los derechos de propiedad intelectual o de una autorización bastante sobre la información, documentación o contenidos literarios, gráficos, audiovisuales o de cualquier tipo que proporcione a vikatickets.com para su publicación en la Página, concede a éste una licencia sobre los contenidos (i) de forma no exclusiva, pero con el carácter de transferible a terceros, (ii) por el tiempo de vigencia del presente contrato y (iii) sin límite territorial, y por tanto para todos los territorios del mundo. La licencia incluye la reproducción, distribución, comunicación pública y transformación de dichos contenidos, siempre que su uso esté relacionado con la actividad de intermediación y promoción de la venta de entradas y reservas para los espectáculos del Promotor, o con la promoción de la misma.
Todos los nombres comerciales, marcas o signos distintivos de cualquier clase contenidos en la Página y todas sus secciones son propiedad de sus dueños o titulares legítimos y están protegidos por ley.
El Promotor autoriza expresamente a vikatickets.com para que éste utilice las marcas y logos de aquél en la Página, si bien únicamente en relación con el objeto de las presentes Condiciones.
El Promotor autoriza expresamente a vikatickets.com a recabar, de su propio sitio web o de sitios web de terceros, aquellos datos que sean precisos para completar la información del Promotor en la Página, licenciándole en los términos previstos en el párrafo anterior.
El Promotor es responsable de la obtención de cualesquiera derechos o autorizaciones que fuesen necesarios, así como el cumplimiento de cualquier obligación, sobre los derechos de propiedad intelectual o industrial de terceros que pudieran afectar a la información que facilite a vikatickets.com para su incorporación a la Página, y sobre la que vikatickets.com no realizará ningún tipo de control previo. vikatickets.com no se hace responsable de las infracciones de propiedad intelectual e industrial derivadas de la actividad de sus Promotor conforme queda recogido en la cláusula 11. Si crees que tu derecho de propiedad intelectual o industrial ha sido infringido o que un contenido no es conforme con la Ley, por favor comunícanoslo a: info@vikatickets.com.
</p><p><b>8. Protección de datos (desplegable)</b></p><p>vikatickets.com será responsable del fichero, conforme a la Ley Orgánica de Protección de Datos (LOPD), respecto de aquella información personal que puedan recibir en virtud de las presentes Condiciones. En este sentido, cuando un usuario realice una reserva a través de la Página se le informará de que está facilitando sus datos a vikatickets.com, y que ésta se los comunicará al Promotor para la prestación del servicio o efectuar la compra.
vikatickets.com cederá los datos de cada reserva al Promotor para la única la finalidad de la gestión y prestación de los servicios reservados. En tal caso, el Promotor será a los efectos de la legislación de protección de datos responsable de los ficheros de datos personales de los compradores.
Ambas Partes se comprometen a observar estrictamente las obligaciones y deberes que les incumben con arreglo a lo estipulado en la presente cláusula, así como en la legislación vigente en materia de protección de datos, así como a comunicar y hacer cumplir estrictamente dichas obligaciones y deberes al personal a su servicio, reconociendo expresamente que los datos incorporados al fichero son o pueden ser de nivel básico.
</p><p><b>9. Miscelánea (desplegable)</b></p><p>9.1. Modificaciones
vikatickets.com se reserva el derecho de modificar, eliminar o alterar en cualquier momento los servicios ofrecidos a través de la la Página, sean propios o de terceros.
9.2. Cualquier incumplimiento de estas Condiciones por parte del Promotor, podría suponer para nosotros daños y perjuicios. De tal forma, si por incumplimientos del Promotor sufriéramos daños, perjuicios, cualquier tipo de pérdidas y costes (como pueden ser los honorarios de abogados y procuradores), aquél estará obligado a resarcirnos. 
Asimismo, si por los incumplimientos del Promotor se generaran cualquier tipo de reclamaciones o procedimientos contra nosotros, el Establecimiento dejará indemne a vikatickets.com, pudiendo reclamarle cualquier gasto, coste, daño o perjuicio derivado de sus acciones.
9.3. Las comunicaciones entre las Partes relativas al Contrato se realizarán por escrito, mediante cualquier medio que permita acreditar su recepción y contenido a las direcciones de correo electrónico comunicadas por cada una de las partes
9.4. Salvaguarda e interpretación de las Condiciones Generales
vikatickets.com y el Promotor son, en todo caso, partes contractuales independientes. En ningún caso el presente Contrato supone la creación de vínculo alguno entre las partes más que el derivado del estricto contenido del mismo, sin que en virtud de sus cláusulas se cree o se establezca relación alguna de agencia, laboral, de franquicia, Joint venture, sociedad o se confiera representación legal a una parte para actuar en nombre de la otra.
Las totalidad de las presentes Condiciones Generales de Contratación constituyen un acuerdo único entre el Promotor de vikatickets.com. Cualquier contrato posterior entre las Partes para idéntico objeto complementará las presentes Condiciones y, en caso de contradicción, se dará preferencia a aquél. 
Si cualquier disposición de las Condiciones fuera considerada ilegal, inválida o no ejecutable según la disposición de la Autoridad competente, la misma podrá ser modificada o interpretada de otra manera del modo en que pueda ser ejecutable y, al mismo tiempo, efectiva del modo más próximo posible a la intención original de la disposición.
Cualquier referencia realizada en las presentes Condiciones a un artículo o cuerpo normativo que resulte derogado se entenderá realizada a la disposición equivalente que lo sustituya.
La no exigencia del cumplimiento estricto de alguno de los términos de estas Condiciones, no supone ni puede interpretarse como una renuncia por nuestra parte a exigir su cumplimiento en sus estrictos términos en el futuro.
La declaración de nulidad de alguna o algunas de las cláusulas establecidas en las presentes Condiciones por la Autoridad competente no perjudicará la validez de las restantes. En este caso, las partes contratantes se comprometen a negociar una nueva cláusula en sustitución de la anulada con la mayor identidad posible con la misma. Si la sustitución deviniese imposible y la cláusula fuese esencial para las Condiciones, a juicio de la parte perjudicada por su eliminación, ésta podrá optar por la resolución del contrato.
9.5. Legislación y fuero
Las relaciones entre vikatickets.com con los usuarios Registrados de sus servicios telemáticos, presentes en la web, se encuentran sometidas a la legislación y jurisdicción españolas.
Como regla general, para la resolución de conflictos relativos a las Condiciones, vikatickets.com y el el usuario registrado, con renuncia expresa a cualquier otro fuero, se someten a la jurisdicción de los Juzgados y Tribunales de la residencia habitual del usuario. No obstante, en el caso de que éste tenga su domicilio fuera de España, vikatickets.com y el usuario registrado se someten, con renuncia expresa a cualquier otro fuero, a los juzgados y tribunales de Madrid.
En caso de que el contrato se haya celebrado entre vikatickets.com y una empresa o profesional, se someterán, con renuncia expresa a cualquier otro fuero, a la jurisdicción que corresponda conforme a la Ley 34/2002, de 11 de julio, de Servicios de la Sociedad de la Información y de Comercio Electrónico. 
</p><p><b>7. Salvaguarda e interpretación de las Condiciones</b></p><p>Las presentes Condiciones Generales de Uso y todas sus Condiciones Particulares de Registro constituyen un acuerdo único entre tú, como usuario, y nosotros como titulares de vikatickets.com.
Si cualquier disposición de las Condiciones fuera considerada ilegal, inválida o no ejecutable según la disposición de la Autoridad competente, la misma será modificada de modo que se pueda interpretar como ejecutable y efectiva del modo más próximo posible a la intención original de la disposición.
La no exigencia del cumplimiento estricto de alguno de los términos de estas Condiciones, no supone ni puede interpretarse como una renuncia por nuestra parte a exigir su cumplimiento en sus estrictos términos en el futuro.
La declaración de nulidad de alguna o algunas de las cláusulas establecidas en las presentes Condiciones Generales de Uso por la Autoridad competente no perjudicará la validez de las restantes.
</p>
    </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var EVALUACIONES = [
        '{#mala#}','{#aceptable#}','{#buena#}','{#muy_buena#}','{#exelente#}'
    ]
</script>
            
{/block}