<?php

if(isset($_REQUEST['Ds_Order'])) {
    $order = $_REQUEST['Ds_Order'];
    $estado = 'Pagada';
    
    $reservacion = getReservacionByCodigo($order);
    $data = array('estado'=>'Pagada');
    $updated = updateReservacion($reservacion->id, $data);
    
    $data_pago = array( 'orden' => $order, 'reservacionId' => $reservacion->id );
    
    if(isset($_REQUEST['Ds_Date']))
        $data_pago['fecha'] = $_REQUEST['Ds_Date'];
    if(isset($_REQUEST['Ds_Hour']))
        $data_pago['hora'] = $_REQUEST['Ds_Hour'];
    if(isset($_REQUEST['Ds_SecurePayment']))
        $data_pago['pagoSeguro'] = $_REQUEST['Ds_SecurePayment'];
    if(isset($_REQUEST['Ds_Amount']))
        $data_pago['cantidad'] = $_REQUEST['Ds_Amount'];
    if(isset($_REQUEST['Ds_Currency']))
        $data_pago['moneda'] = $_REQUEST['Ds_Currency'];
    if(isset($_REQUEST['Ds_MerchantCode']))
        $data_pago['codigo'] = $_REQUEST['Ds_MerchantCode'];
    if(isset($_REQUEST['Ds_Terminal']))
        $data_pago['terminal'] = $_REQUEST['Ds_Terminal'];
    if(isset($_REQUEST['Ds_Signature']))
        $data_pago['firma'] = $_REQUEST['Ds_Signature'];
    if(isset($_REQUEST['Ds_TransactionType']))
        $data_pago['tipo'] = $_REQUEST['Ds_TransactionType'];
    if(isset($_REQUEST['Ds_AuthorisationCode']))
        $data_pago['autorizacion'] = $_REQUEST['Ds_AuthorisationCode'];
    if(isset($_REQUEST['Ds_ConsumerLanguage']))
        $data_pago['idioma'] = $_REQUEST['Ds_ConsumerLanguage'];
    if(isset($_REQUEST['Ds_Card_Country']))
        $data_pago['pais'] = $_REQUEST['Ds_Card_Country'];
    
    $params = $distribuidor;
    $params['codigo'] = $order;
    $params['estado'] = $estado;
    $params['pago'] = $data_pago;
    
    $client = new nusoap_client($service_url.'/soap-reservacion');
    $result = $client->call('cambiarEstado', array('params' => $params));
    $result = json_decode($result);
    $smarty->assign('order',$order);
    $smarty->display('confirmar.tpl');
    //echo $result->msg;
    
} else {
    echo 'Faltan parametros obligatorios';
}
?>