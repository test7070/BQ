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

			q_desc = 1;
			q_tables = 's';
			var q_name = "vcce";
			var q_readonly = ['txtNoa', 'txtWorker', 'txtWorker2', 'txtComp', 'txtAcomp', 'txtSales','textCuft'];
			var q_readonlys = ['txtStore'];
			var bbmNum = [['txtMoney', 10, 0, 1],['txtTax', 10, 0, 1], ['txtTotal', 10, 0, 1]];
			var bbsNum = [['txtMount', 10, 0, 1], ['txtEcount', 10, 0, 1], ['txtAdjcount', 10, 0, 1],];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwCount2 = 14;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Datea';
			aPop = new Array(
				['txtCustno', 'lblCustno', 'cust', 'noa,comp,tel,fax,trantype,zip_comp,addr_comp', 'txtCustno,txtComp,txtTel,txtFax,cmbTrantype,txtZip_post,txtAddr_post', 'cust_b.aspx'],
				['txtOrdeno', '', 'orde', 'noa,custno,comp,trantype,stype,tel,fax,addr2,salesno,sales,cno,acomp,paytype', 'txtOrdeno,txtCustno,txtComp,cmbTrantype,cmbStype,txtTel,txtFax,txtAddr_post,txtSalesno,txtSales,txtCno,txtAcomp,txtPaytype', ''],
				['txtProductno_', 'btnProduct_', 'ucaucc', 'noa,product,unit,spec', 'txtProductno_,txtProduct_,txtUnit_', 'ucaucc_b.aspx'],
				['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
				['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
				['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx'],
				['txtStoreno_', 'btnStoreno_', 'store', 'noa,store', 'txtStoreno_,txtStore_', 'store_b.aspx'],
				['txtRackno_', 'btnRackno_', 'rack', 'noa,rack,storeno,store', 'txtRackno_', 'rack_b.aspx']
			);

			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
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

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtCldate', r_picd],['txtDate1', r_picd],['txtDate2', r_picd],['txtEtcdate', r_picd],['txtEtctime','99:99']];
				q_mask(bbmMask);
				//q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				q_cmbParse("cmbStype", q_getPara('orde.stype'));
				//q_cmbParse("combPaytype", q_getPara('vcc.paytype'));

				var t_where = "where=^^ 1=0 ^^ stop=100";
				q_gt('custaddr', t_where, 0, 0, 0, "");
				
				$('#cmbStype').change(function() {
					HiddenTreat();
				});

				$('#btnBoaj').click(function() {
					var t_noa = $('#txtNoa').val();
					var t_where = '';
					if (t_noa.length > 0)
						t_where = "noa='" + t_noa + "'";
					q_box("boaj.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'boaj', "95%", "95%", q_getMsg('btnBoaj'));
				});

				$('#lblInvo').click(function() {
					var t_noa = $('#txtInvo').val();
					var t_where = '';
					if (t_noa.length > 0)
						t_where = "noa='" + t_noa + "'";
					q_box("invo.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'invo', "95%", "95%", q_getMsg('btnInvo'));
				});
				
				$('#lblCaseno2').click(function() {
					var t_noa = $('#txtCaseno2').val();
					var t_where = '';
					if (t_noa.length > 0)
						t_where = "noa='" + t_noa + "'";
					q_box("vcc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'vcc', "95%", "95%", '出貨單');
				});

				$('#btnPack').click(function() {
					var t_noa = $('#txtNoa').val();
					var t_where = '';
					if (t_noa.length > 0){
						t_where = "noa='" + t_noa + "'";
						q_box("packing_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'packing', "95%", "95%", q_getMsg('btnPack'));
					}
				});

				$('#btnVccimport').click(function() {
				    if($('#txtCaseno2').val().length!=0){
                        t_where = "where=^^ noa='"+$('#txtCaseno2').val()+"' ^^";
                        q_gt('vcc', t_where, 0, 0, 0, "vccimport", r_accy);  
                    }
				});
				$('#txtAddr_post').change(function() {
					var t_custno = trim($(this).val());
					if (!emp(t_custno)) {
						focus_addr = $(this).attr('id');
						var t_where = "where=^^ noa='" + t_custno + "' ^^";
						q_gt('cust', t_where, 0, 0, 0, "");
					}
				});
				$('#txtDeivery_addr').change(function() {
					var t_custno = trim($(this).val());
					if (!emp(t_custno)) {
						focus_addr = $(this).attr('id');
						var t_where = "where=^^ noa='" + t_custno + "' ^^";
						q_gt('cust', t_where, 0, 0, 0, "");
					}
				});

				$('#txtCustno').change(function() {
					if (!emp($('#txtCustno').val())) {
						var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^ stop=100";
						q_gt('custaddr', t_where, 0, 0, 0, "");
					}
				});
				
				$('#btnToinvo').click(function() {
					//post.0
					/*q_gt('invo', "where=^^vcceno='" + $('#txtNoa').val() + "' or noa='"+$('#txtInvo').val()+"' ^^", 0, 0, 0, "",r_accy,1);
					var ass = _q_appendData("invo", "", true);
					if (ass[0] != undefined) {
						q_func('invo_post.post', r_accy + ',' + ass[0].noa + ',0');
						sleep(100);
					}*/
					//qfunc
					if(!emp($('#txtNoa').val()))
						q_func('qtxt.query.toinvo', 'packing.txt,toinvo,' + encodeURI($('#txtNoa').val()) + ';'+encodeURI(q_date())+';' + encodeURI(r_userno)+';'+ encodeURI(r_name)+';'+ encodeURI(r_accy)+';'+ encodeURI(r_len));
					
				});
				$('#btnTovcc').click(function() {
					if(!emp($('#txtNoa').val())){
						//post.0
						q_gt('view_vcc', "where=^^zipcode='" + $('#txtNoa').val() + "' or noa='"+$('#txtCaseno2').val()+"' ^^", 0, 0, 0, "",r_accy,1);
						var ass = _q_appendData("view_vcc", "", true);
						if (ass[0] != undefined) {
							q_func('vcc_post.post', ass[0].accy + ',' + ass[0].noa + ',0');
							sleep(100);
						}
						//qfunc
						q_func('qtxt.query.tovcc', 'packing.txt,tovcc,' + encodeURI($('#txtNoa').val()) + ';'+encodeURI(q_date())+';' + encodeURI(r_userno)+';'+ encodeURI(r_name)+';'+ encodeURI(r_accy)+';'+ encodeURI(r_len));
					}
				});
			}
			
			function sleep(milliseconds) {
                var start = new Date().getTime();
                for (var i = 0; i < 1e7; i++) {
                    if ((new Date().getTime() - start) > milliseconds) {
                        break;
                    }
                }
            }
            
            function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'qtxt.query.toinvo':
                	 var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                            abbm[q_recno]['invo'] = as[0].invo;
                            $('#txtInvo').val(as[0].invo);
							alert('Invoice產生完畢!!');
                            /*if (as[0].invo.length > 0) {
                                q_func('invo_post.post', r_accy + ',' + as[0].invo + ',1');
                            }*/
                        }
                		break;
                    case 'qtxt.query.tovcc':
                        var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                            abbm[q_recno]['caseno2'] = as[0].vccno;
                            $('#txtCaseno2').val(as[0].vccno);
							
                            if (as[0].vccno.length > 0) {
                                q_func('vcc_post.post', as[0].accy + ',' + as[0].vccno + ',1');
                            }
                            alert('出貨單產生完畢!!');
                        }
                        break;
                }
            }

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'packing':
						ChangeCuft();
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}

			var focus_addr = '';
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'packing':
						var as = _q_appendData("packing", "", true);
						var t_cuft=0;
						if (as[0] != undefined) {
							for (var i = 0; i < as.length; i++) {
								t_cuft=q_add(t_cuft,dec(as[i].cuft));
							}
						}
						$('#textCuft').val(t_cuft);
					break;
					case 'custaddr':
						var as = _q_appendData("custaddr", "", true);
						var t_item = " @ ";
						if (as[0] != undefined) {
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].post + '@' + as[i].addr;
							}
						}
						document.all.combAddr.options.length = 0;
						q_cmbParse("combAddr", t_item);
						break;
					case 'vccimport':
                        var asm = _q_appendData("vcc", "", true);
                        if(asm[0]!=undefined){
                            $('#txtOrdeno').val(asm[0].ordeno)
                            $('#txtFax').val(asm[0].contract);
                            $('#txtCno').val(asm[0].cno);
                            $('#txtAcomp').val(asm[0].acomp);
                            $('#txtCustno').val(asm[0].custno);
                            $('#txtComp').val(asm[0].comp);
                        }
                        $('#txtNoa').focus();
                        sum();
                        break;
					case 'cust':
						var as = _q_appendData("cust", "", true);
						if (as[0] != undefined && focus_addr != '') {
							$('#' + focus_addr).val(as[0].addr_fact);
							focus_addr = '';
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function btnOk() {
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				if(HiddenTreat('rack')){
					var t_rackErr = '';
					for(var j=0;j<q_bbsCount;j++){
						var thisProductno = $.trim($('#txtProductno_'+j).val());
						var thisStoreno = $.trim($('#txtStoreno_'+j).val());
						var thisRackno = $.trim($('#txtRackno_'+j).val());
						if(thisProductno.length >0){
							if(thisStoreno.length == 0 || thisRackno.length == 0){
								t_rackErr += '表身第 ' + (j+1) + " 筆 倉庫或料架編號未填寫!! \n";
							}
						}
					}
					if($.trim(t_rackErr).length > 0){
						alert(t_rackErr);
						return;
					}
				}
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
				sum();

				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_vcce') + $('#txtDatea').val(), '/', ''));
				else
					wrServer(s1);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;

				q_box('vcce_s.aspx', q_name + '_s', "500px", "360px", q_getMsg("popSeek"));
			}

			function combPaytype_chg() {
				var cmb = document.getElementById("combPaytype");
				if (!q_cur)
					cmb.value = '';
				else
					$('#txtPaytype').val(cmb.value);
				cmb.value = '';
			}

			function combPay_chg() {
			}

			function combAddr_chg() {
				if (q_cur == 1 || q_cur == 2) {
					$('#txtAddr_post').val($('#combAddr').find("option:selected").text());
					$('#txtZip_post').val($('#combAddr').find("option:selected").val());
				}
			}

			function bbsAssign() {
				for (var j = 0; j < q_bbsCount; j++) {
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#txtWeight_' + j).change(function() {
							sum();
						});
					}
				}
				_bbsAssign();
				HiddenTreat();
			}

			function btnIns() {
				_btnIns();
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
				var t_where = "where=^^ 1=0 ^^ stop=100";
				q_gt('custaddr', t_where, 0, 0, 0, "");
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtDatea').focus();

				if (!emp($('#txtCustno').val())) {
					var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^ stop=100";
					q_gt('custaddr', t_where, 0, 0, 0, "");
				}
			}

			function btnPrint() {
				t_where = "noa='" + $('#txtNoa').val() + "'";
				q_box("z_vccep.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, '', "95%", "95%", q_getMsg('popPrint'));
			}

			function wrServer(key_value) {
				var i;

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['product']) {
					as[bbsKey[1]] = '';
					return;
				}

				q_nowf();
				as['datea'] = abbm2['datea'];
				as['custno'] = abbm2['custno'];

				return true;
			}

			function sum() {
                var t_money=0, t_tax = 0, t_total = 0;
                for (var j = 0; j < q_bbsCount; j++) {
                    t_money = q_add(t_money, dec(q_float('txtTotal_' + j)));
                }
                if($('#chkAtax').prop('checked')){
                    var t_taxrate = q_div(parseFloat(q_getPara('sys.taxrate')), 100);
                    t_tax = round(q_mul(t_money, t_taxrate), 0);
                    t_total = q_add(t_money, t_tax);
                }else{
                    t_tax = q_float('txtTax');
                    t_total = q_add(t_money, t_tax);
                }
                $('#txtMoney').val(t_money);
                $('#txtTax').val(t_tax);
                $('#txtTotal').val(t_total);
            }

			function refresh(recno) {
				_refresh(recno);
				HiddenTreat();
				ChangeCuft();
			}
			
			function ChangeCuft(){
				if(emp($('#txtNoa').val())){
					$('#textCuft').val('');
				}else{
					var t_where = "where=^^ noa='" + $('#txtNoa').val()+ "' ^^";
					q_gt('packing', t_where, 0, 0, 0, "");
				}
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
				if($('#cmbStype').val()=='3'){
					$('.isexport').show();
					if(q_getPara('sys.isport')=='1'){ //外銷
						$('.isport').show();
					}
				}else{
					$('.isexport').hide();
					$('.isport').hide();
				}
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				HiddenTreat();
				if (t_para) {
					$('#btnBoaj').removeAttr('disabled');
					$('#btnToinvo').removeAttr('disabled');
					$('#btnTovcc').removeAttr('disabled');
					$('#btnPack').removeAttr('disabled');
					$('#combAddr').attr('disabled', 'disabled');
				} else {
					$('#btnBoaj').attr('disabled', 'disabled');
					$('#btnToinvo').attr('disabled', 'disabled');
					$('#btnTovcc').attr('disabled', 'disabled');
					$('#btnPack').attr('disabled', 'disabled');
					$('#combAddr').removeAttr('disabled');
				}
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

			function q_popPost(s1) {
				switch (s1) {
					case 'txtCustno':
						if (!emp($('#txtCustno').val())) {
							var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^ stop=100";
							q_gt('custaddr', t_where, 0, 0, 0, "");
						}
						break;
				}
			}

		</script>
		<style type="text/css">
			#dmain {
			}
			.dview {
				float: left;
				width: 28%;
			}
			.tview {
				margin: 0;
				padding: 2px;
				border: 1px black double;
				border-spacing: 0;
				font-size: medium;
				background-color: #FFFF66;
				color: blue;
				width: 100%;
			}
			.tview td {
				padding: 2px;
				text-align: center;
				border: 1px black solid;
			}
			.dbbm {
				float: left;
				width: 68%;
				margin: -1px;
				border: 1px black solid;
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
				/*width: 9%;*/
			}
			.tbbm .tdZ {
				width: 3%;
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
				font-size: medium;
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			.txt.c1 {
				width: 97%;
				float: left;
			}
			.txt.c2 {
				width: 14%;
				float: left;
			}
			.txt.c3 {
				width: 26%;
				float: left;
			}
			.txt.c4 {
				width: 25%;
				float: left;
			}
			.txt.c5 {
				width: 60%;
				float: left;
			}
			.txt.c6 {
				width: 25%;
			}
			.txt.c7 {
				width: 98%;
				float: left;
			}
			.txt.c8 {
				float: left;
				width: 65px;
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
				float: left;
				width: auto;
			}
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
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
			.tbbs tr.error input[type="text"] {
				color: red;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.tbbs {
				FONT-SIZE: medium;
				COLOR: blue;
				TEXT-ALIGN: left;
				BORDER: 1PX LIGHTGREY SOLID;
				width: 100%;
				height: 98%;
			}

			.tbbs .td1 {
				width: 4%;
			}
			.tbbs .td2 {
				width: 6%;
			}
			.tbbs .td3 {
				width: 8%;
			}
			.tbbs .td4 {
				width: 2%;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="width: 1260px;">
			<div class="dview" id="dview" style="float: left;  width:32%;"  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:25%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:30%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:35%"><a id='vewComp'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='comp,4'>~comp,4</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 68%;float:left">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
					<tr class="tr0" style="height: 0px;">
						<td class="td1" style="width: 105px;"> </td>
						<td class="td2" style="width: 105px;"> </td>
						<td class="td4" style="width: 105px;"> </td>
						<td class="td5" style="width: 105px;"> </td>
						<td class="td5" style="width: 105px;"> </td>
						<td class="td3" style="width: 105px;"> </td>
						<td class="td4" style="width: 130px;"> </td>
						<td class="td6" style="width: 105px;"> </td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td class="td2"><input id="txtDatea"  type="text" class="txt c1"/></td>
						<td class="td4"><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td class="td5" colspan="2"><input id="txtNoa"  type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id="lblStype" class="lbl"> </a></td>
						<td class="td4"><select id="cmbStype" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblAcomp" class="lbl btn"> </a></td>
						<td class="td2"><input id="txtCno"  type="text" class="txt c1"/></td>
						<td class="td3" colspan="3"><input id="txtAcomp"  type="text" class="txt c7"/></td>
						<td class="td1"><span> </span><a id="lblCaseno2" class="lbl btn">出貨單號</a></td>
                        <td class="td2"><input id="txtCaseno2"  type="text" class="txt c1"/></td>
                        <td class="td6"><input id="btnVccimport" type="button" value="匯入"/></td>
					</tr>
					<tr>
					    <td class="td6"><span> </span><a id="lblOdate_bq" class="lbl">交貨日期</a></td>
                        <td class="td7"><input id="txtOdate"  type="text" class="txt c1"/></td>
                        <td class="td3"><span> </span><a id="lblOrdeno" class="lbl"> </a></td>
                        <td class="td4" colspan="2"><input id="txtOrdeno"  type="text" class="txt c1"/></td>
                        <td class="td3"><span> </span><a id="lblFax_bq" class="lbl">合約號碼</a></td>
                        <td class="td4" colspan="2"><input id="txtFax"  type="text" class="txt c1"/></td>
                    </tr>
					<tr>
						<td class="td1"><span> </span><a id="lblCustno" class="lbl btn"> </a></td>
						<td class="td2"><input id="txtCustno"  type="text" class="txt c1"/></td>
						<td class="td3" colspan="3"><input id="txtComp"  type="text" class="txt c7"/></td>
						<!--<td class="td4"><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td class="td5"><input id="txtPaytype" type="text" class="txt c1"/></td>
						<td class="td6"><select id="combPaytype" class="txt c1" onchange='combPaytype_chg();'> </select></td>-->
					    <td class="td5"><span> </span><a id="lblTel" class="lbl"> </a></td>
                        <td class="td6"><input id="txtTel"  type="text" class="txt c7"/></td>
                        <td class="td6"><input id="btnBoaj" type="button" class="isexport"/></td>
					</tr>
					<!--<tr>
						<td class="td1"><span> </span><a id="lblFax" class="lbl"> </a></td>
						<td class="td2" colspan="2"><input id="txtFax"  type="text" class="txt c7"/></td>
					</tr>-->
					<tr>
						<td class="td1"><span> </span><a id="lblAddr_post" class="lbl"> </a></td>
						<td class="td2" colspan="4">
							<input id="txtZip_post"  type="text" class="txt c7" style="width: 25%;"/>
							<input id="txtAddr_post"  type="text" class="txt c7" style="width: 68%;"/>
							<select id="combAddr" style="width: 20px" onchange='combAddr_chg();'> </select>
						</td>
						<td class="td1"><span> </span><a id="lblSales_bq" class="lbl btn">檢驗員</a></td>
                        <td class="td2"><input id="txtSalesno"  type="text" class="txt c1"/></td>
                        <td class="td3"><input id="txtSales"  type="text" class="txt c1"/></td>
						<!--<td class="td3"><span> </span><a id="lblTrantype" class="lbl"> </a></td>
						<td class="td4" colspan="2"><select id="cmbTrantype" class="txt c1"> </select></td>-->
					</tr>
					<tr>
					    <td class="td1"><span> </span><a id="lblCardeal_bq" class="lbl btn">知會單位</a></td>
                        <td class="td3" colspan="7"><input id="txtCardeal"  type="text" class="txt c1"/></td>
						<!--<td class="td6"><span> </span><a id="lblConn" class="lbl"> </a></td>
						<td class="td7" colspan="2"><input id="txtConn"  type="text" class="txt c1"/></td>-->
					</tr>
					<tr>
                        <td class="td1"><span> </span><a id="lblDeivery_bq_addr" class="lbl">品管</a></td>
                        <td class="td2" colspan="7"><input id="txtDeivery_addr"  type="text" class="txt c1"/></td>
                        <!--<td class="td6"><span> </span><a id="lblConn" class="lbl"> </a></td>
                        <td class="td7" colspan="2"><input id="txtConn"  type="text" class="txt c1"/></td>-->
                    </tr>
					<tr>
                        <td class="td6"><span> </span><a id="lblSpec_bq" class="lbl">資材</a></td>
                        <td class="td7" colspan="7"><input id="txtSpec"  type="text" class="txt c1"/></td>
                    </tr>
					<tr>
                        <td class="td1"><span> </span><a id="lblMoney" class="lbl">金額</a></td>
                        <td class="td2" colspan='2'><input id="txtMoney" type="text" class="txt num c1"/></td>
                        <td class="td4"><span> </span><a id='lblTax' class="lbl">營業稅</a></td>
                        <td class="td5">
                            <input id="txtTax" type="text" class="txt num c1 istax"  style="width: 80%;"/>
                            <input id="chkAtax" type="checkbox" />
                        </td>
                        <td class="td6"><span> </span><a id='lblTotal_bq' class="lbl istax">總計</a></td>
                        <td class="td7"><input id="txtTotal" type="text" class="txt num c1 istax"/></td>
                    </tr>
					<tr class="isexport">
						<td class="td1"><span> </span><a id="lblInvo" class="lbl btn"> </a></td>
						<td class="td2" colspan="2"><input id="txtInvo"  type="text" class="txt c1"/></td>
						<td class="td4 isport" style="display: none;"><input id="btnToinvo" type="button" value="轉Invoice" /></td>
						<td class="td5 isport" style="display: none;"> </td>
						<td class="td4"><span> </span><a id="lblEtcdate" class="lbl">E.T.C</a></td>
                        <td class="td5" colspan="2"><input id="txtEtcdate"  type="text" class="txt c1" style="width: 50%;"/>
                        <input id="txtEtctime"  type="text" class="txt c1" style="width: 30%;"/>
                        </td>
					</tr>
					<tr class="isexport">
					    <td class="td1"><span> </span><a id="lblLcno" class="lbl"> </a></td>
                        <td class="td2" colspan="2"><input id="txtLcno"  type="text" class="txt c1"/></td>
                        <td class="td4"><span> </span><a id="lblDate2" class="lbl">packing 寄出日</a></td>
                        <td class="td5"><input id="txtDate2"  type="text" class="txt c1"/></td>
                        <td class="td6"><span> </span><a id="lblDate1" class="lbl">invoice 寄出日</a></td>
                        <td class="td7"><input id="txtDate1"  type="text" class="txt c1"/></td>
                    </tr>
                    <tr class="isexport">
                        <td class="td6"><span> </span><a id="lblBill" class="lbl">提單</a></td>
                        <td class="td7" colspan="2"><input id="txtBill"  type="text" class="txt c1"/></td>
                        <td class="td6"><span> </span><a id="lblCo" class="lbl">產證</a></td>
                        <td class="td7" colspan="2"><input id="txtCo"  type="text" class="txt c1"/></td>
                    </tr>
					<tr class="isexport">
						<td class="td1"><span> </span><a id="lblImemo" class="lbl"> </a></td>
						<td class="td2" colspan="8"><textarea id="txtImemo" cols="5" rows="10" style="width: 99%;height: 50px;"> </textarea></td>
					</tr>
					<tr class="isexport">
						<td class="td1"><span> </span><a id="lblPmemo" class="lbl"> </a></td>
						<td class="td2" colspan="8"><textarea id="txtPmemo" cols="5" rows="10" style="width: 99%;height: 50px;"> </textarea></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td class="td2" colspan="8"><textarea id="txtMemo" cols="5" rows="10" style="width: 99%;height: 50px;"> </textarea></td>
					</tr>
					<tr>
						<td class="isexport"><span> </span><a id="lblCuft" class="lbl"> </a></td>
						<td class="isexport"><input id="textCuft"  type="text" class="txt c1 num "/></td>
						<td class="isexport"><input id="btnPack" type="button"/> </td>
						<td class="td5"><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td class="td6"><input id="txtWorker" type="text" class="txt c1" /></td>
						<td class="td7"><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td class="td8"><input id="txtWorker2" type="text" class="txt c1" /></td>
					</tr>
				</table>
			</div>
			<div class='dbbs' >
				<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
					<tr style='color:White; background:#003366;' >
						<td align="center">
							<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
						</td>
						<td align="center" style="width:120px;"><a id='lblProductno_s'> </a></td>
						<td align="center" style="width:40px;"><a id='lblUnit_s'> </a></td>
						<td align="center" style="width:75px;"><a id='lblEweight_bq_s'>單重</a></td>
						<td align="center" style="width:65px;"><a id='lblMount_s'> </a></td>
						<td align="center" style="width:65px;"><a id='lblWeight_s'> </a></td>
						<td align="center" style="width:80px;"><a id='lblPrice_s'>金額</a></td>
						<td align="center" style="width:70px;"><a id='lblOdate_bq_s'>訂單日期</a></td>
						<td align="center" style="width:100px;"><a id='lblRackno_bq_s'>物品ID</a></td>
						<td align="center" style="width:20px;"><a id='lblEnds_s'> </a></td>
						<td align="center" style="width:100px;"><a id='lblStoreno_s'> </a></td>
						<td align="center" style="width:100px;"><a id='lblMemo_s'> </a></td>
					</tr>
					<tr style='background:#cad3ff;'>
						<td style="width:1%;">
							<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
							<input id="txtNoq.*" type="text" style="display:none;"/>
						</td>
						<td>
							<input class="txt c1" id="txtProductno.*" type="text"  style="width: 80%;"/>
							<input class="btn"  id="btnProduct.*" type="button" value='.' style=" font-weight: bold;" />
							<input class="txt c1" id="txtProduct.*" type="text" />
						</td>
						<td><input class="txt c1" id="txtUnit.*" type="text" /></td>
						<td><input class="txt num c1" id="txtEweight.*" type="text"/></td>
						<td><input class="txt num c1" id="txtMount.*" type="text"/></td>
						<td><input class="txt num c1" id="txtWeight.*" type="text"/></td>
						<td><input class="txt num c1" id="txtPrice.*" type="text"/></td>
						<td><input class="txt c1" id="txtOdate.*" type="text" /></td>
						<td><input class="txt c1" id="txtRackno.*" type="text"></td>
						<td align="center"><input id="chkEnda.*" type="checkbox"/></td>
						<td>
							<input id="txtStoreno.*" type="text" class="txt c1" style="width: 75%"/>
							<input class="btn"  id="btnStoreno.*" type="button" value='.' style=" font-weight: bold;" />
							<input id="txtStore.*" type="text" class="txt c1"/>
						</td>						
						<td><input class="txt c1" id="txtMemo.*" type="text" /></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>