{extends file="index.tpl"}

{block name="script" append}
    <script type="text/javascript" src="{$template_url}/js/home.js"></script> 
{/block}

{block name="content" append}
<div class="container header">
 <div class="row sub-header">
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
    </div>
    <div class="col-lg-9">
        <div id="header-slider" class="carousel slide">
            <ol class="carousel-indicators">
                <li data-target="#header-slider" data-slide-to="0" class="active"></li>
                <li data-target="#header-slider" data-slide-to="1"></li>
                <li data-target="#header-slider" data-slide-to="2"></li>
            </ol>

            <div class="carousel-inner">
                <div class="item active">
                    <img src="{$template_url}/imagenes/slider1.jpg" alt="Photo 1">
                    <div class="carousel-caption">

                    </div>
                </div>
                <div class="item">
                    <img src="{$template_url}/imagenes/slider2.jpg" alt="Photo 2">
                    <div class="carousel-caption">

                    </div>
                </div>
                <div class="item">
                    <img src="{$template_url}/imagenes/slider3.jpg" alt="Photo 3">
                    <div class="carousel-caption">

                    </div>
                </div>
            </div>
            <div class="back-images layer-1"></div>
            <div class="back-images layer-2"></div>

            <a class="left carousel-control" href="#header-slider" data-slide="prev">
                <span class="icon-prev"></span>
            </a>
            <a class="right carousel-control" href="#header-slider" data-slide="next">
                <span class="icon-next"></span>
            </a>

        </div>
    </div>
</div>
</div>


 <div class="container content places fullWhite">
    <div class="row">
        <div class="content-title">
            <h3>Recomendaciones</h3>
            <hr class="for_double">
            <hr class="for_double">
        </div>
        <div class="row recomendations-content">
            <div class="col-lg-3 item-grid">
                <div class="item-thumbnail">
                    <a href="#"><img src="{$template_url}/imagenes/slider1.jpg" class="full_width" /></a>
                    <div class="item-caption">
                        <a href="#" class="item-name">Paraíso tropical</a>
                        <hr class="for_double" />
                        <span class="glyphicon glyphicon-map-marker pull-left"></span>
                        <span class="pull-left item-location">Filipinas</span>
                        <span class="pull-right">8 dias</span>
                        <div class="clearfix"></div>
                    </div>
                </div>
                <div class="back-images global"></div>
            </div>
            <div class="col-lg-3 item-grid">
                <div class="item-thumbnail">
                    <a href="#"><img src="{$template_url}/imagenes/slider1.jpg" class="full_width" /></a>
                    <div class="item-caption">
                        <a href="#" class="item-name">Paraíso tropical</a>
                        <hr class="for_double" />
                        <span class="glyphicon glyphicon-map-marker pull-left"></span>
                        <span class="pull-left item-location">Filipinas</span>
                        <span class="pull-right">8 dias</span>
                        <div class="clearfix"></div>
                    </div>
                </div>
                <div class="back-images global"></div>
            </div>
            <div class="col-lg-3 item-grid">
                <div class="item-thumbnail">
                    <a href="#"><img src="{$template_url}/imagenes/slider1.jpg" class="full_width" /></a>
                    <div class="item-caption">
                        <a href="#" class="item-name">Paraíso tropical</a>
                        <hr class="for_double" />
                        <span class="glyphicon glyphicon-map-marker pull-left"></span>
                        <span class="pull-left item-location">Filipinas</span>
                        <span class="pull-right">8 dias</span>
                        <div class="clearfix"></div>
                    </div>
                </div>
                <div class="back-images global"></div>
            </div>
            <div class="col-lg-3 item-grid">
                <div class="item-thumbnail">
                    <a href="#"><img src="{$template_url}/imagenes/slider1.jpg" class="full_width" /></a>
                    <div class="item-caption">
                        <a href="#" class="item-name">Paraíso tropical</a>
                        <hr class="for_double" />
                        <span class="glyphicon glyphicon-map-marker pull-left"></span>
                        <span class="pull-left item-location">Filipinas</span>
                        <span class="pull-right">8 dias</span>
                        <div class="clearfix"></div>
                    </div>
                </div>
                <div class="back-images global"></div>
            </div>
        </div>
    </div>
