<?php

include("../modal/db.php");

if(isset($_GET["delete_id"]))
{
    $provider_id =  addslashes(htmlspecialchars(trim($_GET["delete_id"])));

    $query = $db->prepare("DELETE FROM provider WHERE provider_id = :provider_id");
    $delete = $query->execute(array(
    'provider_id' => $provider_id
    ));
    if($delete)
    {
        header("location:../ProviderPage.php?status=delete-success");
    }
    else
    {
        header("location:../ProviderPage.php?status=delete-unsuccessful");
    }
}
else if(isset($_POST["BtnProviderAdd"]))
{
    $provider_url = addslashes(htmlspecialchars(trim($_POST["provider_url"])));
    $api_key = addslashes(htmlspecialchars(trim($_POST["api_key"])));
    $provider_name = addslashes(htmlspecialchars(trim($_POST["provider_name"])));

        $query = $db->prepare("INSERT INTO provider SET
        provider_url = ?,
        api_key = ?,
        provider_name = ?");
        $insert = $query->execute(array(
            $provider_url,$api_key,$provider_name
        ));
        if ( $insert )
        {
            header("location:../ProviderPage.php?status=insert-success");
        }
        else
        {
            header("location:../ProviderPage.php?status=insert-unsuccessful");
        }

}
else if(isset($_POST["BtnProviderUpdate"]))
{
    $provider_id = addslashes(htmlspecialchars(trim($_POST["provider_id"])));
    $provider_url = addslashes(htmlspecialchars(trim($_POST["provider_url"])));
    $api_key = addslashes(htmlspecialchars(trim($_POST["api_key"])));
    $provider_name = addslashes(htmlspecialchars(trim($_POST["provider_name"])));

                $query = $db->prepare("UPDATE provider SET
                provider_url = :provider_url,
                api_key = :api_key,
                provider_name = :provider_name
                WHERE provider_id = :provider_id");
                $update = $query->execute(array(
                     "provider_url" => $provider_url,
                     "api_key" => $api_key,
                     "provider_name" =>$provider_name,
                     "provider_id" => $provider_id
                ));
            
                if ( $update )
                {
                    header("location:../ProviderPage.php?status=update-success");
                }
                else
                {
                    header("location:../ProviderPage.php?status=update-unsuccessful");
                }
}
else
{
    header("location:../ProviderPage.php");
}
