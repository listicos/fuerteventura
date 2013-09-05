<?php
$usuario_core->cleanSession();
session_destroy();
header('Location: '.$base_url);
?>