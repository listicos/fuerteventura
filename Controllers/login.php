<?php
if (isset($_POST['usuario']) && isset($_POST['password'])) {
    $email = $_POST['usuario'];
    $password = $_POST['password'];
    $usuario = authenticateUsuario($email, $password);
    if ($usuario) {
        $usuario_core->setUsuario($usuario);
        header('Location:'.$init_url);
        /*if (isset($_SESSION['user_redirect'])) {
            header('Location:'.$_SESSION['user_redirect']);
        } else {
            header('Location:'.$init_url);
        }*/
    }else{
    	$smarty->assign('msg','El nombre de usuario o contraseña son incorrectos.');
        $smarty->assign('usuario', $email);
    }
}
$smarty->display('login.tpl');
?>