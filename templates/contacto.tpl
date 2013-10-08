{extends file="index.tpl"}


{block name="style" append}
    <link href="{$template_url}/css/contacto.css" rel="stylesheet">
{/block}

{block name="script" append}
    <script src="http://maps.googleapis.com/maps/api/js?sensor=false&amp;libraries=places"></script>
    <script type="text/javascript" src="{$template_url}/js/contacto.js"></script> 
{/block}

{block name="content" append}



<div class="container content contact fullWhite">
    <div class="row">

        <div class="col-lg-8">
            <form id="contact-form">
                <div class="row contact-for-inner">
                    <div class="content-title pdg015">
                        <h3>Contáctanos</h3>
                        <hr class="for_double">
                        
                    </div>
                    <div class="col-lg-6"><div class="form-group"><input class="btn-box-text validate[required]" type="text" name="nombre" placeholder="Nombre completo" /></div></div>
                    <div class="col-lg-6"><div class="form-group"><input class="btn-box-text validate[required, custom[email]]" type="text" name="email" placeholder="Correo electrónico" /></div></div>
                    <div class="col-lg-12"><div class="form-group"><textarea class="btn-box-text validate[required]" name="mensaje" placeholder="Mensaje"></textarea></div></div>
                    <div class="col-lg-12"><input type="submit" class="btn btn-warning left" value="Enviar" /></div>
                </div>
            </form>
        </div>
        <div class="col-lg-4">
            <div class="content-title">
                <h3>Boletín Informativo</h3>
                <hr class="for_double">
                
            </div>
            <div class="news_suscribe">
                <p>Suscríbete a nuestro boletín ahora para estar actualizado con las novedades.</p>
                <form id="subscribe_form">          
                    <input type="text" id="email" value="Correo Electrónico">
                </form>
            </div>
            <div class="content-title mrgTop20">
                <h3>Detalles</h3>
                <hr class="for_double">
                
            </div>
            <div class="details-content">
                <p><strong>Empresa:</strong> {$empresa->nombreFiscal} </p>
                <p><strong>CIF:</strong> {$empresa->cif} </p>
                <p><strong>Direcci&oacute;n:</strong> {$empresa->direccion->calle} {$empresa->direccion->numero} </p>
            </div>
        </div>
    </div>    
</div>
{/block}