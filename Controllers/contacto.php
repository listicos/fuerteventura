<?php

$client = new nusoap_client($service_url."/soap-empresa");
$params = $distribuidor;

$client->debug_flag = true;
$result = $client->call('get', array('params' => $params));    
$result = json_decode($result);
$smarty->assign('empresa', $result->data);

$smarty->display('contacto.tpl');
?>