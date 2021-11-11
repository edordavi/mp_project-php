<?php 
session_start();
require('CargadorClases.php');

if(!isset($_SESSION["user_name"]))
{
  header("Location:index.php");
  exit;
}

$reporte = new ReporteMapper();
$result = $reporte->reporteDetalleTransacciones();

require('Site_header.php');

require('Site_login.php');

require('Site_body.php');

?>

<div class="page-header">
     
        <div class="row">
            <div class="col-xs-6">
                <h2>Reporte de Detalle de Transacciones</h2>
            </div> 
            <br>
             <div class="col-xs-offset-4 col-xs-2">
               <div class="import_button"><a href="guardar_excel.php?reporte=detalle_transacciones" class="btn btn-primary" role="button"><span class="glyphicon glyphicon-export"></span> Exportar a Excel</a></div>
            </div>
        </div>
    </div>
<?php

require('Site_table.php');

require('Site_footer.php');

?>   

