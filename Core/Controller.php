<?php

class Core_Controller {

    public function getFileAction() {
        $this->clean_vars();
        $contoller_path = dirname(__FILE__) . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'Controllers' . DIRECTORY_SEPARATOR;
        $file_action = 'index.php';
        if (isset($_REQUEST['args'])) {
            $url_request = strip_tags($_REQUEST['args']);
            $args = explode("/", $url_request);
            $action = str_replace('-', DIRECTORY_SEPARATOR, $args[0]);
            $file_action = $action . '.php';

            if (count($args) > 1) {
                foreach ($args as $arg) {
                    if (strstr($arg, ':') !== false) {
                        $var = explode(':', $arg);
                        if ($var && count($var) > 1) {
                            $_GET[$var[0]] = $var[1];
                            $_REQUEST[$var[0]] = $var[1];
                        }
                    }
                }
            }
        }
        return $contoller_path . $file_action;
    }

    public function clean_vars() {
        if ($_POST && is_array($_POST) && count($_POST) > 0) {
            foreach ($_POST as $p_k => $p_v) {
                if (is_string($p_v))
                    $_POST[$p_k] = strip_tags($p_v);
            }
        }
        if ($_GET && is_array($_GET) && count($_GET) > 0) {
            foreach ($_GET as $p_k => $p_v) {
                if (is_string($p_v))
                    $_GET[$p_k] = strip_tags($p_v);
            }
        }
        if ($_REQUEST && is_array($_REQUEST) && count($_REQUEST) > 0) {
            foreach ($_REQUEST as $p_k => $p_v) {
                if (is_string($p_v))
                    $_REQUEST[$p_k] = strip_tags($p_v);
            }
        }
    }

}

?>