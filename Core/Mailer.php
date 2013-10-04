<?php
/*
include_once dirname(__FILE__) . '/../Lib/phpmailer/phpmailer.inc.php';

class Core_Mailer {

    protected $_template = false;
    protected $_mailer = false;

    function __construct(Core_template $template = null) {
        $this->_template = $template;
    }

    public function send_email($to, $subject, $message = false) {
        if ($to && filter_var($to, FILTER_VALIDATE_EMAIL)) {
            $mail = $this->mailer();
            $mail->AddAddress($to);
            $mail->Subject = $subject;
            if ($message) {
                $mail->Body = $message;
                //echo $mail->Body;
            } else if ($this->_template) {
                $mail->IsHTML(true);
                $mail->Body = $this->_template->getContent();
                //echo $mail->Body;
            }
            return $mail->Send();
        } else {
            return false;
        }
    }

    protected function mailer() {
        if (!$this->_mailer) {
            $mail = new phpmailer();
            $mail->CharSet = "UTF-8";
            $mail->Mailer = "smtp";
            $mail->SMTPAuth = true;
            $mail->SMTPSecure = "tls";
            $this->config_mailer($mail);

            $this->_mailer = $mail;
        }
        return $this->_mailer;
    }

    protected function config_mailer($mailer) {
        $mailer->Host = trim(HOST);
        $mailer->Username = trim(USERNAME);
        $mailer->Password = trim(PASSWORD);

        $mailer->From = trim(FROM);
        $mailer->FromName = trim(FROM_NAME);
    }

}*/

?>