<?php
session_start();
if(!isset($_SESSION["admin"]))
{
    header("location:index.php");
}
include("modal/db.php");
$admin_url = "PaymentPage.php";
$query = $db->query("SELECT * FROM payments", PDO::FETCH_ASSOC);
foreach ($query as $payment)
?>

<?php include("static/header.php"); ?>
<div class="content">
    <div class="row">
        <div class="col-md-12">
            <?php
            if(isset($_GET["status"]))
            {
                if($_GET["status"]=="payment-type-success")
                {
                    echo '<div class="alert alert-success" role="alert">
               <b>SUCCESSFUL!</b> Your Payment Transaction Has Been Updated.

              </div>';
                }
                else if($_GET["status"]=="payment-type-unsuccessful")
                {
                    echo '<div class="alert alert-danger" role="alert">
                <b>UNSUCCESSFUL!</b> Your Payment Transaction Could Not Be Updated.

              </div>';
                }

                if($_GET["status"]=="payment-stripe-success")
                {
                    echo '<div class="alert alert-success" role="alert">
               <b>SUCCESSFUL!</b> Your Stripe Information Has Been Updated.

              </div>';
                }
                else if($_GET["status"]=="payment-stripe-unsuccessful")
                {
                    echo '<div class="alert alert-danger" role="alert">
                <b>UNSUCCESSFUL!</b> Your Stripe Information Could Not Be Updated.

              </div>';
                }

                if($_GET["status"]=="payment-paytr-success")
                {
                    echo '<div class="alert alert-success" role="alert">
               <b>SUCCESSFUL!</b> Your Paytr Information Has Been Updated.

              </div>';
                }
                else if($_GET["status"]=="payment-paytr-unsuccessful")
                {
                    echo '<div class="alert alert-danger" role="alert">
                <b>UNSUCCESSFUL!</b> Your Paytr Information Could Not Be Updated.

              </div>';
                }

                if($_GET["status"]=="payment-paypal-success")
                {
                    echo '<div class="alert alert-success" role="alert">
               <b>SUCCESSFUL!</b> Your Paypal Information Has Been Updated.

              </div>';
                }
                else if($_GET["status"]=="payment-paypal-unsuccessful")
                {
                    echo '<div class="alert alert-danger" role="alert">
                <b>UNSUCCESSFUL!</b> Your Paypal Information Could Not Be Updated.

              </div>';
                }

                if($_GET["status"]=="payment-iap-success")
                {
                    echo '<div class="alert alert-success" role="alert">
               <b>SUCCESSFUL!</b> Your iAP information has been updated.

              </div>';
                }
                else if($_GET["status"]=="payment-iap-unsuccessful")
                {
                    echo '<div class="alert alert-danger" role="alert">
                <b>UNSUCCESSFUL!</b> Your iap information could not be updated.

              </div>';
                }


            }
            ?>
            <div class="card" id="frmList">
                <div class="card-header">
                    <h4 class="card-title">Pay list
                    </h4>
                </div>
                <div class="card-body">
                    <form action="controller/PaymentController.php" method="post">
                        <input type="hidden" name="payment_id" value="{{isset($payment->id) ? $payment->id : ''}}">
                        <div class="row">
                            <div class="col-md-12 pr-md-1">
                                <div class="form-group">
                                    <label>Select Payment Process
                                    </label><br><br>
                                    <input type="radio" value="0" name="payment_type" <?=$payment["payment_type"] == 0 ? "checked" : null ?>  id="" required> İAP
                                    &nbsp; &nbsp; &nbsp; &nbsp;
                                    <input type="radio" value="1" name="payment_type" <?=$payment["payment_type"] == 1 ? "checked" : null ?> id="" required> MULTİ
                                </div>
                            </div>
                        </div>
                        <button name="BtnPaymentTypeAdd" type="submit" class="btn btn-fill btn-primary">Save</button>
                    </form>
                    <br>
                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                        <li class="nav-item" role="presentation">
                            <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">Sanal Pos(Stripe)</a>
                        </li>
                        <li class="nav-item" role="presentation">
                            <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">Sanal Pos ( Paytr)</a>
                        </li>
                        <li class="nav-item" role="presentation">
                            <a class="nav-link" id="contact-tab" data-toggle="tab" href="#contact" role="tab" aria-controls="contact" aria-selected="false">Paypal</a>
                        </li>
                        <li class="nav-item" role="presentation">
                            <a class="nav-link" id="contact-tab" data-toggle="tab" href="#iap" role="tab" aria-controls="contact" aria-selected="false">İap</a>
                        </li>
                    </ul>
                    <div class="tab-content" id="myTabContent">
                        <div class="tab-pane p-2 fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                            <form action="controller/PaymentController.php" method="post">
                                <input type="hidden" name="payment_id" value="<?=$payment["id"]?>">
                                <div class="row">
                                    <div class="col-md-12 pr-md-1">
                                        <div class="form-group">
                                            <label>Publishable key</label>
                                            <input value="<?=isset($payment["stripe_publishable_key"]) ? $payment["stripe_publishable_key"] : null ?>" name="stripe_publishable_key" type="text"  class="form-control" placeholder="Publishable Key Enter" required>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12 pr-md-1">
                                        <div class="form-group">
                                            <label>Secret key</label>
                                            <input value="<?=isset($payment["stripe_secret_key"]) ? $payment["stripe_secret_key"] : null?>" name="stripe_secret_key" type="text"  class="form-control" placeholder="Secret Key Enter" required>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12 pr-md-1">
                                        <div class="form-group">
                                            <label>Language</label>
                                            <input value="<?=isset($payment["stripe_language"]) ? $payment["stripe_language"] : null?>" name="stripe_language" type="text"  class="form-control" placeholder="Language Enter" required>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12 pr-md-1">
                                        <div class="form-group">
                                            <label>Success url</label>
                                            <input value="<?=isset($payment["stripe_success_url"]) ? $payment["stripe_success_url"] : null?>" name="stripe_success_url" type="text"  class="form-control" placeholder="Success url Enter" required>
                                        </div>
                                    </div>
                                </div>


                                <div class="row">
                                    <div class="col-md-12 pr-md-1">
                                        <div class="form-group">
                                            <label>Fail url</label>
                                            <input value="<?=isset($payment["stripe_fail_url"]) ? $payment["stripe_fail_url"] : null?>" name="stripe_fail_url" type="text"  class="form-control" placeholder="Fail url Enter" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 pr-md-1">
                                        <div class="form-group">
                                            <label>Active</label>
                                            <div class="custom-control custom-switch">
                                                <input <?=isset($payment["stripe_active"]) ? $payment["stripe_active"] == 1 ? "checked" : null : null?> name="stripe_active" type="checkbox" class="custom-control-input" id="stripe">
                                                <label class="custom-control-label" for="stripe"></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <button name="BtnStripeAdd" type="submit" class="btn btn-fill btn-primary">
                                    <?= isset($payment["stripe_publishable_key"]) ? "UPDATE" : "SAVE" ?>
                                </button>
                            </form>
                        </div>
                        <div class="tab-pane fade p-2" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                            <form action="controller/PaymentController.php" method="post">
                                <input type="hidden" name="payment_id" value="<?=$payment["id"]?>">
                                <div class="row">
                                    <div class="col-md-12 pr-md-1">
                                        <div class="form-group">
                                            <label>Paytr merchant id</label>
                                            <input value="<?=isset($payment["paytr_merchant_id"]) ? $payment["paytr_merchant_id"] : null?>" name="paytr_merchant_id" type="text"  class="form-control" placeholder="Paytr merchant id Enter" required>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12 pr-md-1">
                                        <div class="form-group">
                                            <label>Merchant key</label>
                                            <input value="<?=isset($payment["paytr_merchant_key"]) ? $payment["paytr_merchant_key"] : null?>" name="paytr_merchant_key" type="text"  class="form-control" placeholder="Merchant key Enter" required>
                                        </div>
                                    </div>
                                </div>


                                <div class="row">
                                    <div class="col-md-12 pr-md-1">
                                        <div class="form-group">
                                            <label>Merchant salt</label>
                                            <input value="<?=isset($payment["paytr_merchant_salt"]) ? $payment["paytr_merchant_salt"] : null?>" name="paytr_merchant_salt" type="text"  class="form-control" placeholder="Merchant salt Enter" required>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12 pr-md-1">
                                        <div class="form-group">
                                            <label>Language</label>
                                            <input value="<?=isset($payment["paytr_language"]) ? $payment["paytr_language"] : null?>" name="paytr_language" type="text"  class="form-control" placeholder="Paytr Language Enter" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 pr-md-1">
                                        <div class="form-group">
                                            <label>Success url</label>
                                            <input value="<?=isset($payment["paytr_success_url"]) ? $payment["paytr_success_url"] : null?>" name="paytr_success_url" type="text"  class="form-control" placeholder="Success Url Enter" required>
                                        </div>
                                    </div>
                                </div>


                                <div class="row">
                                    <div class="col-md-12 pr-md-1">
                                        <div class="form-group">
                                            <label>Fail url</label>
                                            <input value="<?=isset($payment["paytr_fail_url"]) ? $payment["paytr_fail_url"] : null?>" name="paytr_fail_url" type="text"  class="form-control" placeholder="Paytr Fail Url Enter" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 pr-md-1">
                                        <div class="form-group">
                                            <label>Active</label>
                                            <div class="custom-control custom-switch">
                                                <input <?=isset($payment["paytr_active"]) ? $payment["paytr_active"] == 1 ? "checked" : null : null?> name="paytr_active"  type="checkbox" class="custom-control-input" id="paytr">
                                                <label class="custom-control-label" for="paytr"></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <button name="BtnPaytrAdd" type="submit" class="btn btn-fill btn-primary">
                                    <?=isset($payment["paytr_merchant_id"]) ? "UPDATE" : "SAVE" ?>
                                </button>
                            </form>
                        </div>
                        <div class="tab-pane fade p-2" id="contact" role="tabpanel" aria-labelledby="contact-tab">
                            <form action="controller/PaymentController.php" method="post">
                                <input type="hidden" name="payment_id" value="<?=$payment["id"]?>">
                                <div class="row">
                                    <div class="col-md-12 pr-md-1">
                                        <div class="form-group">
                                            <label>Paypal Email</label>
                                            <input value="<?=isset($payment["paypay_email"]) ? $payment["paypay_email"] : null?>" name="paypay_email" type="text"  class="form-control" placeholder="Paypal Email Enter" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 pr-md-1">
                                        <div class="form-group">
                                            <label>Paypal Client Id</label>
                                            <input value="<?=isset($payment["paypal_client_id"]) ? $payment["paypal_client_id"] : null?>" name="paypal_client_id" type="text"  class="form-control" placeholder="Paypal Client Id Enter" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 pr-md-1">
                                        <div class="form-group">
                                            <label>Paypal Secret Id</label>
                                            <input value="<?=isset($payment["paypal_secret_id"]) ? $payment["paypal_secret_id"] : null?>"  name="paypal_secret_id" type="text"  class="form-control" placeholder="Paypal Secret Id Enter" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 pr-md-1">
                                        <div class="form-group">
                                            <label>Active</label>
                                            <div class="custom-control custom-switch">
                                                <input <?=isset($payment["paypal_active"]) ? $payment["paypal_active"] == 1 ? "checked" : null : null?> name="paypal_active" type="checkbox"  class="custom-control-input" id="paypal">
                                                <label class="custom-control-label" for="paypal"></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <button name="BtnPayPalAdd" type="submit" class="btn btn-fill btn-primary">
                                    <?=isset($payment["paypay_email"]) ? "UPDATE" : "SAVE" ?>
                                </button>
                            </form>
                        </div>
                        <div class="tab-pane fade p-2" id="iap" role="tabpanel" aria-labelledby="contact-tab">
                            <form action="controller/PaymentController.php" method="post">
                                <input type="hidden" name="payment_id" value="<?=$payment["id"]?>">
                                <div class="row">
                                    <div class="col-md-12 pr-md-1">
                                        <div class="form-group">
                                            <label>Active</label>
                                            <div class="custom-control custom-switch">
                                                <input <?=isset($payment["iap_active"]) ? $payment["iap_active"] == 1 ? "checked" : null : null?>  name="iap_active" type="checkbox" class="custom-control-input" id="iap_active">
                                                <label class="custom-control-label" for="iap_active"></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <button name="BtnIapAdd" type="submit" class="btn btn-fill btn-primary">SAVE</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </form>
    </div>

</div>

<?php include("static/footer.php"); ?>


<script>
    $(document).ready(function(){

        $("#frmAdd").hide();
        $("#frmUpdate").hide();

        $("#frmAddBtn").click(function(){

            $("#frmList").slideUp(300);
            $("#frmAdd").slideDown(300);

        });

        $("#frmAddBackBtn").click(function(){

            $("#frmAdd").slideUp(300);
            $("#frmList").slideDown(300);

        });

        $("#frmAddBtn").click(function(){

            $("#frmList").slideUp(300);
            $("#frmAdd").slideDown(300);

        });

        $("#frmAddBackBtn").click(function(){

            $("#frmAdd").slideUp(300);
            $("#frmList").slideDown(300);

        });
    });
</script>

<?php if(isset($_GET["update_id"])): ?>
    <script>
        $(document).ready(function(){
            $("#frmList").hide();
            $("#frmAdd").hide();
            $("#frmUpdate").show();
        });
    </script>
<?php endif;?>
