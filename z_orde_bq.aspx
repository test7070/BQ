<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
             
            $(document).ready(function() {
            	q_getId();
                q_gf('', 'z_orde_bq');
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_orde_bq',
                    options : [ {
                         type : '0', //[1]
                        name : 'accy',
                        value : q_getId()[4]
                    }, {
                        type : '1', //[2][3]
                        name : 'xdate'
                    }, {
                        type : '1', //[4][5]
                        name : 'xodate'
                    }, {
                        type : '2', //[6][7]
                        name : 'xcust',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    }, {
                        type : '2', //[8][9]
                        name : 'xproduct',
                        dbf : 'ucaucc',
                        index : 'noa,product',
                        src : 'ucaucc_b.aspx'
                    }, {
                        type : '6',//[10]
                        name : 'xnoa'
                    }, {
                        type : '5',//[11]
                        name : 'xenda',
                        value : "0@N,1@Y".split(',')
                    }, {
                        type : '5',//[12]
                        name : 'xvccenda',
                        value : "0@N,1@Y".split(',')
                    }]
                });
                q_popAssign();
                
                $('#txtXdate1').mask(r_picd);
                $('#txtXdate1').datepicker();
                $('#txtXdate2').mask(r_picd);
                $('#txtXdate2').datepicker();
                $('#txtXodate1').mask(r_picd);
                $('#txtXodate1').datepicker();
                $('#txtXodate2').mask(r_picd);
                $('#txtXodate2').datepicker();
                
                $('#txtXodate1').val(q_date().substr(0,r_lenm)+'/01');
                $('#txtXodate2').val(q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',45).substr(0,r_lenm)+'/01',-1));
                $('#txtXdate1').val(q_date().substr(0,r_lenm)+'/01');
                $('#txtXdate2').val(q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',45).substr(0,r_lenm)+'/01',-1));
	        }

            function q_boxClose(s2) {
            }
            function q_gtPost(s2) {
            }
	</script>
	<style type="text/css">
		#frameReport table{
			border-collapse: collapse;
		}
	</style>
	</head>
	<body ondragstart="return false" draggable="false"
        ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"  
        ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"  
        ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
     >
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>