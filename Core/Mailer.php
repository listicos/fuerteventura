<?php

include_once dirname(__FILE__) . '/../Lib/phpmailer/class.phpmailer.php';

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
                $mail->MsgHTML($message);
                
            } else if ($this->_template) {
                $mail->IsHTML(true);
                $mail->MsgHTML($this->_template->getContent());
                
            }
            if($mail->Send()) {
                return true;
            } else {
                echo $mail->ErrorInfo;
                return false;
            }
        } else {
            return false;
        }
    }

    protected function mailer() {
        if (!$this->_mailer) {
            $mail = new PHPMailer();
            $mail->CharSet = "UTF-8";
            $mail->Mailer = "smtp";
            $mail->SMTPAuth = true;
            $mail->SMTPSecure = "ssl";
            $this->config_mailer($mail);

            $this->_mailer = $mail;
        }
        return $this->_mailer;
    }

    protected function config_mailer($mailer) {
        $mailer->Host = trim('smtp.gmail.com');
        $mailer->Port = 465;
        $mailer->Username = trim('ruben.listico@gmail.com');
        $mailer->Password = trim('534%$DcdE23');

        $mailer->setFrom('ruben.listico@gmail.com', 'Fuerteventura');
        $mailer->FromName = trim('Fuerteventura');
    }

}

?>