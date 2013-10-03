<?php

$client = new nusoap_client($service_url."/soap-evento");
$params = $distribuidor;
$client->debug_flag = true;
$result = $client->call('excursiones', array('params' => $params));

$result = json_decode($result);

$excursiones = $result->data;

$tipologias = array();
if ($excursiones)
foreach ($excursiones as $e) {
    if(!isset($tipologias[$e->tipologiaId]))
        $tipologias[$e->tipologiaId] = array('tipologia' => $e->tipologia, 'cantidad' => 0);
    $tipologias[$e->tipologiaId]['cantidad']++;
}

$smarty->assign('excursiones', $excursiones);
$smarty->assign('tipos', $tipologias);

// edificio
$client = new nusoap_client($service_url.'/soap-edificio');
$result = $client->call('get', array('params'=>$params));
$result = json_decode($result);
$edificio = $result->data;

$smarty->assign('edificio', $edificio);


$smarty->display('home.tpl');
?>