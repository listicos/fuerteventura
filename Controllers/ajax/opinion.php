<?php

$action = $_POST["action"];
$result = array("msg" => "error", "data" => "Tu no tienes suficientes permisos.");

if (strcmp($action, "enviarOpinion") == 0) {
    $data = array(
        'eventoId' => NULL,
        'puntuacion' => 0,
        'opinion' => NULL,
        'email' => NULL,
        'nombre' => NULL,
        'apellidoPaterno' => NULL
    );
    
    foreach (array_keys($data) as $key) {
        if(isset($_POST[$key]))
            $data[$key] = $_POST[$key];
    }
    
    
    $params = $distribuidor;
    $params['opinion'] = $data;
    
    $client = new nusoap_client($service_url.'/soap-opinion');
    $client->debug_flag = true;
    $result = $client->call('insert', array('params'=>$params));
    $result = json_decode($result);
}

echo json_encode($result);

?>
