<?php

if(isset($_GET['id'])) {
    //require_once('Lib/recaptcha/recaptchalib.php');

    $client = new nusoap_client($service_url."/soap-evento");
    $params = $distribuidor;
    $params['id'] = $_GET['id'];
    $client->debug_flag = true;
    $result = $client->call('get', array('params' => $params));    
    $result = json_decode($result);
    $smarty->assign('excursion', $result->data);
    
    $cantidades = array();
    for($i=0;$i<51;$i++) {
        array_push($cantidades, $i);
    }
    $smarty->assign('cantidades', $cantidades);
    
    if(isset($_GET['fecha'])) {
        $fechaSeleccionada = $_GET['fecha'];
        
        $smarty->assign('fechaSeleccionada', $fechaSeleccionada);
    }
    //$recaptcha_html = recaptcha_get_html($republickey, $error);
    //$smarty->assign('recaptcha_html', $recaptcha_html);
}

$smarty->display('detalle.tpl');
?>