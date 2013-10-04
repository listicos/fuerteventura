<?php

if(isset($_REQUEST['Ds_Order'])) {
    $order = $_REQUEST['Ds_Order'];
    $estado = 'Denegado';
    
    $params = $distribuidor;
    $params['codigo'] = $order;
    $params['estado'] = $estado;
    
    $client = new nusoap_client($service_url.'/soap-reservacion');
    $result = $client->call('cambiarEstado', array('params' => $params));
    $result = json_decode($result);
    $smarty->assign('order',$order);
    $smarty->display('denegar.tpl');
} else {
    echo 'Faltan parametros obligatorios';
}
?>