<?php

class Core_Usuario {

    protected $usuario = false;
    private static $instancia = NULL;
    protected $api_client = false;

    private function __construct() {
        
    }

    public static function getInstance() {
        if (!self::$instancia instanceof self) {
            self::$instancia = new self;
        }
        return self::$instancia;
    }

    public function cleanSession() {
        unset($_SESSION['usuario']);
        unset($_SESSION['api_client']);
        $this->usuario = false;
    }

    public function setUsuario($usuario, $api_client = false) {
        $_SESSION['usuario'] = serialize($usuario);
        $_SESSION['api_client'] = $api_client;
        $this->usuario = $usuario;
    }

    public function validateUser($redirect = true) {

        if (isset($_SESSION['usuario'])) {
            return true;
        } else {
            if ($redirect)
                $this->loginRedirect();
            else
                return false;
        }
    }

    public static function loginRedirect() {
        global $base_url;
        $url = Core_Util_General::getCurrentUrl();
        if (strpos('Scripts', $url) === false)
            $_SESSION['user_redirect'] = $url;
        else
            $_SESSION['user_redirect'] = $base_url;

        header('Location:' . $base_url . '/login');
    }

    public function getApiClient() {
        if (!$this->api_client && isset($_SESSION['api_client']) && !$_SESSION['api_client']) {
            $this->api_client = $_SESSION['api_client'];
            return $_SESSION['api_client'];
        }return false;
    }

    public function getUsuario() {
        if (isset($_SESSION['usuario'])) {
            $this->usuario = unserialize($_SESSION['usuario']);
            return $this->usuario;
        } else {
            return false;
        }
    }

    public function getLoginUrl($api_client = false) {
        global $base_url;
        if (!$api_client)
            $api_client = $this->getApiClient();
        switch ($api_client) {
            case 'facebook':
                $facebook_a = new Core_SocialNetwork_Facebook();
                return $facebook_a->getLoginUrl();
                break;
            case 'linkedin':
                $linkedin_a = new Core_SocialNetwork_Linkedin();
                return $linkedin_a->getLoginUrl();
                break;
            default:
                return $base_url . '/login';
                break;
        }
    }

    public function getLogoutUrl($api_client = false) {
        global $base_url;
        if (!$api_client)
            $api_client = $this->getApiClient();
        switch ($api_client) {
            case 'facebook':
                $facebook_a = new Core_SocialNetwork_Facebook();
                return $facebook_a->getLogoutUrl();
                break;
            default:
                return $base_url . '/logout/api:none';
                break;
        }
    }

    public function validateLogin($user, $pass) {
        $response = authenticateCustomer($user, $pass);
        if ($response) {
            return $response;
        } else {
            return false;
        }
    }

    public function validateToken($token) {
        return true;
    }

    public function generatePassword($longitud, $tipo = "alfanumerico") {
        if ($tipo == "alfanumerico")
            $exp_reg = "[^A-Z0-9a-z]";
        elseif ($tipo == "numerico")
            $exp_reg = "[^0-9]";

        return substr(preg_replace($exp_reg, "", md5(rand())) . preg_replace($exp_reg, "", md5(rand())) . preg_replace($exp_reg, "", md5(rand())), 0, $longitud);
    }

    public function encrypt($string) {
        $key = md5("12345678");
        $result = '';
        for ($i = 0; $i < strlen($string); $i++) {
            $char = substr($string, $i, 1);
            $keychar = substr($key, ($i % strlen($key)) - 1, 1);
            $char = chr(ord($char) + ord($keychar));
            $result.=$char;
        }
        return urlencode(base64_encode($result));
    }

    public function decrypt($string) {
        $key = md5("12345678");
        $result = '';
        $string = urldecode(base64_decode($string));

        for ($i = 0; $i < strlen($string); $i++) {
            $char = substr($string, $i, 1);
            $keychar = substr($key, ($i % strlen($key)) - 1, 1);
            $char = chr(ord($char) - ord($keychar));
            $result.=$char;
        }
        return $result;
    }

    public function getToken() {
        return '';
    }

}

?>