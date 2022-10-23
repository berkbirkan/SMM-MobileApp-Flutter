<?php 
  session_start();
  if(!isset($_SESSION["admin"]))
  {
    header("location:index.php");
  }
  include("modal/db.php");
  $admin_url = "ProviderPage.php";
  $query = $db->query("SELECT * FROM provider", PDO::FETCH_ASSOC);

  if(isset($_GET["update_id"]))
  {
    $provider_id = $_GET["update_id"];
    if(is_numeric($provider_id))
    {
      $provider_update_get = $db->query("SELECT * FROM provider WHERE provider_id = '{$provider_id}'")->fetch(PDO::FETCH_ASSOC);
      if ( $provider_update_get )
      {

      }
      else
      {
        header("location:ProviderPage.php");
      }
    }
    else
    {
      header("location:ProviderPage.php");
    }
  }
?>

<?php include("static/header.php"); ?>
<div class="content">
    <div class="row">
      <div class="col-md-12">
        <div class="card" id="frmList">
          <div class="card-header">
            <h4 class="card-title">Api Provider List
            </h4>
          </div>
          <div class="card-body">
            <p><button id="frmAddBtn" type="submit" class="btn btn-fill btn-primary">New Record</button></p>
           
            <?php
                    if(isset($_GET["status"]))
                    {
                       
                        if($_GET["status"]=="delete-success")
                        {
                            echo '<div class="alert alert-success" role="alert">
                            <b>SUCCESSFUL!</b> Transaction Successful Provider Deleted.

                            </div>';
                        }
                        else  if($_GET["status"]=="delete-unsuccessful")
                        {
                            echo '<div class="alert alert-danger" role="alert">
                            <b>UNSUCCESSFUL!</b>  Operation Failed Couldnt Delete Provider.

                            </div>';
                        }
                        else  if($_GET["status"]=="insert-success")
                        {
                          echo '<div class="alert alert-success" role="alert">
                          <b>SUCCESSFUL!</b> Transaction Successful Provider Added.

                          </div>';
                        }
                        else  if($_GET["status"]=="insert-unsuccessful")
                        {
                            echo '<div class="alert alert-danger" role="alert">
                            <b>UNSUCCESSFUL!</b> Operation Failed Unable to Add Provider.

                            </div>';
                        }
                        else  if($_GET["status"]=="update-success")
                        {
                          echo '<div class="alert alert-success" role="alert">
                          <b>SUCCESSFUL!</b> Transaction Successful Provider Updated.

                          </div>';
                        }
                        else  if($_GET["status"]=="update-unsuccessful")
                        {
                            echo '<div class="alert alert-danger" role="alert">
                            <b>UNSUCCESSFUL!</b> Operation Failed Provider Failed to Update.

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
                                <th class="text-center">PROVİDER NAME</th>
                                <th class="text-center">PROVİDER URL</th>
                                <th class="text-center">API KEY</th>
                                <th class="text-center">date of registration</th>
                                <th class="text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach($query as $provider): ?>
                              <tr>
                                <td class="text-center"><?=$provider["provider_id"]?></td>
                                <td  class="text-center"><?=$provider["provider_name"]?></td>
                                <td  class="text-center"><?=$provider["provider_url"]?></td>
                                <td  class="text-center"><?=$provider["api_key"]?></td>
                                <td  class="text-center"><?=$provider["provider_date"]?></td>
                                <td class="td-actions text-center">
                                  <a href="?update_id=<?=$provider["provider_id"]?>" id="frmUpdateBtn" class='btn btn-danger btn-link btn-icon btn-sm'>
                                          <i class='tim-icons icon-pencil'></i>
                                  </a>
                                  <a href='controller/ProviderController.php?delete_id=<?=$provider["provider_id"]?>' class='btn btn-danger btn-link btn-icon btn-sm'>
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
                        NO REGISTERED PROVIDERS

                    </p>
                    <?php endif;?>
              </div>
          </div>
        </div>
      </div>    
      <div class="col-md-12">
        <div class="card" id="frmAdd">
            <div class="card-header">
              <h4 class="card-title">Add Api Provider
              </h4>
            </div>
            <div class="card-body">
            <form action="controller/ProviderController.php" method="post">
                <div class="row">
                    <div class="col-md-12 pr-md-1">
                      <div class="form-group">
                        <label>Api Provider Name</label>
                        <input name="provider_name" type="text"  class="form-control" placeholder="Api Provider Name Enter" required>
                      </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 pr-md-1">
                      <div class="form-group">
                        <label>Api Provider Url</label>
                        <input name="provider_url" type="text"  class="form-control" placeholder="Api Provider Url Enter" required>
                      </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 pr-md-1">
                      <div class="form-group">
                        <label>Api Key</label>
                        <input name="api_key" type="text"  class="form-control" placeholder="Api Key Enter" required>
                      </div>
                    </div>
                </div>
            </div>
            <div class="card-footer">
              <a id="frmAddBackBtn" class="btn btn-fill btn-primary" style="color:white;">BACK</a>
              <button name="BtnProviderAdd" type="submit" class="btn btn-fill btn-primary">ADD</button>
            </div>
          </div>
          </form>
      </div>
       
      <div class="col-md-12">
        <div class="card" id="frmUpdate">
            <div class="card-header">
              <h4 class="card-title">Update Api Provider
              </h4>
            </div>
            <div class="card-body">
            <form action="controller/ProviderController.php" method="post">
            <div class="row">
                    <div class="col-md-12 pr-md-1">
                      <div class="form-group">
                        <label>Api Provider Name</label>
                        <input name="provider_name" value="<?=$provider_update_get["provider_name"]?>" type="text"  class="form-control" placeholder="Api Provider Name Enter" required>
                      </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 pr-md-1">
                      <div class="form-group">
                        <label>Api Provider Url</label>
                        <input name="provider_url" type="text" value="<?=$provider_update_get["provider_url"]?>" class="form-control" placeholder="Api Provider Url Enter" required>
                        <input style="display:none;" name="provider_id" type="text" value="<?=$provider_update_get["provider_id"]?>" class="form-control" required>
                      </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 pr-md-1">
                      <div class="form-group">
                        <label>Api Key</label>
                        <input name="api_key" type="text" value="<?=$provider_update_get["api_key"]?>" class="form-control" placeholder="Api Key Enter" required>
                      </div>
                    </div>
                </div>
            </div>
            <div class="card-footer">
                  <a href="ProviderPage.php" id="frmUpdateBackBtn" class="btn btn-fill btn-primary" style="color:white;">BACK</a>
                  <button name="BtnProviderUpdate" type="submit" class="btn btn-fill btn-primary">UPDATE</button>
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
