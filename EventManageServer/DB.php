<?php

$conn = new mysqli("localhost", "root", "root", "evdb");
if($conn->connect_error != null){
    die($conn->connect_error);
}
