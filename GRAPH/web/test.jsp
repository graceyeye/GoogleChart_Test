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
<%@page import="org.json.JSONObject"%>

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

	
	//모든차트 한번에 읽기
	google.charts.load('current', {
		'packages' : [ 'corechart', 'bar', 'annotationchart','geochart','line','wordtree' ]
	});
	google.charts.setOnLoadCallback(drawMultSeries);

	function drawMultSeries() {

		var data = new google.visualization.DataTable();
		data.addColumn('string', 'city');
		data.addColumn('number', 'amount');
		data.addColumn('number', 'per');

		//alert('data생성');
		for (var i = 0; i < queryObjectLen; i++) {
			var city = queryObject.barlist[i].city;
			var amount = queryObject.barlist[i].amount;
			var per = queryObject.barlist[i].per;
			// alert(city + amount + per);
			data.addRows([ [ city, amount, per ] ]);

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

	/////////차트 2
	google.charts.setOnLoadCallback(drawChart);
	function drawChart() {
		var data = new google.visualization.DataTable();
		data.addColumn('date', 'Date');
		data.addColumn('number', 'Kepler-22b mission');
		data.addColumn('string', 'Kepler title');
		data.addColumn('string', 'Kepler text');
		data.addColumn('number', 'Gliese 163 mission');
		data.addColumn('string', 'Gliese title');
		data.addColumn('string', 'Gliese text');
		data.addRows([
				[ new Date(2314, 2, 15), 12400, undefined, undefined, 10645,
						undefined, undefined ],
				[ new Date(2314, 2, 16), 24045, 'Lalibertines',
						'First encounter', 12374, undefined, undefined ],
				[ new Date(2314, 2, 17), 35022, 'Lalibertines',
						'They are very tall', 15766, 'Gallantors',
						'First Encounter' ],
				[ new Date(2314, 2, 18), 12284, 'Lalibertines',
						'Attack on our crew!', 34334, 'Gallantors',
						'Statement of shared principles' ],
				[ new Date(2314, 2, 19), 8476, 'Lalibertines',
						'Heavy casualties', 66467, 'Gallantors',
						'Mysteries revealed' ],
				[ new Date(2314, 2, 20), 0, 'Lalibertines', 'All crew lost',
						79463, 'Gallantors', 'Omniscience achieved' ] ]);

		var chart = new google.visualization.AnnotationChart(document
				.getElementById('chart_div2'));

		var options = {
			displayAnnotations : true
		};

		chart.draw(data, options);
	}

	/////////////차트 3

	google.charts.setOnLoadCallback(drawVisualization);

	function drawVisualization() {
		// Some raw data (not necessarily accurate)
		var data = google.visualization.arrayToDataTable([
				[ 'Month', 'Bolivia', 'Ecuador', 'Madagascar',
						'Papua New Guinea', 'Rwanda', 'Average' ],
				[ '2004/05', 165, 938, 522, 998, 450, 614.6 ],
				[ '2005/06', 135, 1120, 599, 1268, 288, 682 ],
				[ '2006/07', 157, 1167, 587, 807, 397, 623 ],
				[ '2007/08', 139, 1110, 615, 968, 215, 609.4 ],
				[ '2008/09', 136, 691, 629, 1026, 366, 569.6 ] ]);

		var options = {
			title : 'Monthly Coffee Production by Country',
			vAxis : {
				title : 'Cups'
			},
			hAxis : {
				title : 'Month'
			},
			seriesType : 'bars',
			series : {
				5 : {
					type : 'line'
				}
			}
		};

		var chart = new google.visualization.ComboChart(document
				.getElementById('chart_div3'));
		chart.draw(data, options);
	}
	
	
	
	
	/////////////차트4 Geo chart
	 google.charts.setOnLoadCallback(drawRegionsMap);

      function drawRegionsMap() {

        var data = google.visualization.arrayToDataTable([
          ['Country', 'Popularity'],
          ['Germany', 200],
          ['United States', 300],
          ['Brazil', 400],
          ['Canada', 500],
          ['France', 600],
          ['RU', 700]
        ]);

        var options = {};

        var chart = new google.visualization.GeoChart(document.getElementById('regions_div'));

        chart.draw(data, options);
      }
      
      
      
      ///////////////////차트5 Intervals
      
      google.charts.setOnLoadCallback(drawChart2);

      function drawChart2() {
        var data = new google.visualization.DataTable();
        data.addColumn('number', 'x');
        data.addColumn('number', 'values');
        data.addColumn({id:'i0', type:'number', role:'interval'});
        data.addColumn({id:'i1', type:'number', role:'interval'});
        data.addColumn({id:'i2', type:'number', role:'interval'});
        data.addColumn({id:'i2', type:'number', role:'interval'});
        data.addColumn({id:'i2', type:'number', role:'interval'});
        data.addColumn({id:'i2', type:'number', role:'interval'});
  
        data.addRows([
            [1, 100, 90, 110, 85, 96, 104, 120],
            [2, 120, 95, 130, 90, 113, 124, 140],
            [3, 130, 105, 140, 100, 117, 133, 139],
            [4, 90, 85, 95, 85, 88, 92, 95],
            [5, 70, 74, 63, 67, 69, 70, 72],
            [6, 30, 39, 22, 21, 28, 34, 40],
            [7, 80, 77, 83, 70, 77, 85, 90],
            [8, 100, 90, 110, 85, 95, 102, 110]]);
  
        // The intervals data as narrow lines (useful for showing raw source data)
        var options_lines = {
            title: 'Line intervals, default',
            curveType: 'function',
            lineWidth: 4,
            intervals: { 'style':'line' },
            legend: 'none'
        };
  
        var chart_lines = new google.visualization.LineChart(document.getElementById('chart_lines'));
        chart_lines.draw(data, options_lines);
      }
      
      
      ///Linechart
          google.charts.setOnLoadCallback(drawChart4);

    function drawChart4() {

      var data = new google.visualization.DataTable();
      data.addColumn('number', 'Day');
      data.addColumn('number', 'Guardians of the Galaxy');
      data.addColumn('number', 'The Avengers');
      data.addColumn('number', 'Transformers: Age of Extinction');

      data.addRows([
        [1,  37.8, 80.8, 41.8],
        [2,  30.9, 69.5, 32.4],
        [3,  25.4,   57, 25.7],
        [4,  11.7, 18.8, 10.5],
        [5,  11.9, 17.6, 10.4],
        [6,   8.8, 13.6,  7.7],
        [7,   7.6, 12.3,  9.6],
        [8,  12.3, 29.2, 10.6],
        [9,  16.9, 42.9, 14.8],
        [10, 12.8, 30.9, 11.6],
        [11,  5.3,  7.9,  4.7],
        [12,  6.6,  8.4,  5.2],
        [13,  4.8,  6.3,  3.6],
        [14,  4.2,  6.2,  3.4]
      ]);

      var options = {
        chart: {
          title: 'Box Office Earnings in First Two Weeks of Opening',
          subtitle: 'in millions of dollars (USD)'
        },
        width: 900,
        height: 500,
        axes: {
          x: {
            0: {side: 'top'}
          }
        }
      };

      var chart = new google.charts.Line(document.getElementById('line_top_x'));

      chart.draw(data, options);
    }
    google.charts.setOnLoadCallback(drawChart5);

    function drawChart5() {
      var data = google.visualization.arrayToDataTable(
        [ ['Phrases'],
          ['cats are better than dogs'],
          ['cats eat kibble'],
          ['cats are better than hamsters'],
          ['cats are awesome'],
          ['cats are people too'],
          ['cats eat mice'],
          ['cats meowing'],
          ['cats in the cradle'],
          ['cats eat mice'],
          ['cats in the cradle lyrics'],
          ['cats eat kibble'],
          ['cats for adoption'],
          ['cats are family'],
          ['cats eat mice'],
          ['cats are better than kittens'],
          ['cats are evil'],
          ['cats are weird'],
          ['cats eat mice'],
        ]
      );

      var options = {
        wordtree: {
          format: 'implicit',
          word: 'cats'
        }
      };

      var chart = new google.visualization.WordTree(document.getElementById('wordtree_basic'));
      chart.draw(data, options);
    }
</script>
</head>
<body>
	<div id="chart_div"></div>
	<div id='chart_div2' style='width: 900px; height: 500px;'></div>
	  <div id="chart_div3" style="width: 900px; height: 500px;"></div>
	   <div id="regions_div" style="width: 900px; height: 500px;"></div>
	    <div id="chart_lines" style="width: 900px; height: 500px;"></div>
	    <div id="line_top_x"></div>

    <div id="wordtree_basic" style="width: 900px; height: 500px;"></div>

</body>
</html>