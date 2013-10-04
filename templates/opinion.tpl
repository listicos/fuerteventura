{extends file="index.tpl"}


{block name="style" append}
    <link href="{$template_url}/css/detalle.css" rel="stylesheet">
{/block}

{block name="script" append}
    <script src="http://maps.googleapis.com/maps/api/js?sensor=false&amp;libraries=places"></script>
    <script type="text/javascript" src="{$template_url}/js/jquery.raty.min.js"></script>
    <script type="text/javascript" src="{$template_url}/js/home.js"></script> 
    <script type="text/javascript" src="{$template_url}/js/opinion.js"></script> 
{/block}

{block name="content" append}
<div class="container content home fullWhite" style="background-color: #fff;">
    <div class="row">
        <div class="col-lg-12 mrg-btn-20">
            <div class="row-fluid">
                <div class="clearfix"> 
                    <ol class="breadcrumb pull-left">
                      <li><a href="{$base_url}">{#inicio#}</a></li>
                      <li class="active">{#opinion#}</li>
                    </ol>
                    <div class="social-links pull-right">
                        <span class='st_facebook_large' displayText='Facebook'></span>
                        <span class='st_googleplus_large' displayText='Google +'></span>
                        <span class='st_twitter_large' displayText='Tweet'></span>
                        <span class='st_linkedin_large' displayText='LinkedIn'></span>
                        <span class='st_pinterest_large' displayText='Pinterest'></span>
                        <span class='st_sharethis_large' displayText='ShareThis'></span>                                            
                    </div>
                     <hr class="for_double">
                </div>
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
                            
                            <h3>
                                <i style="float:left;">{$excursion->nombre}</i>
                                    {if $excursion->rating > 0}
                                        <div class="excursion-rating" puntuacion="{$excursion->rating}"></div>
                                    {/if}
                                    
                                    <br />
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
                            <p>
                                {$excursion->sinopsis}
                            </p>                    
                        </div>
                    </div>
                </div>
                <div class="col-lg-8">
                    <div class="borderBoxBlue form_reservation clearfix">
                        <form id="opinionFrm">
                            
                            <input type="hidden" name="action" value="enviarOpinion">
                            <input type="hidden" name="eventoId" value="{$excursion->id}">
                            
                        <div class="row-fluid col-lg-12">
                            <h5 class="card-message">{#deje_su_opinion#}</h5>
                            
                            <div class="col-lg-6">
                                
                                <div id="rating" class="col-lg-12 row"></div>
                            </div>
                            
                            <div class="col-lg-6 form-group">
                                <label for="puntuacion">Puntuación</label>
                                <select class="form-control" id="puntuacion" name="puntuacion">
                                    <option disabled="">Puntuación</option>
                                    <option value="1">{#mala#}</option>
                                    <option value="2">{#aceptable#}</option>
                                    <option value="3">{#buena#}</option>
                                    <option value="4">{#muy_buena#}</option>
                                    <option value="5">{#exelente#}</option>
                                </select>
                            </div>
                            
                            <div class="col-lg-12 form-group">
                                <label for="opinion">{#opinion#}</label>
                                <textarea class="form-control" name="opinion"></textarea>
                            </div>
                            
                        </div>
                        
                        
                        <div class="row-fluid col-lg-12">
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

                             </div>
                                 
                            <div class="credit-card-section">
                                <div class="form-group text-right">
                                    
                                    <input id="total_reservar_button" class="btn btn-warning notHover" type="submit" name="" value="Enviar opinión" />
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                                 
                        </div>
                       </form> 
                    </div>
                </div>
                <div class="col-lg-4">
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
                                        {if $otraexcursion->rating > -1}
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
                                        {$otraexcursion->sinopsisCorta}
                                    </li>
                                </ul>                    
                            </div>
                        </div>
                        <div>
                            <a href="{$base_url}/detalle/id:{$otraexcursion->id}/{$otraexcursion->tituloSeo}" class="btn btn-warning notHover" >¡Lo quiero!</a>
                        </div>
                    </div>
                    {/if}
                    
                </div>
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