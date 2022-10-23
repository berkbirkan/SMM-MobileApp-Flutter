<?php 
  session_start();
  if(!isset($_SESSION["admin"]))
  {
    header("location:index.php");
  }
  include("modal/db.php");
  $admin_url = "UserPage.php";
  $query = $db->query("SELECT * FROM users", PDO::FETCH_ASSOC);

  if(isset($_GET["update_id"]))
  {
    $users_id = $_GET["update_id"];
    if(is_numeric($users_id))
    {
      $users_update_get = $db->query("SELECT * FROM users WHERE user_id = '{$users_id}'")->fetch(PDO::FETCH_ASSOC);
      if ( $users_update_get )
      {

      }
      else
      {
        header("location:UserPage.php");
      }
    }
    else
    {
      header("location:UserPage.php");
    }
  }
?>

<?php include("static/header.php"); ?>
<div class="content">
    <div class="row">
      <div class="col-md-12">
        <div class="card" id="frmList">
          <div class="card-header">
            <h4 class="card-title"> User List</h4>
          </div>
          <div class="card-body">
            <p><button id="frmAddBtn" type="submit" class="btn btn-fill btn-primary">New Record</button></p>
            <?php
                    if(isset($_GET["status"]))
                    {
                        if($_GET["status"]=="delete-success")
                        {
                            echo '<div class="alert alert-success" role="alert">
                            <b>SUCCESSFUL!</b> Operation Successful User Deleted.
                            </div>';
                        }
                        else  if($_GET["status"]=="delete-unsuccessful")
                        {
                            echo '<div class="alert alert-danger" role="alert">
                            <b>UNSUCCESSFUL!</b> Operation Failed. User Couldnt Delete.
                            </div>';
                        }
                        else  if($_GET["status"]=="record-error")
                        {
                            echo '<div class="alert alert-danger" role="alert">
                            <b>UNSUCCESSFUL!</b> Operation Failed You Are Trying To Add The Same Record.
                            </div>';
                        }
                        else  if($_GET["status"]=="insert-success")
                        {
                          echo '<div class="alert alert-success" role="alert">
                          <b>SUCCESSFUL!</b> Operation Successful User Added.
                          </div>';
                        }
                        else  if($_GET["status"]=="insert-unsuccessful")
                        {
                            echo '<div class="alert alert-danger" role="alert">
                            <b>UNSUCCESSFUL!</b> Operation Failed. Unable to Add User.
                            </div>';
                        }
                        else  if($_GET["status"]=="update-success")
                        {
                          echo '<div class="alert alert-success" role="alert">
                          <b>SUCCESSFUL!</b> Transaction Successful User Updated.
                          </div>';
                        }
                        else  if($_GET["status"]=="update-unsuccessful")
                        {
                            echo '<div class="alert alert-danger" role="alert">
                            <b>UNSUCCESSFUL!</b> Operation Failed User Failed to Update.
                            </div>';
                        }
                        
                    }
              ?>
              <div class="table-responsive">
                    <?php if($query->rowCount()>0): ?>
                      <table class="table">
                        <thead>
                            <tr>
                                <th class="text-center">#Id</th>
                                <th class="text-center">Username</th>
                                <th class="text-center">Name</th>
                                <th class="text-center">surname</th>
                                <th class="text-center">Email</th>
                                <th class="text-center">credit</th>
                                <th class="text-center">date of registration</th>
                                <th class="text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach($query as $users): ?>
                              <tr>
                                <td class="text-center"><?=$users["user_id"]?></td>
                                <td class="text-center"><?=$users["user_username"]?></td>
                                <td class="text-center"><?=$users["user_name"]?></td>
                                <td class="text-center"><?=$users["user_surname"]?></td>
                                <td class="text-center"><?=$users["user_email"]?></td>
                                <td class="text-center"><?=$users["user_kredi"]?></td>
                                <td class="text-center"><?=$users["user_date"]?></td>
                                <td class="td-actions text-center">
                                  <a href="?update_id=<?=$users["user_id"]?>" id="frmUpdateBtn" class='btn btn-danger btn-link btn-icon btn-sm'>
                                          <i class='tim-icons icon-pencil'></i>
                                  </a>
                                  <a href='controller/UserPageController.php?delete_id=<?=$users["user_id"]?>' class='btn btn-danger btn-link btn-icon btn-sm'>
                                          <i class='tim-icons icon-trash-simple'></i>
                                  </a>
                                </td>
                              </tr>
                            <?php endforeach;?>
                        </tbody>
                      </table>
                      <?php endif;?>
                    <?php if(!$query->rowCount()>0): ?>
                    <p class="text-center">
                        NO REGISTERED USERS
                    </p>
                    <?php endif;?>
              </div>
          </div>
        </div>
      </div>    
      <div class="col-md-12">
        <div class="card" id="frmAdd">
            <div class="card-header">
              <h4 class="card-title">Add User</h4>
            </div>
            <div class="card-body">
            <form action="controller/UserPageController.php" method="post"  enctype="multipart/form-data">
                <div class="row">
                    <div class="col-md-12 pr-md-1">
                      <div class="form-group">
                        <label>Username</label>
                        <input name="user_username" type="text"  class="form-control" placeholder="Username Enter" required>
                      </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12 pr-md-1">
                      <div class="form-group">
                        <label>Password</label>
                        <input name="user_password" type="password"  class="form-control" placeholder="Password Enter" required>
                      </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12 pr-md-1">
                        <div class="form-group">
                            <label>Name</label>
                            <input name="user_name" type="text"  class="form-control" placeholder="Name Enter" required>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12 pr-md-1">
                        <div class="form-group">
                            <label>Surname</label>
                            <input name="user_surname" type="text"  class="form-control" placeholder="Surname Enter" required>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12 pr-md-1">
                      <div class="form-group">
                        <label>E-mail Address</label>
                        <input name="user_email" type="email"  class="form-control" placeholder="E-mail Address Enter" required>
                      </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12 pr-md-1">
                      <div class="form-group">
                        <label>Credit</label>
                        <input name="user_kredi" type="number"  class="form-control" placeholder="Credit Enter" required>
                      </div>
                    </div>
                </div> 
              
            </div>
            <div class="card-footer">
              <a id="frmAddBackBtn" class="btn btn-fill btn-primary" style="color:white;">BACK</a>
              <button name="BtnUserAdd" type="submit" class="btn btn-fill btn-primary">ADD</button>
            </div>
          </div>
          </form>
      </div>
       
      <div class="col-md-12">
        <div class="card" id="frmUpdate">
            <div class="card-header">
              <h4 class="card-title">Update User Information</h4>
            </div>
            <div class="card-body">
            <form action="controller/UserPageController.php" method="post">
            <div class="row">
                    <div class="col-md-12 pr-md-1">
                      <div class="form-group">
                        <label>Username</label>
                        <input style="display:none;" name="user_id" value="<?=$users_update_get["user_id"]?>"  type="text">
                        <input name="user_username"  value="<?=$users_update_get["user_username"]?>" type="text"  class="form-control" placeholder="Username Enter" required>
                      </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12 pr-md-1">
                      <div class="form-group">
                        <label>Password</label>
                        <input name="user_password"  type="password"  class="form-control" placeholder="Password Enter">
                      </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12 pr-md-1">
                      <div class="form-group">
                        <label>Name</label>
                        <input name="user_name" value="<?=$users_update_get["user_name"]?>" type="text"  class="form-control" placeholder="Name Enter" required>
                      </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12 pr-md-1">
                        <div class="form-group">
                            <label>Surname</label>
                            <input name="user_surname" value="<?=$users_update_get["user_surname"]?>" type="text"  class="form-control" placeholder="Surname Enter" required>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12 pr-md-1">
                      <div class="form-group">
                        <label>E-mail Address</label>
                        <input name="user_email" value="<?=$users_update_get["user_email"]?>" type="email"  class="form-control" placeholder="E-mail Address Enter" required>
                      </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12 pr-md-1">
                      <div class="form-group">
                        <label>Credit</label>
                        <input name="user_kredi" value="<?=$users_update_get["user_kredi"]?>" type="number"  class="form-control" placeholder="Credit Enter" required>
                      </div>
                    </div>
                </div> 
                
            </div>
            <div class="card-footer">
                  <a href="UserPage.php" id="frmUpdateBackBtn" class="btn btn-fill btn-primary" style="color:white;">BACK</a>
                  <button name="BtnUserUpdate" type="submit" class="btn btn-fill btn-primary">UPDATE</button>
              </div>
          </div>
        </div>    
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
