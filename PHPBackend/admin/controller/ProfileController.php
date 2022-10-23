<?php

    session_start();
    $admin_id = addslashes(htmlspecialchars(trim($_SESSION["admin_id"])));

    if(isset($_POST["btnSave"]))
    {
        include("../modal/db.php");
        
        $admin_fullname = addslashes(htmlspecialchars(trim($_POST["admin_fullname"])));
        $admin_email = addslashes(htmlspecialchars(trim($_POST["admin_email"])));
        $admin_username = addslashes(htmlspecialchars(trim($_POST["admin_username"])));
        $admin_password = addslashes(htmlspecialchars(trim($_POST["admin_password"])));

        if(empty($admin_password))
        {
            
            $query = $db->prepare("UPDATE admins SET
                admin_fullname = :admin_fullname,
                admin_email = :admin_email,
                admin_username = :admin_username
                WHERE admin_id = :admin_id");
                $update = $query->execute(array(
                "admin_fullname" => $admin_fullname,
                "admin_email" => $admin_email,
                "admin_username" => $admin_username,
                "admin_id" => $admin_id
            ));
            if ( $update )
            {
                header("location:../ProfilePage.php?status=success");
            }
            else
            {
                header("location:../ProfilePage.php?status=unsuccessful");
            }
        }
        else
        {
            $hashing_password = password_hash($admin_password, PASSWORD_DEFAULT);

            $query = $db->prepare("UPDATE admins SET
            admin_fullname = :admin_fullname,
            admin_email = :admin_email,
            admin_username = :admin_username,
            admin_password = :admin_password
            WHERE admin_id = :admin_id");
            $update = $query->execute(array(
                "admin_fullname" => $admin_fullname,
                "admin_email" => $admin_email,
                "admin_username" => $admin_username,
                "admin_password" => $hashing_password,
                "admin_id" => $admin_id
            ));
            if ( $update )
            {
                header("location:../ProfilePage.php?status=success");
            }
            else
            {
                header("location:../ProfilePage.php?status=unsuccessful");
            }
        }

    }
    else
    {
        header("location:../ProfilePage.php");
    }



