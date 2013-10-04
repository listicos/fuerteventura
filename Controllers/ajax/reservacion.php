<?php

$action = $_POST["action"];
$result = array("msg" => "error", "data" => "Tu no tienes suficientes permisos.");

if (strcmp($action, "insertReservacion") == 0) {
    $eventoId = $_POST['eventoId'];
    $client = new nusoap_client($service_url."/soap-evento");
    $params = $distribuidor;
    $params['id'] = $eventoId;
    $client->debug_flag = true;
    $result = $client->call('get', array('params' => $params));    
    $result = json_decode($result);
    $evento = $result->data;
    
    if($evento->cobro->validacionCaptcha) {
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
        } else {
            echo json_encode(array('msg'=>'El Captcha es obligatorio','result' => 'error'));       
            exit();
        }
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
        'telefono' => null,
        'sesion' => null,
        'cupon' => NULL
    );
    
    $data_tarjeta = array(
        'CardNumber' => null,
        'StartDateMonth' => null,
        'StartDateYear' => null,
        'ExpiryDateMonth' => null,
        'ExpiryDateYear' => null,
        'CardType' => null,
        'CVV' => null,
        'BillingFirstnames' => null,
        'BillingSurname' => null,
        'BillingAddress1' => null,
        'BillingAddress2' => null,
        'BillingCity' => null,
        'BillingCountry' => null,
        'BillingPostCode' => null,
        'Amount' => null
    );
    
    foreach(array_keys($data) as $key) {
        if(isset($_POST[$key]))
            $data[$key] = $_POST[$key];
    }
    
    foreach(array_keys($data_tarjeta) as $key) {
        if(isset($_POST[$key]))
            $data_tarjeta[$key] = $_POST[$key];
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
    $params['tarjeta'] = $data_tarjeta;
    
    $client = new nusoap_client($service_url."/soap-reservacion");
    $client->timeout = 1000000000;
    $client->response_timeout = 1000000000;
    $result = $client->call('insert', array('params' => $params));
    
    $result = json_decode($result);
    
    $reservacion = $result->data;
    
    if(!$reservacion->evento->onRequest && strcmp($reservacion->evento->cobro->forma, 'Online') == 0) {
        //Pago para la caixa
        $caixa = new Core_Util_Caixa();
        $order = $reservacion->codigo;
        // Me parece que hay un error en el precio
        //$amount = $reservacion->precio;
        $amount = ($reservacion->precio * $reservacion->evento->cobro->porcentajeAdelanto / 100);
        //$urlMerchant = $_POST['current_url'];

        if (is_object($result)){      
            // Este número puede ser el id de la reservación
            $result->order = $order;
            $message = $amount.$order.$caixa->code.$caixa->currency.$caixa->transactionType.$caixa->clave;
            $signature = sha1($message);
            $result->signature = $signature;
        }else{
            //Fast horrible hack
            // Este número puede ser el id de la reservación
            $result['order'] = $order;
            $message = $amount.$order.$caixa->code.$caixa->currency.$caixa->transactionType.$caixa->clave;
            $signature = sha1($message);
            $result['signature'] = $signature;
        }
    }
     
    //Correo de confirmacion
    $data_email = array();
    $usuario = $reservacion->usuario;
    $evento = $reservacion->evento;

    $smarty->assign('reservacion', $reservacion);
    $smarty->assign('usuario', $usuario);
    $smarty->assign('evento', $evento);

    
    if(strcmp($reservacion->estatus, "Aprobado") == 0) {
        $body_email = $smarty->fetch('confirmacion_email.tpl');

        $subject = 'Gracias ' . $usuario->nombre . '! Tu reserva está confirmada';
    } else {
        $body_email = 'Se te enviará un email de confirmación con los datos de tu reserva';

        $subject = 'Gracias ' . $usuario->nombre . '! Tu solicitud esta siendo procesada';
    }

    try {
    $mail = new Core_Mailer();                               

    $enviado = $mail->send_email($usuario->email, $subject, $body_email);
    }
    catch(Exception $e) {
        
    }
        
    
}

if (strcmp($action, "enviarPregunta") == 0) {
    $data = array('name'=>NULL, 'email'=>NULL, 'message'=>NULL);
    foreach(array_keys($data) as $key) {
        if(isset($_POST[$key])) {
            $data[$key] = $_POST[$key];
        }
    }
    
    $params = $distribuidor;
    $params['eventoId'] = $_POST['eventoId'];
    $params['formulario_contacto'] = $data;
    
    $client = new nusoap_client($service_url.'/soap-reservacion');
    $client->response_timeout = 10000000;
    $client->timeout = 10000000;
    $result = $client->call('contactar', array('params' => $params)); 
    
    $result = json_decode($result);
    
}

if (strcmp($action, "validarCupon") == 0) {
    $data = array(
        'codigo' => NULL,
        'tarifaId' => NULL,
        'sesion' => NULL,
        'fecha' => NULL
    );
    
    foreach(array_keys($data) as $key) {
        if(isset($_POST[$key]) && strlen($_POST[$key]) > 0)
            $data[$key] = $_POST[$key];
    }
    
    if(!is_null($data['fecha'])) {
        $fecha = explode("/", $data['fecha']);
        $data['fecha'] = $fecha[2]."-".$fecha[1]."-".$fecha[0];
    }
    
    $params = $distribuidor;
    $params['cupon'] = $data;
    
    $client = new nusoap_client($service_url.'/soap-cupon');
    $client->response_timeout = 10000000;
    $client->timeout = 10000000;
    $result = $client->call('validar', array('params' => $params)); 
   
    $result = json_decode($result);
}

echo json_encode($result);



?>
