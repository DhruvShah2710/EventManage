<?php
require_once __DIR__ . '/vendor/autoload.php';

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

function sendMail($eMail, $subject, $data){
    $mail = new PHPMailer(true);
    try {
        $mail->isSMTP();
        $mail->Host = 'smtp-relay.brevo.com';
        $mail->SMTPAuth = true;
        $mail->Username = '<username>';
        $mail->Password = '<password>';
        $mail->SMTPSecure = 'tls';
        $mail->Port = 587;

        $mail->setFrom('<email>', 'EventManage');
        $mail->addAddress($eMail);
        $mail->addCC('<email>');

        $mail->Subject = $subject;
        $mail->Body = $data;

        $mail->send();
    } catch (Exception $e) {
        error_log('Message could not be sent. Mailer Error: ' . $mail->ErrorInfo);
    }
}

function sendMailWithAttach($eMail, $subject, $data, $attachname, $attachpath){
    $mail = new PHPMailer(true);
    try {
        $mail->isSMTP();
        $mail->Host = 'smtp-relay.brevo.com';
        $mail->SMTPAuth = true;
        $mail->Username = '<username>';
        $mail->Password = '<password>';
        $mail->SMTPSecure = 'tls';
        $mail->Port = 587;

        $mail->setFrom('<email>', 'EventManage');
        $mail->addAddress($eMail);
        $mail->addCC('<email>');

        $mail->addAttachment($attachpath, $attachname);

        $mail->Subject = $subject;
        $mail->Body = $data;

        $mail->send();
    } catch (Exception $e) {
        error_log('Message could not be sent. Mailer Error: ' . $mail->ErrorInfo);
    }
}
