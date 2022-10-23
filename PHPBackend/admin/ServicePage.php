<?php
  session_start();
  if(!isset($_SESSION["admin"]))
  {
    header("location:index.php");
  }
  include("modal/db.php");
  $admin_url = "ServicePage.php";
  $query = $db->query("SELECT * FROM service", PDO::FETCH_ASSOC);

  if(isset($_GET["update_id"]))
  {
    $service_id = $_GET["update_id"];
    if(is_numeric($service_id))
    {
      $service_update_get = $db->query("SELECT * FROM service WHERE api_service_id  = '{$service_id}'")->fetch(PDO::FETCH_ASSOC);
      if ( $service_update_get )
      {

      }
      else
      {
        header("location:ServicePage.php");
      }
    }
    else
    {
      header("location:ServicePage.php");
    }
  }
?>

<?php include("static/header.php"); ?>
<div class="content">
    <div class="row">
      <div class="col-md-12">
        <div class="card" id="frmList">
          <div class="card-header">
            <h4 class="card-title">Api Service List
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
                            <b>SUCCESSFUL!</b> Operation Successful Service Deleted.

                            </div>';
                        }
                        else  if($_GET["status"]=="delete-unsuccessful")
                        {
                            echo '<div class="alert alert-danger" role="alert">
                            <b>UNSUCCESSFUL!</b> Operation Failed Service Failed to Delete.

                            </div>';
                        }
                        else  if($_GET["status"]=="provider-category-error")
                        {
                            echo '<div class="alert alert-danger" role="alert">
                            <b>UNSUCCESSFUL!</b> Add a Category or Provider Before Operation Fails.

                            </div>';
                        }
                        else  if($_GET["status"]=="insert-success")
                        {
                          echo '<div class="alert alert-success" role="alert">
                          <b>SUCCESSFUL!</b> Transaction Successful Service Added.

                          </div>';
                        }
                        else  if($_GET["status"]=="insert-unsuccessful")
                        {
                            echo '<div class="alert alert-danger" role="alert">
                            <b>UNSUCCESSFUL!</b> Operation Failed Service Failed to Add.

                            </div>';
                        }
                        else  if($_GET["status"]=="update-success")
                        {
                          echo '<div class="alert alert-success" role="alert">
                          <b>SUCCESSFUL!</b> Transaction Successful Service Updated.

                          </div>';
                        }
                        else  if($_GET["status"]=="update-unsuccessful")
                        {
                            echo '<div class="alert alert-danger" role="alert">
                            <b>UNSUCCESSFUL!</b> Operation Failed Service could not be updated.

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
                                <th class="text-center">SERVİS name</th>
                                <th class="text-center">SERVİS ID</th>
                                <th class="text-center">PRICE</th>
                                <th class="text-center">AMOUNT</th>
                                <th class="text-center">PROVİDER name</th>
                                <th class="text-center">category</th>
                                <th class="text-center">date of registration</th>
                                <th class="text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach($query as $service): ?>
                              <tr>
                                <td class="text-center"><?=$service["api_service_id"]?></td>
                                <td  class="text-center"><?=$service["service_name"]?></td>
                                <td  class="text-center"><?=$service["service_id"]?></td>
                                <td  class="text-center"><?=$service["provider_price"]?></td>
                                <td  class="text-center"><?=$service["provider_amount"]?></td>
                                <td  class="text-center">
                                  <?php 
                                     
                                     $provider = $db->query("SELECT * FROM provider WHERE provider_id = '{$service["provider_id"]}'")->fetch(PDO::FETCH_ASSOC);
                                     if ( $provider ){
                                        echo $provider["provider_name"];
                                     }
                                   
                                  ?>
                                </td>  
                                <td  class="text-center">
                                  <?php 
                                     
                                     $category = $db->query("SELECT * FROM category WHERE category_id = '{$service["category_id"]}'")->fetch(PDO::FETCH_ASSOC);
                                     if ( $category ){
                                        echo $category["category_name"];
                                     }
                                   
                                  ?>
                                </td>
                                <td  class="text-center"><?=$service["service_date"]?></td>
                                <td class="td-actions text-center">
                                  <a href="?update_id=<?=$service["api_service_id"]?>" id="frmUpdateBtn" class='btn btn-danger btn-link btn-icon btn-sm'>
                                          <i class='tim-icons icon-pencil'></i>
                                  </a>
                                  <a href='controller/serviceController.php?delete_id=<?=$service["api_service_id"]?>' class='btn btn-danger btn-link btn-icon btn-sm'>
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
                        NO REGISTERED SERVICES

                    </p>
                    <?php endif;?>
              </div>
          </div>
        </div>
      </div>    

      <div class="col-md-12">
        <div class="card" id="frmAdd">
            <div class="card-header">
              <h4 class="card-title">Add Service
              </h4>
            </div>
            <div class="card-body">
            <form action="controller/serviceController.php" method="post">
            
            <div class="row">
                    <div class="col-md-12 pr-md-1">
                      <div class="form-group">
                        <label  for="category_id">Category</label>
                        <select name="category_id" class="form-control" style="">
                             <?php 
                                $query = $db->query("SELECT * FROM category", PDO::FETCH_ASSOC);
                                if ( $query->rowCount() )
                                {
                                        $socialmedia = $db->query("SELECT * FROM socialmedia")->fetchAll(PDO::FETCH_ASSOC);
                                        foreach($socialmedia as $social)
                                        {
                                          echo '<optgroup label="'.$social["socialmedia_name"].'">';
                                          $query = $db->query("SELECT * FROM category where socialmedia_id='{$social["socialmedia_id"]}'", PDO::FETCH_ASSOC);
                                          if ( $query->rowCount() ){
                                               foreach( $query as $row ){
                                                echo '<option value="'.$row["category_id"].'">'.$row["category_name"].'</option>';
                                               }
                                               echo ' </optgroup>';
                                        }
                                    }    
                                }
  
                                else
                                {
                                  echo '<option value="0">Kayıtlı Kategori Yok</option>';
                                }
                               
                             ?>
                        </select>
                      </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 pr-md-1">
                      <div class="form-group">
                        <label  for="provider_id">Api Provider Name</label>
                        <select name="provider_id" class="form-control">
                             <?php 
                                $query = $db->query("SELECT * FROM provider", PDO::FETCH_ASSOC);
                                if ( $query->rowCount() ){
                                     foreach( $query as $row ){
                                          echo '<option value="'.$row["provider_id"].'">'.$row["provider_name"].'</option>';
                                     }
                                }
                                else
                                {
                                  echo '<option value="0">No Registered Providers</option>';
                                }
                             ?>
                        </select>
                      </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 pr-md-1">
                      <div class="form-group">
                        <label>Servis Name</label>
                        <input name="service_name" type="text"  class="form-control" placeholder="Servis Name Enter" required>
                      </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 pr-md-1">
                      <div class="form-group">
                        <label>Servis Id</label>
                        <input name="service_id" type="text"  class="form-control" placeholder="Servis Id Enter" required>
                      </div>
                    </div>
                </div>
               
                <div class="row">
                    <div class="col-md-12 pr-md-1">
                      <div class="form-group">
                        <label>Price</label>
                        <input name="provider_price" type="number"  class="form-control" placeholder="Price Enter" required>
                      </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 pr-md-1">
                      <div class="form-group">
                        <label>Amount</label>
                        <input name="provider_amount" type="number"  class="form-control" placeholder="Amount Enter" required>
                      </div>
                    </div>
                </div>
            </div>
            <div class="card-footer">
              <a id="frmAddBackBtn" class="btn btn-fill btn-primary" style="color:white;">BACK</a>
              <button name="BtnServiceAdd" type="submit" class="btn btn-fill btn-primary">ADD</button>
            </div>
          </div>
          </form>
      </div>
       
    <div class="col-md-12">
        <div class="card" id="frmUpdate">
            <div class="card-header">
              <h4 class="card-title">Update Service
              </h4>
            </div>
            <form action="controller/serviceController.php" method="post">
            <div class="card-body">
            <div class="row">
                    <div class="col-md-12 pr-md-1">
                      <div class="form-group">
                        <label  for="cars">Category</label>
                        <select name="category_id" class="form-control">
                        <?php
                            $query = $db->query("SELECT * FROM category", PDO::FETCH_ASSOC);
                            if ( $query->rowCount() )
                            {
                                $socialmedia = $db->query("SELECT * FROM socialmedia")->fetchAll(PDO::FETCH_ASSOC);
                                foreach($socialmedia as $social)
                                {
                                    echo '<optgroup label="'.$social["socialmedia_name"].'">';
                                    $query = $db->query("SELECT * FROM category where socialmedia_id='{$social["socialmedia_id"]}'", PDO::FETCH_ASSOC);
                                    if ( $query->rowCount() ){
                                        foreach( $query as $row ){
                                            echo '<option value="'.$row["category_id"].'">'.$row["category_name"].'</option>';
                                        }
                                        echo ' </optgroup>';
                                    }
                                }
                            }

                            else
                            {
                                echo '<option value="0">Kayıtlı Kategori Yok</option>';
                            }

                            ?>
                        </select>
                      </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 pr-md-1">
                      <div class="form-group">
                        <label  for="cars">Api Provider Name</label>
                        <select name="provider_id" class="form-control">
                             <?php 
                                $provider_id = $service_update_get["provider_id"];
                                $provider = $db->query("SELECT * FROM provider WHERE provider_id = '{$provider_id}'")->fetch(PDO::FETCH_ASSOC);
                                if ( $provider ){
                                  $provider_name = $provider["provider_name"];
                                }

                                echo '<option value="'.$service_update_get["provider_id"].'">'.$provider_name.'</option>';
                                $query = $db->query("SELECT * FROM provider where provider_id!='{$provider_id}'", PDO::FETCH_ASSOC);
                                if ( $query->rowCount() ){
                                     foreach( $query as $row ){
                                          echo '<option value="'.$row["provider_id"].'">'.$row["provider_name"].'</option>';
                                     }
                                }
                             ?>
                        </select>
                      </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12 pr-md-1">
                      <div class="form-group">
                        <label>Servis Name</label>
                        <input name="service_name" type="text" value="<?=$service_update_get["service_name"]?>"  class="form-control" placeholder="Servis Name Enter" required>
                      </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 pr-md-1">
                      <div class="form-group">
                        <label>Servis Id</label>
                        <input name="service_id" type="text" value="<?=$service_update_get["service_id"]?>"  class="form-control" placeholder="Servis Id Enter" required>
                        <input name="api_service_id" type="hidden" value="<?=$service_update_get["api_service_id"]?>" class="form-control" required>
                      </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 pr-md-1">
                      <div class="form-group">
                        <label>Price</label>
                        <input name="provider_price" type="number"  value="<?=$service_update_get["provider_price"]?>"  class="form-control" placeholder="Price Enter" required>
                      </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 pr-md-1">
                      <div class="form-group">
                        <label>Amount</label>
                        <input name="provider_amount" type="number"  value="<?=$service_update_get["provider_amount"]?>"  class="form-control" placeholder="Amount Enter" required>
                      </div>
                    </div>
                </div>
            </div>
            <div class="card-footer">
                  <a href="ServicePage.php" id="frmUpdateBackBtn" class="btn btn-fill btn-primary" style="color:white;">BACK</a>
                  <button name="BtnServiceUpdate" type="submit" class="btn btn-fill btn-primary">UPDATE</button>
              </div>
            </form>
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
