<h2>Debian Repository</h2>

<h4>Available apps:</h4>
<ul>
  <?php
    $files = array();
    foreach (new DirectoryIterator('./debian') as $file) {
    	if ($file->isDot() || $file == "Packages.gz") continue;
    	array_push($files, $file->getFilename());
    }
    
    sort($files);
    
    foreach ($files as $file) {
    	print '<li>' . $file . '</li>';
    }
  ?>
</ul>
