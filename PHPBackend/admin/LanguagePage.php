<?php 
  session_start();
  if(!isset($_SESSION["admin"]))
  {
    header("location:index.php");
  }
  include("modal/db.php");
  $admin_url = "LanguagePage.php";
  $languages = $db->query("SELECT * FROM languages", PDO::FETCH_ASSOC);
  $socialmedia = $db->query("SELECT * FROM socialmedia", PDO::FETCH_ASSOC);
  $category = $db->query("SELECT * FROM category", PDO::FETCH_ASSOC);
  $service = $db->query("SELECT * FROM service", PDO::FETCH_ASSOC);

  if(isset($_GET["update_id"]))
  {
    $language_id = $_GET["update_id"];
    if(is_numeric($language_id))
    {
      $language_update_get = $db->query("SELECT * FROM languages WHERE language_id = '{$language_id}'")->fetch(PDO::FETCH_ASSOC);
      if ( $language_update_get )
      {
        $socialmedias = $db->query("SELECT * FROM socialmedia", PDO::FETCH_ASSOC);
        $categorys = $db->query("SELECT * FROM category", PDO::FETCH_ASSOC);
        $services = $db->query("SELECT * FROM service", PDO::FETCH_ASSOC);
      }
      else
      {
       header("location:LanguagePage.php");
      }
    }
    else
    {
      header("location:LanguagePage.php");
    }
  }
