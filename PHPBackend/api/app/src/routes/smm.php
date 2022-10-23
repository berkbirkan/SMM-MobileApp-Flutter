<?php
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

$app = new \Slim\App;



// Login 

$app->post('/login', function (Request $request, Response $response){

    $user_username = addslashes(htmlspecialchars(trim($request->getParam("user_username"))));
    $user_password = addslashes(htmlspecialchars(trim($request->getParam("user_password"))));

    if(!empty($user_username) && !empty($user_password))
    {
        $db = new Db();
        try
        {
            $db = $db->connect();
            $user = $db->query("SELECT * FROM users WHERE user_username = '{$user_username}'")->fetch(PDO::FETCH_OBJ);
            if($user)
            {
                if (password_verify($user_password,$user->user_password))
                {
                    return $response
                    ->withStatus(200)
                    ->withHeader("Content-Type", 'application/json;charset=utf-8')
                    ->withJson(array(
                        "message" => array(
                            "login"  => "true"
                        )
                    ));
                }
                else
                {
                    return $response
                    ->withStatus(200)
                    ->withHeader("Content-Type", 'application/json;charset=utf-8')
                    ->withJson(array(
                        "message" => array(
                            "login"  => "false"
                        )
                    ));
                }
            }
            else
            {
                return $response
                    ->withStatus(200)
                    ->withHeader("Content-Type", 'application/json;charset=utf-8')
                    ->withJson(array(
                        "message" => array(
                            "login"  => "false"
                        )
                    ));
            }

        }
        catch(PDOException $e)
        {
            return $response->withJson(
                array(
                    "error" => array(
                        "text"  => $e->getMessage(),
                        "code"  => $e->getCode()
                    )
                )
            );
        }
        $db = null;
    }
    else
    {
        return $response
            ->withStatus(200)
            ->withHeader("Content-Type", 'application/json;charset=utf-8')
            ->withJson(array(
                "error" => array(
                    "text"  => "Boş Alanlar Bırakmayınız."
                )
            ));
    }
});

// Register

$app->post('/register', function (Request $request, Response $response){
    $user_username = addslashes(htmlspecialchars(trim($request->getParam("user_username"))));
    $user_password = password_hash(addslashes(htmlspecialchars(trim($request->getParam("user_password")))),PASSWORD_DEFAULT);
    $user_name = addslashes(htmlspecialchars(trim($request->getParam("user_name"))));
    $user_surname = addslashes(htmlspecialchars(trim($request->getParam("user_surname"))));
    $user_email = addslashes(htmlspecialchars(trim($request->getParam("user_email"))));
    $user_kredi = addslashes(htmlspecialchars(trim($request->getParam("user_kredi"))));

    if($user_kredi<0 || empty($user_kredi))
    {
        $user_kredi = 0;
    }

    if(!empty($user_username) && !empty($user_password) && !empty($user_name) && !empty($user_surname) && !empty($user_email))
    {
        $db = new Db();
        try
        {
            $db = $db->connect();
            $user = $db->query("SELECT * FROM users WHERE user_username = '{$user_username}'")->fetch(PDO::FETCH_OBJ);
            if($user)
            {
                return $response
                    ->withStatus(200)
                    ->withHeader("Content-Type", 'application/json;charset=utf-8;charset=utf-8')
                    ->withJson(array(
                        "message" => array(
                            "register"  => "username-false"
                        )
                    ));
            }
            else
            {
                

                $statement = "INSERT INTO users (user_username,user_password,user_name,user_surname,user_email,user_kredi) VALUES(:user_username, :user_password,:user_name,:user_surname,:user_email,:user_kredi)";
                $prepare = $db->prepare($statement);

                $prepare->bindParam("user_username", $user_username);
                $prepare->bindParam("user_password", $user_password);
                $prepare->bindParam("user_name", $user_name);
                $prepare->bindParam("user_surname", $user_surname);
                $prepare->bindParam("user_email", $user_email);
                $prepare->bindParam("user_kredi", $user_kredi);


                $user = $prepare->execute();

                if($user)
                {
                    return $response
                        ->withStatus(200)
                        ->withHeader("Content-Type", 'application/json;charset=utf-8')
                        ->withJson(array(
                            "message" => array(
                                "register"  => "true"
                            )
                        ));

                }
                else
                {
                    return $response
                        ->withStatus(200)
                        ->withHeader("Content-Type", 'application/json;charset=utf-8')
                        ->withJson(array(
                            "message" => array(
                                "register"  => "false"
                            )
                        ));
                }
            }

        }
        catch(PDOException $e)
        {
            return $response->withJson(
                array(
                    "error" => array(
                        "text"  => $e->getMessage(),
                        "code"  => $e->getCode()
                    )
                )
            );
        }
        $db = null;
    }
    else
    {
        return $response
            ->withStatus(200)
            ->withHeader("Content-Type", 'application/json;charset=utf-8')
            ->withJson(array(
                "error" => array(
                    "text"  => "Boş Alanlar Bırakmayınız."
                )
            ));
    }
});

