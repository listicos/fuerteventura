<?php


$result = array("msg" => "error", "data" => "Tu no tienes suficientes permisos.");

if(isset($_POST['email'])) {
    $data = array();
    $data['email'] = $_POST['email'];
    
    
    $params = $distribuidor;
    $params['suscripcion'] = $data;
    
    $client = new nusoap_client($service_url . '/soap-empresa');
    $result = $client->call('suscribir', array('params'=>$params));
    $result = json_decode($result);
}

echo json_encode($result);
?>
