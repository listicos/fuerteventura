{extends file="index.tpl"}

{block name="style" append}
    <link href="{$template_url}/css/detalle.css" rel="stylesheet">
{/block}

{block name="script" append}
    <script type="text/javascript" src="{$template_url}/js/home.js"></script>
{/block}

{block name="content" append}

<div class="container content tours fullWhite">
    <div class="row">
        <div class="col-lg-3 search-panel-content">
            <div class="panel panel-primary borderBoxBlue">
                <div class="panel-heading">
                    <h3 class="panel-title">{#cuando_quieres_ir#}</h3>
                </div>
                <div class="panel-content">
                    <form id="search_tours">
                        <div class="row" id="sandbox-container">
                            <div></div>
                        </div>
                    </form>
                </div>
                <div class="clearfix"></div>
                
                <div class="filter_box">
                    <h4>
                            Filtrar excursiones
                    </h4>
                    <ul>
                    {foreach from=$tipos item=t}
                    <li>
                      <label class="checkbox ">
                        <input type="checkbox" id="room_type_0" name="room_types" value="{$t['tipologia']->id}">
                        {$t['tipologia']->nombre}
                        <span class="badge pull-right">{$t['cantidad']}</span>
                      </label>
                    </li>
                    {/foreach}
                    </ul>
                </div>
            </div>
            <div class="col-lg-12 left-panel">
                <div class="row-fluid">
                    <div class="weather-container borderBoxBlue">
                        <div id="weatherslider">
                            <span title="Corralejo, Fuerteventura" class="ws-location">28.7361111111,-13.8677777778</span>
                            <!--<span title="Madrid, España" class="ws-location">Madrid</span>
                            <span title="Barcelona, España" class="ws-location">Barcelona</span>-->
                        </div>
                    </div>
                </div>
            </div>      
             </div>
        <div class="col-lg-9">      
            <div class="row" style="padding-bottom: 0; padding-top: 5px;">
                <div class="content-title col-lg-12">
                    <h2>Las mejores aventuras de Fuerteventura al mejor precio.</h2>
                    <p>Ven y disfruta de la isla mas salvaje y natural de Canarias con nuestras excursiones y eventos.</p>
                    <p>{if $edificio && $edificio->descripcion->$lang}
                            {$edificio->descripcion->$lang->descripcion}
                        {else}
                            {$edificio->descripcion->es->descripcion}
                        {/if}</p>
                </div>
            </div>
                
            <div class="tours-list">
                {foreach from=$excursiones item=excursion name=loop_excursiones}
                <div class="row tour-item tipologia-{$excursion->tipologiaId}">
                    <div class="col-lg-5 no-padding">
                        <div id="header-slider-{$smarty.foreach.loop_excursiones.iteration}" class="header-slider carousel slide">
                            <div class="carousel-inner home_carousel_inner">
                                {if $excursion->imagenes}
                                {foreach from=$excursion->imagenes item=imagen name=loop_imagenes}
                                <div class="item {if $smarty.foreach.loop_imagenes.first}active{/if}">
                                    <img src="{$imagen->ruta}" alt="imagen {$smarty.foreach.loop_imagenes.iteration}">
                                    <div class="carousel-caption">

                                    </div>
                                </div>
                                {/foreach}
                                {else}
                                <div class="item active">
                                    <img src="{$template_url}/imagenes/slider1.jpg" alt="Photo 2">
                                    <div class="carousel-caption">

                                    </div>
                                </div>
                                {/if}
                            </div>
                            <div class="back-images layer-1"></div>
                            <div class="back-images layer-2"></div>

                            <a class="left carousel-control" href="#header-slider-{$smarty.foreach.loop_excursiones.iteration}" data-slide="prev">
                                <span class="icon-prev"></span>
                            </a>
                            <a class="right carousel-control" href="#header-slider-{$smarty.foreach.loop_excursiones.iteration}" data-slide="next">
                                <span class="icon-next"></span>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-7">
                        <div class="content-title">
                            <h3>
                                <div style="float:left;">
                                <a href="{$base_url}/detalle/id:{$excursion->id}/{$excursion->tituloSeo|replace:" ":"%20"}" class="title-link-reservar" >
                                    <i style="float:left;">{$excursion->nombre}</i>                                    
                                </a>
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

                                            {if $excursion->rating > -1}
                                            <div>
                                                <span class="badge pull-right">{$excursion->rating} Puntos</span>
                                            </div>
                                            {/if}

                                        {/if}
                                    </div>
                                </div>
                            </h3>
                            <select name="fechasDisponibles" class="hidden" >
                                {foreach from=$excursion->tarifas item=tarifa}
                                    {foreach from=$tarifa->fechas item=fecha}
                                        <option value="{$fecha->fecha|date_format:"%m/%d/%Y"}">
                                            {$fecha->fecha|date_format:"%m/%d/%Y"}
                                        </option>
                                    {/foreach}
                                {/foreach}
                            </select>
                            <hr class="for_double">
                        </div>
                        <ul class="parthenon-caption">
                            
                            <li>
                                <div class="icon-map-marker"></div>
                                <strong>Destino</strong> {$excursion->direccion->descripcion}
                            </li>
                            <li>
                                <div class="icon-tag"></div>
                                <strong>Precio</strong> <a href="{$base_url}/detalle/id:{$excursion->id}/{$excursion->tituloSeo}/fecha:{$excursion->precio->fecha|date_format:"%d-%m-%Y"}" >a partir de {$excursion->precio->precio|number_format:2:',':'.'} &euro; {if $excursion->precio->fecha}({$excursion->precio->fecha|date_format}){/if}</a>
                            </li>
                            {if !$excursion->duracionIndefinida}
                            <li>
                                <div class="icon-time"></div>
                                <strong>Duraci&oacute;n</strong> {if $excursion->dias eq 0}{$excursion->duracion}hrs{else}{$excursion->dias}días{/if}
                            </li>
                            {/if}
                        </ul>
                        <p>
                            {if $excursion->sinopsisCorta->$lang}
                                {$excursion->sinopsisCorta->$lang}
                            {else}
                                {$excursion->sinopsisCorta->es}
                            {/if}
                        </p>
                        
                        <a href="{$base_url}/detalle/id:{$excursion->id}/{$excursion->tituloSeo}" class="btn btn-warning notHover reservar-btn">Reserve ahora</a>
                        <a href="#make_question_modal" class="notHover make_a_question" data-toggle="modal">¿Tienes alguna pregunta?</a>
                        
                    </div>
                </div>
                {/foreach}
            </div>
        </div>
       </div>
    
            <div class="delimiter"></div>
</div>
<div class="modal fade" id="make_question_modal">
    <div class="modal-dialog">
        <div class="modal-content">
             <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Realiza tu pregunta</h4>
            </div>
            <div class="modal-body">
                <form id="make-question-form">
                    <div class="row contact-for-inner">
                        <div class="col-lg-6"><div class="form-group"><input type="text" name="name" placeholder="Nombre completo"></div></div>
                        <div class="col-lg-6"><div class="form-group"><input type="text" name="email" placeholder="Correo electrónico"></div></div>
                        <div class="col-lg-12"><div class="form-group"><textarea name="message" placeholder="Mensaje"></textarea></div></div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-warning">Enviar pregunta</button>
            </div>
        </div>
    </div>
</div>
{/block}