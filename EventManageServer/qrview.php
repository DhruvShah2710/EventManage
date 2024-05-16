<?php
//api url filter
if (strpos($_SERVER['REQUEST_URI'], "qrview.php")) {
    require_once 'utils.php';
    PlainDie();
}

require_once 'utils.php';
require_once 'global.php';

$fcode = $_GET['code'];
$fpath = "qrcodes/" . $fcode . "_qr.png";
if(file_exists($fpath)){
    header("Content-type: image/png");
    header("Content-Disposition: inline; filename=Event".$QR_Postfix);
    @readfile($fpath);
} else {
    PlainDie("Not Found");
}
