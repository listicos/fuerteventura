<?php
session_start();
header('Content-Type: text/html; charset=UTF-8'); 
error_reporting(E_ERROR | E_WARNING | E_PARSE);

require 'config.php';
include 'Core/Include.php';
require 'Lib/smarty/Smarty.class.php';
require 'Lib/nusoap/nusoap.php';

$smarty = new Smarty;
$smarty->debugging = false;
$smarty->caching = false;
$smarty->cache_lifetime = 120;
$smarty->assign("base_url",$base_url);
$smarty->assign("template_url",$template_url);

$smarty->assign('distribuidor', $distribuidor);

if (isset($_SESSION['lang'])){
   $lang_set = $_SESSION['lang'];
   } else {
          $lang_set = "es";
}
$smarty->configLoad($lang_set . '.conf');

$controller = new Core_Controller();
$usuario_core = Core_Usuario::getInstance();
$usuario = $usuario_core->getUsuario();

if($usuario){
	$smarty->assign('logged_user',$usuario);
}


$includes = $controller->getFileAction();
if (is_file($includes)) {
    include $includes;
} else {
    header('Location:' . $base_url);
}

?>