</div>

<div class="container content space-between-rows">
    <div class="row"></div>
</div>

<div class="container content guide gallery fullWhite">
    <div class="row">
        <div class="col-lg-3">
            <div class="content-title">
                <h3>Guía de viaje</h3>
                <hr class="for_double">
                <hr class="for_double">
            </div>
            <div class="travel-blog">
                <div class="post">
                    <div class="post-image">
                        <a href="#"><img src="{$template_url}/imagenes/sahara.jpg" class="full_width img-thumbnail" /></a>
                    </div>
                    <div class="post-content">
                        <h5><a href="#">¿Cómo sobrevivir en el Sahara?</a></h5>
                    </div>
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed interdum accumsan ante, vel accumsan neque suscipit id. </p>
                    <div class="post-meta">
                        <a href="#" class="btn btn-warning btn-sm"><span>Leer más</span></a>
                        <div class="post-comment-count">3</div>
                        <div class="post-info">24/11/2012</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="content-title">
                <h3>Galeria</h3>
                <hr class="for_double">
                <hr class="for_double">
            </div>
            <div class="row gallery-content">
                <div class="col-lg-4">
                    <div class="gallery-image">
                        <a href="#"><img src="{$template_url}/imagenes/slider1.jpg" class="full_width img-thumbnail" /></a>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="gallery-image">
                        <a href="#"><img src="{$template_url}/imagenes/slider1.jpg" class="full_width img-thumbnail" /></a>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="gallery-image">
                        <a href="#"><img src="{$template_url}/imagenes/slider1.jpg" class="full_width img-thumbnail" /></a>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="gallery-image">
                        <a href="#"><img src="{$template_url}/imagenes/slider1.jpg" class="full_width img-thumbnail" /></a>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="gallery-image">
                        <a href="#"><img src="{$template_url}/imagenes/slider1.jpg" class="full_width img-thumbnail" /></a>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="gallery-image">
                        <a href="#"><img src="{$template_url}/imagenes/slider1.jpg" class="full_width img-thumbnail" /></a>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-3">
            <div class="content-title">
                <h3>Boletín Informativo</h3>
                <hr class="for_double">
                <hr class="for_double">
            </div>
            <div class="news_suscribe">
                <p>Suscríbete a nuestro boletín ahora para estar actualizado con las novedades.</p>
                <form id="subscribe_form">			
                    <input type="text" id="email" value="Correo Electrónico">
                </form>
            </div>
            <div class="content-title mrgTop20">
                <h3>Tweets</h3>
                <hr class="for_double">
                <hr class="for_double">
            </div>
            <div class="tweets_content">
                <div class="tweets_list">
                    <div class="col-lg-12 tweet-row">
                        <div class="colors-icon icon-tweet"></div>
                        <p class="tweet">Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
                            <a href="#"><span class="tweet-link">http:://tweeter.com</span></a>
                        </p>

                    </div>
                    <hr class="for_double">
                    <div class="col-lg-12 tweet-row">
                        <div class="colors-icon icon-tweet"></div>
                        <p class="tweet">Sed interdum accumsan ante, vel accumsan neque suscipit id.
                            <a href="#"><span class="tweet-li   nk">http:://tweeter.com</span></a>
                        </p>

                    </div>
                    <hr class="for_double">
                    <div class="col-lg-12 tweet-row">
                        <div class="colors-icon icon-tweet"></div>
                        <p class="tweet">Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                            <a href="#"><span class="tweet-link">http:://tweeter.com</span></a>
                        </p>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
{/block}