<?php
$action = $_GET["action"];
$result = array("msg" => "error", "data" => "Tu no tienes suficientes permisos.");

if (strcmp($action, "set") == 0) {
    $_SESSION['lang'] = $_GET['lang'];
    $result = array("msg" => "ok", "data" => "El email fue enviado.");
}

echo json_encode($result);
?>