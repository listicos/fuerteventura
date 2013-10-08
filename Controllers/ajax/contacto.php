<?php


$result = array("msg" => "error", "data" => "Tu no tienes suficientes permisos.");

if(isset($_POST['nombre']) && isset($_POST['email']) && isset($_POST['mensaje'])) {
    $data = array();
    $data['nombre'] = $_POST['nombre'];
    $data['email'] = $_POST['email'];
    $data['mensaje'] = $_POST['mensaje'];
    $data['desde'] = $base_url;
    
    $params = $distribuidor;
    $params['contacto'] = $data;
    
    $client = new nusoap_client($service_url . '/soap-empresa');
    $result = $client->call('contactar', array('params'=>$params));
    $result = json_decode($result);
}

echo json_encode($result);
?>
