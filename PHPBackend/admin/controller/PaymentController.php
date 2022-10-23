<?php

if(isset($_POST["BtnPaymentTypeAdd"]))
{
    include("../modal/db.php");
    $payment_type = addslashes(htmlspecialchars(trim($_POST["payment_type"])));

    $query = $db->prepare("UPDATE payments SET
        payment_type = :payment_type");
    $update = $query->execute(array(
        "payment_type" => $payment_type,
    ));
    if ( $update )
    {
        header("location:../PaymentPage.php?status=payment-type-success");
    }
    else
    {
        header("location:../PaymentPage.php?status=payment-type-unsuccessful");
    }
}
else if(isset($_POST["BtnStripeAdd"]))
{
    include("../modal/db.php");
    $stripe_publishable_key = addslashes(htmlspecialchars(trim($_POST["stripe_publishable_key"])));
    $stripe_secret_key = addslashes(htmlspecialchars(trim($_POST["stripe_secret_key"])));
    $stripe_language = addslashes(htmlspecialchars(trim($_POST["stripe_language"])));
    $stripe_success_url = addslashes(htmlspecialchars(trim($_POST["stripe_success_url"])));
    $stripe_fail_url = addslashes(htmlspecialchars(trim($_POST["stripe_fail_url"])));
    @$stripe_active = addslashes(htmlspecialchars(trim($_POST["stripe_active"])));

    $query = $db->prepare("UPDATE payments SET
        stripe_publishable_key = :stripe_publishable_key,
        stripe_secret_key = :stripe_secret_key,
        stripe_language = :stripe_language,
        stripe_success_url = :stripe_success_url,
        stripe_fail_url =:stripe_fail_url,
        stripe_active =:stripe_active");
    $update = $query->execute(array(
        "stripe_publishable_key" => $stripe_publishable_key,
        "stripe_secret_key" => $stripe_secret_key,
        "stripe_language" => $stripe_language,
        "stripe_success_url" => $stripe_success_url,
        "stripe_fail_url" => $stripe_fail_url,
        "stripe_active" =>$stripe_active == "on" ? 1 : 0,
    ));
    if ( $update )
    {
        header("location:../PaymentPage.php?status=payment-stripe-success");
    }
    else
    {
        header("location:../PaymentPage.php?status=payment-stripe-unsuccessful");
    }
}
else if(isset($_POST["BtnPaytrAdd"]))
{
    include("../modal/db.php");
    $paytr_merchant_id = addslashes(htmlspecialchars(trim($_POST["paytr_merchant_id"])));
    $paytr_merchant_key = addslashes(htmlspecialchars(trim($_POST["paytr_merchant_key"])));
    $paytr_merchant_salt = addslashes(htmlspecialchars(trim($_POST["paytr_merchant_salt"])));
    $paytr_language = addslashes(htmlspecialchars(trim($_POST["paytr_language"])));
    $paytr_success_url = addslashes(htmlspecialchars(trim($_POST["paytr_success_url"])));
    $paytr_fail_url = addslashes(htmlspecialchars(trim($_POST["paytr_fail_url"])));
    $paytr_active  = @addslashes(htmlspecialchars(trim($_POST["paytr_active"])));

    $query = $db->prepare("UPDATE payments SET
        paytr_merchant_id = :paytr_merchant_id,
        paytr_merchant_key = :paytr_merchant_key,
        paytr_merchant_salt = :paytr_merchant_salt,
        paytr_language = :paytr_language,
        paytr_success_url =:paytr_success_url,
        paytr_fail_url =:paytr_fail_url,
        paytr_active =:paytr_active");

    $update = $query->execute(array(
        "paytr_merchant_id" => $paytr_merchant_id,
        "paytr_merchant_key" => $paytr_merchant_key,
        "paytr_merchant_salt" => $paytr_merchant_salt,
        "paytr_language" => $paytr_language,
        "paytr_success_url" => $paytr_success_url,
        "paytr_fail_url" => $paytr_fail_url,
        "paytr_active" =>$paytr_active == "on" ? 1 : 0,
    ));
    if ( $update )
    {
        header("location:../PaymentPage.php?status=payment-paytr-success");
    }
    else
    {
        header("location:../PaymentPage.php?status=payment-paytr-unsuccessful");
    }
}
else if(isset($_POST["BtnPayPalAdd"]))
{
    include("../modal/db.php");

    $paypay_email = addslashes(htmlspecialchars(trim($_POST["paypay_email"])));
    $paypal_client_id = addslashes(htmlspecialchars(trim($_POST["paypal_client_id"])));
    $paypal_secret_id = addslashes(htmlspecialchars(trim($_POST["paypal_secret_id"])));
    $paypal_active = @addslashes(htmlspecialchars(trim($_POST["paypal_active"])));

    $query = $db->prepare("UPDATE payments SET
        paypay_email = :paypay_email,
        paypal_client_id = :paypal_client_id,
        paypal_secret_id = :paypal_secret_id,
        paypal_active = :paypal_active");

    $update = $query->execute(array(
        "paypay_email" => $paypay_email,
        "paypal_client_id" => $paypal_client_id,
        "paypal_secret_id" => $paypal_secret_id,
        "paypal_active" =>$paypal_active == "on" ? 1 : 0,
    ));
    if ( $update )
    {
        header("location:../PaymentPage.php?status=payment-paypal-success");
    }
    else
    {
        header("location:../PaymentPage.php?status=payment-paypal-unsuccessful");
    }
}
else if(isset($_POST["BtnIapAdd"]))
{
    include("../modal/db.php");
    $iap_active = @addslashes(htmlspecialchars(trim($_POST["iap_active"])));
    $query = $db->prepare("UPDATE payments SET
        iap_active =:iap_active");
    $update = $query->execute(array(
        "iap_active" =>$iap_active == "on" ? 1 : 0,
    ));
    if ( $update )
    {
        header("location:../PaymentPage.php?status=payment-iap-success");
    }
    else
    {
        header("location:../PaymentPage.php?status=payment-iap-unsuccessful");
    }
}