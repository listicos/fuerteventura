<?php

$client = new nusoap_client($service_url."/soap-opinion");
$params = $distribuidor;
$params['base_url_opinar'] = $base_url . "/opinion";
$client->timeout = 1000000000;
$client->response_timeout = 1000000000;
$client->debug_flag = true;
$result = $client->call('enviarEmailSolicitudOpinion', array('params' => $params)); 

$result = json_decode($result);

?>
