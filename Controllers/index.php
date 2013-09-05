<?php

$client = new nusoap_client($service_url."/soap-evento");
$params = $distribuidor;
$client->debug_flag = true;
$result = $client->call('excursiones', array('params' => $params));

$result = json_decode($result);

$excursiones = $result->data;

$smarty->assign('excursiones', $excursiones);

// edificio
$client = new nusoap_client($service_url.'/soap-edificio');
$result = $client->call('get', array('params'=>$params));
$result = json_decode($result);
$edificio = $result->data;

$smarty->assign('edificio', $edificio);


$smarty->display('home.tpl');
?>