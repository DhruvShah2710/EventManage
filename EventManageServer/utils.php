<?php
require_once __DIR__ . '/vendor/autoload.php';

use chillerlan\QRCode\{QRCode, QROptions};
use chillerlan\QRCode\Output\QRGdImagePNG;

class QRImageWithText extends QRGdImagePNG {

    /**
     * @inheritDoc
     */
    public function dump(string $file = null, string $text = null):string{
        // set returnResource to true to skip further processing for now
        $this->options->returnResource = true;

        // there's no need to save the result of dump() into $this->image here
        parent::dump($file);

        // render text output if a string is given
        if($text !== null){
            $this->addText($text);
        }

        $imageData = $this->dumpImage();

        $this->saveToFile($imageData, $file);

        if($this->options->outputBase64){
            $imageData = $this->toBase64DataURI($imageData);
        }

        return $imageData;
    }

    protected function addText(string $text):void{
        // save the qrcode image
        $qrcode = $this->image;

        // options things
        $textSize  = 3; // see imagefontheight() and imagefontwidth()
        $textBG    = [200, 200, 200];
        $textColor = [50, 50, 50];

        $bgWidth  = $this->length;
        $bgHeight = ($bgWidth + 20); // 20px extra space

        // create a new image with additional space
        $this->image = imagecreatetruecolor($bgWidth, $bgHeight);
        $background  = imagecolorallocate($this->image, ...$textBG);

        // allow transparency
        if($this->options->imageTransparent){
            imagecolortransparent($this->image, $background);
        }

        // fill the background
        imagefilledrectangle($this->image, 0, 0, $bgWidth, $bgHeight, $background);

        // copy over the qrcode
        imagecopymerge($this->image, $qrcode, 0, 0, 0, 0, $this->length, $this->length, 100);
        imagedestroy($qrcode);

        $fontColor = imagecolorallocate($this->image, ...$textColor);
        $w         = imagefontwidth($textSize);
        $x         = round(($bgWidth - strlen($text) * $w) / 2);

        // loop through the string and draw the letters
        foreach(str_split($text) as $i => $chr){
            imagechar($this->image, $textSize, (int)($i * $w + $x), $this->length, $chr, $fontColor);
        }
    }
}

function QRImageWithText($file, $data){
    $options = new QROptions;
    $options->version      = 7;
    $options->scale        = 3;
    $options->outputBase64 = false;
    
    $qrcode = new QRCode($options);
    $qrcode->addByteSegment($data);
    
    $qrOutputInterface = new QRImageWithText($options, $qrcode->getQRMatrix());
    
    $out = $qrOutputInterface->dump($file, $data);
}

function genID($email, $event, $pcount=1){
    $hash = strtoupper(substr(sha1($email.$event.$pcount), 0, 6));
    if($pcount > 1){
        return "EV-".$event."-".$pcount."-".$hash;
    } else {
        return "EV-".$event."-".$hash;
    }
}

function genFileKey(){
    $seed = myexplode("abcdefghijklmnopqrstuvwxyz1234567890");
    $uname = array();
    $size = 0;
    while($size != 10){
        $uname[$size] = $seed[mt_rand(0,count($seed)-1)];
        $size++;
    }
    return implode($uname);
}

function genApiKey(){
    $seed = myexplode("ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890");
    $uname = array();
    $size = 0;
    while($size != 18){
        $uname[$size] = $seed[mt_rand(0,count($seed)-1)];
        $size++;
    }
    return implode($uname);
}

function genPassKey(){
    $seed = myexplode("ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890");
    $uname = array();
    $size = 0;
    while($size != 7){
        $uname[$size] = $seed[mt_rand(0,count($seed)-1)];
        $size++;
    }
    return implode($uname);
}

function myexplode($str){
    $out = array();
    for ($i = 0; $i < strlen($str); $i++) {
        $out[$i] = substr($str, $i, 1);
    }
    return $out;
}

function getMicro(){
    return explode(' ', microtime())[1];
}

function readFileData($path){
    $file = fopen($path,"r") or die();
    $data = fread($file,filesize($path));
    fclose($file);
    return $data;
}

function isFileExist($path){
    if (file_exists($path)) {
        return 1;
    }
    return 0;
}

function toBase64($data){
    return base64_encode($data);
}

function fromBase64($data){
    return base64_decode($data);
}

function urlsafe_b64encode($string) {
    $data = base64_encode($string);
    $data = str_replace(array('+','/','='),array('-','_',''),$data);
    return $data;
}

function urlsafe_b64decode($string) {
    $data = str_replace(array('-','_'),array('+','/'),$string);
    $mod4 = strlen($data) % 4;
    if ($mod4) {
        $data .= substr('====', $mod4);
    }
    return base64_decode($data);
}

function toJson($data){
    return json_encode($data);
}

function fromJson($data){
    return json_decode($data, true);
}

function PlainDie($status = "404 File Not Found"){
    header('Content-type: text/plain');
    die($status);
}
