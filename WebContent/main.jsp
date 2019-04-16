<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="statics/jquery.min.js"></script>
<script src="statics/echarts.min.js"></script>
<script src="statics/china.js"></script>
</head>
<body>
	<div id="main" style="width: 100%; height: 570px;"></div>
	<script>
		var myChart = echarts.init(document.getElementById('main'));

		// 指定图表的配置项和数据
		var geoCoordMap = {
			"海门" : [ 121.15, 31.89 ],
			"鄂尔多斯" : [ 109.78, 39.60 ],
			"招远" : [ 120.38, 37.35 ]
		};

		var convertData = function(data) {
			var res = [];
			for (var i = 0; i < data.length; i++) {
				var geoCoord = geoCoordMap[data[i].name];
				if (geoCoord) {
					res.push({
						name : data[i].name,
						value : geoCoord.concat(data[i].value)
					});
				}
			}
			return res;
		};
		var option = {
			backgroundColor : '#404a59',
			title : {
				text : '人流量检测系统',
				subtext : 'data from python',
				left : 'center',
				textStyle : {
					color : '#fff'
				}
			},
			tooltip : {
				trigger : 'item',
				formatter : function(params) {
					 /* "componentType:" + params.componentType + "<br/>"
							+ "seriesType:" + params.seriesType + "<br/>"
							+ "seriesIndex:" + params.seriesIndex + "<br/>"
							+ "seriesName:" + params.seriesName + "<br/>"
							+ "name:" + params.name + "<br/>" + "dataIndex:"
							+ params.dataIndex + "<br/>" + "data:"
							+ params.data + "<br/>" + "value:" + params.value
							+ "<br/>" + "color:" + params.color + "<br/>" */
							
							return "地点 : "+params.name+"<br/>"+
							"坐标 : "+params.value[0]+","+params.value[1]+"<br/>"+
							"人流量 : "+params.value[2];
					/* return params.name+"<br>"+params.seriesName+" : "+params.value[2]+"<br/>"+"坐标 : "+params.value[0]+","+params.value[1]; */
				}
			},
			legend : {
				orient : 'vertical',
				top : 'bottom',
				left : 'right',
				data : [ '人流量' ],
				textStyle : {
					color : '#fff'
				}
			},
			visualMap : {
				min : 0,
				max : 300,
				calculable : true,
				color : [ '#CC0000', '#FFFFFF' ],
				textStyle : {
					color : '#fff'
				}
			},
			geo : {
				map : 'china',
				label : {
					emphasis : {
						show : false
					}
				},
				itemStyle : {
					normal : {
						areaColor : '#323c48',
						borderColor : '#111'
					},
					emphasis : {
						areaColor : '#2a333d'
					}
				}
			},
			series : [ {
				name : '人流量',
				type : 'scatter',
				coordinateSystem : 'geo',
				symbolSize : 10,
				label : {
					normal : {
						show : false
					},
					emphasis : {
						show : false
					}
				},
				itemStyle : {
					emphasis : {
						borderColor : '#fff',
						borderWidth : 4
					}
				}
			} ]
		};
		// 使用刚指定的配置项和数据显示图表。
		myChart.setOption(option);

		var list = [];
		$(function() {
			setInterval(function() {
				$.ajax({
					type : 'get',
					url : 'list',
					dataType : "json",
					success : function(result) {
						myChart.setOption({ //加载数据图表
							series : [ {
								// 根据名字对应到相应的系列
								data : convertData([ {
									name : result.name,
									value : result.value
								}]),
							} ]
						}); 
					},
					error : function(errorMsg) {
						//请求失败时执行该函数
						alert("图表请求数据失败!");
						myChart.hideLoading();
					}
				});
			}, 1000);
			
		});
	</script>
</body>
</html>