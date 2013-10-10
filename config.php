<?php
$site_title = 'Deteatros'; 

$site_prefix = '/fuerteventura';

$base_url = "http://" . $_SERVER['SERVER_NAME'].$site_prefix;
$base_url_ssl = "https://" . $_SERVER['SERVER_NAME'].$site_prefix;
$app_dir = $_SERVER['DOCUMENT_ROOT'].$site_prefix;
$template_dir = $_SERVER['DOCUMENT_ROOT'].$site_prefix.'/templates';
$template_url = "http://" . $_SERVER['SERVER_NAME'].$site_prefix.'/templates';

$republickey = "6LcY-uYSAAAAACBIaBBmfEdbYqJxCkDdtOONaeIE";
$reprivatekey = "6LcY-uYSAAAAABRFFQn56OhwJwhDVGciLO6W_KcQ";

$distribuidor = array(
    'email' => 'excursiones_web@vikatickets.com',
    'password' => '123',
    'empresaId' => 3,
    'canalId' => 1,
    'edificioId' => 2
);
$service_url = "http://localhost/vikatickets";
?>