//User List

$app->post('/user/list', function (Request $request, Response $response){

    $user_username = $request->getParam("user_username");
    if(!empty($user_username))
    {
        $db = new Db();
        try
        {
            $db = $db->connect();
            $user = $db->query("SELECT * FROM users where user_username = '{$user_username}'")->fetch(PDO::FETCH_OBJ);
            if($user)
            {
                return $response
                    ->withStatus(200)
                    ->withHeader("Content-Type", 'application/json;charset=utf-8')
                    ->withJson($user);
            }
            else
            {
                return $response
                    ->withStatus(200)
                    ->withHeader("Content-Type", 'application/json;charset=utf-8')
                    ->withJson(array(
                        "error" => array(
                            "text"  => "Böyle bir Kullanıcı yok."
                        )
                    ));
            }
        }
        catch(PDOException $e)
        {
            return $response->withJson(
                array(
                    "error" => array(
                        "text"  => $e->getMessage(),
                        "code"  => $e->getCode()
                    )
                )
            );
        }
        $db = null;
    }
    else
    {
        return $response
            ->withStatus(200)
            ->withHeader("Content-Type", 'application/json;charset=utf-8')
            ->withJson(array(
                "error" => array(
                    "text"  => "Boş alan Bırakmayanız."
                )
            ));
    }
});

// payment işlemleri
$app->get('/payment/list',function (Request $request , Response $response){

    $db = new Db();
    try
    {
        $db = $db->connect();
        $payment = $db->query("SELECT * FROM payments")->fetch(PDO::FETCH_OBJ);
        if($payment)
        {
            return $response
                ->withStatus(200)
                ->withHeader("Content-Type", 'application/json;charset=utf-8')
                ->withJson($payment);
        }
        else
        {
            return $response
                ->withStatus(200)
                ->withHeader("Content-Type", 'application/json;charset=utf-8')
                ->withJson(array(
                    "error" => array(
                        "text"  => "KAYITLI HERHANGİ BİR KAYIT YOK"
                    )
                ));
        }
    }
    catch(PDOException $e)
    {
        return $response->withJson(
            array(
                "error" => array(
                    "text"  => $e->getMessage(),
                    "code"  => $e->getCode()
                )
            )
        );
    }
    $db = null;
});

// Kredi İşlemleri

$app->post('/credit/add', function (Request $request, Response $response){

    $user_username = $request->getParam("user_username");
    $user_amount = $request->getParam("user_amount");

    if(!empty($user_username) && !empty($user_amount))
    {
        $db = new Db();
        try
        {
            $db = $db->connect();
            $user = $db->query("SELECT * FROM users WHERE user_username = '{$user_username}'")->fetch(PDO::FETCH_OBJ);
            if($user)
            {


                $statement = "UPDATE users SET user_kredi = user_kredi + :user_kredi WHERE user_username = '{$user_username}' ";
                $prepare = $db->prepare($statement);
                $prepare->bindParam("user_kredi",$user_amount);

                $credit = $prepare->execute();

                if($credit)
                {
                    return $response
                        ->withStatus(200)
                        ->withHeader("Content-Type", 'application/json;charset=utf-8')
                        ->withJson(array(
                            "message" => array(
                                "Credit-add"  => "true"
                            )
                        ));
                }
                else
                {
                    return $response
                        ->withStatus(200)
                        ->withHeader("Content-Type", 'application/json;charset=utf-8')
                        ->withJson(array(
                            "message" => array(
                                "Credit-add"  => "false"
                            )
                        ));
                }
            }
            else
            {
                return $response
                    ->withStatus(200)
                    ->withHeader("Content-Type", 'application/json;charset=utf-8')
                    ->withJson(array(
                        "message" => array(
                            "Credit-add"  => "no-user"
                        )
                    ));
            }

        }
        catch(PDOException $e)
        {
            return $response->withJson(
                array(
                    "error" => array(
                        "text"  => $e->getMessage(),
                        "code"  => $e->getCode()
                    )
                )
            );
        }
        $db = null;
    }
    else
    {
        return $response
            ->withStatus(200)
            ->withHeader("Content-Type", 'application/json;charset=utf-8')
            ->withJson(array(
                "error" => array(
                    "text"  => "Boş Alanlar Bırakmayınız."
                )
            ));
    }
});