?>
<?php include("static/header.php"); ?>
<div class="content">
    <div class="row">
      <div class="col-md-12">
      <?php
                    if(isset($_GET["status"]))
                    {
                        if($_GET["status"]=="delete-success")
                        {
                            echo '<div class="alert alert-success" role="alert">
                            <b>Tebrikler!</b> İşlem Başarılı Language Silindi.
                            </div>';
                        }
                        else  if($_GET["status"]=="delete-unsuccessful")
                        {
                            echo '<div class="alert alert-danger" role="alert">
                            <b>Hata!</b> İşlem Başarısız Language Silinemedi.
                            </div>';
                        }
                        else  if($_GET["status"]=="language-record")
                        {
                            echo '<div class="alert alert-danger" role="alert">
                            <b>Hata!</b> İşlem Başarısız Language Daha Önce Eklenmiş.
                            </div>';
                        }
                        else  if($_GET["status"]=="insert-success")
                        {
                          echo '<div class="alert alert-success" role="alert">
                          <b>Tebrikler!</b> İşlem Başarılı Language Eklendi.
                          </div>';
                        }
                        else  if($_GET["status"]=="insert-unsuccessful")
                        {
                            echo '<div class="alert alert-danger" role="alert">
                            <b>Hata!</b> İşlem Başarısız Language Eklenemedi.
                            </div>';
                        }
                        else  if($_GET["status"]=="update-success")
                        {
                          echo '<div class="alert alert-success" role="alert">
                          <b>Tebrikler!</b> İşlem Başarılı Language Güncellendi.
                          </div>';
                        }
                        else  if($_GET["status"]=="update-unsuccessful")
                        {
                            echo '<div class="alert alert-danger" role="alert">
                            <b>Hata!</b> İşlem Başarısız Language Güncellenemedi.
                            </div>';
                        }
                        
                    }
              ?>
        <div class="card" id="frmList">
          <div class="card-header">
            <h4 class="card-title">Language List
            </h4>
          </div>
          <div class="card-body">
            <p><button id="frmAddBtn" type="submit" class="btn btn-fill btn-primary">New Record</button></p>
            <div class="table-responsive">
                    <?php if($languages->rowCount()>0): ?>
                      <table class="table">
                        <thead>
                            <tr>
                                <th class="text-center">#Id</th>
                                <th class="text-center">NAME</th>
                                <th class="text-center">date of registration</th>
                                <th class="text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach($languages as $lg): ?>
                              <tr>
                                <td class="text-center"><?=$lg["language_id"]?></td>
                                <td  class="text-center"><?=$lg["lc_id"]?></td>
                                <td  class="text-center"><?=$lg["language_date"]?></td>
                                <td class="td-actions text-center">
                                  <a href="?update_id=<?=$lg["language_id"]?>" id="frmUpdateBtn" class='btn btn-danger btn-link btn-icon btn-sm'>
                                          <i class='tim-icons icon-pencil'></i>
                                  </a>
                                  <a href='controller/LanguageController.php?delete_id=<?=$lg["language_id"]?>&language=<?=$lg['lc_id']?>' class='btn btn-danger btn-link btn-icon btn-sm'>
                                          <i class='tim-icons icon-trash-simple'></i>
                                  </a>
                                </td>
                              </tr>
                            <?php endforeach;?>
                        </tbody>
                      </table>
                      <?php endif;?>
                    <?php if(!$languages->rowCount()>0): ?>
                    <p class="text-center">
                        NO LANGUAGE REGISTERED
                    </p>
                    <?php endif;?>
              </div>
          </div>
        </div>
      </div>    
      <div class="col-md-12">
      <div class="card" id="frmAdd">
                <div class="card-header">
                    <h4 class="card-title">Language Add</h4>
                </div>
                <div class="card-body">
                <form action="controller/LanguageController.php" method="post">
                    <div class="row">
                        <div class="col-md-12 pr-md-1">
                            <div class="form-group">
                                <label>Choose a Language</label>
                                <select name="language" data-placeholder="Choose a Language..." class="form-control">
                                    <option value="af">Afrikaans</option>
                                    <option value="sq">Albanian</option>
                                    <option value="am">Amharic</option>
                                    <option value="ar-dz">Arabic-Algeria</option>
                                    <option value="ar-bh">Arabic-Bahrain</option>
                                    <option value="ar-eg">Arabic-Egypt</option>
                                    <option value="ar-iq">Arabic-Iraq</option>
                                    <option value="ar-jo">Arabic-Jordan</option>
                                    <option value="ar-kw">Arabic-Kuwait</option>
                                    <option value="ar-lb">Arabic-Lebanon</option>
                                    <option value="ar-ly">Arabic-Libya</option>
                                    <option value="ar-ma">Arabic-Morocco</option>
                                    <option value="ar-om">Arabic-Oman</option>
                                    <option value="ar-jo">Arabic-Qatar</option>
                                    <option value="ar-sa">Arabic-Saudi Arabia</option>
                                    <option value="ar-sy">Arabic-Syria</option>
                                    <option value="ar-tn">Arabic-Tunisia</option>
                                    <option value="ar-ae">Arabic-United Arab Emirates</option>
                                    <option value="ar-ye">Arabic-Yemen</option>
                                    <option value="hy">Armenian</option>
                                    <option value="as">Assamese</option>
                                    <option value="az-az">Azeri-Cyrillic</option>
                                    <option value="az-az">Azeri-Latin</option>
                                    <option value="eu">Basque</option>
                                    <option value="be">Belarusian</option>
                                    <option value="bn" >Bengali-Bangladesh</option>
                                    <option value="bn" >Bengali-India</option>
                                    <option value="bs">Bosnian</option>
                                    <option value="bg">Bulgarian</option>
                                    <option value="my">Burmese</option>
                                    <option value="ca">Catalan</option>
                                    <option value="zh-cn">Chinese-China</option>
                                    <option value="zh-hk">Chinese-Hong Kong SAR</option>
                                    <option value="zh-mo">Chinese-Macau SAR</option>
                                    <option value="zh-sg">Chinese-Singapore</option>
                                    <option value="zh-tw">Chinese-Taiwan</option>
                                    <option value="hr">Croatian</option>       
                                    <option value="cs">Czech</option>
                                    <option value="da">Danish</option>
                                    <option value="Maldivian">Divehi</option>
                                    <option value="nl-be">Dutch-Belgium</option>
                                    <option value="nl-nl">Dutch-Netherlands</option>
                                    <option value="en-au">English-Australia</option>
                                    <option value="en-bz">English-Belize</option>
                                    <option value="en-ca">English-Canada</option>
                                    <option value="en-cb">English-Caribbean</option>
                                    <option value="en-gb">English-Great Britain</option>
                                    <option value="en-in">English-India</option>
                                    <option value="en-ie">English-Ireland</option>
                                    <option value="en-jm">English-Jamaica</option>
                                    <option value="en-nz">English-New Zealand</option>
                                    <option value="en-ph">English-Philippines</option>
                                    <option value="en-za">English-Southern Africa</option>
                                    <option value="en-tt">English-Trinidad</option>
                                    <option value="en-us">English-United States</option>
                                    <option value="et">Estonian</option>
                                    <option value="mk">FYRO Macedonia</option>
                                    <option value="fo">Faroese</option>
                                    <option value="fa">Farsi - Persian</option>
                                    <option value="fi">Finnish</option>
                                    <option value="fr-be">French-Belgium</option>
                                    <option value="fr-ca">French-Canada</option>
                                    <option value="fr-fr">French-France</option>
                                    <option value="fr-lu">French-Luxembourg</option>
                                    <option value="fr-ch">French-Switzerland</option>
                                    <option value="gd-ie">Gaelic-Ireland</option>
                                    <option value="gd">Gaelic-Scotland</option>
                                    <option value="de-at">German-Austria</option>
                                    <option value="de-de">German-Germany</option>
                                    <option value="de-li">German-Liechtenstein</option>
                                    <option value="de-lu">German-Luxembourg</option>
                                    <option value="de-ch">German-Switzerland</option>
                                    <option value="el">Greek</option>
                                    <option value="gn">Guarani-Paraguay</option>
                                    <option value="gu">Gujarati</option>
                                    <option value="he">Hebrew</option>
                                    <option value="hi">Hindi</option>
                                    <option value="hu">Hungarian</option>
                                    <option value="is">Icelandic</option>
                                    <option value="id">Indonesian</option>
                                    <option value="it-it">Italian-Italy</option>
                                    <option value="it-ch">Italian-Switzerland</option>
                                    <option value="ja">Japanese</option>
                                    <option value="kn">Kannada</option>
                                    <option value="ks">Kashmiri</option>
                                    <option value="kk">Kazakh</option>
                                    <option value="km">Khmer</option>
                                    <option value="ko">Korean</option>
                                    <option value="lo">Lao</option>
                                    <option value="la">Latin</option>
                                    <option value="lv">Latvian</option>
                                    <option value="ms-bn">Malay-Brunei</option>
                                    <option value="ms-my">Malay-Malaysia</option>
                                    <option value="ml">Malayalam</option>
                                    <option value="mt">Maltese</option>
                                    <option value="mi">Maori</option>
                                    <option value="mr">Marathi</option>
                                    <option value="mn">Mongolian</option>
                                    <option value="ne">Nepali</option>
                                    <option value="no-no">Norwegian-Bokml</option>
                                    <option value="no-no">Norwegian-Nynorsk</option>
                                    <option value="or">Oriya</option>
                                    <option value="pl">Polish</option>
                                    <option value="pt-br">Portuguese-Brazil</option>
                                    <option value="pt-pt">Portuguese-Portugal</option>
                                    <option value="pa">Punjabi</option>
                                    <option value="rm">Raeto-Romance</option>
                                    <option value="ro-mo">Romanian-Moldova</option>
                                    <option value="ro">Romanian-Romania</option>
                                    <option value="ru">Russian</option>
                                    <option value="ru-mo">Russian-Moldova</option>
                                    <option value="sa">Sanskrit</option>
                                    <option value="sr-sp">Serbian-Cyrillic</option>
                                    <option value="sr-sp">Serbian-Latin</option>
                                    <option value="tn">Setsuana</option>
                                    <option value="sd">Sindhi</option>
                                    <option value="si">Sinhala</option>
                                    <option value="sk">Slovak</option>
                                    <option value="sl">Slovenian</option>
                                    <option value="so">Somali</option>
                                    <option value="sb">Sorbian</option>
                                    <option value="es-ar">Spanish-Argentina</option>
                                    <option value="es-bo">Spanish-Bolivia</option>
                                    <option value="es-cl">Spanish-Chile</option>
                                    <option value="es-co">Spanish-Colombia</option>
                                    <option value="es-cr">Spanish-Costa Rica</option>
                                    <option value="es-do">Spanish-Dominican Republic</option>
                                    <option value="es-ec">Spanish-Ecuador</option>
                                    <option value="es-sv">Spanish-El Salvador</option>
                                    <option value="es-gt">Spanish-Guatemala</option>
                                    <option value="es-hn">Spanish-Honduras</option>
                                    <option value="es-mx">Spanish-Mexico</option>
                                    <option value="es-ni">Spanish-Nicaragua</option>
                                    <option value="es-pa">Spanish-Panama</option>
                                    <option value="es-py">Spanish-Paraguay</option>
                                    <option value="es-pe">Spanish-Peru</option>
                                    <option value="es-pr">Spanish-Puerto Rico</option>
                                    <option value="es-es">Spanish-Spain(Traditional)</option>
                                    <option value="es-uy">Spanish-Uruguay</option>
                                    <option value="es-ve">Spanish-Venezuela</option>
                                    <option value="sw">Swahili</option>
                                    <option value="sv-fi">Swedish-Finland</option>
                                    <option value="sv-se">Swedish-Sweden</option>
                                    <option value="tg">Tajik</option>
                                    <option value="ta">Tamil</option>
                                    <option value="tt">Tatar</option>
                                    <option value="te">Telugu</option>
                                    <option value="th">Thai</option>
                                    <option value="bo">Tibetan</option>
                                    <option value="ts">Tsonga</option>
                                    <option value="tr">Turkish</option>
                                    <option value="tk">Turkmen</option>
                                    <option value="uk">Ukrainian</option>
                                    <option value="ur">Urdu</option>
                                    <option value="uz-uz">Uzbek-Cyrillic</option>
                                    <option value="uz-uz">Uzbek-Latin</option>
                                    <option value="vi">Vietnamese</option>
                                    <option value="cy">Welsh</option>
                                    <option value="xh">Xhosa</option>
                                    <option value="yi">Yiddish</option>
                                    <option value="zu">Zulu</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 pr-md-1">
                            <div class="form-group">
                                <label>Key</label>
                            </div>
                        </div>
                        <div class="col-md-6 pr-md-1">
                            <div class="form-group">
                                <label>Value</label>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 pr-md-1">
                            <div class="form-group">
                                <label>SocialMedia Translate</label>
                            </div>
                        </div>
                    </div>
                    <?php foreach($socialmedia as $sm): ?>
                    <div class="row">
                        <div class="col-md-6 pr-md-1">
                            <div class="form-group">
                                <input disabled type="text" value="<?=$sm["socialmedia_name"]?>" class="form-control">
                            </div>
                        </div>
                        <div class="col-md-6 pr-md-1">
                            <div class="form-group">
                                <input name="socialmedia_name-<?=$sm["socialmedia_id"]?>" type="text" value="<?=$sm["socialmedia_name"]?>" class="form-control" placeholder="SocialMedia Name Enter" required>
                            </div>
                        </div>
                    </div>
                    <?php endforeach;?>
                    <div class="row">
                        <div class="col-md-12 pr-md-1">
                            <div class="form-group">
                                <label>Category Translate</label>
                            </div>
                        </div>
                    </div>
                    <?php foreach($category as $ct): ?>
                    <div class="row">
                        <div class="col-md-6 pr-md-1">
                            <div class="form-group">
                                <input disabled type="text" value="<?=$ct["category_name"]?>" class="form-control">
                            </div>
                        </div>
                        <div class="col-md-6 pr-md-1">
                            <div class="form-group">
                                <input name="category_name-<?=$ct["category_id"]?>" type="text" value="<?=$ct["category_name"]?>" class="form-control" placeholder="Category Name Enter" required>
                            </div>
                        </div>
                    </div>
                    <?php endforeach;?>
                    <div class="row">
                        <div class="col-md-12 pr-md-1">
                            <div class="form-group">
                                <label>Service Translate</label>
                            </div>
                        </div>
                    </div>
                    <?php foreach($service as $sv): ?>
                    <div class="row">
                        <div class="col-md-6 pr-md-1">
                            <div class="form-group">
                                <input disabled type="text" value="<?=$sv["service_name"]?>" class="form-control">
                            </div>
                        </div>
                        <div class="col-md-6 pr-md-1">
                            <div class="form-group">
                                <input name="service_name-<?=$sv["api_service_id"]?>" type="text" value="<?=$sv["service_name"]?>" class="form-control" placeholder="Service Name Enter" required>
                            </div>
                        </div>
                    </div>
                    <?php endforeach;?>
                
                </div>
                <div class="card-footer">
                  <a href="LanguagePage.php" id="frmUpdateBackBtn" class="btn btn-fill btn-primary" style="color:white;">BACK</a>
                  <button name="BtnLanguageAdd" type="submit" class="btn btn-fill btn-primary">SAVE</button>
              </div>
              </form>
            </div>
      </div>
       
      <div class="col-md-12">
        <div class="card" id="frmUpdate">
        <div class="card-header">
                    <h4 class="card-title">Language Update - <?=$language_update_get["lc_id"]?></h4>
                </div>
                <div class="card-body">
                <form action="controller/LanguageController.php" method="post">
                <input type="hidden" name="lc_id" value="<?=$language_update_get["lc_id"]?>">
                    <div class="row">
                        <div class="col-md-6 pr-md-1">
                            <div class="form-group">
                                <label>Key</label>
                            </div>
                        </div>
                        <div class="col-md-6 pr-md-1">
                            <div class="form-group">
                                <label>Value</label>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 pr-md-1">
                            <div class="form-group">
                                <label>SocialMedia Translate</label>
                            </div>
                        </div>
                    </div>
                    <?php foreach($socialmedias as $sm): ?>
                    <div class="row">
                        <div class="col-md-6 pr-md-1">
                            <div class="form-group">
                                <input disabled type="text" value="<?=$sm["socialmedia_name"]?>" class="form-control">
                            </div>
                        </div>
                        <div class="col-md-6 pr-md-1">
                            <div class="form-group">
                                <input name="socialmedia_name-<?=$sm["socialmedia_id"]?>" type="text" value="<?=isset($sm[$language_update_get["lc_id"]])?$sm[$language_update_get["lc_id"]]:$sm["socialmedia_name"]?>" class="form-control" placeholder="SocialMedia Name Enter" required>
                            </div>
                        </div>
                    </div>
                    <?php endforeach;?>
                    <div class="row">
                        <div class="col-md-12 pr-md-1">
                            <div class="form-group">
                                <label>Category Translate</label>
                            </div>
                        </div>
                    </div>
                    <?php foreach($categorys as $ct): ?>
                    <div class="row">
                        <div class="col-md-6 pr-md-1">
                            <div class="form-group">
                                <input disabled type="text" value="<?=$ct["category_name"]?>" class="form-control">
                            </div>
                        </div>
                        <div class="col-md-6 pr-md-1">
                            <div class="form-group">
                                <input name="category_name-<?=$ct["category_id"]?>" type="text" value="<?=isset($ct[$language_update_get["lc_id"]])?$ct[$language_update_get["lc_id"]]:$ct["category_name"]?>" class="form-control" placeholder="Category Name Enter" required>
                            </div>
                        </div>
                    </div>
                    <?php endforeach;?>
                    <div class="row">
                        <div class="col-md-12 pr-md-1">
                            <div class="form-group">
                                <label>Service Translate</label>
                            </div>
                        </div>
                    </div>
                    <?php foreach($services as $sv): ?>
                    <div class="row">
                        <div class="col-md-6 pr-md-1">
                            <div class="form-group">
                                <input disabled type="text" value="<?=$sv["service_name"]?>" class="form-control">
                            </div>
                        </div>
                        <div class="col-md-6 pr-md-1">
                            <div class="form-group">
                                <input name="service_name-<?=$sv["api_service_id"]?>" type="text" value="<?=isset($sv[$language_update_get["lc_id"]])?$sv[$language_update_get["lc_id"]]:$sv["service_name"]?>" class="form-control" placeholder="Service Name Enter" required>
                            </div>
                        </div>
                    </div>
                    <?php endforeach;?>
                
                </div>
                <div class="card-footer">
                  <a href="LanguagePage.php" id="frmUpdateBackBtn" class="btn btn-fill btn-primary" style="color:white;">BACK</a>
                  <button name="BtnLanguageUpdate" type="submit" class="btn btn-fill btn-primary">UPDATE</button>
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
