<?php

$action = $_POST["action"];
$result = array("msg" => "error", "data" => "Tu no tienes suficientes permisos.");

if (strcmp($action, "insertReservacion") == 0) {
    if (isset($_POST["recaptcha_response_field"])){
        require_once('Lib/recaptcha/recaptchalib.php');
        $resp = recaptcha_check_answer($reprivatekey,
                                            $_SERVER["REMOTE_ADDR"],
                                            $_POST["recaptcha_challenge_field"],
                                            $_POST["recaptcha_response_field"]);
        if(!$resp->is_valid){
            echo json_encode(array('msg'=>'Captcha incorrecto, por favor, escriba de nuevo la frase de la imagen, o vuelva a recargarla.','result' => 'error'));       
            exit();
        }
    }else{
        echo json_encode(array('msg'=>'El Captcha es obligatorio','result' => 'error'));       
        exit();
    }

    $data = array(
        'nombre' => null,
        'apellidoPaterno' => null,
        'email' => null,
        'eventoId' => null,
        'fecha' => null,
        'tarifaId' => null,
        'entradas' => 1,
        'canal' => 'web_excursiones',
        'telefono' => null
    );
    
    foreach(array_keys($data) as $key) {
        if(isset($_POST[$key]))
            $data[$key] = $_POST[$key];
    }
    
    if(!is_null($data['fecha'])) {
        $fecha = explode("/", $data['fecha']);
        $data['fecha'] = $fecha[2]."-".$fecha[1]."-".$fecha[0];
    }
    
    $params = $distribuidor;
    
    if(isset($distribuidor['canalId']))
        $data['canalId'] = $distribuidor['canalId'];
    else
        $params['canal'] = 'web_excursiones';
    
    $data_entradas = array();
    
    if(isset($_POST['entradas'])) {
        $entradas = $_POST['entradas'];
        foreach ($entradas as $key=>$value) {
            if($value > 0) {
                array_push($data_entradas, array('tarifaEntradaId'=>$key, 'entradas'=>$value));
            }
        }
    }
    
    if(isset($_POST['aceptoRecibirOfertas'])) {
        $data['recibirOfertas'] = true;
    }
    
    $data['entradas'] = $data_entradas;
    $params['reservacion'] = $data;    
    
    $client = new nusoap_client($service_url."/soap-reservacion");
    $client->timeout = 1000000000;
    $client->response_timeout = 1000000000;
    $result = $client->call('insert', array('params' => $params));
    $result = json_decode($result);
    
    
    
}

if (strcmp($action, "enviarPregunta") == 0) {
    
}

echo json_encode($result);

function crearEmailConfirmacionReserva($reservacion, $smarty) {
    
    $usuario = $reservacion->usuario;
    $evento = $reservacion->evento;
    
    $smarty->assign('reservacion', $reservacion);
    $smarty->assign('usuario', $usuario);
    $smarty->assign('evento', $evento);
    
    $body_email = $smarty->fetch('confirmacion_email.tpl');
    
    $headers = "From:reservaciones@vikatickets.com\r\n";
    $headers .= "Reply-To:no-reply@vikatickets.com\r\n";
    $headers .= "Content-Type: text/html;\r\n charset=\"iso-8859-1\"\r\n";
    
    $data_email = array(
        'to' => $usuario->email,
        'subject' => 'Tu reserva está confirmada',
        'body' => $body_email,
        'headers' => $headers
    );
    
    return $data_email;
}

?>