$app->post('/credit/remove', function (Request $request, Response $response){

    $user_username = $request->getParam("user_username");
    $user_amount = $request->getParam("user_amount");

    if(!empty($user_username) && !empty($user_amount))
    {
        $db = new Db();
        try
        {
            $db = $db->connect();
            $user = $db->query("SELECT * FROM users WHERE user_username = '{$user_username}'")->fetch(PDO::FETCH_ASSOC);
            if($user)
            {
                $user_kredi = $user["user_kredi"];

                if($user_kredi>=$user_amount)
                {

                    $statement = "UPDATE users SET user_kredi = user_kredi - :user_kredi WHERE user_username = '{$user_username}' ";
                    $prepare = $db->prepare($statement);
                    $prepare->bindParam("user_kredi",$user_amount);
                    $credit = $prepare->execute();

                    if($credit)
                    {
                        return $response
                            ->withStatus(200)
                            ->withHeader("Content-Type", 'application/json;charset=utf-8')
                            ->withJson(array(
                                "message" => "success",
                                "status" => "true"
                            ));
                    }
                    else
                    {
                        return $response
                            ->withStatus(200)
                            ->withHeader("Content-Type", 'application/json;charset=utf-8')
                            ->withJson(array(
                                "message" => "Failed",
                                "status" => "false"
                            ));
                    }
                }
                else
                {
                    return $response
                        ->withStatus(200)
                        ->withHeader("Content-Type", 'application/json;charset=utf-8')
                        ->withJson(array(
                            "message" => "There is no enough credit",
                            "status" => "false"
                        ));
                }
            }
            else
            {
                return $response
                    ->withStatus(200)
                    ->withHeader("Content-Type", 'application/json;charset=utf-8')
                    ->withJson(array(
                        "message" => array(
                            "Credit-remove"  => "no-user"
                        )
                    ));
            }

        }
        catch(PDOException $e)
        {
            return $response->withJson(
                array(
                    "error" => array(
                        "text"  => $e->getMessage(),
                        "code"  => $e->getCode()
                    )
                )
            );
        }
        $db = null;
    }
    else
    {
        return $response
            ->withStatus(200)
            ->withHeader("Content-Type", 'application/json;charset=utf-8')
            ->withJson(array(
                "error" => array(
                    "text"  => "Boş Alanlar Bırakmayınız."
                )
            ));
    }
});

