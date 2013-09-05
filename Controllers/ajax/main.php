<?php

//$usuario_core->validateUser();
$action = $_POST["action"];
$result = array("msg" => "error", "data" => "Tu no tienes suficientes permisos.");

if (strcmp($action, "make_question") == 0) {

    $mailer = new Core_Mailer();
    //$opinion = getOpinion($_POST['idOpinion']);
    $from = "zapata46_9@hotmail.com";
    $to = $_POST['email'];
    $subject = "You make a question";
    $body = $_POST['message'];
    if($mailer->send_email($to, $subject, $body)){
        $result = array("msg" => "ok", "data" => "El email fue enviado.");
    }else{
        $result = array("msg" => "error", "data" => "El email no fue enviado.");
    }
    
    //$template = new Core_template('admin/reserva/correo.php');
    //$template->setAttribute('reserva', $reserva_array);
    //$result = array("msg" => "ok", "data" => "Opiniones encontradas.", 'idReservacion' => '', 'html' => $template->getContent());
}

echo json_encode($result);
?>
