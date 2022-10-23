<?php

    session_start();

    if(isset($_SESSION["admin"]))
    {
        header("location:ProfilePage.php");
    }
    else
    {
        header("location:LoginPage.php");
    }
    