// SocialMedia İşlemler
$app->get('/socialmedia/list', function (Request $request, Response $response){
    $db = new Db();
    try
    {
        $db = $db->connect();
        $socialmedia = $db->query("SELECT socialmedia_id,socialmedia_name,socialmedia_url,socialmedia_date FROM socialmedia")->fetchAll(PDO::FETCH_OBJ);
        if($socialmedia)
        {
            return $response
                ->withStatus(200)
                ->withHeader("Content-Type", 'application/json;charset=utf-8')
                ->withJson($socialmedia);
        }
        else
        {
            return $response
                ->withStatus(200)
                ->withHeader("Content-Type", 'application/json;charset=utf-8')
                ->withJson(array(
                    "error" => array(
                        "text"  => "Herhangi bir kayıtlı sosyal medya yok."
                    )
                ));
        }
    }
    catch(PDOException $e)
    {
        return $response->withJson(
            array(
                "error" => array(
                    "text"  => $e->getMessage(),
                    "code"  => $e->getCode()
                )
            )
        );
    }
    $db = null;
});
$app->get('/socialmedia/list/{key}', function (Request $request, Response $response){
    $key = $request->getAttribute("key");
    $db = new Db();
    try
    {
        $db = $db->connect();
        if(intval($key))
        {
             $socialmedia = $db->query("SELECT socialmedia_id,socialmedia_name,socialmedia_url,socialmedia_date FROM socialmedia where socialmedia_id = '{$key}' ")->fetchAll(PDO::FETCH_OBJ);
            if($socialmedia)
            {
                return $response
                    ->withStatus(200)
                    ->withHeader("Content-Type", 'application/json;charset=utf-8')
                    ->withJson($socialmedia);
            }
            else
            {
                return $response
                    ->withStatus(200)
                    ->withHeader("Content-Type", 'application/json;charset=utf-8')
                    ->withJson(array(
                        "error" => array(
                            "text"  => "Herhangi bir kayıtlı sosyal medya yok."
                        )
                    ));
            }
        }
        else
        {
            $sm = $db->query("SELECT * FROM socialmedia")->fetch(PDO::FETCH_OBJ);
                if($sm->$key)
                {
                    $socialmedia = $db->query("SELECT socialmedia_id,$key,socialmedia_url,socialmedia_date FROM socialmedia")->fetchAll(PDO::FETCH_OBJ);
                    if($socialmedia)
                    {
                        return $response
                            ->withStatus(200)
                            ->withHeader("Content-Type", 'application/json;charset=utf-8')
                            ->withJson($socialmedia);
                    }
                    else
                    {
                        return $response
                            ->withStatus(200)
                            ->withHeader("Content-Type", 'application/json;charset=utf-8')
                            ->withJson(array(
                                "error" => array(
                                    "text"  => "Herhangi bir kayıtlı sosyal medya yok."
                                )
                            ));
                    }
                }
                else
                {
                    $socialmedia = $db->query("SELECT socialmedia_id,socialmedia_name,socialmedia_url,socialmedia_date FROM socialmedia")->fetchAll(PDO::FETCH_OBJ);
                if($socialmedia)
                {
                    return $response
                        ->withStatus(200)
                        ->withHeader("Content-Type", 'application/json;charset=utf-8')
                        ->withJson($socialmedia);
                }
                else
                {
                    return $response
                        ->withStatus(200)
                        ->withHeader("Content-Type", 'application/json;charset=utf-8')
                        ->withJson(array(
                            "error" => array(
                                "text"  => "Herhangi bir kayıtlı sosyal medya yok."
                            )
                        ));
                }
                }
                
        }
    }
    catch(PDOException $e)
    {
        return $response->withJson(
            array(
                "error" => array(
                    "text"  => $e->getMessage(),
                    "code"  => $e->getCode()
                )
            )
        );
    }
    $db = null;
});
 

