<?php

$client = new nusoap_client($service_url."/soap-reservacion");
$params = $distribuidor;
if(isset($_GET['codigo'])) {
    $codigo = $_GET['codigo'];
    $params['codigo'] = $codigo;
}
$client->debug_flag = true;
$result = $client->call('get', array('params' => $params)); 

$result = json_decode($result);
$smarty->assign('reserva', $result->data);
$smarty->assign('qrcodeurl', $service_url.'/cache/'.'qrcode_reservacion_'.$result->data->id.'.png');

if(isset($_GET['imprimir'])) {
    $smarty->display('imprimirconfirmacion.tpl');
} else {
    $smarty->display('confirmacion.tpl');
}


?>