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
		<script type="text/javascript">
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}
			q_copy=1;
			q_desc = 1;
			q_tables = 's';
			var q_name = "quat";
			var q_readonly = ['txtWorker', 'txtComp', 'txtAcomp', 'txtSales', 'txtWorker2'];
			var q_readonlys = ['txtNo3'];
			var bbmNum = [];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwCount2 = 11;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Datea';
			aPop = new Array(
				['txtProductno_', 'btnProduct_', 'ucaucc', 'noa,product,unit,spec', 'txtProductno_,txtProduct_,txtUnit_,txtSpec_', 'ucaucc_b.aspx'],
				['txtCustno', 'lblCust', 'cust', 'noa,nick,tel,fax,zip_comp,addr_comp', 'txtCustno,txtComp,txtTel,txtFax,txtPost,txtAddr', 'cust_b.aspx'],
				['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
				['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
			);
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'no3'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(1);
			}

			function sum() {
			    var t1 = 0, t_unit, t_mount, t_weight = 0, t_total = 0;
                for (var j = 0; j < q_bbsCount; j++) {
                    $('#txtTotal_' + j).val(round(q_mul(q_float('txtEweight_' + j),(q_mul(q_float('txtMount_' + j), q_float('txtPrice_' + j)))),0));
                    t_total = q_add(t_total, q_float('txtTotal_' + j));
                }
                q_tr('txtMoney', t_total);
                q_tr('txtTotal', t_total);
                calTax();
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtOdate', r_picd]];
				q_mask(bbmMask);
				bbmNum = [['txtMoney', 15, 0, 1], ['txtTax', 10, 0, 1], ['txtTotal', 15, 0, 1]];
				bbsNum = [['txtEweight', 10, 2, 1],['txtMount', 10, 2, 1], ['txtPrice', 10, 2, 1], ['txtTotal', 15, 0, 1]];
				q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
			}

			function q_boxClose(s2) {
				var
				ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}
			function q_gtPost(t_name) {
				switch (t_name) {
				    case 'ordex':
				        var asm = _q_appendData("ordex", "", true);
				        if(asm[0]!=undefined){
                            $('#txtDatea').val(asm[0].datea);
                            $('#txtContract').val(asm[0].ordcno);
                            $('#txtCustno').val(asm[0].custno);
                            $('#txtComp').val(asm[0].comp);
                            $('#txtTel').val(asm[0].tel);
                            $('#txtFax').val(asm[0].fax);
                            $('#txtPost').val(asm[0].post);
                            $('#txtAddr').val(asm[0].addr);
                            $('#txtMoney').val(asm[0].money);
                            $('#txtTax').val(asm[0].tax);
                            $('#cmbTaxtype').val(asm[0].taxtype);
                            $('#txtTotal').val(asm[0].total);
                            $('#txtMemo').val(asm[0].memo);
                        }
                        var as = _q_appendData("ordexs", "", true);
                        q_gridAddRow(bbsHtm, 'tbbs', 'txtNo3,txtProductno,txtProduct,txtSpec,txtEweight,txtUnit,txtMount,txtPrice,txtTotal,txtMemo'
                        , as.length, as, 'no2,productno,product,spec,gweight,unit,mount,price,total,memo', 'txtProductno,txtProduct,txtSpec,txtEweight,txtUnit,txtMount,txtPrice,txtTotal,txtMemo','');
                        for ( i = 0; i < q_bbsCount; i++) {
                            if (i < as.length) {
                            }else{
                                _btnMinus("btnMinus_" + i);
                            }
                        }
                        $('#txtNoa').focus();
                        break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function btnOk() {
			    if($('#txtDatea').val().length==0){
                    $('#txtDatea').val(q_date());
                }
                if($('#txtNoa').val().length==0){
                   $('#txtNoa').val('AUTO');
                }

				t_err = '';
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                if (q_cur == 2)
                    $('#txtWorker2').val(r_name);

				sum();
				

				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_quat') + (!emp($('#txtDatea').val())?$('#txtDatea').val():q_date()), '/', ''));
				else
					wrServer(s1);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;

				q_box('quat_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
			}

			function bbsAssign() {
				for (var j = 0; j < q_bbsCount; j++) {
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#txtEweight_' + j).change(function() {
                            sum();
                        });
						$('#txtMount_' + j).change(function() {
							sum();
						});
						$('#txtPrice_' + j).change(function() {
							sum();
						});
					}
				}
				_bbsAssign();
			}

			function btnIns() {
				_btnIns();
				
				$('#txtNoa').change(function() {
                    if($('#txtNoa').val().length!=0){
                        t_where = "where=^^ noa='"+$('#txtNoa').val()+"' ^^";
                        q_gt('ordex', t_where, 0, 0, 0, "", r_accy);
                    }
                });
                
				$('#txtDatea').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtProduct').focus();

			}

			function btnPrint() {
				q_box('z_quatp_bq.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", m_print);
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
				as['custno'] = abbm2['custno'];
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
			}
			
			function btnMinus(id) {
				_btnMinus(id);
				sum();
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				if (q_tables == 's')
					bbsAssign();
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

			function q_popPost(s1) {
			}
		</script>
		<style type="text/css">
			.tview {
				width: 100%;
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
				width: 70%;
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
				width: 9%;
			}
			.tbbm .tdZ {
				width: 1%;
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
			.txt.c2 {
				width: 48%;
				float: left;
			}
			.txt.c3 {
				width: 50%;
				float: left;
			}
			.txt.c4 {
				width: 25%;
				float: left;
			}
			.txt.c5 {
				width: 72%;
				float: left;
			}
			.txt.c6 {
				width: 25%;
			}
			.txt.c7 {
				width: 95%;
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
			.tbbm td input[type="button"] {
				width: auto;
			}
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
			}
			.dbbs {
				width: 100%;
			}
			.tbbs a {
				font-size: medium;
			}
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}
			.num {
				text-align: right;
			}
			.tbbs tr.error input[type="text"] {
				color: red;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;width: 1270px;">
			<div id="dview" style="float:left;width:30%;border-width:0px;">
				<table class="tview" id="tview"	>
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:25%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:25%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:40%"><a id='vewComp'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='custno comp,4'>~custno ~comp,4</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm" style="width: 872px;">
				    <tr style="height:1px;">
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td class="tdZ"></td>
                    </tr>
					<tr class="tr1">
					    <td class="td1"><span> </span><a id='lblDatea_bq' class="lbl">報價日期</a></td>
						<td class="td2"><input id="txtDatea" type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblContract' class="lbl"> </a></td>
                        <td class="td4" colspan="2"><input id="txtContract" type="text" class="txt c1"/></td>
						<td class="td6"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td class="td7"><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					 <tr class="tr2">
                        <td><span> </span><a id='lblAddr2_bq' class="lbl">工程名稱</a></td>
                        <td colspan='5' ><input id="txtAddr2" type="text" class="txt c1" /></td>
                    </tr>
					<tr class="tr3">
						<td><span> </span><a id='lblCust' class="lbl btn"> </a></td>
						<td><input id="txtCustno" type="text" class="txt c1"/></td>
						<td colspan="2"><input id="txtComp" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr4">
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td colspan='2'><input id="txtTel"	type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblFax' class="lbl"> </a></td>
						<td colspan='2'><input id="txtFax" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr5">
						<td><span> </span><a id='lblAddr' class="lbl"> </a></td>
						<td><input id="txtPost" type="text" class="txt c1"></td>
						<td colspan='5' ><input id="txtAddr" type="text" class="txt c1" /></td>
					</tr>
					<tr class="tr8">
						<td><span> </span><a id='lblMoney_bq' class="lbl">小計</a></td>
						<td>
							<input id="txtMoney" type="text" class="txt c1 num" />
						</td>
						<td><span> </span><a id='lblTax_bq' class="lbl">稅額</a></td>
						<td><input id="txtTax" type="text" class="txt c1 num"/></td>
						<td><select id="cmbTaxtype" class="txt c1" onchange='sum()'> </select></td>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td><input id="txtTotal" type="text" class="txt c1 num"/></td>
					</tr>
					<tr class="tr10">
						<td align="right">
							<span> </span><a id='lblMemo' class="lbl"> </a>
						</td>
						<td colspan='6' >
							<input id="txtMemo" type="text" style="width: 99%;"/>
						</td>
					</tr>
					<tr class="tr10">
                        <td><span> </span><a id='lblMemo2' class="lbl"> </a></td>
                        <td colspan='6'><textarea id="txtMemo2" rows='5' cols='10' style="width:99%; height: 100px;"> </textarea></td>
                    </tr>
					<tr class="tr11">
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1" /></td>
						<td> </td>
						<td> </td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="width: 1260px;">
			<table id="tbbs" class='tbbs' border="1" cellpadding='2' cellspacing='1' >
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:40px;">
						<input class="btn" id="btnPlus" type="button" value='＋' style="font-weight: bold;" />
					</td>
					<td align="center" style="width:90px;"><a id='lblProductno'>產品編號</a></td>
					<td align="center" style="width:90px;"><a id='lblProduct'>產品名稱</a></td>
                    <td align="center" style="width:120px;"><a id='lblStyle_bq'>規格(mm)</a></td>
                    <td align="center" style="width:70px;"><a id='lblEwwight'>單重</a></td>
					<td align="center" style="width:40px;"><a id='lblUnit'> </a></td>
					<td align="center" style="width:70px;"><a id='lblMount'> </a></td>
					<td align="center" style="width:50px;"><a id='lblPrices'> </a></td>
					<td align="center" style="width:80px;"><a id='lblTotals_bq'>複價</a></td>
					<td align="center" style="width:100px;"><a id='lblMemos'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td><input class="btn" id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
					<td align="center">
						<input id="txtProductno.*" type="text" class="txt c1" />
						<input class="btn" id="btnProduct.*" type="button" value='.' style=" font-weight: bold;" />
						<input id="txtNo3.*" type="text" class="txt c6" />
					</td>
					<td><input id="txtProduct.*" type="text" class="txt c1"/></td>
					<td><input id="txtSpec.*" type="text" class="txt c1 isSpec"/></td>
					<td><input id="txtEweight.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtUnit.*" type="text" class="txt c1"/></td>
					<td><input id="txtMount.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtPrice.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtTotal.*" type="text" class="txt c1 num"/></td>
					<td>
						<input id="txtMemo.*" type="text" class="txt c1"/>
						<input id="txtNoq.*" type="hidden" />
						<input id="recno.*" type="hidden" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>