// Category İşlemler
$app->get('/category/list', function (Request $request, Response $response){
    $db = new Db();
    try
    {
        $db = $db->connect();
        $category = $db->query("SELECT category_id,category_name,socialmedia_id,category_date FROM category")->fetchAll(PDO::FETCH_OBJ);
        if($category)
        {
            return $response
                ->withStatus(200)
                ->withHeader("Content-Type", 'application/json;charset=utf-8')
                ->withJson($category);
        }
        else
        {
            return $response
                ->withStatus(200)
                ->withHeader("Content-Type", 'application/json;charset=utf-8')
                ->withJson(array(
                    "error" => array(
                        "text"  => "Herhangi bir kayıtlı kategori yok."
                    )
                ));
        }
    }
    catch(PDOException $e)
    {
        return $response->withJson(
            array(
                "error" => array(
                    "text"  => $e->getMessage(),
                    "code"  => $e->getCode()
                )
            )
        );
    }
    $db = null;
});
$app->get('/category/list/{key}', function (Request $request, Response $response){
    $key = $request->getAttribute("key");
    $db = new Db();
    try
    {
        $db = $db->connect();
        if(intval($key))
        {
             $category = $db->query("SELECT category_id,category_name,socialmedia_id,category_date FROM category where socialmedia_id = '{$key}' ")->fetchAll(PDO::FETCH_OBJ);
            if($category)
            {
                return $response
                    ->withStatus(200)
                    ->withHeader("Content-Type", 'application/json;charset=utf-8')
                    ->withJson($category);
            }
            else
            {
                return $response
                    ->withStatus(200)
                    ->withHeader("Content-Type", 'application/json;charset=utf-8')
                    ->withJson(array(
                        "error" => array(
                            "text"  => "Herhangi bir kayıtlı Kategori yok."
                        )
                    ));
            }
        }
        else
        {
            $sm = $db->query("SELECT * FROM category")->fetch(PDO::FETCH_OBJ);
                if($sm->$key)
                {
                    $category = $db->query("SELECT category_id,$key,socialmedia_id,category_date FROM category")->fetchAll(PDO::FETCH_OBJ);
                    if($category)
                    {
                        return $response
                            ->withStatus(200)
                            ->withHeader("Content-Type", 'application/json;charset=utf-8')
                            ->withJson($category);
                    }
                    else
                    {
                        return $response
                            ->withStatus(200)
                            ->withHeader("Content-Type", 'application/json;charset=utf-8')
                            ->withJson(array(
                                "error" => array(
                                    "text"  => "Herhangi bir kayıtlı sosyal medya yok."
                                )
                            ));
                    }
                }
                else
                {
                    $category = $db->query("SELECT category_id,category_name,socialmedia_id,category_date FROM category")->fetchAll(PDO::FETCH_OBJ);
                if($category)
                {
                    return $response
                        ->withStatus(200)
                        ->withHeader("Content-Type", 'application/json;charset=utf-8')
                        ->withJson($category);
                }
                else
                {
                    return $response
                        ->withStatus(200)
                        ->withHeader("Content-Type", 'application/json;charset=utf-8')
                        ->withJson(array(
                            "error" => array(
                                "text"  => "Herhangi bir kayıtlı sosyal medya yok."
                            )
                        ));
                }
                }
                
        }
    }
    catch(PDOException $e)
    {
        return $response->withJson(
            array(
                "error" => array(
                    "text"  => $e->getMessage(),
                    "code"  => $e->getCode()
                )
            )
        );
    }
    $db = null;
});
$app->get('/category/list/{key}/{language}', function (Request $request, Response $response){
    $key = $request->getAttribute("key");
    $language = $request->getAttribute("language");
    $db = new Db();
    if(intval($key))
    {
        try
        {
            $db = $db->connect();

            $sm = $db->query("SELECT * FROM category")->fetch(PDO::FETCH_OBJ);
            if($sm->$language)
            {
                $category = $db->query("SELECT category_id,$language,socialmedia_id,category_date FROM category WHERE socialmedia_id = $key")->fetchAll(PDO::FETCH_OBJ);
            if($category)
            {
                return $response
                    ->withStatus(200)
                    ->withHeader("Content-Type", 'application/json;charset=utf-8')
                    ->withJson($category);
            }
            else
            {
                return $response
                    ->withStatus(200)
                    ->withHeader("Content-Type", 'application/json;charset=utf-8')
                    ->withJson(array(
                        "error" => array(
                            "text"  => "Böyle bir kategori yok."
                        )
                    ));
            }
            }
            else
            {
                $category = $db->query("SELECT category_id,category_name,socialmedia_id,category_date FROM category where socialmedia_id = '{$key}' ")->fetchAll(PDO::FETCH_OBJ);
                if($category)
                {
                    return $response
                        ->withStatus(200)
                        ->withHeader("Content-Type", 'application/json;charset=utf-8')
                        ->withJson($category);
                }
                else
                {
                    return $response
                        ->withStatus(200)
                        ->withHeader("Content-Type", 'application/json;charset=utf-8')
                        ->withJson(array(
                            "error" => array(
                                "text"  => "Herhangi bir kayıtlı Kategori yok."
                            )
                        ));
                }
            }

            
        }
        catch(PDOException $e)
        {
            return $response->withJson(
                array(
                    "error" => array(
                        "text"  => $e->getMessage(),
                        "code"  => $e->getCode()
                    )
                )
            );
        }
        $db = null;
    }
});
 

