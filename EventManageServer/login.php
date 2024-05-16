<?php
require_once __DIR__ . '/vendor/autoload.php';
require_once 'utils.php';
require_once 'global.php';
require_once 'DB.php';

$result = array();

$result['code'] = 404;
$result['message'] = "Error";
$result['name'] = "";
$result['type'] = "";

if(isset($_POST['email']) && isset($_POST['pass'])){
    $email = $_POST['email'];
    $pass = $_POST['pass'];

    $query = $conn->query("SELECT * FROM `em_admins` WHERE `EMail` = '".$email."' AND `Password` = '".$pass."'");
    if($query->num_rows !== 1){
        $result['message'] = "Invalid Email or Password";
    } else {
        $res = $query->fetch_assoc();
        
        $result['code'] = 200;
        $result['name'] = $res["Name"];

        if(intval($res["isCoordinator"]) === 1){
            $result['type'] = "Coordinator";
        } else if(intval($res["isCampaigner"]) === 1){
            $result['type'] = "Campaigner";
        } else {
            $result['type'] = "Faculty";
        }
    }
} else {
    $result['message'] = "Email and Password are Required";
}

echo toJson($result);