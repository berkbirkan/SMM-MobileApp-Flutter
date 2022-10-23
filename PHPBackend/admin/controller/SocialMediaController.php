<?php

include("../modal/db.php");

if(isset($_GET["delete_id"]))
{
    $socialmedia_id =  addslashes(htmlspecialchars(trim($_GET["delete_id"])));

    $query = $db->prepare("DELETE FROM socialmedia WHERE socialmedia_id = :socialmedia_id");
    $delete = $query->execute(array(
        'socialmedia_id' => $socialmedia_id
    ));
    if($delete)
    {
        header("location:../SocialMediaPage.php?status=delete-success");
    }
    else
    {
        header("location:../SocialMediaPage.php?status=delete-unsuccessful");
    }
}
else if(isset($_POST["BtnSocialMediaAdd"]))
{
    $socialmedia_name = addslashes(htmlspecialchars(trim($_POST["socialmedia_name"])));

    $query = $db->query("SELECT * FROM socialmedia WHERE socialmedia_name = '{$socialmedia_name}'")->fetch(PDO::FETCH_ASSOC);
    if ( $query )
    {
        header("location:../SocialMediaPage.php?status=record-error");
    }
    else
    {
        if((isset($_FILES['dosya']) && !empty($_FILES['dosya'])) && !empty($socialmedia_name))
        {
         
            $hata = $_FILES['dosya']['error'];
            if($hata != 0)
            {
                header("location:../SocialMediaPage.php?status=file-error");
            }
            else {

                $boyut = $_FILES['dosya']['size'];

                if($boyut > (1024*1024*10))
                {
                    header("location:../SocialMediaPage.php?status=size-error");
                }
                else
                {
                    $time = time();

                    $tip = $_FILES['dosya']['type'];
                    $isim = $_FILES['dosya']['name'];

                    $uzanti = explode('.', $isim);
                    $uzanti = $uzanti[count($uzanti)-1];

                    if($tip != 'image/png' && $tip != 'image/jpeg')
                    {
                        header("location:../SocialMediaPage.php?status=extension-error");
                    }
                    else
                    {
                        $dosya = $_FILES['dosya']['tmp_name'];

                        $web_url = 'http://'.$_SERVER['SERVER_NAME']."/boostmobile/admin";
                        $url = $web_url."/assets/socialmedia/".$socialmedia_name.$time.".png";

                        copy($dosya, '../assets/socialmedia/'.$socialmedia_name.$time.".png");
                        
                        
                        $query = $db->prepare("INSERT INTO socialmedia SET
                socialmedia_name = ?,
                socialmedia_url = ?");
                        $insert = $query->execute(array(
                            $socialmedia_name,$url
                        ));
                        if ( $insert )
                        {
                            $last_id = $db->lastInsertId();
                           
                            
            $languages = $db->query("SELECT * FROM languages",PDO::FETCH_ASSOC);
                        if ( $languages->rowCount() ){
                             foreach( $languages as $row ){
                                 $lc_id = $row["lc_id"];
                                $sm_update = $db->prepare("UPDATE socialmedia SET
                                    $lc_id = :lc_id
                                    WHERE socialmedia_id = :socialmedia_id");
                                    $update = $sm_update->execute(array(
                                         "lc_id" => $socialmedia_name,
                                         "socialmedia_id" => $last_id
                                    ));
                                
                             }
                        }
                      
                        
                            header("location:../SocialMediaPage.php?status=insert-success");
                        
                        
                        
                           
                        }
                        else
                        {
                            header("location:../SocialMediaPage.php?status=insert-unsuccessful");
                        }
                    }
                }
            }
        }
    }
}
else if(isset($_POST["BtnSocialMediaUpdate"]))
{
    $socialmedia_id = addslashes(htmlspecialchars(trim($_POST["socialmedia_id"])));
    $socialmedia_name = addslashes(htmlspecialchars(trim($_POST["socialmedia_name"])));

    if(isset($_FILES['dosya']) && $_FILES['dosya']["name"] != ""  )
    {
        $hata = $_FILES['dosya']['error'];
        if($hata != 0)
        {
            header("location:../SocialMediaPage.php?status=file-error");
        }
        else {

            $boyut = $_FILES['dosya']['size'];

            if($boyut > (1024*1024*10))
            {
                header("location:../SocialMediaPage.php?status=size-error");
            }
            else
            {
                $tip = $_FILES['dosya']['type'];
                $isim = $_FILES['dosya']['name'];

                $uzanti = explode('.', $isim);
                $uzanti = $uzanti[count($uzanti)-1];

                if($tip != 'image/png' && $tip != 'image/jpeg')
                {
                    header("location:../SocialMediaPage.php?status=extension-error");
                }
                else
                {
                    $time = time();
                    $dosya = $_FILES['dosya']['tmp_name'];

                    $web_url = 'http://'.$_SERVER['SERVER_NAME']."/boostmobile/admin";
                    $url = $web_url."/assets/socialmedia/".$socialmedia_name.$time.".png";

                    copy($dosya, '../assets/socialmedia/'.$socialmedia_name.$time.".png");

                    $query = $db->prepare("UPDATE socialmedia SET
            socialmedia_name = :socialmedia_name, socialmedia_url = :socialmedia_url
            WHERE socialmedia_id = :socialmedia_id");
                    $update = $query->execute(array(
                        "socialmedia_name" => $socialmedia_name,
                        "socialmedia_url" => $url,
                        "socialmedia_id" => $socialmedia_id
                    ));

                    if ( $update )
                    {
                        header("location:../SocialMediaPage.php?status=update-success");
                    }
                    else
                    {
                        header("location:../SocialMediaPage.php?status=update-unsuccessful");
                    }
                }
            }
        }
    }
    else
    {
       
        $query = $db->prepare("UPDATE socialmedia SET
    socialmedia_name = :socialmedia_name
    WHERE socialmedia_id = :socialmedia_id");
            $update = $query->execute(array(
                "socialmedia_name" => $socialmedia_name,
                "socialmedia_id" => $socialmedia_id
            ));

            if ( $update )
            {
                header("location:../SocialMediaPage.php?status=update-success");
            }
            else
            {
                header("location:../SocialMediaPage.php?status=update-unsuccessful");
            }
    }
}
