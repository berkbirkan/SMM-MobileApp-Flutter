<?php
    $admin['menu'] = [
      'ProfilePage.php' => [
          'title' =>'PROFİLE page',
          'icon' => 'tim-icons icon-single-02'
      ],
      'UserPage.php' => [
        'title' =>'USER page',
        'icon' => 'tim-icons icon-single-02'
      ],
      'SocialMediaPage.php' => [
          'title' =>'SOCİALMEDİA page',
          'icon' => 'tim-icons icon-world'
      ],
      'CategoryPage.php' => [
        'title' =>'CATEGORY page',
        'icon' => 'tim-icons icon-bullet-list-67'
      ],
      'ProviderPage.php' => [
        'title' =>'API Provider page',
        'icon' => 'tim-icons icon-paper'
      ],
      'ServicePage.php' => [
        'title' =>'Service page',
        'icon' => 'tim-icons icon-settings'
      ],
        'PaymentPage.php' => [
        'title' =>'PAYMENT page',
        'icon' => 'tim-icons icon-credit-card'
        ],
        'LanguagePage.php' => [
            'title' =>'Language page',
            'icon' => 'tim-icons icon-square-pin'
        ]
  ];
?>
<!doctype html>
<html lang="en">
  <head>
    <title>SMM | Admin Panel</title>
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
    <link href="assets/css/select.css" rel="stylesheet" />
  </head>
  <body>
<div class="wrapper ">
  <div class="sidebar" data-color="purple" data-background-color="white">
    <div class="logo">
      <a href="#" class="simple-text logo-mini">
        SMM
      </a>
      <a href="#" class="simple-text logo-normal">
       ADMİN PANEL
      </a>
    </div>

    <div class="sidebar-wrapper">
      <ul class="nav">
      <?php foreach($admin['menu'] as $key => $menu):?>
        <li class="nav-item <?=$admin_url == $key ? 'active' : null ?>">
            <a class="nav-link" href="<?=$key?>">
                <i class="<?=$menu["icon"]?>"></i>
                <p><?=$menu["title"]?></p>
            </a>
        </li>
      <?php endforeach; ?>
         <!-- your sidebar here -->
      </ul>
    </div>
  </div>
  <div class="main-panel">
      <!-- Navbar -->
      <nav id="topbar" class="navbar navbar-expand-lg navbar-absolute navbar-transparent">
        <div class="container-fluid">
          <div class="navbar-wrapper">
            <div class="navbar-toggle d-inline">
              <button type="button" class="navbar-toggler">
                <span class="navbar-toggler-bar bar1"></span>
                <span class="navbar-toggler-bar bar2"></span>
                <span class="navbar-toggler-bar bar3"></span>
              </button>
            </div>
            <a class="navbar-brand" href="javascript:void(0)">SMM ADMİN PANEL</a>
          </div>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navigation" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-bar navbar-kebab"></span>
            <span class="navbar-toggler-bar navbar-kebab"></span>
            <span class="navbar-toggler-bar navbar-kebab"></span>
          </button>
          <div class="collapse navbar-collapse" id="navigation">
            <ul class="navbar-nav ml-auto">
              <li class="dropdown nav-item">
                <a href="#" class="dropdown-toggle nav-link" data-toggle="dropdown">
                  <div class="photo">
                    <img src="assets/img/anime3.png" alt="Profile Photo">
                  </div>
                  <b class="caret d-none d-lg-block d-xl-block"></b>
                  <p class="d-lg-none">
                   Çıkış Yap
                  </p>
                </a>
                <ul class="dropdown-menu dropdown-navbar">
                  <li class="nav-link"><a href="ProfilePage.php" class="nav-item dropdown-item">Profile</a></li>
                  <li class="dropdown-divider"></li>
                  <li class="nav-link"><a href="functions/exit.php" class="nav-item dropdown-item">Exit</a></li>
                </ul>
              </li>
              <li class="separator d-lg-none"></li>
            </ul>
          </div>
        </div>
      </nav>
      <!-- End Navbar -->