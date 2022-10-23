<?php

include("../modal/db.php");
if(isset($_GET["delete_id"]))
{
    $language_id =  addslashes(htmlspecialchars(trim($_GET["delete_id"])));
    $language=  addslashes(htmlspecialchars(trim($_GET["language"])));
    $query = $db->prepare("DELETE FROM languages WHERE language_id = :language_id");
    $delete = $query->execute(array(
    'language_id' => $language_id
    ));
    if($delete)
    {
        $language_add = $db->exec("ALTER TABLE socialmedia DROP COLUMN $language");
        $language_add = $db->exec("ALTER TABLE category DROP COLUMN $language");
        $language_add = $db->exec("ALTER TABLE service DROP COLUMN $language");
        
        header("location:../LanguagePage.php?status=delete-success");
    }
    else
    {
        header("location:../ServicePage.php?status=delete-unsuccessful");
    }
}
else if(isset($_POST["BtnLanguageAdd"]))
{
    $__counter = 0;
    $array =  $_POST;
    $language = addslashes(htmlspecialchars(trim($_POST["language"])));
     $a = $db->query("SELECT * FROM languages WHERE lc_id='{$language}'")->fetch(PDO::FETCH_ASSOC);
    if ($a ){
        header("location:../LanguagePage.php?status=language-record");
        }
    foreach($array as $key => $value)
    {
        if(strstr($key,"socialmedia_name"))
        {
            if(!empty($value))
            {
                $id = explode('-',$key);
                $socialmedia_language = $db->prepare("SELECT $language FROM socialmedia");
                $count = $socialmedia_language->columnCount();
                if ($count > 0)
                {
                    echo "socialmedia var";
                }
                else
                {
                    echo "yok ama ekleniyor socialmedia";
                    $language_add = $db->exec("ALTER TABLE socialmedia ADD $language VARCHAR(75)");
                        $query = $db->prepare("UPDATE socialmedia SET
                        $language = :socialmedia_name WHERE socialmedia_id = :socialmedia_id");
                                $update = $query->execute(array(
                                    "socialmedia_name" => $value,
                                    "socialmedia_id" => $id[1]
                                ));
                                $__counter++;
                }
             
            }
        }
        else if(strstr($key,"category_name"))
        {
            if(!empty($value))
            {
                $id = explode('-',$key);
                $category_language = $db->prepare("SELECT $language FROM category");
                $count = $category_language->columnCount();
                if ($count > 0)
                { 
                    echo "category var";
                }
                else
                {
                    echo "yok ama ekleniyor category";
                    $language_add = $db->exec("ALTER TABLE category ADD $language VARCHAR(75)");
                        $query = $db->prepare("UPDATE category SET
                        $language = :category_name WHERE category_id = :category_id");
                                $update = $query->execute(array(
                                    "category_name" => $value,
                                    "category_id" => $id[1]
                                ));
                                $__counter++;
                }
               
            }
        }
        else if(strstr($key,"service_name"))
        {
            if(!empty($value))
            {
                $id = explode('-',$key);
                $service_language = $db->prepare("SELECT $language FROM service");
                $count = $service_language->columnCount();
                if ($count > 0)
                { 
                    echo "service var";
                }
                else
                {
                    echo "yok ama ekleniyor service";
                    $language_add = $db->exec("ALTER TABLE service ADD $language VARCHAR(75)");
                        $query = $db->prepare("UPDATE service SET
                        $language = :service_name WHERE api_service_id = :api_service_id");
                                $update = $query->execute(array(
                                    "service_name" => $value,
                                    "api_service_id" => $id[1]
                                ));
                                $__counter++;
                }
              
            }
        }
    }

    if($__counter > 0)
    {
        $a = $db->query("SELECT * FROM languages WHERE lc_id='{$language}'")->fetch(PDO::FETCH_ASSOC);
        if ( !$a ){
                    $query = $db->prepare("INSERT INTO languages SET
                    lc_id = ?");
                $insert = $query->execute(array(
                    $language
                ));
        header("location:../LanguagePage.php?status=insert-success");
        }
        else
        {
            header("location:../LanguagePage.php?status=language-record");
        }
      
    }
    else
    {
        header("location:../LanguagePage.php?status=insert-unsuccessful");
    }
   
}
else if(isset($_POST["BtnLanguageUpdate"]))
{
    $array =  $_POST;
    $__counter = 0;
    $language = addslashes(htmlspecialchars(trim($_POST["lc_id"])));
    foreach($array as $key => $value)
    {
        if(strstr($key,"socialmedia_name"))
        {
            if(!empty($value))
            {
                $id = explode('-',$key);
                $socialmedia_language = $db->prepare("SELECT $language FROM socialmedia");
                $count = $socialmedia_language->columnCount();
                if ($count > 0)
                {
                    $id = explode('-',$key);
                    $query = $db->prepare("UPDATE socialmedia SET
                        $language = :socialmedia_name WHERE socialmedia_id = :socialmedia_id");
                                $update = $query->execute(array(
                                    "socialmedia_name" => $value,
                                    "socialmedia_id" => $id[1]
                                ));
                $__counter++;
                }
                else
                {
                    $language_add = $db->exec("ALTER TABLE socialmedia ADD $language VARCHAR(75)");
                    $query = $db->prepare("UPDATE socialmedia SET
                    $language = :socialmedia_name WHERE socialmedia_id = :socialmedia_id");
                            $update = $query->execute(array(
                                "socialmedia_name" => $value,
                                "socialmedia_id" => $id[1]
                            ));
                            $__counter++;
                }
            }
        
        }
        if(strstr($key,"category_name"))
        {
               if(!empty($value))
            {
                $id = explode('-',$key);
                $socialmedia_language = $db->prepare("SELECT $language FROM category");
                $count = $socialmedia_language->columnCount();
                if ($count > 0)
                {
                    $id = explode('-',$key);
                    $query = $db->prepare("UPDATE category SET
                        $language = :category_name WHERE category_id = :category_id");
                                $update = $query->execute(array(
                                    "category_name" => $value,
                                    "category_id" => $id[1]
                                ));
                $__counter++;
                }
                else
                {
                    $language_add = $db->exec("ALTER TABLE category ADD $language VARCHAR(75)");
                    $query = $db->prepare("UPDATE category SET
                    $language = :category_name WHERE category_id = :category_id");
                            $update = $query->execute(array(
                                "category_name" => $value,
                                "category_id" => $id[1]
                            ));
                            $__counter++;
                }
            }
        }
        if(strstr($key,"service_name"))
        {
            	$id = explode('-',$key);
                $service_language = $db->prepare("SELECT $language FROM service");
                $count = $service_language->columnCount();
                if ($count > 0)
                { 
                    if(!empty($value))
                    {
                        $id = explode('-',$key);
                            $query = $db->prepare("UPDATE service SET
                            $language = :service_name WHERE api_service_id = :api_service_id");
                                    $update = $query->execute(array(
                                        "service_name" => $value,
                                        "api_service_id" => $id[1]
                                    ));
                                    $__counter++;
                    }
                }
                else
                {
                    $language_add = $db->exec("ALTER TABLE service ADD $language VARCHAR(75)");
                        $query = $db->prepare("UPDATE service SET
                        $language = :service_name WHERE api_service_id = :api_service_id");
                                $update = $query->execute(array(
                                    "service_name" => $value,
                                    "api_service_id" => $id[1]
                                ));
                                $__counter++;
                }
            
        }
    }

    if($__counter == 0)
    {
        header("location:../LanguagePage.php?status=update-unsuccessful");
    }
    else
    {
        header("location:../LanguagePage.php?status=update-success");
    }
   
}