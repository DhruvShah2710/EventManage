<?php
require_once __DIR__ . '/vendor/autoload.php';
require_once 'utils.php';
require_once 'global.php';
require_once 'mailer.php';
require_once 'DB.php';

$result = array();

$result['code'] = 404;
$result['message'] = "Error";

if(isset($_POST['email']) && isset($_POST['fname']) && isset($_POST['lname']) && isset($_POST['college']) 
    && isset($_POST['department']) && isset($_POST['semester']) && isset($_POST['mobile']) && isset($_POST['gender'])){
    $email = $_POST['email'];
    $fname = $_POST['fname'];
    $lname = $_POST['lname'];
    $college = $_POST['college'];
    $dept = $_POST['department'];
    $sem = $_POST['semester'];
    $mobile = str_replace("+61","", $_POST['mobile']);
    $gender = $_POST['gender'];

    if(strpos($email, '@gmail.com') !== false || strpos($email, '@yahoo.com') !== false || strpos($email, '@outlook.com') !== false || strpos($email, '@outlook.com.au') !== false
        || strpos($email, '@yahoo.in') !== false){
        $query = $conn->query("SELECT * FROM `em_participants` WHERE `EMail` = '".$email."'");
        if($query->num_rows !== 1){
            $conn->query("INSERT INTO `em_participants` (`EMail`, `FirstName`, `LastName`, `College`, `Department`, `Semester`, `Mobile`, `Gender`, `RegisterTime`) VALUES 
                            ('".$email."', '".$fname."', '".$lname."', '".$college."', '".$dept."', '".$sem."', '".$mobile."', '".$gender."', CURRENT_TIMESTAMP)");

            sendMail($email, "Hurray! Registration Done..",
            "We heartily welcome you to the technology festival at UTS.\n\n".
            "You can start participating in your desired events");

            $result['code'] = 200;
            $result['message'] = "Registration Done";
        } else {
            $res = $query->fetch_assoc();
            $result['message'] = "Already Registered";
        }
    } else {
        $result['message'] = $email . " is not a valid";
    }
} else {
    $result['message'] = "Registration data not provided";
}

echo toJson($result);
