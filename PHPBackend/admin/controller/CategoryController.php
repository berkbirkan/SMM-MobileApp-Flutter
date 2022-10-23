<?php

    include("../modal/db.php");
    if(isset($_GET["delete_id"]))
    {
        $category_id = addslashes(htmlspecialchars(trim($_GET["delete_id"])));

        $query = $db->prepare("DELETE FROM category WHERE category_id = :category_id");
        $delete = $query->execute(array(
            'category_id' => $category_id
        ));
        if($delete)
        {
            header("location:../CategoryPage.php?status=delete-success");
        }
        else
        {
            header("location:../CategoryPage.php?status=delete-unsuccessful");
        }
    }
    else if(isset($_POST["BtnCategoryAdd"]))
    {
        $category_name = addslashes( htmlspecialchars(trim($_POST["category_name"])));
        $socialmedia_id = addslashes(htmlspecialchars(trim($_POST["socialmedia"])));

        if($socialmedia_id==0)
        {
            header("location:../CategoryPage.php?status=socialmedia-error");
        }
        else
        {
            $query = $db->query("SELECT * FROM category WHERE category_name = '{$category_name}' and socialmedia_id='{$socialmedia_id}'")->fetch(PDO::FETCH_ASSOC);
            if ( $query )
            {
                header("location:../CategoryPage.php?status=record-error");
            }
            else
            {
                $query = $db->prepare("INSERT INTO category SET
                category_name = ?,
                socialmedia_id = ?");
                $insert = $query->execute(array(
                    $category_name,$socialmedia_id
                ));
                if ( $insert )
                {
                    $last_id = $db->lastInsertId();
                           
                            
            $languages = $db->query("SELECT * FROM languages",PDO::FETCH_ASSOC);
                        if ( $languages->rowCount() ){
                             foreach( $languages as $row ){
                                 $lc_id = $row["lc_id"];
                                $sm_update = $db->prepare("UPDATE category SET
                                    $lc_id = :lc_id
                                    WHERE category_id = :category_id");
                                    $update = $sm_update->execute(array(
                                         "lc_id" => $category_name,
                                         "category_id" => $last_id
                                    ));
                                
                             }
                        }
                        header("location:../CategoryPage.php?status=insert-success");
                        
                        
                        
                   
                }
                else
                {
                    header("location:../CategoryPage.php?status=insert-unsuccessful");
                }
            }
        }
    }
    else if(isset($_POST["BtnCategoryUpdate"]))
    {
        $socialmedia_id = addslashes(htmlspecialchars(trim($_POST["socialmedia"])));

        if($socialmedia_id==0)
        {
            header("location:../CategoryPage.php?status=socialmedia-error");
        }
        {
            $category_id = addslashes(htmlspecialchars(trim($_POST["category_id"])));
            $category_name = addslashes(htmlspecialchars(trim($_POST["category_name"])));
            $socialmedia_id = addslashes(htmlspecialchars(trim($_POST["socialmedia"])));

            $query = $db->prepare("UPDATE category SET
                    category_name = :category_name,
                    socialmedia_id = :socialmedia_id
                    WHERE category_id = :category_id");
            $update = $query->execute(array(
                "category_name" => $category_name,
                "socialmedia_id" => $socialmedia_id,
                "category_id" => $category_id
            ));

            if ( $update )
            {
                header("location:../CategoryPage.php?status=update-success");
            }
            else
            {
                header("location:../CategoryPage.php?status=update-unsuccessful");
            }
        }
    }
    else
    {
        header("location:../CategoryPage.php");
    }

