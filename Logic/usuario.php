<?php

function authenticateUsuario($user, $pass) {
    try {
        $args = array("email" => $user, "password" => $pass);

        $customer = DAOFactory::getUsuarioDAO()->queryByArgs($args);
        if (sizeof($customer) > 0)
            return $customer[0];
        else
            return false;
    } catch (Exception $e) {
        return false;
    }
}

function insertUsuario($data = array()) {
    try {
        //set creatrion date.	
        $data["tiempoCreacion"] = date("Y-m-d H:i:s");
        //start new transaction				
        $transaction = new Transaction();

        $customer = DAOFactory::getUsuarioDAO()->prepare($data);
        $new_customer_id = DAOFactory::getUsuarioDAO()->insert($customer);

        $transaction->commit();

        return $new_customer_id;
    } catch (Exception $e) {
        var_dump($e);
        if ($transaction)
            $transaction->rollback();
        return false;
    }
}

function updateUsuario($idUsuario, $data = array()) {
    try {
        //start new transaction	
        $transaction = new Transaction();

        $customer = DAOFactory::getUsuarioDAO()->prepare($data, $idUsuario);

        DAOFactory::getUsuarioDAO()->update($customer);

        $transaction->commit();

        return $customer;
    } catch (Exception $e) {
        if ($transaction)
            $transaction->rollback();
        return false;
    }
}

function deleteUsuario($idUsuario) {
    try {
        //start new transaction	
        $transaction = new Transaction();

        $result = DAOFactory::getUsuarioDAO()->delete($idUsuario);

        if (!$result) {
            throw new Exception("Failed to delete the Events.");
        }
        
        $transaction->commit();

        return $result;
    } catch (Exception $e) {
        if ($transaction)
            $transaction->rollback();
        return false;
    }
}

function getAllUsuarios() {
    try {
        
        $usuarios = DAOFactory::getUsuarioDAO()->queryAll();
        return $usuarios;
        
    } catch (Exception $e) {
        return false;
    }
}

function getUsuario($idUsuario) {
    try {
        $customer = DAOFactory::getUsuarioDAO()->load($idUsuario);
        return $customer;
    } catch (Exception $e) {
        return false;
    }
}

function getUsuarioByEmail($email) {
    try {
        $customer = DAOFactory::getUsuarioDAO()->queryByEmail($email);
        return $customer;
    } catch (Exception $e) {
        return false;
    }
}

function getUsuarios($args = array()) {
    try {
        return DAOFactory::getUsuarioDAO()->queryByArgs($args);
    } catch (Exception $e) {
        return array();
    }
}

function searchUsuarios($args) {
    try {
        return DAOFactory::getUsuarioDAO()->querySearch($args);
    } catch (Exception $e) {
        return array();
    }
}

function getAllGrupos() {
    try {
        
        $grupos = DAOFactory::getGrupoUsuarioDAO()->queryAll();
        return $grupos;
        
    } catch (Exception $e) {
        return false;
    }
}

?>