// Service İşlemler
$app->get('/service/list', function (Request $request, Response $response){
    $language = $request->getAttribute("language");
    $db = new Db();
    try
    {
        $db = $db->connect();
        $service = $db->query("SELECT api_service_id,service_name,service_id,provider_price,provider_amount,provider_id,provider_url,provider_api_key,category_id,service_date  FROM service")->fetchAll(PDO::FETCH_OBJ);
        if($service)
        {
            return $response
                ->withStatus(200)
                ->withHeader("Content-Type", 'application/json;charset=utf-8')
                ->withJson($service);
        }
        else
        {
            return $response
                ->withStatus(200)
                ->withHeader("Content-Type", 'application/json;charset=utf-8')
                ->withJson(array(
                    "error" => array(
                        "text"  => "Herhangi bir kayıtlı servis yok."
                    )
                ));
        }
    }
    catch(PDOException $e)
    {
        return $response->withJson(
            array(
                "error" => array(
                    "text"  => $e->getMessage(),
                    "code"  => $e->getCode()
                )
            )
        );
    }
    $db = null;
});
$app->get('/service/list/{key}', function (Request $request, Response $response){
    $key = $request->getAttribute("key");
    $db = new Db();
    try
    {
        $db = $db->connect();
        if(intval($key))
        {
             $service = $db->query("SELECT api_service_id,service_name,service_id,provider_price,provider_amount,provider_id,provider_url,provider_api_key,category_id,service_date  FROM service  where category_id = '{$key}'")->fetchAll(PDO::FETCH_OBJ);
            if($service)
            {
                return $response
                    ->withStatus(200)
                    ->withHeader("Content-Type", 'application/json;charset=utf-8')
                    ->withJson($service);
            }
            else
            {
                return $response
                    ->withStatus(200)
                    ->withHeader("Content-Type", 'application/json;charset=utf-8')
                    ->withJson(array(
                        "error" => array(
                            "text"  => "Herhangi bir kayıtlı Kategori yok."
                        )
                    ));
            }
        }
        else
        {
            $sm = $db->query("SELECT * FROM service")->fetch(PDO::FETCH_OBJ);
                if($sm->$key)
                {
                    $service = $db->query("SELECT api_service_id,$key,service_id,provider_price,provider_amount,provider_id,provider_url,provider_api_key,category_id,service_date FROM service")->fetchAll(PDO::FETCH_OBJ);
                    if($service)
                    {
                        return $response
                            ->withStatus(200)
                            ->withHeader("Content-Type", 'application/json;charset=utf-8')
                            ->withJson($service);
                    }
                    else
                    {
                        return $response
                            ->withStatus(200)
                            ->withHeader("Content-Type", 'application/json;charset=utf-8')
                            ->withJson(array(
                                "error" => array(
                                    "text"  => "Herhangi bir kayıtlı sosyal medya yok."
                                )
                            ));
                    }
                }
                else
                {
                    $service = $db->query("SELECT api_service_id,service_name,service_id,provider_price,provider_amount,provider_id,provider_url,provider_api_key,category_id,service_date FROM service")->fetchAll(PDO::FETCH_OBJ);
                if($service)
                {
                    return $response
                        ->withStatus(200)
                        ->withHeader("Content-Type", 'application/json;charset=utf-8')
                        ->withJson($service);
                }
                else
                {
                    return $response
                        ->withStatus(200)
                        ->withHeader("Content-Type", 'application/json;charset=utf-8')
                        ->withJson(array(
                            "error" => array(
                                "text"  => "Herhangi bir kayıtlı sosyal medya yok."
                            )
                        ));
                }
                }
                
        }
    }
    catch(PDOException $e)
    {
        return $response->withJson(
            array(
                "error" => array(
                    "text"  => $e->getMessage(),
                    "code"  => $e->getCode()
                )
            )
        );
    }
    $db = null;
});

