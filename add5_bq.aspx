<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			q_tables = 's';
			var q_name = "add5";
			var q_readonly = ['txtNoa','txtCardeal'];
			var q_readonlys = [];
			var bbmNum = [];
			var bbsNum = [];
			var bbmMask = [['txtBoil', 10, 0, 1]];
			var bbsMask = [['txtTotal', 10, 0, 1],['txtMount', 10, 0, 1],['txtPrice2', 10, 1, 1],['txtPrice', 10, 1, 1],['txtCount1', 10, 0, 1],['txtCount2', 10, 0, 1]];
			q_sqlCount = 6;
			brwCount = 6;
			brwCount2 = 4;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1);
			});
			
			aPop = new Array(
				['txtCardealno', 'lblCardealno_bq', 'cust', 'noa,comp','txtCardealno,txtCardeal', 'cust_b.aspx']
				,['txtProductno_', 'btnProduct_', 'ucaucc', 'noa,product,unit,spec', 'txtProductno_,txtProduct_,txtUnit_,txtSpec_', 'ucaucc_b.aspx']
			);

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd]];
				bbsMask = [['txtDatea', r_picd]];
				q_mask(bbmMask);
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

			function q_gtPost(t_name) {
				switch (t_name){
				    case 'ordeuno':
                        var a = _q_appendData("orde", "", true);
                        var asd = _q_appendData("ordes", "", true);
                        if(a[0]!=undefined){
                            $('#txtContract').val(a[0].contract);
                            $('#txtCardealno').val(a[0].custno);
                            $('#txtCardeal').val(a[0].comp);
                            $('#txtAddr').val(a[0].addr2);                         
                        }
                        var t_mt=0;
                        if(asd[0]!=undefined){
                            for ( i = 0; i < q_bbsCount; i++) {
                               _btnMinus("btnMinus_" + i); 
                            }
                            for(var i=0;i<asd.length;i++){
                                if(asd[i].product.indexOf('螺栓')>-1 || asd[i].product.indexOf('膠圈')>-1 || asd[i].product.indexOf('押圈')>-1 ){
                                        $('#txtProductno_'+t_mt).val(asd[i].productno);
                                        $('#txtProduct_'+t_mt).val(asd[i].product);
                                        $('#txtSpec_'+t_mt).val(asd[i].spec);
                                        $('#txtUnit_'+t_mt).val(asd[i].unit);
                                        $('#txtMount_'+t_mt).val(asd[i].mount);
                                        if(asd[i].product.indexOf('膠圈')>-1){
                                                $('#txtPost_'+t_mt).val('世展');
                                        }else{
                                                $('#txtPost_'+t_mt).val('IT');
                                        }
                                        q_bbs_addrow('bbs',t_mt,1);
                                        t_mt+=1
                                }else{
                                    for(var j=0;j<asd[i].mount;j++){
                                         $('#txtDatea_'+t_mt).val(asd[i].datea);
                                         $('#txtProductno_'+t_mt).val(asd[i].productno);
                                         $('#txtProduct_'+t_mt).val(asd[i].product);
                                         $('#txtSpec_'+t_mt).val(asd[i].spec);
                                         $('#txtUnit_'+t_mt).val(asd[i].unit);
                                         $('#txtPostno_'+t_mt).val('IT');
                                         $('#txtMount_'+t_mt).val(1);
                                         $('#txtPrice2_'+t_mt).val(asd[i].gweight);
                                         q_bbs_addrow('bbs',t_mt,1);
                                         t_mt+=1
                                    }
                                }
                                
                            }
                        }
                        $('#txtNoa').focus();
                        sum();
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock();
			}

			function btnOk() {
				Lock();
				var t_date = $('#txtDatea').val();
				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll((t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(s1);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('add5_s.aspx', q_name + '_s', "550px", "400px", q_getMsg("popSeek"));
			}

			function btnIns() {
				 _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date);
                $('#txtDatea').focus();

                $('#btnOrdes').click(function() {
                    if($('#txtCartype').val().length!=0){
                        t_where = "where=^^ noa='"+$('#txtCartype').val()+"' ^^";
                        q_gt('orde', t_where, 0, 0, 0, "ordeuno", r_accy);  
                    }
                });
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtCardealno').focus();
			}

			function btnPrint() {

			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
					}
				}
				_bbsAssign();
			}

			function bbsSave(as) {
				t_err = '';
				if (!as['productno'] && !as['product']) {
                    as[bbsKey[1]] = '';
                    return;
                }
				q_nowf();
				as['noa'] = abbm2['noa'];
				if (t_err) {
					alert(t_err)
					return false;
				}
				return true;
			}

			function sum() {
			        var t_round=1+Math.random();
			        if(t_round>1.02)
			           t_round=1.02;  
                    for (var j = 0; j < q_bbsCount; j++) {
                        t_spec=replaceAll(replaceAll($('#txtSpec_'+j).val().substr(0,4),'x',''),'-','');
                        if($('#txtPrice2_'+j).val().length!=0){
                            $('#txtTotal_'+j).val(q_mul(q_mul($('txtMount_'+j).val(),$('#txtPrice_'+j).val()),t_round));
                            if($('#txtProduct_'+i).val().indexOf('管塞')>-1 ||$('#txtProduct_'+i).val().indexOf('盲蓋')>-1){
                                $('#txtCount1_'+j).val(0);
                                $('#txtCount2_'+j).val(0);
                            }else if(t_spec<75){
                                $('#txtBoil').val(40);
                            }else if(t_spec>= 75 && t_spec < 350){
                                $('#txtBoil').val(30);
                                $('#txtCount1_'+j).val(30);
                                $('#txtCount2_'+j).val(30);
                            }else if(t_spec >= 350 && t_spec < 400){
                                $('#txtBoil').val(25);
                                $('#txtCount1_'+j).val(25);
                                $('#txtCount2_'+j).val(25);
                            }else if(t_spec >= 700 && t_spec < 1100){
                                $('#txtBoil').val(20);
                                $('#txtCount1_'+j).val(20);
                                $('#txtCount2_'+j).val(20);
                            }else if(t_spec >= 1100 && t_spec < 2600){
                                $('#txtBoil').val(15);
                                $('#txtCount1_'+j).val(15);
                                $('#txtCount2_'+j).val(15);
                            }else{
                                $('#txtBoil').val(0);
                                $('#txtCount1_'+j).val(0);
                                $('#txtCount2_'+j).val(0);
                            }
                        }
                    }
				
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
				width: 450px;
				border-width: 0px;
			}
			.tview {
				border: 5px solid gray;
				font-size: medium;
				background-color: black;
				width: 100%;
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
				width: 650px;
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
				width: 95%;
				float: left;
			}
			.txt.c2 {
				width: 25%;
				float: left;
			}
			.txt.c3 {
				width: 74%;
				float: left;
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
				font-size: medium;
				width: 100%;
			}
			.dbbs {
				width: 1300px;
			}
			.tbbs a {
				font-size: medium;
			}
			.num {
				text-align: right;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
                        <td align="center" style="width:5%"><a id='vewChk'> </a></td>
                        <td align="center" style="width:20%"><a id='vewDatea_bq'>檢驗日期</a></td>
                        <td align="center" style="width:30%"><a id='vewNoa'> </a></td>
                        <td align="center" style="width:45%"><a id='vewCardeal_bq'>客戶</a></td>
                    </tr>
                    <tr>
                        <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                        <td align="center" id='datea'>~datea</td>
                        <td align="center" id='noa'>~noa</td>
                        <td align="center" id='cardeal'>~cardeal</td>
                    </tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
					<tr style="height:1px;">
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
                        <td class="td1"><span> </span><a id='lblDatea_bq' class="lbl">檢驗日期</a></td>
                        <td class="td2" colspan="2"><input id="txtDatea" type="text" class="txt c1"/></td>
                        <td class="td4"><span> </span><a id='lblNoa' class="lbl"> </a></td>
                        <td class="td5" colspan="2"><input id="txtNoa" type="text" class="txt c1" /></td>
                    </tr>
					<tr>
                        <td class="td1"><span> </span><a id='lblContract' class="lbl">合約編號</a></td>
                        <td class="td2" colspan="2"><input id="txtContract" type="text" class="txt c1"/></td>
                        <td class="td3"><span> </span><a id='lblCartype_bq' class="lbl">訂單號碼</a></td>
                        <td class="td4" colspan="2"><input id="txtCartype" type="text" class="txt c1" /></td>
                        <td class="td6"><input id="btnOrdes" type="button" value="訂單匯入"/></td>
                    </tr>
					<tr>
                        <td class="td1"><span> </span><a id='lblAddr' class="lbl">工程名稱</a></td>
                        <td class="td2" colspan="6"><input id="txtAddr" type="text" class="txt c1" style="width: 99%"/></td>
                    </tr>
                    <tr>
                        <td class="td1"><span> </span><a id='lblCardealno_bq' class="lbl btn">客戶名稱</a></td>
                        <td class="td2" colspan="4">
                            <input id="txtCardealno" type="text" class="txt c2"/>
                            <input id="txtCardeal" type="text" class="txt c3"/>
                        </td>
                        <td class="td7"><span> </span><a id='lblBoil_bq' class="lbl">耐壓測試</a></td>
                        <td class="td8"><input id="txtBoil" type="text" class="txt num c1"/></td>
                    </tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width: 2%;">
						<input class="btn" id="btnPlus" type="button" value='+' style="font-weight: bold;" />
					</td>
					<td align="center" style="width:90px;"><a id='lbldatea_s'>日期</a></td>
					<td align="center" style="width:120px;"><a id='lblProductno_s'>產品編號</a></td>
                    <td align="center" style="width:120px;"><a id='lblProduct_s'>產品名稱</a></td>
                    <td align="center" style="width:120px;"><a id='lblSpec_s'>規格</a></td>
                    <td align="center" style="width:80px;"><a id='lblTotal_s'>重量</a></td>
                    <td align="center" style="width:80px;"><a id='lblPosts_s'>合格編號</a></td> 
                    <td align="center" style="width:80px;"><a id='lblCount1s_s'>管身1分鐘</a></td>
                    <td align="center" style="width:80px;"><a id='lblCount2s_s'>管尾承插口1分鐘</a></td>
                    <td align="center" style="width:50px;"><a id='lblUnit_s'>配件</a></td>
                    <td align="center" style="width:50px;"><a id='lblMount_s'>數量</a></td>
                    <td align="center" style="width:60px;"><a id='lblPostno_s'>製造商或代號</a></td>
                    <td align="center" style="width:80px;"><a id='lblPrices_s'>單重</a></td>
                    <td align="center" style="width:80px;"><a id='lblPrice2s_s'>單位許可差</a></td>
                    <td align="center" style="width:100px;"><a id='lblMemo_s'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input class="btn" id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><input id="txtDatea.*" type="text" class="txt c1"/></td>
					<td><input id="txtProductno.*" type="text" class="txt c1"/></td>
                    <td><input id="txtProduct.*" type="text" class="txt c1"/></td>
                    <td><input id="txtSpec.*" type="text" class="txt c1"/></td>
                    <td><input id="txtTotal.*" type="text" class="txt num c1"/></td>
                    <td><input id="txtPost.*" type="text" class="txt c1"/></td>
                    <td><input id="txtCount1.*" type="text" class="txt num c1"/></td>
                    <td><input id="txtCount2.*" type="text" class="txt num c1"/></td>
                    <td><input id="txtUnit.*" type="text" class="txt c1"/></td>
                    <td><input id="txtMount.*" type="text" class="txt num c1"/></td>
                    <td><input id="txtPostno.*" type="text" class="txt c1"/></td>
					<td><input id="txtPrice.*" type="text" class="txt num c1"/></td>
                    <td><input id="txtPrice2.*" type="text" class="txt num c1"/></td>
					<td><input id="txtMemo.*" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>