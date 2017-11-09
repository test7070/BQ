<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
    <head>
        <title></title>
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

            qBoxNo3id = -1;
            q_desc = 1;
            q_tables = 't';
            var q_name = "orde";
            var q_readonly = ['txtApv', 'txtWorker', 'txtWorker2', 'txtComp', 'txtAcomp', 'txtMoney', 'txtTax', 'txtTotal', 'txtTotalus', 'txtWeight', 'txtSales'];
            var q_readonlys = ['txtTotal', 'txtQuatno', 'txtNo3', 'txtTheory', 'txtC1', 'txtNotv'];
            var q_readonlyt = ['txtTotal', 'txtQuatno', 'txtTheory'];
            var bbmNum = [['txtMoney', 10, 0, 1], ['txtTax', 10, 0, 1], ['txtTotal', 10, 0, 1],['txtWeight', 10, 2, 1]];
            // 允許 key 小數
            var bbsNum = [['txtPrice', 15, 3, 1],['txtTotal', 12, 2, 1, 1], ['txtWeight', 10, 2, 1], ['txtMount', 10, 2, 1]];
            var bbtNum = [['txtMount', 10, 2, 1], ['txtWeight', 10, 3, 1]];
            var bbmMask = [];
            var bbsMask = [['txtStyle', 'A']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            //ajaxPath = ""; // 只在根目錄執行，才需設定
            aPop = new Array(
            ['txtCustno', 'lblCust', 'cust', 'noa,comp,nick,paytype,trantype,tel,fax,zip_comp,addr_comp', 'txtCustno,txtComp,txtNick,txtPaytype,cmbTrantype,txtTel,txtFax,txtPost,txtAddr', 'cust_b.aspx']
            , ['txtProductno__', 'btnProductno__', 'assignproduct', 'noa,product', 'txtProductno__,txtProduct__', 'ucc_b.aspx']);
            brwCount2 = 12;
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'no2'];
                bbtKey = ['noa', 'no2'];
                $('#dbbt').hide();
                $('#btnBBTShow').click(function() {
                    $('#dbbt').toggle();
                });

                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
            });

            function main() {
                if (dataErr)// 載入資料錯誤
                {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }

            function sum() {
               
            }
            function mainPost() {// 載入資料完，未 refresh 前
                q_getFormat();
                bbmMask = [['txtDatea', r_picd], ['txtOdate', r_picd]];
                bbsMask = [['txtDatea', r_picd],['txtStyle','A']];
                q_mask(bbmMask);
                q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
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
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }
            function btnOk() { 
                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);
                    
                sum();
                
                if (s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_orde') + $('#txtOdate').val(), '/', ''));
                else
                    wrServer(s1);
            }
            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('ordest_s.aspx', q_name + '_s', "550px", "700px", q_getMsg("popSeek"));
            }

            function bbtAssign() {
                for (var j = 0; j < q_bbtCount; j++) {
                    $('#lblNo__' + j).text(j + 1);
                }
                _bbtAssign();
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
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                sum();
            }

            function btnPrint() {
                //t_where = "noa='" + $('#txtNoa').val() + "'";
                //q_box("z_ordestp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, '', "95%", "95%", q_getMsg('popPrint'));
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbtSave(as) {
                if (!as['productno'] && !as['product']) {
                    as[bbtKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function bbsSave(as) {
                if (!as['productno'] && !as['product'] && !as['spec'] && !dec(as['total'])) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['noa'] = abbm2['noa'];
                if (!emp(abbm2['datea']))/// 預交日
                    as['datea'] = abbm2['datea'];
                as['custno'] = abbm2['custno'];
                if (!as['enda'])
                    as['enda'] = '0';
                t_err = '';
                if (t_err) {
                    alert(t_err);
                    return false;
                }
                return true;
            }
            function refresh(recno) {
                _refresh(recno);
            }

            function q_popPost(s1) {
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

            function btnPlut2(org_htm, dest_tag, afield) {
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
           
            function FormatNumber(n) {
                var xx = "";
                if (n < 0) {
                    n = Math.abs(n);
                    xx = "-";
                }
                n += "";
                var arr = n.split(".");
                var re = /(\d{1,3})(?=(\d{3})+$)/g;
                return xx + arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
            }
        </script>
        <style type="text/css">
            #dmain {
                /*overflow: hidden;*/
                
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
            .tbbm tr td span {
                float: right;
                display: block;
                width: 5px;
                height: 10px;
            }
            .tbbm tr td .lbl {
                float: right;
                color: black;
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
            }
            .dbbs {
                width: 1300px;
            }
            .tbbs a {
                font-size: medium;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            select {
                font-size: medium;
            }
            #dbbt {
                width: 1200px;
            }
            #tbbt {
                margin: 0;
                padding: 2px;
                border: 2px pink double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: pink;
                width: 100%;
            }
            #tbbt tr {
                height: 35px;
            }
            #tbbt tr td {
                text-align: center;
                border: 2px pink double;
            }
        </style>
    </head>
    <body ondragstart="return false" draggable="false"
    ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
    ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    >
        <div style="overflow: auto;display:block;width:1050px;">
            <!--#include file="../inc/toolbar.inc"-->
        </div>
        <div style="overflow: auto;display:block;width:1280px;">
            <div class="dview" id="dview" style="float:left;width:30%;border-width:0px;">
                <table class="tview" id="tview">
                    <tr>
                        <td align="center" style="width:5% color:black;"><a id="vewChk"> </a></td>
                        <td align="center" style="width:25%; color:black;"><a id="vewOdate"> </a></td>
                        <td align="center" style="width:25%; color:black;"><a id="vewNoa"> </a></td>
                        <td align="center" style="width:40%; color:black;"><a id="vewNick"> </a></td>
                    </tr>
                    <tr>
                        <td><input id="chkBrow.*" type="checkbox"/></td>
                        <td id="odate" style="text-align: center;">~odate</td>
                        <td id="noa" class="control_noa" style="text-align: center;">~noa</td>
                        <td id="nick" style="text-align: center;">~nick</td>
                    </tr>
                </table>
            </div>
            <div class="dbbm">
                <table class="tbbm"  id="tbbm">
                    <tr style="height:1px;">
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td class="tdZ"></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblOdate' class="lbl"> </a></td>
                        <td>
                        <input id="txtOdate"  type="text"  class="txt c1"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblNoa' class="lbl"> </a></td>
                        <td colspan="2">
                        <input id="txtNoa"   type="text" class="txt c1"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblCust' class="lbl btn"> </a></td>
                        <td colspan="4">
                        <input id="txtCustno" type="text" style="float:left;width:25%;"/>
                        <input id="txtComp" type="text" style="float:left;width:75%;"/>
                        <input id="txtNick" type="text" style="display:none;"/>
                        </td>
                        <td><span> </span><a id='lblContract' class="lbl"> </a></td>
                        <td colspan="2">
                        <input id="txtContract"  type="text" class="txt c1"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblTel' class="lbl"> </a></td>
                        <td colspan='2'>
                        <input id="txtTel" type="text" class="txt c1"/>
                        </td>
                        <td><span> </span><a id='lblFax' class="lbl"> </a></td>
                        <td colspan="2">
                        <input id="txtFax" type="text" class="txt c1" />
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblAddr' class="lbl"> </a></td>
                        <td colspan="4">
                            <input id="txtPost"  type="text" style="float:left;width:25%;"/>
                            <input id="txtAddr"  type="text" style="float:left;width:75%;" />
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblAddr2' class="lbl"> </a></td>
                        <td colspan="4">
                              <input id="txtAddr2"  type="text" style="float:left;width:99%;" />
                        </td>
                      
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblWeight' class="lbl"> </a></td>
                        <td><input id="txtWeight"  type="text" class="txt num c1"/></td>
                        <td><span> </span><a id='lblMoney' class="lbl"> </a></td>
                        <td><input id="txtMoney" type="text" class="txt num c1" /></td>
                        <td><span> </span><a id='lblTax' class="lbl"> </a></td>
                        <td><input id="txtTax" type="text" class="txt c1 num"/></td>
                        <td><select id="cmbTaxtype" class="txt c1" onchange='sum()'> </select></td>
                        <td><span> </span><a id='lblTotal' class="lbl"> </a></td>
                        <td>
                        <input id="txtTotal" type="text" class="txt num" style="float:left;width:99%;"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblMemo' class="lbl"> </a></td>
                        <td colspan='6' >
                            <input id="txtMemo" type="text" style="width: 99%;"/>
                        </td>
                        <td align="center" ><input id="btnBBTShow" type="button" /></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblWorker' class="lbl"> </a></td>
                        <td>
                        <input id="txtWorker"  type="text" class="txt c1"/>
                        </td>
                        <td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
                        <td>
                        <input id="txtWorker2"  type="text" class="txt c1"/>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div class='dbbs'>
            <table id="tbbs" class='tbbs' style=' text-align:center'>
                <tr style='color:white; background:#003366;' >
                    <td  align="center" style="width:30px;">
                    <input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
                    </td>
                    <td align="center" style="width:20px;"> </td>
                    <td align="center" style="width:120px;"><a id='lblProductno'> </a></td>
                    <td align="center" style="width:120px;"><a id='lblProduct_s'> </a>	</td>
                    <td align="center" style="width:150px;"><a id='lblSize_st'> </a></td>
                    <td align="center" style="width:50px;"><a id='lblUnit'> </a></td>
                    <td align="center" style="width:80px;"><a id='lblMount'> </a></td>
                    <td align="center" style="width:60px;"><a id='lblPrices'> </a></td>
                    <td align="center" style="width:80px;"><a id='lblGweight'> </a></td>
                    <td align="center" style="width:80px;"><a id='lblTotals'> </a><br></a></td>
                    <td align="center" style="width:80px;"><a id='lblGemounts'> </a><br><a id='lblNotv'> </a></td>
                    <td align="center" style="width:80px;"><a id='lblDateas'> </a></td>
                    <td align="center" style="width:43px;"><a id='lblEndas'> </a></td>
                    <td align="center" style="width:100px;"><a id='lblMemos_bq'>備註</a></td>
                </tr>
                <tr style='background:#cad3ff;'>
                    <td align="center">
                        <input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
                    </td>
                    <td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
                    
                    <td>
                        <input type="text" id="txtProductno.*"  style="width:95%; float:left;"/>
                        <input class="btn" id="btnProduct.*" type="button" value='.' style=" font-weight: bold;" />
                        <input id="txtNo2.*" type="text" class="txt" style="width:40px;" />
                    </td>
                    <td><input id="txtProduct.*" type="text" style="float:left;width:93%;"/></td>
                    <td><input id="txtSpec.*" type="text" style="float:left;width:95%;"/></td>
                    <td><input  id="txtUnit.*" type="text" style="width:90%;"/></td>
                    <td><input id="txtMount.*" type="text" class="txt num" style="width:95%;"/></td>
                    <td><input id="txtGweight.*" type="text"  class="txt num" style="width:95%;"/></td>
                    <td><input id="txtPrice.*" type="text"  class="txt num" style="width:95%;"/></td>
                    <td><input id="txtTotal.*" type="text" class="txt num" style="width:95%;"/></td>
                    <td>
                        <input class="txt num " id="txtC1.*" type="text" style="width:95%;"/>
                        <input class="txt num " id="txtNotv.*" type="text" style="width:95%;"/>
                    </td>
                    <td ><input class="txt " id="txtDatea.*" type="text" style="width:95%;"/></td>
                    <td align="center"><input id="chkEnda.*" type="checkbox"/></td>
                    <td ><input id="txtMemo.*" type="text" style="width:95%; float:left;"/></td>
                </tr>
            </table>
        </div>
        <div id="dbbt">
            <table id="tbbt" class='tbbt'  border="2"  cellpadding='2' cellspacing='1'>
                <tr style='color:white; background:#003366;' >
                    <td class="td1" align="center" style="width:1%; max-width:20px;">
                    <input class="btn"  id="btnPlut" type="button" value='+' style="font-weight: bold;"  />
                    </td>
                    <td align="center" style="width:20px;"></td>
                    <td class="td3" align="center" style="width:40px;"><a id='lblNo3'>訂序</a></td>
                    <td class="td3" align="center" style="width:120px;"><a id='lblProduct_t'></a></td>
                    <td class="td4" align="center" style="width:120px;"><a id='lblProductno_t'></a></td>
                    <td class="td8" align="center" style="width:80px;"><a id='lblOrdmount_t'></a></td>
                    <td class="td8" align="center" style="width:80px;"><a id='lblMount_t'></a></td>
                    <td class="td9" align="center" style="width:120px;"><a id='lblWeight_t'></a></td>
                    <td class="td9" align="center" style="width:90px;"><a id='lblUnit_t'></a></td>
                    <td class="td10" align="center" style="width:90px;"><a id='lblSource_t'></a></td>
                    <td class="td10" align="center" style="width:30px;"><a id='lblCancel_t'></a></td>
                    <td class="td10" align="center" style="width:30px;"><a id='lblSale_t'></a></td>
                </tr>
                <tr>
                    <td class="td1" align="center">
                    <input class="txt c1"  id="txtNoa..*" style="display:none;"/>
                    <input class="btn"  id="btnMinut..*" type="button" value='-' style="font-weight: bold; "  />
                    </td>
                    <td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
                    <td>
                    <input class="txt" id="txtNo3..*" type="text" style="width:95%;"  />
                    <input class="txt" id="txtNo2..*" type="text" style="display:none;"  />
                    </td>
                    <td class="td2">
                    <input class="txt c1" id="txtProductno..*" type="text" style="float:left;width:80%;" />
                    </td>
                    <td class="td3">
                    <input class="txt" id="txtProduct..*" type="text" style="width:75%;"  />
                    </td>
                    <td class="td4">
                    <input class="txt" id="txtOrdmount..*" type="text" style="width:95%;"  />
                    </td>
                    <td class="td5">
                    <input class="txt" id="txtMount..*" type="text" style="width:95%; text-align: right;"  />
                    </td>
                     <td class="td6">
                    <input class="txt" id="txtWeight..*" type="text" style="width:95%; text-align: right;"  />
                    </td>
                     <td class="td7">
                    <input class="txt" id="txtUnit..*" type="text" style="width:95%; text-align: right;"  />
                    </td>
                     <td class="td8">
                    <input class="txt" id="txtSource..*" type="text" style="width:95%; text-align: right;"  />
                    </td>
                    <td align="center">
                    <input id="chkCancel..*" type="checkbox"/>
                    </td>
                    <td align="center">
                    <input id="chkSale..*" type="checkbox"/>
                    </td>
                </tr>
            </table>
        </div>

        <input id="q_sys" type="hidden" />
    </body>
</html>
