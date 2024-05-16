<?php
require_once __DIR__ . '/vendor/autoload.php';
require_once 'utils.php';
require_once 'global.php';
require_once 'DB.php';

$result = array();

$query = $conn->query("SELECT * FROM `em_event_reg`");
while ($row = $query->fetch_assoc()) {
    $query1 = $conn->query("SELECT * FROM `em_participants` WHERE PID = '".$row["PID"]."'");
    $parti = $query1->fetch_assoc();

    $query2 = $conn->query("SELECT * FROM `em_events` WHERE EVID = '".$row["EVID"]."'");
    $event = $query2->fetch_assoc();

    $result[] = array(
        "id" => intval($row["ERID"]),
        "name" => $parti["FirstName"] . " " . $parti["LastName"],
        "phoneNumber" => $parti["Mobile"],
        "semester" => $parti["Semester"],
        "email" => $parti["EMail"],
        "college" => $parti["College"],
        "eventName" => $event["EVName"].(intval($row["isAttended"]) == 1 ? " (Attended)" : "")
    );
}

echo toJson($result);