<?php

$client = new nusoap_client($service_url."/soap-reservacion");
$params = $distribuidor;
if(isset($_GET['codigo'])) {
    $codigo = $_GET['codigo'];
    $params['codigo'] = $codigo;
}
$client->debug_flag = true;

if(isset($_GET['imprimir'])) {
    $result = $client->call('get', array('params' => $params)); 
} else {
    $result = $client->call('cancelar', array('params' => $params)); 
}
   
$result = json_decode($result);
$smarty->assign('reserva', $result->data);
$smarty->assign('qrcodeurl', $service_url.'/cache/'.'qrcode_reservacion_'.$result->data->id.'.png');
if(isset($_GET['imprimir'])) {
    $smarty->display('imprimircancelar.tpl'); 
} else {
    $smarty->display('cancelar.tpl'); 
}


?>
