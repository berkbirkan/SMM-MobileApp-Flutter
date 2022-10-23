<?php 
  session_start();
  if(!isset($_SESSION["admin"]))
  {
    header("location:index.php");
  }
  include("modal/db.php");
  $admin_url = "CategoryPage.php";
  $query = $db->query("SELECT * FROM category", PDO::FETCH_ASSOC);

  if(isset($_GET["update_id"]))
  {
    $category_id = $_GET["update_id"];
    if(is_numeric($category_id))
    {
      $category_update_get = $db->query("SELECT * FROM category WHERE category_id = '{$category_id}'")->fetch(PDO::FETCH_ASSOC);
      if ( $category_update_get )
      {

      }
      else
      {
        header("location:CategoryPage.php");
      }
    }
    else
    {
      header("location:CategoryPage.php");
    }
  }
?>

<?php include("static/header.php"); ?>
<div class="content">
    <div class="row">
      <div class="col-md-12">
        <div class="card" id="frmList">
          <div class="card-header">
            <h4 class="card-title">Category List
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
                            <b>Tebrikler!</b> İşlem Başarılı Kategori Silindi.
                            </div>';
                        }
                        else  if($_GET["status"]=="delete-unsuccessful")
                        {
                            echo '<div class="alert alert-danger" role="alert">
                            <b>Hata!</b> İşlem Başarısız Kategori Silinemedi.
                            </div>';
                        }
                        else  if($_GET["status"]=="record-error")
                        {
                            echo '<div class="alert alert-danger" role="alert">
                            <b>Hata!</b> İşlem Başarısız Aynı Kayıtı Eklemeye Çalışıyorsunuz.
                            </div>';
                        }
                        else  if($_GET["status"]=="socialmedia-error")
                        {
                            echo '<div class="alert alert-danger" role="alert">
                            <b>Hata!</b> İşlem Başarısız Önce Kategori Ekleyiniz.
                            </div>';
                        }
                        else  if($_GET["status"]=="insert-success")
                        {
                          echo '<div class="alert alert-success" role="alert">
                          <b>Tebrikler!</b> İşlem Başarılı Kategori Eklendi.
                          </div>';
                        }
                        else  if($_GET["status"]=="insert-unsuccessful")
                        {
                            echo '<div class="alert alert-danger" role="alert">
                            <b>Hata!</b> İşlem Başarısız Kategori Eklenemedi.
                            </div>';
                        }
                        else  if($_GET["status"]=="update-success")
                        {
                          echo '<div class="alert alert-success" role="alert">
                          <b>Tebrikler!</b> İşlem Başarılı Kategori Güncellendi.
                          </div>';
                        }
                        else  if($_GET["status"]=="update-unsuccessful")
                        {
                            echo '<div class="alert alert-danger" role="alert">
                            <b>Hata!</b> İşlem Başarısız Kategori Güncellenemedi.
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
                                <th class="text-center">SOCİALMEDİA</th>
                                <th class="text-center">date of registration</th>
                                <th class="text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach($query as $category): ?>
                              <tr>
                                <td class="text-center"><?=$category["category_id"]?></td>
                                <td  class="text-center"><?=$category["category_name"]?></td>
                                <td  class="text-center">
                                  <?php
                                    $sm = $db->query("SELECT * FROM socialmedia WHERE socialmedia_id = '{$category["socialmedia_id"]}'")->fetch(PDO::FETCH_ASSOC);
                                    if ( $sm ){
                                       echo $sm["socialmedia_name"];
                                    }
                                  ?>
                                </td>
                                <td  class="text-center"><?=$category["category_date"]?></td>
                                <td class="td-actions text-center">
                                  <a href="?update_id=<?=$category["category_id"]?>" id="frmUpdateBtn" class='btn btn-danger btn-link btn-icon btn-sm'>
                                          <i class='tim-icons icon-pencil'></i>
                                  </a>
                                  <a href='controller/CategoryController.php?delete_id=<?=$category["category_id"]?>' class='btn btn-danger btn-link btn-icon btn-sm'>
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
                        NO REGISTERED CATEGORIES

                    </p>
                    <?php endif;?>
              </div>
          </div>
        </div>
      </div>    
      <div class="col-md-12">
        <div class="card" id="frmAdd">
            <div class="card-header">
              <h4 class="card-title">Category Add</h4>
            </div>
            <div class="card-body">
            <form action="controller/CategoryController.php" method="post">
                <div class="row">
                    <div class="col-md-12 pr-md-1">
                      <div class="form-group">
                        <label>Category Name</label>
                        <input name="category_name" type="text"  class="form-control" placeholder="Category Name Enter" required>
                      </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 pr-md-1">
                      <div class="form-group">
                      <label  for="socialmedia">SocialMedia</label>
                        <select name="socialmedia" class="form-control">
                             <?php 
                                $query = $db->query("SELECT * FROM socialmedia", PDO::FETCH_ASSOC);
                                if ( $query->rowCount() ){
                                     foreach( $query as $row ){
                                          echo '<option value="'.$row["socialmedia_id"].'">'.$row["socialmedia_name"].'</option>';
                                     }
                                }
                                else
                                {
                                  echo '<option value="0">No SocialMedia Saved</option>';
                                }
                             ?>
                        </select>
                      </div>
                    </div>
                </div>
            </div>
            <div class="card-footer">
              <a id="frmAddBackBtn" class="btn btn-fill btn-primary" style="color:white;">BACK</a>
              <button name="BtnCategoryAdd" type="submit" class="btn btn-fill btn-primary">ADD</button>
            </div>
          </div>
          </form>
      </div>
       
      <div class="col-md-12">
        <div class="card" id="frmUpdate">
            <div class="card-header">
              <h4 class="card-title">Category Update</h4>
            </div>
            <div class="card-body">
            <form action="controller/CategoryController.php" method="post">
                <div class="row">
                    <div class="col-md-12 pr-md-1">
                      <div class="form-group">
                          <label>Category Name</label>
                        <input name="category_name" type="text" value="<?=$category_update_get["category_name"]?>" class="form-control" placeholder="Category Name Enter" required>
                        <input style="display:none;" name="category_id" type="text" value="<?=$category_update_get["category_id"]?>" class="form-control" required>
                      </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 pr-md-1">
                      <div class="form-group">
                      <label  for="socialmedia">SocialMedia</label>
                        <select name="socialmedia" class="form-control">
                             <?php 
                                $query = $db->query("SELECT * FROM socialmedia", PDO::FETCH_ASSOC);
                                if ( $query->rowCount() ){
                                     foreach( $query as $row ){
                                          echo '<option value="'.$row["socialmedia_id"].'">'.$row["socialmedia_name"].'</option>';
                                     }
                                }
                                else
                                {
                                  echo '<option value="0">No Social Media Saved</option>';
                                }
                             ?>
                        </select>
                      </div>
                    </div>
                </div>
            </div>
            <div class="card-footer">
                  <a href="CategoryPage.php" id="frmUpdateBackBtn" class="btn btn-fill btn-primary" style="color:white;">BACK</a>
                  <button name="BtnCategoryUpdate" type="submit" class="btn btn-fill btn-primary">UPDATE</button>
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
