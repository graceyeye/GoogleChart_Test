<!DOCTYPE html>
<html>
<head>
<title>TNT PROJECT</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript"
    src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script type="text/javascript"
    src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">
    var queryObject = "";
    var queryObjectLen = "";
    $.ajax({
        type : 'POST',
        url : 'bardata.jsp',
        dataType : 'json',
        success : function(data) {
            queryObject = eval('(' + JSON.stringify(data) + ')');
            // stringify : 인자로 전달된 자바스크립트의 데이터를 문자열로 바꾸기.   
            // eval: javascript 코드가 맞는지 검증하고 문자열을 자바스크립트 코드로 처리하는 함수 
            //queryObject.empdetails[0].name ="leeyeye" , queryObject.empdetails[0].empid ="10";
 
            queryObjectLen = queryObject.barlist.length;
            // queryObject.empdetails 에는 6개의 Json 객체가 있음 
 
            //alert('ㅋㅋ' + queryObjectLen);
            // alert(queryObject.barlist[0].city +queryObject.barlist[0].per );
        },
        error : function(xhr, type) {
            alert('server error occoured')
        }
    });
 
    google.charts.load('current', {
        packages : [ 'corechart', 'bar' ]
    });
    google.charts.setOnLoadCallback(drawMultSeries);
 
    function drawMultSeries() {
        
         var data = new google.visualization.DataTable();
         data.addColumn('string', 'city');
         data.addColumn('number', 'amount');
         data.addColumn('number', 'per');
 
        alert('data생성');
        for (var i = 0; i < queryObjectLen; i++) {
            var city = queryObject.barlist[i].city;
            var amount = queryObject.barlist[i].amount;
            var per = queryObject.barlist[i].per;
            alert(city + amount + per);
             data.addRows([
                            [city,amount,per]
                        ]);
 
        }
 
        var options = {
            title : 'TNT Test',
            chartArea : {
                width : '50%'
            },
            hAxis : {
                title : 'TNT TEST IMPORMATION',
                minValue : 0
            },
            vAxis : {
                title : 'City'
            }
        };
        var chart = new google.visualization.BarChart(document
                .getElementById('chart_div'));
        chart.draw(data, options);
    }
</script>
</head>
<body>
    <div id="chart_div"></div>
 
</body>
</html>