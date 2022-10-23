<?php 
    session_start();
    if(isset($_SESSION["admin"]))
    {
        header("location:ProfilePage.php");
    }
?>
<!doctype html>
<html lang="en">
  <head>
    <title>Giriş Sayfası</title>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <!--  Fonts and icons  -->
    <!--  Fonts and icons     -->
    <link href="https://fonts.googleapis.com/css?family=Poppins:200,300,400,600,700,800" rel="stylesheet">
    <link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel="stylesheet">
    <!-- Nucleo Icons -->
    <link href="assets/css/nucleo-icons.css" rel="stylesheet" />
    <!-- Black Dashboard CSS -->
    <link href="assets/css/black-dashboard.css?v=1.0.0" rel="stylesheet" />
    <style>
        .content{
            padding:0!important;
            margin:0!important;
            min-height:calc(100vh - 2px)!important;
            display:flex;
            flex-direction: column;   
            justify-content: center;
        }
        .content .row{
            display:flex;
            justify-content: center;
            margin:10px;
        }
    </style>
  </head>
  <body>
<div class="wrapper ">
  <div class="main-panel">
   <div class="content">
        <div class="row">
          <div class="col-md-4">
         <?php
          if(isset($_GET["status"]))
          {
            if($_GET["status"]=="unsuccessful")
            {
              echo ' <div class="alert alert-danger" role="alert" style="font-size:13px;text-align:center;">
              Üzgünüz, kullanıcı adın veya şifren yanlıştı. Lütfen Bilgilerini dikkatlice kontrol et.
              </div>';
            }
          }
         ?>
          <div class="card">
  <div class="card-body col-10 ml-auto mr-auto">
    <form action="controller/LoginController.php" method="post">
     <p class="text-center size-12" style="font-size:25px;margin:30px 0 30px 0;font-weight:bold;">GİRİŞ SAYFASI</p>
      <div class="form-group" style="margin:30px 0 30px 0;">
        <label for="exampleInputEmail1">Kullanıcı Adı</label>
        <input name="username" maxlength="12" minlength="5" type="text" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Kullanıcı Adınıız Giriniz" required>
      </div>
      <div class="form-group" style="margin:30px 0 30px 0;">
        <label for="exampleInputPassword1">Password</label>
        <input name="pass" maxlength="12" minlength="6" type="password" class="form-control" id="exampleInputPassword1" placeholder="Şifrenizi Giriniz" required>
      </div>
      <div class="form-check">
          <label class="form-check-label">
              <input class="form-check-input" type="checkbox" name="remember">
             Beni Hatırla
              <span class="form-check-sign">
                  <span class="check"></span>
              </span>
          </label>
      </div>
      <button name="btnlogin" type="submit" class="btn btn-primary" style="margin:30px 0 30px 0;width:100%;">Giriş Yap</button>
    </form>
  </div>
</div>
          </div>
          </div>
      </div>
  </div>
</div>
<!--   Core JS Files   -->
<script src="assets/js/core/jquery.min.js" type="text/javascript"></script>
<script src="assets/js/core/popper.min.js" type="text/javascript"></script>
<script src="assets/js/core/bootstrap.min.js" type="text/javascript"></script>
<script src="assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>
<!--  Notifications Plugin    -->
<script src="assets/js/plugins/bootstrap-notify.js"></script>
<!-- Control Center for Material Dashboard: parallax effects, scripts for the example pages etc -->
<script src="assets/js/black-dashboard.js?v=1.0.0" type="text/javascript"></script></body>
</html>