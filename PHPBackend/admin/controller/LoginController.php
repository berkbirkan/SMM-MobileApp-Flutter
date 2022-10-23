<?php
    if(isset($_POST["btnlogin"]))
    {
        include("../modal/db.php");
        
        $username = addslashes(htmlspecialchars(trim($_POST["username"])));
        $pass = addslashes(htmlspecialchars(trim($_POST["pass"])));
        
        $admin = $db->query("SELECT * FROM admins WHERE admin_username='{$username}'")->fetch(PDO::FETCH_ASSOC);
        if ( $admin )
        {
            if (password_verify($pass,$admin["admin_password"]))
            {
                $payment = $db->query("SELECT id FROM payments")->fetch(PDO::FETCH_ASSOC);
                if(!$payment)
                {
                    $payment_insert_query = $db->prepare("INSERT INTO payments SET
                    payment_type = ?,
                    stripe_publishable_key = ?,
                    stripe_secret_key = ?,
                    stripe_language = ?,
                    stripe_success_url = ?,
                    stripe_fail_url = ?,
                    stripe_active = ?,
                    paytr_merchant_id = ?,
                    paytr_merchant_key = ?,
                    paytr_merchant_salt = ?,
                    paytr_language = ?,
                    paytr_success_url = ?,
                    paytr_fail_url = ?,
                    paytr_active = ?,
                    paypay_email = ?,
                    paypal_client_id = ?,
                    paypal_secret_id = ?,
                    paypal_active = ?,
                    iap_active = ?");
                    $payment_insert = $payment_insert_query->execute(array(
                        "0","","","","","","0","","","","","","","0","","","","0","0"
                    ));

                    if($payment_insert)
                    {
                        session_start();
                        $_SESSION["admin"] = true;
                        $_SESSION["admin_id"] = $admin["admin_id"];
                        header("location:../ProfilePage.php");
                    }
                    else
                    {
                        header("location:../LoginPage.php?status=unsuccessful");
                    }
                }
                else
                {
                    session_start();
                    $_SESSION["admin"] = true;
                    $_SESSION["admin_id"] = $admin["admin_id"];
                    header("location:../ProfilePage.php");
                }
               
            }
            else
            {
                header("location:../LoginPage.php?status=unsuccessful");
            }
        }
        else
        {
            header("location:../LoginPage.php?status=unsuccessful");
        }
    }
    else
    {
        header("location:../ProfilePage.php");
    }
?>