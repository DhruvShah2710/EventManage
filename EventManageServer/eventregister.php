<?php
require_once __DIR__ . '/vendor/autoload.php';
require_once 'utils.php';
require_once 'global.php';
require_once 'mailer.php';
require_once 'DB.php';

$result = array();

$result['code'] = 404;
$result['message'] = "Error";

if(isset($_POST['email']) && isset($_POST['eventcode'])){
    $email = $_POST['email'];
    $eventcode = $_POST['eventcode'];

    $query = $conn->query("SELECT * FROM `em_events` WHERE `EVCode` = '".$eventcode."'");
    if($query->num_rows !== 1){
        $result['message'] = "Event not found";
    } else {
        $event = $query->fetch_assoc();
        if(strpos($email, '@gmail.com') !== false || strpos($email, '@yahoo.com') !== false || strpos($email, '@outlook.com') !== false || strpos($email, '@outlook.com.au') !== false
            || strpos($email, '@yahoo.in') !== false){
            $query = $conn->query("SELECT * FROM `em_participants` WHERE `EMail` = '".$email."'");
            if($query->num_rows !== 1){
                $result['message'] = "Email is not registered yet";
            } else {
                $parti = $query->fetch_assoc();

                $query = $conn->query("SELECT * FROM `em_event_reg` WHERE `PID` = '".$parti["PID"]."' AND `EVID` = '".$event["EVID"]."'");
                if($query->num_rows !== 1){
                    $fcode = genFileKey();
                    $erentrycode = genID($email, $eventcode);

                    QRImageWithText("qrcodes/" . $fcode . "_qr.png", $erentrycode);

                    //QRCode Sending
                    sendMailWithAttach($email, "Yo! Participation Done..",
                            "Thank You For Participating in " . $event["EVName"] .
                            ".\nHere is your QR Code for Attendance.\n" . $GLOBALS['URL'] . "/api/qr/" . $fcode . "\n\n" .
                            "Please Note that If you haven't Paid Fees During Participation, " .
                            "You need to Pay at Event Venue",
                            $parti["FirstName"] . '_' .
                            preg_replace('/\s+/', '_', $event["EVName"]) . $GLOBALS['QR_Postfix'],
                            "qrcodes/" . $fcode . "_qr.png");

                    $conn->query("INSERT INTO `em_event_reg` (`PID`, `EVID`, `ERCode`, `FCode`, `RegAdmin`, `isPaid`, `isAttended`, `AttendAdmin`, `AttendTime`, `EventRegTime`) 
                                    VALUES ('".$parti["PID"]."', '".$event["EVID"]."', '".$erentrycode."', '".$fcode."', '".$parti["PID"]."', '0', '0', NULL, NULL, NOW())");

                    $result['code'] = 200;
                    $result['message'] = "Event Registration Done";
                } else {
                    $result['message'] = "You already participated in this Event";
                }
            }
        } else {
            $result['message'] = $email . " is not a valid";
        }
    }
} else {
    $result['message'] = "Event participation data not provided";
}

echo toJson($result);