$app->get('/service/list/{key}/{language}', function (Request $request, Response $response){
    $key = $request->getAttribute("key");
    $language = $request->getAttribute("language");
    $db = new Db();
    if(intval($key))
    {
        try
        {
            $db = $db->connect();

            $sm = $db->query("SELECT * FROM service")->fetch(PDO::FETCH_OBJ);
            if($sm->$language)
            {
                $service = $db->query("SELECT api_service_id,$language,service_id,provider_price,provider_amount,provider_id,provider_url,provider_api_key,category_id,service_date FROM service  where category_id = '{$key}'")->fetchAll(PDO::FETCH_OBJ);
            if($service)
            {
                return $response
                    ->withStatus(200)
                    ->withHeader("Content-Type", 'application/json;charset=utf-8')
                    ->withJson($service);
            }
            else
            {
                return $response
                    ->withStatus(200)
                    ->withHeader("Content-Type", 'application/json;charset=utf-8')
                    ->withJson(array(
                        "error" => array(
                            "text"  => "Böyle bir kategori yok."
                        )
                    ));
            }
            }
            else
            {
                $service = $db->query("SELECT api_service_id,service_name,service_id,provider_price,provider_amount,provider_id,provider_url,provider_api_key,category_id,service_date FROM service where category_id = '{$key}' ")->fetchAll(PDO::FETCH_OBJ);
                if($service)
                {
                    return $response
                        ->withStatus(200)
                        ->withHeader("Content-Type", 'application/json;charset=utf-8')
                        ->withJson($service);
                }
                else
                {
                    return $response
                        ->withStatus(200)
                        ->withHeader("Content-Type", 'application/json;charset=utf-8')
                        ->withJson(array(
                            "error" => array(
                                "text"  => "Herhangi bir kayıtlı Kategori yok."
                            )
                        ));
                }
            }

            
        }
        catch(PDOException $e)
        {
            return $response->withJson(
                array(
                    "error" => array(
                        "text"  => $e->getMessage(),
                        "code"  => $e->getCode()
                    )
                )
            );
        }
        $db = null;
    }
});

// Provider İşlemler

$app->get('/provider/list', function (Request $request, Response $response){
    $db = new Db();
    try
    {
        $db = $db->connect();
        $provider = $db->query("SELECT * FROM provider")->fetchAll(PDO::FETCH_OBJ);
        if($provider)
        {
            return $response
                ->withStatus(200)
                ->withHeader("Content-Type", 'application/json;charset=utf-8')
                ->withJson($provider);
        }
        else
        {
            return $response
                ->withStatus(200)
                ->withHeader("Content-Type", 'application/json;charset=utf-8')
                ->withJson(array(
                    "error" => array(
                        "text"  => "Herhangi bir kayıtlı provider yok."
                    )
                ));
        }
    }
    catch(PDOException $e)
    {
        return $response->withJson(
            array(
                "error" => array(
                    "text"  => $e->getMessage(),
                    "code"  => $e->getCode()
                )
            )
        );
    }
    $db = null;
});
$app->get('/provider/list/{key}', function (Request $request, Response $response){
    $key = $request->getAttribute("key");
    $db = new Db();
    if(is_numeric($key))
    {
        try
        {
            $db = $db->connect();
            $provider = $db->query("SELECT * FROM provider WHERE provider_id = $key")->fetch(PDO::FETCH_OBJ);
            if($provider)
            {
                return $response
                    ->withStatus(200)
                    ->withHeader("Content-Type", 'application/json;charset=utf-8')
                    ->withJson($provider);
            }
            else
            {
                return $response
                    ->withStatus(200)
                    ->withHeader("Content-Type", 'application/json;charset=utf-8')
                    ->withJson(array(
                        "error" => array(
                            "text"  => "Böyle bir provider yok."
                        )
                    ));
            }
        }
        catch(PDOException $e)
        {
            return $response->withJson(
                array(
                    "error" => array(
                        "text"  => $e->getMessage(),
                        "code"  => $e->getCode()
                    )
                )
            );
        }
        $db = null;
    }
    else
    {
        if(is_string($key))
        {
            try
            {
                $db = $db->connect();
                $provider = $db->query("SELECT * FROM provider WHERE provider_url = '$key' or api_key = '$key'")->fetch(PDO::FETCH_OBJ);
                if($provider)
                {
                    return $response
                        ->withStatus(200)
                        ->withHeader("Content-Type", 'application/json;charset=utf-8')
                        ->withJson($provider);
                }
                else
                {
                    return $response
                        ->withStatus(200)
                        ->withHeader("Content-Type", 'application/json;charset=utf-8')
                        ->withJson(array(
                            "error" => array(
                                "text"  => "Böyle bir servis yok."
                            )
                        ));
                }
            }
            catch(PDOException $e)
            {
                return $response->withJson(
                    array(
                        "error" => array(
                            "text"  => $e->getMessage(),
                            "code"  => $e->getCode()
                        )
                    )
                );
            }
            $db = null;
        }
        else
        {
            return $response
                ->withStatus(200)
                ->withHeader("Content-Type", 'application/json;charset=utf-8')
                ->withJson(array(
                    "error" => array(
                        "text"  => "Geçersiz Anahtar Girişi."
                    )
                ));
        }
    }
});
 
