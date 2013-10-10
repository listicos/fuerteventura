<div class="container content header">
    <div class="row-fluid sup-header">
        <div class="row-fluid">
            <!--<div id="parthenon-slider" class="carousel slide">
                <div class="carousel-inner detalle_carousel_inner">                    
                    <div class="item active">
                        <img src="{$template_url}/imagenes/top.jpg" alt="Photo 1">
                        <div class="carousel-caption">
                        </div>
                    </div>
                </div>
                <div class="back-images layer-1"></div>
                <div class="back-images layer-2"></div>

                <a class="left carousel-control" href="#parthenon-slider" data-slide="prev">
                    <span class="icon-prev"></span>
                </a>
                <a class="right carousel-control" href="#parthenon-slider" data-slide="next">
                    <span class="icon-next"></span>
                </a>
            </div>-->
            <div class="header_photo_wrapper hidden-xs">
              <img src="{$template_url}/imagenes/top1.jpg" alt="Photo 1">
            </div>
        </div>
    </div>
    <div class="row-fluid sub-header">
        <div class="row-fluid site-name">
           <div class="col-md-3 hidden-xs"></div>
            <div class="col-xs-10 col-md-7">
                <div class="menu pull-left">
                   <ul class="nav nav-tabs">
  <li {if strlen($current_uri) == 0}class="active"{/if}><a href="{$base_url}">Inicio</a></li>
  <li {if $current_uri eq 'detalles'}class="active"{/if}><a href="#">Excursiones</a></li>
  <li {if $current_uri eq 'hoteles'}class="active"{/if}><a href="#">Hoteles</a></li>
  <li {if $current_uri eq 'contacto'}class="active"{/if}><a href="{$base_url}/contacto">Contacto</a></li>
</ul>
                </div>
            </div>
              <div class="col-xs-2 col-xs-offset-2">
              <div class="menu pull-left">
             <div class="btn-group">
                       
                          <button type="button" class="btn btn-warning dropdown-toggle" data-toggle="dropdown">
                            <span class="lang_text">Español</span>
                          </button>
                          <ul class="dropdown-menu dropdown_lang" role="menu">
                            <li class="active"><a data-lang="es" href="#">Español</a></li>
                            <li><a data-lang="de" href="#">Deutsch</a></li>
                            <li><a data-lang="en" href="#">English</a></li>
                            <li><a data-lang="fr" href="#">Français</a></li>
                            <li><a data-lang="it" href="#">Italiano</a></li>
                          </ul>
                         </div>
                        </div>
                 </div>      
        </div>
    </div>
                        
</div>

