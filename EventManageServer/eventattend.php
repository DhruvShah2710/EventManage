<?php
require_once __DIR__ . '/vendor/autoload.php';
require_once 'utils.php';
require_once 'global.php';
require_once 'mailer.php';
require_once 'DB.php';

$result = array();

$result['code'] = 404;
$result['name'] = "";
$result['event'] = "";
$result['email'] = "";
$result['message'] = "Error";

if(isset($_POST['email']) && isset($_POST['eventcode'])){
    $email = $_POST['email'];
    $eventcode = $_POST['eventcode'];

    if(strpos($email, '@gmail.com') !== false || strpos($email, '@yahoo.com') !== false
            || strpos($email, '@yahoo.in') !== false){
        $query = $conn->query("SELECT * FROM `em_admins` WHERE `EMail` = '".$email."'");
        if($query->num_rows !== 1){
            $result['message'] = "Invalid Admin";
        } else {
            $admin = $query->fetch_assoc();

            if($admin["isCoordinator"] == 1){
                $query = $conn->query("SELECT * FROM `em_event_reg` WHERE `ERCODE` = '".$eventcode."'");
                if($query->num_rows !== 1){
                    $result['message'] = "Invalid Code";
                } else {
                    $erdata = $query->fetch_assoc();

                    $query = $conn->query("SELECT * FROM `em_events` WHERE `EVID` = '".$erdata["EVID"]."'");
                    $event = $query->fetch_assoc();

                    $query = $conn->query("SELECT * FROM `em_participants` WHERE `PID` = '".$erdata["PID"]."'");
                    $parti= $query->fetch_assoc();

                    if (intval($erdata["isAttended"]) == 0) {
                        $conn->query("UPDATE `em_event_reg` SET `isAttended`='1',`AttendAdmin`='".$admin["AID"]."',`AttendTime`=NOW() WHERE `ERCODE`='".$eventcode."'");

                        sendMail($parti["EMail"], "Hurray! Attendance Done..",
                                        "Hurray! You have attended Your Participated Event, " . $event["EVName"] . " Of " .
                                        $event["EVDepartment"] . " Department\n\n");

                        $result['code'] = 200;
                        $result['name'] = $parti["FirstName"] . " " . $parti["LastName"];
                        $result['event'] = $event["EVName"];
                        $result['email'] = $parti["EMail"];
                        $result['message'] = "You have Successfully Attend This Event!";
                    } else {
                        $result['message'] = "You have Already Attended This Event!";
                    }
                }
            } else {
                $result['message'] = "Only Coordinator Can Set Attendance";
            }
        }
    } else {
        $result['message'] = $email . " is not a valid";
    }
} else {
    $result['message'] = "Event participation data not provided";
}

echo toJson($result);