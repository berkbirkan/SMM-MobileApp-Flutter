<?php
  session_start();

  if(!isset($_SESSION["admin"]))
  {
    header("location:index.php");
  }

  include("modal/db.php");
  $id = addslashes(htmlspecialchars(trim($_SESSION["admin_id"])));
  $admin = $db->query("SELECT * FROM admins WHERE admin_id = '{$id}'")->fetch(PDO::FETCH_ASSOC);
  $admin_url = "ProfilePage.php";
?>

<?php include("static/header.php"); ?>

    <div class="content">
        <div class="row">
          <div class="col-md-8">
          <?php
            if(isset($_GET["status"]))
            {
              if($_GET["status"]=="success")
              {
                echo '<div class="alert alert-success" role="alert">
               <b>SUCCESSFUL!</b> Your User Information Has Been Updated.
              </div>';
              }
              else if($_GET["status"]=="unsuccessful")
              {
                echo '<div class="alert alert-danger" role="alert">
                <b>UNSUCCESSFUL!</b> Your User Information Could Not Be Updated.
              </div>';
              }
            }
          ?>
            <div class="card">
              <div class="card-header">
                <h4 class="card-title">Edit Profile</h4>
              </div>
              <div class="card-body">
                <form action="controller/ProfileController.php" method="post">
                <div class="row">
                    <div class="col-md-6 pr-md-1">
                      <div class="form-group">
                        <label>Name</label>
                        <input name="admin_fullname" type="text" class="form-control" placeholder="Name Enter" value="<?=$admin["admin_fullname"]?>" required>
                      </div>
                    </div>
                    <div class="col-md-6 pl-md-1">
                      <div class="form-group">
                        <label>E-mail address</label>
                        <input name="admin_email" type="text" class="form-control" placeholder="E-mail Address Enter " value="<?=$admin["admin_email"]?>" required>
                      </div>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col-md-6 pr-md-1">
                      <div class="form-group">
                        <label>Username</label>
                        <input name="admin_username" type="text" class="form-control" placeholder="Username Enter" value="<?=$admin["admin_username"]?>" required>
                      </div>
                    </div>
                    <div class="col-md-6 pl-md-1">
                      <div class="form-group">
                        <label>Password</label>
                        <input name="admin_password" type="text" class="form-control" placeholder="Password Enter">
                      </div>
                    </div>
                  </div>
              </div>
              <div class="card-footer">
                <button name="btnSave" type="submit" class="btn btn-fill btn-primary">UPDATE</button>
              </div>
              </form>
            </div>
          </div>
          <div class="col-md-4">
            <div class="card card-user">
              <div class="card-body">
                <p class="card-text">
                  <div class="author">
                    <div class="block block-one"></div>
                    <div class="block block-two"></div>
                    <div class="block block-three"></div>
                    <div class="block block-four"></div>
                    <a href="javascript:void(0)">
                      <img class="avatar" src="assets/img/anime3.png" alt="...">
                      <h5 class="title"><?=mb_strtoupper ($admin["admin_fullname"],"UTF-8")?></h5>
                    </a>
                    <p class="description">
                    CEO / Founding Partner
                  </p>
                  </div>
                </p>
                <div class="card-description text-center">
                    Don't be afraid of the facts because we really need to reboot the human foundation And I love you like Kanye loves Kanye I love Rick Owens' bed design but the backside ...
                </div>
              </div>
            </div>
          </div>
        </div>
    </div>
  </div>
</div>
<?php include("static/footer.php") ?>