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
            </div>
            
        </div>
        <div class="col-lg-9">
            
            <div class="row" style="padding-bottom: 0;padding-top: 5px;">
                <div class="content-title">
                    <h3>{#que_es_fuertetour#}</h5>
                    <hr class="for_double">
                    <p>{if $edificio && $edificio->descripciones && count($edificio->descripciones) > 0}
                            {$edificio->descripciones[0]->descripcion}
                        {/if}</p>
                </div>
            </div>
                
            <div class="row" style="padding-bottom: 0; padding-top: 10px;">
                <div class="content-title">
                    <h3>Lista de Excursiones</h5>
                    <hr class="for_double">
                    
                </div>
            </div>
            
            <div class="tours-list">
                {foreach from=$excursiones item=excursion name=loop_excursiones}
                <div class="row tour-item">
                    <div class="col-lg-5">
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
                                <i style="float:left;">{$excursion->nombre}</i>
                                {if $excursion->rating > -1}
                                <ul class="rating" title="{$excursion->rating}">
                                    <li class="{if $excursion->rating >= 2}yellow-star{elseif $excursion->rating > 0}middle-star{/if}"></li>
                                    <li class="{if $excursion->rating >= 3.5}yellow-star{elseif $excursion->rating > 2}middle-star{/if}"></li>
                                    <li class="{if $excursion->rating >= 5.5}yellow-star{elseif $excursion->rating > 4}middle-star{/if}"></li>
                                    <li class="{if $excursion->rating >= 7.5}yellow-star{elseif $excursion->rating > 6}middle-star{/if}"></li>
                                    <li class="{if $excursion->rating > 9.5}yellow-star{elseif $excursion->rating > 8}middle-star{/if}"></li>
                                </ul>
                                {/if}
                            </h3>
                            <input name="fechasDisponibles" type="hidden" value="{$excursion->fechaInicio|date_format:"%m/%d/%Y"}-{$excursion->fechaFinal|date_format:"%m/%d/%Y"}">
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
                            <li>
                                <div class="icon-time"></div>
                                <strong>Duraci&oacute;n</strong> {$excursion->duracion}
                            </li>
                        </ul>
                        <p>
                            {$excursion->sinopsisCorta}
                        </p>
                        
                        <a href="{$base_url}/detalle/id:{$excursion->id}/{$excursion->tituloSeo}" class="btn btn-warning notHover reservar-btn">Reserve ahora</a>
                        <a href="#make_question_modal" class="btn btn-default notHover make_a_question" data-toggle="modal">Hacer una pregunta</a>
                        
                    </div>
                </div>
                {/foreach}
            </div>
        </div>
    </div>    
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