<?php

if(isset($_GET['id'])) {
    $client = new nusoap_client($service_url."/soap-evento");
    $params = $distribuidor;
    $params['id'] = $_GET['id'];
    $client->debug_flag = true;
    $result = $client->call('get', array('params' => $params));    
    $result = json_decode($result);
    $excursion = $result->data;
    $smarty->assign('excursion', $excursion);
    
    $result = $client->call('excursiones', array('params'=> $params));
    $result = json_decode($result);
    $excursiones = $result->data;
    
    foreach ($excursiones as $ex) {
        if($ex->tipologiaId == $excursion->tipologiaId && $ex->id != $excursion->id) {
            $smarty->assign('otraexcursion', $ex);
            break;
        }            
    }
    
    $cantidades = array();
    for($i=0;$i<51;$i++) {
        array_push($cantidades, $i);
    }
    $smarty->assign('cantidades', $cantidades);
    
    if(isset($_GET['fecha'])) {
        $fechaSeleccionada = $_GET['fecha'];
        
        $smarty->assign('fechaSeleccionada', $fechaSeleccionada);
    }
    $countries = Core_Util_General::countries();
    $smarty->assign('countries',$countries);
    $smarty->assign('current_url','http://'.$_SERVER["SERVER_NAME"].$_SERVER["REQUEST_URI"]);
}

$smarty->display('detalle.tpl');
?>