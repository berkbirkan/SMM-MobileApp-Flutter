<?php


include("../modal/db.php");

if(isset($_GET["delete_id"]))
{
    $service_id =  addslashes(htmlspecialchars(trim($_GET["delete_id"])));

    $query = $db->prepare("DELETE FROM service WHERE api_service_id = :api_service_id");
    $delete = $query->execute(array(
    'api_service_id' => $service_id
    ));
    if($delete)
    {
        header("location:../ServicePage.php?status=delete-success");
    }
    else
    {
        header("location:../ServicePage.php?status=delete-unsuccessful");
    }
}
else if(isset($_POST["BtnServiceAdd"]))
{
    $service_name = addslashes(htmlspecialchars(trim($_POST["service_name"])));
    $service_id = addslashes(htmlspecialchars(trim($_POST["service_id"])));
    $provider_price = addslashes(htmlspecialchars(trim($_POST["provider_price"])));
    $provider_amount = addslashes(htmlspecialchars(trim($_POST["provider_amount"])));
    $provider_id = addslashes(htmlspecialchars(trim($_POST["provider_id"])));
    $category_id = addslashes(htmlspecialchars(trim($_POST["category_id"])));

    
    if($provider_id==0 || $category_id==0)
    {
        header("location:../ServicePage.php?status=provider-category-error");
    }
    else
    {
        $query = $db->query("SELECT * FROM provider WHERE provider_id = '{$provider_id}'")->fetch(PDO::FETCH_ASSOC);
        if ( $query )
        {
           $provider_url = $query["provider_url"];
           $api_key = $query["api_key"];
        }
        
            $query = $db->prepare("INSERT INTO service SET
            service_id = ?,
            service_name = ?,
            provider_price = ?,
            provider_amount = ?,
            provider_id = ?,
            provider_url = ?,
            provider_api_key =?,
            category_id = ?");
            $insert = $query->execute(array(
                $service_id,$service_name,$provider_price,$provider_amount,$provider_id,$provider_url,$api_key,$category_id
            ));
            if ( $insert )
            {
                $last_id = $db->lastInsertId();
                           
                            
            $languages = $db->query("SELECT * FROM languages",PDO::FETCH_ASSOC);
                        if ( $languages->rowCount() ){
                             foreach( $languages as $row ){
                                 $lc_id = $row["lc_id"];
                                $sm_update = $db->prepare("UPDATE service SET
                                    $lc_id = :lc_id
                                    WHERE api_service_id = :api_service_id");
                                    $update = $sm_update->execute(array(
                                         "lc_id" => $service_name,
                                         "api_service_id" => $last_id
                                    ));
                                
                             }
                        }
                         header("location:../ServicePage.php?status=insert-success");
               
            }
            else
            {
                header("location:../ServicePage.php?status=insert-unsuccessful");
            }
    
    }
    
}
else if(isset($_POST["BtnServiceUpdate"]))
{
    $service_name = addslashes(htmlspecialchars(trim($_POST["service_name"])));
    $service_id = addslashes(htmlspecialchars(trim($_POST["service_id"])));
    $provider_price = addslashes(htmlspecialchars(trim($_POST["provider_price"])));
    $provider_amount = addslashes(htmlspecialchars(trim($_POST["provider_amount"])));
    $provider_id = addslashes(htmlspecialchars(trim($_POST["provider_id"])));
    $category_id = addslashes(htmlspecialchars(trim($_POST["category_id"])));
    $api_service_id = addslashes(htmlspecialchars(trim($_POST["api_service_id"])));

    if($provider_id==0 && $category_id==0)
    {
        header("location:../ServicePage.php?status=provider-category-error");
    }
    else
    {
        

        $query = $db->query("SELECT * FROM provider WHERE provider_id = '{$provider_id}'")->fetch(PDO::FETCH_ASSOC);
        if ( $query ){
           $provider_url = $query["provider_url"];
           $api_key = $query["api_key"];
        }
    
                    $query = $db->prepare("UPDATE service SET
                    service_id = :service_id,
                    service_name = :service_name,
                    provider_price = :provider_price,
                    provider_amount = :provider_amount,
                    provider_id = :provider_id,
                    provider_url = :provider_url,
                    provider_api_key = :provider_api_key,
                    category_id = :category_id
                    WHERE api_service_id = :api_service_id");
                    $update = $query->execute(array(
                         "service_id" => $service_id,
                         "service_name" => $service_name,
                         "provider_price" => $provider_price,
                         "provider_amount" => $provider_amount,
                         "provider_id" => $provider_id,
                         "provider_url" =>$provider_url,
                         "provider_api_key" =>$api_key,
                         "category_id" =>$category_id,
                         "api_service_id" =>$api_service_id
                    ));
                
                    if ( $update )
                    {
                        header("location:../ServicePage.php?status=update-success");
                    }
                    else
                    {
                        header("location:../ServicePage.php?status=update-unsuccessful");
                    }
    }
}
else
{
    header("location:../ServicePage.php");
}
