<?php
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

require __DIR__."/app/vendor/autoload.php";
require __DIR__."/app/src/config/db.php";

$app = new \Slim\App;

require __DIR__."/app/src/routes/smm.php";

$app->run();