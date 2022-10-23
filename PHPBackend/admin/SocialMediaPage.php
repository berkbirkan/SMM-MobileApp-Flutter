<?php
  session_start();
  if(!isset($_SESSION["admin"]))
  {
    header("location:index.php");
  }
  include("modal/db.php");
  $admin_url = "SocialMediaPage.php";
  $query = $db->query("SELECT * FROM socialmedia", PDO::FETCH_ASSOC);

  if(isset($_GET["update_id"]))
  {
    $socialmedia_id = $_GET["update_id"];
    if(is_numeric($socialmedia_id))
    {
      $socialmedia_update_get = $db->query("SELECT * FROM socialmedia WHERE socialmedia_id = '{$socialmedia_id}'")->fetch(PDO::FETCH_ASSOC);
      if ( $socialmedia_update_get )
      {

      }
      else
      {
        header("location:SocialMediaPage.php");
      }
    }
    else
    {
      header("location:SocialMediaPage.php");
    }
  }
?>

<?php include("static/header.php"); ?>
<div class="content">
    <div class="row">
      <div class="col-md-12">
        <div class="card" id="frmList">
          <div class="card-header">
            <h4 class="card-title">SocialMedia List</h4>
          </div>
          <div class="card-body">
            <p><button id="frmAddBtn" type="submit" class="btn btn-fill btn-primary">New Record</button></p>
           
            <?php
                    if(isset($_GET["status"]))
                    {
                       
                        if($_GET["status"]=="delete-success")
                        {
                            echo '<div class="alert alert-success" role="alert">
                            <b>SUCCESSFUL!</b> Transaction Successful Social Media Deleted.

                            </div>';
                        }
                        else  if($_GET["status"]=="delete-unsuccessful")
                        {
                            echo '<div class="alert alert-danger" role="alert">
                            <b>UNSUCCESSFUL!</b> Operation Failed Social Media Could Not Be Deleted.

                            </div>';
                        }
                        else  if($_GET["status"]=="record-error")
                        {
                            echo '<div class="alert alert-danger" role="alert">
                            <b>UNSUCCESSFUL!</b> Operation Failed You Are Trying To Add The Same Record.

                            </div>';
                        }
                        else  if($_GET["status"]=="file-error")
                        {
                            echo '<div class="alert alert-danger" role="alert">
                            <b>UNSUCCESSFUL!</b> Operation Failed. Unable to insert image.

                            </div>';
                        }
                        else  if($_GET["status"]=="size-error")
                        {
                            echo '<div class="alert alert-danger" role="alert">
                            <b>UNSUCCESSFUL!</b> Operation Failed Picture cannot exceed 10 mb.

                            </div>';
                        }
                        else  if($_GET["status"]=="extension-error")
                        {
                            echo '<div class="alert alert-danger" role="alert">
                            <b>UNSUCCESSFUL!</b> Operation Failed Bad Image Extension (PNG OR JPG).
                            </div>';
                        }
                        else  if($_GET["status"]=="insert-success")
                        {
                          echo '<div class="alert alert-success" role="alert">
                          <b>SUCCESSFUL!</b> Operation Successful Social Media Added.
                          </div>';
                        }
                        else  if($_GET["status"]=="insert-unsuccessful")
                        {
                            echo '<div class="alert alert-danger" role="alert">
                            <b>UNSUCCESSFUL!</b> Operation Failed Failed to Add Social Media.

                            </div>';
                        }
                        else  if($_GET["status"]=="update-success")
                        {
                          echo '<div class="alert alert-success" role="alert">
                          <b>SUCCESSFUL!</b> Transaction Successful Social Media Updated.

                          </div>';
                        }
                        else  if($_GET["status"]=="update-unsuccessful")
                        {
                            echo '<div class="alert alert-danger" role="alert">
                            <b>UNSUCCESSFUL!</b> Operation Failed Social Media Failed to Update.

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
                                <th class="text-center">NAME</th>
                                <th class="text-center">Image</th>
                                <th class="text-center">date of registration</th>
                                <th class="text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach($query as $socialmedia): ?>
                              <tr>
                                <td class="text-center"><?=$socialmedia["socialmedia_id"]?></td>
                                <td  class="text-center"><?=$socialmedia["socialmedia_name"]?></td>
                                <td  class="text-center">
                                  <img width="30px" src="<?=$socialmedia["socialmedia_url"]?>" alt="resim yok">
                                </td>
                                <td  class="text-center"><?=$socialmedia["socialmedia_date"]?></td>
                                <td class="td-actions text-center">
                                  <a href="?update_id=<?=$socialmedia["socialmedia_id"]?>" id="frmUpdateBtn" class='btn btn-danger btn-link btn-icon btn-sm'>
                                          <i class='tim-icons icon-pencil'></i>
                                  </a>
                                  <a href='controller/SocialMediaController.php?delete_id=<?=$socialmedia["socialmedia_id"]?>' class='btn btn-danger btn-link btn-icon btn-sm'>
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
                        NO SOCIALMEDIA REGISTERED

                    </p>
                    <?php endif;?>
              </div>
          </div>
        </div>
      </div>
      <div class="col-md-12">
        <div class="card" id="frmAdd">
            <div class="card-header">
              <h4 class="card-title">Add SocialMedia
              </h4>
            </div>
            <div class="card-body">
            <form action="controller/SocialMediaController.php" method="post"  enctype="multipart/form-data">
                <div class="row">
                    <div class="col-md-12 pr-md-1">
                      <div class="form-group">
                        <label>SocialMedia Name</label>
                        <input name="socialmedia_name" type="text"  class="form-control" placeholder="SocialMedia Name Enter" required>
                      </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 pr-md-1">
                      <div class="form-group" style="position:relative;">
                      <label>SocialMedia Image</label>
                        <label style="width:100%;padding:50px 20px;border:2px dashed #ddd;" >
                        <center>
                        <i style="font-size:20px;" class="tim-icons icon-cloud-download-93"></i>
                        </center>
                        </label>
                        <input type="file" name="dosya" id="file" required>
                        <img style="width:100px;position:absolute;left:42%;top:24%;" id="preview">
                      </div>
                    </div>
              </div>
              
            </div>
            <div class="card-footer">
              <a id="frmAddBackBtn" class="btn btn-fill btn-primary" style="color:white;">BACK</a>
              <button name="BtnSocialMediaAdd" type="submit" class="btn btn-fill btn-primary">ADD</button>
            </div>
          </div>
          </form>
      </div>
       
      <div class="col-md-12">
        <div class="card" id="frmUpdate">
            <div class="card-header">
              <h4 class="card-title">SocialMedia Update
              </h4>
            </div>
            <div class="card-body">
            <form action="controller/SocialMediaController.php" method="post"  enctype="multipart/form-data">
                <div class="row">
                    <div class="col-md-12 pr-md-1">
                      <div class="form-group">
                          <label>SocialMedia Name</label>
                        <input name="socialmedia_name" type="text" value="<?=$socialmedia_update_get["socialmedia_name"]?>" class="form-control" placeholder="SocialMedia Name Enter" required>
                        <input style="display:none;" name="socialmedia_id" type="text" value="<?=$socialmedia_update_get["socialmedia_id"]?>" class="form-control" required>
                      </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 pr-md-1">
                      <div class="form-group" style="position:relative;">
                          <label>SocialMedia Image</label>
                        <label style="width:100%;padding:50px 20px;border:2px dashed #ddd;" >
                        <center>
                        <i style="font-size:20px;" class="tim-icons icon-cloud-download-93"></i>
                        </center>
                        </label>
                        <input type="file" name="dosya" id="fileupdate">
                        <img style="width:100px;position:absolute;left:42%;top:24%;" id="previewupdate">
                      </div>
                      <div class="form-group">
                      GÜncel Resim  <br> <br> <img src="<?=$socialmedia_update_get["socialmedia_url"]?>" alt="" width="150px">
                      </div>
                    </div>
              </div>
            </div>
            <div class="card-footer">
                  <a href="SocialMediaPage.php" id="frmUpdateBackBtn" class="btn btn-fill btn-primary" style="color:white;">BACK</a>
                  <button name="BtnSocialMediaUpdate" type="submit" class="btn btn-fill btn-primary">UPDATE</button>
              </div>
          </div>
        </div>
    </div>
      
</div>
<?php if(isset($_GET["update_id"])): ?>
  <script>
  const fileElement = document.getElementById("fileupdate");
                          const previewElement = document.getElementById("previewupdate");
                          fileElement.addEventListener('change',function(e){
                              const file = e.target.files[0];
                              const reader = new FileReader();
                              reader.addEventListener('load',function(){
                                previewElement.src = reader.result;
                              });
                              reader.readAsDataURL(file);
                          });

</script>
<?php endif; ?>

<?php if(!isset($_GET["update_id"])): ?>
  <script>
  const fileElement = document.getElementById("file");
                          const previewElement = document.getElementById("preview");
                          fileElement.addEventListener('change',function(e){
                              const file = e.target.files[0];
                              const reader = new FileReader();
                              reader.addEventListener('load',function(){
                                previewElement.src = reader.result;
                              });
                              reader.readAsDataURL(file);
                          });

</script>
<?php endif; ?>

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
