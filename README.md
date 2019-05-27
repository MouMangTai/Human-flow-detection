[代码已上传GitHub](https://github.com/MouMangTai/Human-flow-detection)

## 利用Echarts前端显示

Echarts([官网](https://echarts.baidu.com/index.html))是一款无敌酷炫的前端数据显示软件，可以显示各种表格、地图、甚至动态、3D方式的数据，功能强大而且开源，有兴趣可以研究研究。

###### 1.0版本(19.04.18)

![](https://github.com/MouMangTai/moumangtai.github.io/blob/master/img/map.jpg?raw=true)

## 利用python进行人头检测

###### 1.0版本(19.04.18)

数据采用opencv自带的训练集(haarcascade_fullbody.xml),暂时还没有研究深度学习和算法，行人检测错误率相当高。

![](https://github.com/MouMangTai/moumangtai.github.io/blob/master/img/people.jpg?raw=true)

## MySql存储数据

###### 1.0版本(19.04.18)

python在计算每一帧图像人数的同时更改数据库的信息

```python
db = MySQLdb.Connect("localhost", "root", "admin", "head", charset='utf8')
    cursor = db.cursor()
    sql = "UPDATE place SET num = %s where id = %s" % (len(faces), 1)
    try:
        cursor.execute(sql)
        db.commit()
    except:
        db.rollback()
    db.close()
```

前端部分发送ajax请求获取到数据库的数据更新页面

```javascript
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
    }, 500);
});
```

## 未完：

行人检测的精确度，web的设计