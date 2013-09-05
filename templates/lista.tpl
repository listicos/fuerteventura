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
        <div class="col-lg-9">
            <div class="tours-list">
                <div class="row tour-item">
                    <div class="col-lg-5"><a href="#"><img src="{$template_url}/imagenes/slider2.jpg" alt="Photo 2" class="img-thumbnail full_width" /></a></div>
                    <div class="col-lg-7">
                        <div class="content-title">
                            <h3>Paraíso Tropical</h3>
                            <hr class="for_double">
                            <hr class="for_double">
                        </div>
                        <ul class="parthenon-caption">
                            <li>
                                <div class="colors-icon icon-map-marker"></div>
                                <strong>Destino</strong> Filipinas
                            </li>
                            <li>
                                <div class="colors-icon icon-watch"></div>
                                <strong>Duración</strong> 4 Días
                            </li>
                            <li>
                                <div class="colors-icon icon-price-tag"></div>
                                <strong>Precio</strong> $379
                            </li>
                        </ul>
                        <p>
                            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed interdum accumsan ante, vel accumsan neque suscipit id. Nam ut purus feugiat, 
                            vestibulum nulla non, dapibus nulla. Cras ac condimentum nunc. Donec cursus urna non ipsum faucibus adipiscing.
                        </p>

                        <a href="#" class="btn btn-warning notHover">Reserve ahora</a>
                        <a href="#" class="btn btn-default notHover">Hacer una pregunta</a>
                    </div>
                </div>
                <div class="row tour-item">
                    <div class="col-lg-5"><a href="#"><img src="{$template_url}/imagenes/slider2.jpg" alt="Photo 2" class="img-thumbnail full_width" /></a></div>
                    <div class="col-lg-7">
                        <div class="content-title">
                            <h3>Paraíso Tropical</h3>
                            <hr class="for_double">
                            <hr class="for_double">
                        </div>
                        <ul class="parthenon-caption">
                            <li>
                                <div class="colors-icon icon-map-marker"></div>
                                <strong>Destino</strong> Filipinas
                            </li>
                            <li>
                                <div class="colors-icon icon-watch"></div>
                                <strong>Duración</strong> 4 Días
                            </li>
                            <li>
                                <div class="colors-icon icon-price-tag"></div>
                                <strong>Precio</strong> $379
                            </li>
                        </ul>
                        <p>
                            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed interdum accumsan ante, vel accumsan neque suscipit id. Nam ut purus feugiat, 
                            vestibulum nulla non, dapibus nulla. Cras ac condimentum nunc. Donec cursus urna non ipsum faucibus adipiscing.
                        </p>

                        <a href="#" class="btn btn-warning notHover">Reserve ahora</a>
                        <a href="#" class="btn btn-default notHover">Hacer una pregunta</a>
                    </div>
                </div>
                <div class="row tour-item">
                    <div class="col-lg-5"><a href="#"><img src="{$template_url}/imagenes/slider2.jpg" alt="Photo 2" class="img-thumbnail full_width" /></a></div>
                    <div class="col-lg-7">
                        <div class="content-title">
                            <h3>Paraíso Tropical</h3>
                            <hr class="for_double">
                            <hr class="for_double">
                        </div>
                        <ul class="parthenon-caption">
                            <li>
                                <div class="colors-icon icon-map-marker"></div>
                                <strong>Destino</strong> Filipinas
                            </li>
                            <li>
                                <div class="colors-icon icon-watch"></div>
                                <strong>Duración</strong> 4 Días
                            </li>
                            <li>
                                <div class="colors-icon icon-price-tag"></div>
                                <strong>Precio</strong> $379
                            </li>
                        </ul>
                        <p>
                            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed interdum accumsan ante, vel accumsan neque suscipit id. Nam ut purus feugiat, 
                            vestibulum nulla non, dapibus nulla. Cras ac condimentum nunc. Donec cursus urna non ipsum faucibus adipiscing.
                        </p>

                        <a href="#" class="btn btn-warning notHover">Reserve ahora</a>
                        <a href="#" class="btn btn-default notHover">Hacer una pregunta</a>
                    </div>
                </div>
            </div>
            <ul class="pagination">
                <li><a href="#">&laquo;</a></li>
                <li><a href="#">1</a></li>
                <li><a href="#">2</a></li>
                <li><a href="#">3</a></li>
                <li><a href="#">4</a></li>
                <li><a href="#">5</a></li>
                <li><a href="#">&raquo;</a></li>
            </ul>
        </div>
        <div class="col-lg-3">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">Encuentra tu viaje perfecto</h3>
                </div>
                <div class="panel-content">
                    <form id="search_tours">
                        <select class="selectpicker row" data-style="btn-primary"  title="Ordenar">
                            <option>Destinos</option>
                            <option>Australia</option>
                            <option>Brasil</option>
                            <option>España</option>
                            <option>México</option>
                        </select>
                        <select class="selectpicker row" data-style="btn-primary"  title="Ordenar">
                            <option>Tipos</option>
                            <option>Cultural</option>
                            <option>Educacional</option>
                        </select>

                        <div class="row">
                            <div id="dateStart" class="col-lg-12 date datepicker date-start" data-date-format="dd-mm-yyyy">
                                <input size="16" class="col-lg-12 btn-primary" name="dateStart" type="text" value="Fecha Llegada" readonly>
                                <span class="add-on"><i class="glyphicon glyphicon-calendar icon-white"></i></span>
                            </div>
                        </div>

                        <div class="row">
                            <div id="dateEnd" class="col-lg-12 date datepicker date-end" data-date-format="dd-mm-yyyy">
                                <input size="16" class="col-lg-12 btn-primary" name="dateEnd" type="text" value="Fecha Salida" readonly>
                                <span class="add-on"><i class="glyphicon glyphicon-calendar icon-white"></i></span>
                            </div>
                        </div>

                        <div class="row go_search">
                            <button type="search" results="10" class="btn btn-warning col-lg-6" id="search">Buscar viajes</button>
                        </div>
                    </form>
                </div>
                <div class="clearfix"></div>
            </div>
            <div class="tours-announcement-content">
                <a href="#"><img src="{$template_url}/imagenes/announcement.png" alt="Photo 2" class="img-thumbnail full_width" /></a>
                <div class="announcement-caption">
                    <p>Paraíso Tropical <br> <smal>from $799</smal></p>
                </div>
            </div>
        </div>
    </div>    
</div>

{/block}