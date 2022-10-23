<?php

    include("../modal/db.php");
    if(isset($_GET["delete_id"]))
    {
        $user_id = addslashes(htmlspecialchars(trim($_GET["delete_id"])));
        $query = $db->prepare("DELETE FROM users WHERE user_id = :user_id");
        $delete = $query->execute(array(
            'user_id' => $user_id
        ));
        if($delete)
        {
            header("location:../UserPage.php?status=delete-success");
        }
        else
        {
            header("location:../UserPage.php?status=delete-unsuccessful");
        }
    }
    else if(isset($_POST["BtnUserAdd"]))
    {
        $user_username = addslashes(htmlspecialchars(trim($_POST["user_username"])));
        $user_password = password_hash(addslashes(htmlspecialchars(trim($_POST["user_password"]))),PASSWORD_DEFAULT);
        $user_name = addslashes(htmlspecialchars(trim($_POST["user_name"])));
        $user_surname = addslashes(htmlspecialchars(trim($_POST["user_surname"])));
        $user_email = addslashes(htmlspecialchars(trim($_POST["user_email"])));
        $user_kredi = addslashes(htmlspecialchars(trim($_POST["user_kredi"])));

        if($user_kredi<0)
        {
            $user_kredi = 0;
        }

        $query = $db->query("SELECT user_id FROM users WHERE user_username = '{$user_username}'")->fetch(PDO::FETCH_ASSOC);
        if ( $query )
        {
            header("location:../UserPage.php?status=record-error");
        }
        else
        {
            $query = $db->prepare("INSERT INTO users SET
                    user_username = ?,
                    user_password = ?,
                    user_name = ?,
                    user_surname = ?,
                    user_email = ?,
                    user_kredi = ?");
            $insert = $query->execute(array(
                $user_username,$user_password,$user_name,$user_surname,$user_email,$user_kredi
            ));
            if ( $insert )
            {
                header("location:../UserPage.php?status=insert-success");
            }
            else
            {
                header("location:../UserPage.php?status=insert-unsuccessful");
            }

        }
    }
    else if(isset($_POST["BtnUserUpdate"]))
    {
        $user_id = addslashes(htmlspecialchars(trim($_POST["user_id"])));
        $user_username = addslashes(htmlspecialchars(trim($_POST["user_username"])));
        $user_password = addslashes(htmlspecialchars(trim($_POST["user_password"])));
        $user_name = addslashes(htmlspecialchars(trim($_POST["user_name"])));
        $user_surname = addslashes(htmlspecialchars(trim($_POST["user_surname"])));
        $user_email = addslashes(htmlspecialchars(trim($_POST["user_email"])));
        $user_kredi = addslashes(htmlspecialchars(trim($_POST["user_kredi"])));

        $query = $db->query("SELECT * FROM users WHERE user_id = '{$user_id}'")->fetch(PDO::FETCH_ASSOC);
        if ( $query )
        {
            $user_control_usename = $query["user_username"];
            if($user_control_usename == $user_username)
            {
                if(empty($user_password))
                {
                    $query = $db->prepare("UPDATE users SET
                    user_username = :user_username,
                    user_name = :user_name,
                    user_surname = :user_surname,
                    user_email = :user_email,
                    user_kredi = :user_kredi
                    WHERE user_id  = :user_id ");
                    $update = $query->execute(array(
                        "user_username" => $user_username,
                        "user_name" =>$user_name,
                        "user_surname" =>$user_surname,
                        "user_email" => $user_email,
                        "user_kredi" => $user_kredi,
                        "user_id" => $user_id
                    ));

                    if ( $update )
                    {
                        header("location:../UserPage.php?status=update-success");
                    }
                    else
                    {
                        header("location:../UserPage.php?status=update-unsuccessful");
                    }
                }
                else
                {
            $hashing_password = password_hash($user_password,PASSWORD_DEFAULT);

                    $query = $db->prepare("UPDATE users SET
                user_username = :user_username,
                user_password = :user_password,
                user_name = :user_name,
                user_surname = :user_surname,
                user_email = :user_email,
                user_kredi = :user_kredi
                WHERE user_id  = :user_id ");
                    $update = $query->execute(array(
                        "user_username" => $user_username,
                        "user_password" => $hashing_password,
                        "user_name" =>$user_name,
                        "user_surname" =>$user_surname,
                        "user_email" => $user_email,
                        "user_kredi" => $user_kredi,
                        "user_id" => $user_id
                    ));

                    if ( $update )
                    {
                        header("location:../UserPage.php?status=update-success");
                    }
                    else
                    {
                        header("location:../UserPage.php?status=update-unsuccessful");
                    }
                }
            }
            else
            {
                $query = $db->query("SELECT * FROM users WHERE user_username = '{$user_username}'")->fetch(PDO::FETCH_ASSOC);
                if ( $query )
                {
                    header("location:../UserPage.php?status=record-error");
                }
                else
                {
                    if (empty($user_password))
                    {
                        $query = $db->prepare("UPDATE users SET
                        user_username = :user_username,
                        user_name = :user_name,
                        user_surname = :user_surname,
                        user_email = :user_email,
                        user_kredi = :user_kredi
                        WHERE user_id  = :user_id ");
                        $update = $query->execute(array(
                            "user_username" => $user_username,
                            "user_name" =>$user_name,
                            "user_surname" =>$user_surname,
                            "user_email" => $user_email,
                            "user_kredi" => $user_kredi,
                            "user_id" => $user_id
                        ));

                        if ( $update )
                        {
                            header("location:../UserPage.php?status=update-success");
                        }
                        else
                        {
                            header("location:../UserPage.php?status=update-unsuccessful");
                        }
                    }
                    else
                    {
                        $hashing_password = password_hash($user_password,PASSWORD_DEFAULT);
                        
                        $query = $db->prepare("UPDATE users SET
                        user_username = :user_username,
                        user_password = :user_password,
                        user_name = :user_name,
                        user_surname = :user_surname,
                        user_email = :user_email,
                        user_kredi = :user_kredi
                        WHERE user_id  = :user_id ");
                        $update = $query->execute(array(
                            "user_username" => $user_username,
                            "user_password" => $hashing_password,
                            "user_name" =>$user_name,
                            "user_surname" =>$user_surname,
                            "user_email" => $user_email,
                            "user_kredi" => $user_kredi,
                            "user_id" => $user_id
                        ));

                        if ( $update )
                        {
                            header("location:../UserPage.php?status=update-success");
                        }
                        else
                        {
                            header("location:../UserPage.php?status=update-unsuccessful");
                        }
                    }
                }

            }
        }
    }
    else
    {
        header("location:../UserPage.php");
    }
