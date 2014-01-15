<?php

/*
   This program is a sample to use R and amap and ctc as a web application.
   ctc package is available on bioconductor.org

   Standard setup: 
   put amap.php in your public_html directory
   check that webserver user (apache, or www) is able
   to write in public_html (chmod 'a+w' ~/public_html)

   Change global variable R_BIN below

   That's all.

   Example working:
   http://bioinfo.genopole-toulouse.prd.fr/~lucas/amap.php

   Note:
   Variable include_path in php.ini should includes path to gs binary.

 */ 

/*  Some globals variables */

$R_BIN = "/usr/local/bin/R";
$MAX_FILE = 307200;  // 300 Ko
/* End of personalization */
?>


<html>
<header>
<title>AMAP Demo Web application V0-3</title>
</header>
<body>
<center>

<?php 


/* and ID made by TIME + Process_ID  */
$ID = "tmp_".time().getmypid();


/* Print form  */
if ($_POST[page] != "Exec") 
  {

    ?>
    <p>
    Upload your data (text-tabulated file)
    <form 
      action="amap.php"
      enctype="multipart/form-data"   
      method="POST"
    >
      <INPUT TYPE = hidden  NAME=page value="Exec"></input>
      <INPUT type="file" name="FileData" />
      <p>
      File Description:
      <table><tr>
      <td>A first Column</td><td>
        <SELECT NAME=rownames>
           <OPTION SELECTED  VALUE = "1">with labels
           <OPTION VALUE = "NULL">with data
        </SELECT>
      </td></tr>
      <tr><td>
      A first line</td><td>
        <SELECT NAME=header>
           <OPTION SELECTED  VALUE = TRUE>with columns header
           <OPTION VALUE = FALSE>with data
        </SELECT>
      </td></tr>
      <tr><td>
      Separator</td><td>
        <SELECT NAME=sep>
           <OPTION SELECTED  VALUE = "t">tabulation</option>
           <OPTION VALUE = "s">space</option>
           <OPTION VALUE = "c">comma</option>
           <OPTION VALUE = 'sc'>semicolon</option>
        </SELECT>

      </td></tr></table>

      <INPUT TYPE=SUBMIT VALUE="Submit" name="GO">
    </form>    
    <?php
  }
else
{


   mkdir($ID,0777);

   $HEADER = $_POST[header];
   $ROWNAMES = $_POST[rownames];
   $SEP = $_POST[sep];
   if($SEP == 't')
      $SEP = "\t";
   if($SEP == 'c')
      $SEP = ",";
   if($SEP == 'sc')
      $SEP = ";";
   if($SEP == 's')
      $SEP = " ";

   /* Get upload data */
   if(is_uploaded_file ($_FILES['FileData']['tmp_name'] ))
     {
       move_uploaded_file ($_FILES['FileData']['tmp_name'],$ID."/data.txt");
       $taillefichier = filesize($ID."/data.txt");
       if($taillefichier>$MAX_FILE)
	 exit("File size: $taillefichier; max allowed: $MAX_FILE");
     }



   /* ================================== */
   /* We write R code in file $ID/prog.R */
   /* ================================== */

   $fp=fopen("$ID/prog.R",'w');

   fwrite($fp,"library(amap)\n");
   fwrite($fp,"library(ctc)\n");


   /* Read Data */
   fwrite($fp,"data <- read.delim('$ID/data.txt',header=$HEADER,row.names=$ROWNAMES,sep='$SEP') \n" );


   fwrite($fp,"data <- scale(data)             \n");
   fwrite($fp,"pca <- acprob(data,h=1)         \n");


   /* Number of columns to keep  ( number of column to keep 90 % of
    *   variance)*/
   fwrite($fp,"cumVarNorm <- cumsum(pca\$sdev ^ 2) / sum(pca\$sdev ^ 2)\n");
   fwrite($fp,"ncol <- max(which( cumVarNorm< 0.9)) +1               \n");
   fwrite($fp,"ncol                                                  \n");
 
   fwrite($fp,"data <- pca\$scores[,1:ncol]                          \n");

   /* Hierarchical clustering */
   fwrite($fp,"hr0 <- hclusterpar(data)      \n");
   fwrite($fp,"hc0 <- hclusterpar(t(data))   \n");
   fwrite($fp,"hr <- as.dendrogram(hr0)      \n");
   fwrite($fp,"hc <- as.dendrogram(hc0)   \n");

   /* A pdf file */
   fwrite($fp,"pdf(file='$ID/Rplots.pdf')                        \n");
   fwrite($fp,"plot(pca)                                         \n"); 
   fwrite($fp,"biplot(pca)                                       \n");
   fwrite($fp,"plot2.acp(pca)                                    \n"); 
   fwrite($fp,"heatmap(as.matrix(data),Colv=hc,Rowv=hr)          \n"); 
   fwrite($fp,"dev.off()                                         \n");

   /* Some png images */
   fwrite($fp,"bitmap(file='$ID/pcaplot.png')                    \n");
   fwrite($fp,"plot(pca)                                         \n");
   fwrite($fp,"dev.off()                                         \n");
   fwrite($fp,"bitmap(file='$ID/pcabiplot.png')                  \n");
   fwrite($fp,"biplot(pca)                                       \n");
   fwrite($fp,"dev.off()                                         \n");
   fwrite($fp,"bitmap(file='$ID/pcaplot2.png')                   \n");
   fwrite($fp,"plot2.acp(pca)                                    \n");
   fwrite($fp,"dev.off()                                         \n");
   fwrite($fp,"bitmap(file='$ID/heatmap.png')                    \n");
   fwrite($fp,"heatmap(as.matrix(data),Colv=hc,Rowv=hr)          \n");
   fwrite($fp,"dev.off()                                         \n");

   fwrite($fp,"r2atr(hc0,file='$ID/cluster.atr')                  \n");
   fwrite($fp,"r2gtr(hr0,file='$ID/cluster.gtr')                  \n");
   fwrite($fp,"r2cdt(hr0,hc0,data ,file='$ID/cluster.cdt')         \n");


   fclose($fp);


   /* ===================== */
   /* Send command (R batch)*/
   /* ===================== */
   system("$R_BIN --no-save < $ID/prog.R > $ID/prog.R.out  2> $ID/prog.R.warnings");
 

   /* ===================================== */
   /* We create html page including results */
   /* ===================================== */


   echo "<h3>Amap Demo results </h3>";
   echo "<a href=$ID/Rplots.pdf>A pdf file</a><p>";
   echo "<img src=$ID/pcaplot.png></img><p>";
   echo "<img src=$ID/pcabiplot.png></img><p>";
   echo "<img src=$ID/pcaplot2.png></img><p>";
   echo "<img src=$ID/heatmap.png></img><p>";

   echo "3 files for <a href=http://magix.fri.uni-lj.si/freeview/>Freeview</a>";
   echo " or <a href=http://rana.lbl.gov/>Treeview</a>: ";
   echo "<a href=$ID/cluster.cdt>cdt</a> ";
   echo "<a href=$ID/cluster.atr>atr</a> ";
   echo "<a href=$ID/cluster.gtr>gtr</a> ";
   echo "<p>";

   /* Signature  */

   echo "<p>This results made by <a
href='http://mulcyber.toulouse.inra.fr/projects/amap/'>amap
package</a>. Code use: <a href='$ID/prog.R'>prog.R</a>, 
Out: <a href='$ID/prog.R.out'>prog.R.out</a>,
Warnings: <a href='$ID/prog.R.warnings'>prog.R.warnings</a>.";

}
?>



</center>
</body>
</html>