<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
    <head>
        <title> </title>
        <script src="../script/jquery.min.js" type="text/javascript"></script>
        <script src='../script/qj2.js' type="text/javascript"></script>
        <script src='qset.js' type="text/javascript"></script>
        <script src='../script/qj_mess.js' type="text/javascript"></script>
        <script src="../script/qbox.js" type="text/javascript"></script>
        <script src='../script/mask.js' type="text/javascript"></script>
        <link href="../qbox.css" rel="stylesheet" type="text/css" />
        <link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
        <script src="css/jquery/ui/jquery.ui.core.js"></script>
        <script src="css/jquery/ui/jquery.ui.widget.js"></script>
        <script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
        <script type="text/javascript">
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			q_tables = 's';
			var q_name = "ina";
			var q_readonly = ['txtNoa','txtComp','txtStore','txtWorker','txtWorker2','txtMount','txtWeight'];
			var q_readonlys = [];
			var bbmNum = [];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Datea';
			aPop = new Array(
				['txtStoreno', 'lblStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
				['txtRackno', 'lblRackno', 'rack', 'noa,rack,storeno,store', 'txtRackno', 'rack_b.aspx'],
				['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtComp', 'tgg_b.aspx'],
				['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'ucaucc_b.aspx'],
				['txtMechno_', 'btnMechno_', 'mech', 'noa,mech', 'txtMechno_,txtMech_', 'mech_b.aspx'],
				//['txtUno_', 'btnUno_', 'view_uccc', 'uno,productno,product,unit,style,lengthb,spec', 'txtUno_,txtProductno_,txtProduct_,txtUnit_,txtStyle_,txtLengthb_,txtSpec_', 'uccc_seek_b.aspx?;;;1=0', '95%', '60%'],
				['txtSssno_', 'btnSssno_', 'sss', 'noa,namea', 'txtSssno_,txtNamea_', 'sss_b.aspx']
			);
			brwCount2 = 5;
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
			});

			var abbsModi = [];

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}

				mainForm(1);
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd]];
				bbsMask = [['txtTimea', '99:99']];
				//bbmNum = [['txtMount', 15, q_getPara('rc2.mountPrecision'), 1], ['txtWeight', 15, q_getPara('rc2.weightPrecision'), 1]];
				//bbsNum = [['txtLengthb', 15, 2, 1],['txtMount', 15, q_getPara('rc2.mountPrecision'), 1], ['txtWeight', 15, q_getPara('rc2.weightPrecision'), 1]];
				q_mask(bbmMask);
				q_cmbParse("cmbItype", '1@生產入庫,2@加工入庫,3@進貨入庫,4@盤點入庫,5@調料入庫,6@客戶入料,7@退貨入庫,8@試水入庫,9@車床入庫,10@鑽孔入庫,11@膠圈入庫,12@螺栓入庫,13@押圈入庫,14@不良品');
				q_cmbParse("cmbKind", '1@生產,2@加工');
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}
			function q_popPost(s1) {
				switch (s1) {
					
				}
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
					default:
                     	try{
                     		t_para = JSON.parse(t_name);
                     		if(t_para.action == 'getWeight'){
                     			var as = _q_appendData('ucc', '', true);
                     			if (as[0] != undefined && parseFloat(as[0].uweight)!=0) {
                     				$('#txtWeight_'+t_para.n).val(round(parseFloat(as[0].uweight)*t_para.mount,3));
                     			}
                     			sum();
                     		}else if(t_para.action == 'getWeight_sum'){
                     			var as = _q_appendData('ucc', '', true);
                     			if (as[0] != undefined && parseFloat(as[0].uweight)!=0) {
                     				$('#txtWeight_'+t_para.n).val(round(parseFloat(as[0].uweight)*t_para.mount,3));
                     			}
                     			btnOk_sum(t_para.n);
                     		}
                     	}catch(e){
                     	}
                     	break;
				}
			}

			function btnOk() {
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				for(var i=0;i<q_bbsCount;i++)
					$('#txtStoreno_'+i).val($.trim($('#txtStoreno').val()));
				
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
				btnOk_sum(q_bbsCount); 
			}
			function btnOk_sum(n){
            	if(n==0){
            		sum();
					var t_noa = $('#txtNoa').val();
					if (t_noa.length == 0 || t_noa == "AUTO")
						q_gtnoa(q_name, replaceAll(q_getPara('sys.key_ina') + $('#txtDatea').val(), '/', ''));
					else
						wrServer(t_noa);
            	}else{
            		n--;
            		btnOk_sum(n);
            		
            		/*t_productno = $.trim($('#txtProductno_'+n).val());
                    t_mount = q_float('txtMount_' + n);
                    if(t_productno.length>0 && t_mount!=0){
                    	q_gt('ucc', "where=^^noa='"+t_productno+"'^^", 0, 0, 0,JSON.stringify({action:"getWeight_sum",n:n,mount:t_mount}));	
                    }else{
                    	btnOk_sum(n);
                    }*/
            	}           		
            }

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;
				q_box('inafe_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
			}

			function bbsAssign() {
				for (var j = 0; j < q_bbsCount; j++) {
					$('#lblNo_'+j).text(j+1);
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#txtProductno_' + j).bind('contextmenu', function(e) {
							/*滑鼠右鍵*/
							e.preventDefault();
							var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
							$('#btnProductno_'+n).click();
						});
						$('#txtSssno_' + j).bind('contextmenu', function(e) {
							/*滑鼠右鍵*/
							e.preventDefault();
							var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
							$('#btnSssno_'+n).click();
						});
						$('#txtMechno_' + j).bind('contextmenu', function(e) {
							/*滑鼠右鍵*/
							e.preventDefault();
							var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
							$('#btnMechno_'+n).click();
						});
						/*$('#txtMount_' + j).change(function() {
							if (q_cur == 1 || q_cur == 2){
                            	var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                            	t_productno = $.trim($('#txtProductno_'+n).val());
			                    t_mount = q_float('txtMount_' + n);
			                    if(t_productno.length>0 && t_mount!=0){
			                    	q_gt('ucc', "where=^^noa='"+t_productno+"'^^", 0, 0, 0,JSON.stringify({action:"getWeight",n:n,mount:t_mount}));	
			                    }
                            } 
						});*/
						$('#txtWeight_' + j).change(function() {
							sum();
						});
					}
				}
				_bbsAssign();
				HiddenTreat()
			}

			function btnIns() {
				_btnIns();
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
			}

			function btnPrint() {
				q_box('z_ina_bq.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "650px", q_getMsg("popPrint"));
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['productno']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['datea'] = abbm2['datea'];
				return true;
			}
			
			function sum() {
				/*var t_mount=0,t_weight=0;
				for (var j = 0; j < q_bbsCount; j++) {
					t_mount = q_add(t_mount,q_float('txtMount_' + j));
					t_weight = q_add(t_weight,q_float('txtWeight_' + j));
				}
				$('#txtMount').val(t_mount);
				$('#txtWeight').val(t_weight);*/
			}

			function refresh(recno) {
				_refresh(recno);
				HiddenTreat();
			}

			function HiddenTreat(returnType){
				returnType = $.trim(returnType).toLowerCase();
				var hasStyle = q_getPara('sys.isstyle');
				var isStyle = (hasStyle.toString()=='1'?$('.isStyle').show():$('.isStyle').hide());
				var hasSpec = q_getPara('sys.isspec');
				var isSpec = (hasSpec.toString()=='1'?$('.isSpec').show():$('.isSpec').hide());
				var hasRackComp = q_getPara('sys.rack');
				var isRack = (hasRackComp.toString()=='1'?$('.isRack').show():$('.isRack').hide());
				if(returnType=='style'){
					return (hasStyle.toString()=='1');
				}else if(returnType=='spec'){
					return (hasSpec.toString()=='1');
				}else if(returnType=='rack'){
					return (hasRackComp.toString()=='1');
				}
				
				if(q_getPara('sys.menu').substr(0,3)=='qfe')
                	$('.isFe').show()
                else
                	$('.isFe').hide()
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				HiddenTreat();
			}

			function btnMinus(id) {
				_btnMinus(id);
				sum();
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}

			function q_appendData(t_Table) {
				return _q_appendData(t_Table);
			}

			function btnSeek() {
				_btnSeek();
			}

			function btnTop() {
				_btnTop();
			}

			function btnPrev() {
				_btnPrev();
			}

			function btnPrevPage() {
				_btnPrevPage();
			}

			function btnNext() {
				_btnNext();
			}

			function btnNextPage() {
				_btnNextPage();
			}

			function btnBott() {
				_btnBott();
			}

			function q_brwAssign(s1) {
				_q_brwAssign(s1);
			}

			function btnDele() {
				_btnDele();
			}

			function btnCancel() {
				_btnCancel();
			}

		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 200px; 
                border-width: 0px; 
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30px;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #FFFF66;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 800px;
                /*margin: -1px;        
                border: 1px black solid;*/
                border-radius: 5px;
            }
            .tbbm {
                padding: 0px;
                border: 1px white double;
                border-spacing: 0;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .tbbm tr {
                height: 35px;
            }
            .tbbm tr td {
                width: 10%;
            }
            .tbbm .tdZ {
                width: 1%;
            }
            td .schema {
                display: block;
                width: 95%;
                height: 0px;
            }
            .tbbm tr td span {
                float: right;
                display: block;
                width: 5px;
                height: 10px;
            }
            .tbbm tr td .lbl {
                float: right;
                color: blue;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
                float: left;
            }
            .txt.num {
                text-align: right;
            }
            .tbbm td {
                margin: 0 -1px;
                padding: 0;
            }
            .tbbm td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                float: left;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size:medium;
            }
            .dbbs {
                width: 100%;
            }
            .tbbs a {
                font-size: medium;
            }
            
            .num {
                text-align: right;
            }
            input[type="text"],input[type="button"] {
                font-size:medium;
            }
        </style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
            <div class="dview" id="dview" >
                <table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:20%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:25%"><a id='vewItype'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='itype'>~itype</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
                <table class="tbbm"  id="tbbm">
                    <tr style="height:1px;">
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td class="tdZ"></td>
                    </tr>
					<tr>
						<td><span> </span><a id="lblKind" class="lbl"> </a></td>
						<td><select id="cmbKind" class="txt c1"> </select></td>
						<td><span> </span><a id="lblItype" class="lbl"> </a></td>
						<td><select id="cmbItype" class="txt c1"> </select></td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblNoa" class="lbl" > </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblStore" class="lbl btn" > </a></td>
						<td colspan="3">
							<input id="txtStoreno" type="text" class="txt" style="float:left;width:40%;"/>
							<input id="txtStore" type="text" class="txt" style="float:left;width:60%;"/>
						</td>
						<td class='isRack'><span> </span><a id="lblRackno" class="lbl btn" > </a></td>
						<td class="isRack"><input id="txtRackno" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>	
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>					
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan='5'><textarea id="txtMemo" cols="10" rows="5" style="width: 99%;height: 50px;"> </textarea></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
            <table id="tbbs" class='tbbs'>
                <tr style='color:white; background:#003366;' >
                    <td  align="center" style="width:30px;">
                    <input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
                    </td>
                    <td align="center" style="width:20px;"></td>
					<td align="center" style="width:200px"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblProductno_s'> </a></td>
					<td align="center" style="width:100px;"><a id='Mount_s'>入庫數量</a></td>
					<td align="center" style="width:100px;"><a id='Mount2_s'>生產數量</a></td>
					<td align="center" style="width:100px;"><a id='Price_s'>不良數</a></td>
					<td align="center" style="width:200px;"><a id='lblMemo_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblSss_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblClass_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblMech_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblTimea_s'> </a></td>
					<td align="center" style="width:200px;"><a id='lblUnit_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
                    <td align="center">
                    	<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
                    	<input id="txtNoq.*" type="text" style="display: none;" />
                    	<input id="txtStoreno.*" type="text" style="display: none;" />
                    </td>
                    <td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input id="txtProductno.*" type="text" style="width:95%;" />
						<input class="btn" id="btnProductno.*" type="button" style="display:none;" />
					</td>
					<td><input class="txt" id="txtProduct.*" type="text" style="width:95%;"/></td>
					<td class="isStyle"><input id="txtStyle.*" type="text" class="txt isStyle" style="width:95%;"/></td>
					<td class="isFe"><input id="txtLengthb.*" type="text" class="txt num isFe" style="width:95%;"/></td>
					
					<td><input class="txt num" id="txtMount.*" type="text" style="width:95%;"/></td>
					<td><input class="txt num" id="txtDime.*" type="text" style="width:95%;"/></td>
					<td><input class="txt num" id="txtWidth.*" type="text" style="width:95%;"/></td>
					<td>
						<input class="txt" id="txtMemo.*" type="text" style="width:95%;"/>
						<input id="recno.*" type="text" style="display:none;" />
					</td>
					<td>
						<input class="txt" id="txtSssno.*" type="text" style="width:95%;"/>
						<input class="btn" id="btnSssno.*" type="button" value='.' style="display:none;" />
						<input class="txt" id="txtNamea.*" type="text" style="width:95%;"/>
					</td>
					<td><input class="txt" id="txtClass.*" type="text" style="width:95%;"/></td>
					<td>
						<input class="txt" id="txtMechno.*" type="text" style="width:95%;"/>
						<input class="btn" id="btnMechno.*" type="button" value='.' style="display:none;" />
						<input class="txt" id="txtMech.*" type="text" style="width:95%;"/>
					</td>
					<td><input class="txt" id="txtTimea.*" type="text" style="width:95%;"/></td>
					<td><input class="txt" id="txtUnit.*" type="text" style="width:95%;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>