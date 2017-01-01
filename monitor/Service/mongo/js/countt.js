db.auth("w123","w123");
var now = new Date().toString();
var a = now.substring(0,16);
var b = now.substring(24,now.length);
var time = a+"00:00:01"+b;
var timestamp = new Date(time).getTime()/1000;
var startime = timestamp-1-86400*0;
var endtime = new Date().getTime()/1000;
function dis(a,startime,endtime,sid,uat){
var result = "";
for(var i=0;i<a.length;i++){
	var num = count(a[i],startime,endtime,sid,uat);
        result += "【"+a[i]+":"+num+"】"+" ";
}
return result;
}
//
function count(b,startime,endtime,sid,uat){
	var num = db.docinfo.find({"_spec":"M-INEWS01","it":{$gt:startime,$lt:endtime},"sid":sid,"bname":b,"uat":uat}).count();
	return num;
}
var yesday = new Date(startime*1000);
var y = yesday.getFullYear()+"-";
var m = (yesday.getMonth()+1 < 10 ? '0'+(yesday.getMonth()+1)+'-' : yesday.getMonth()+1)+"-";
var d = yesday.getDate();
print("==========="+y+m+d+"频道/板块类型统计===========");
var xl0 = db.docinfo.distinct("bname",{"_spec":"M-INEWS01","it":{$gt:startime,$lt:endtime},"sid":21,"uat":0});
var xl1 = db.docinfo.distinct("bname",{"_spec":"M-INEWS01","it":{$gt:startime,$lt:endtime},"sid":21,"uat":1});
var xl2 = db.docinfo.distinct("bname",{"_spec":"M-INEWS01","it":{$gt:startime,$lt:endtime},"sid":21,"uat":2});
var xl3 = db.docinfo.distinct("bname",{"_spec":"M-INEWS01","it":{$gt:startime,$lt:endtime},"sid":21,"uat":3});
//var xll = db.docinfo.distinct("bname",{"_spec":"M-INEWS01","it":{$gt:startime,$lt:endtime},"sid":21}).length;

//var xlc = db.docinfo.find({"_spec":"M-INEWS01","it":{$gt:startime,$lt:endtime},"mssid":21}).count();
var wy0 = db.docinfo.distinct("bname",{"_spec":"M-INEWS01","it":{$gt:startime,$lt:endtime},"sid":23,"uat":0});
var wy1 = db.docinfo.distinct("bname",{"_spec":"M-INEWS01","it":{$gt:startime,$lt:endtime},"sid":23,"uat":1});
var wy2 = db.docinfo.distinct("bname",{"_spec":"M-INEWS01","it":{$gt:startime,$lt:endtime},"sid":23,"uat":2});
var wy3 = db.docinfo.distinct("bname",{"_spec":"M-INEWS01","it":{$gt:startime,$lt:endtime},"sid":23,"uat":3});

//var wyl = db.docinfo.distinct("bname",{"_spec":"M-INEWS01","it":{$gt:startime,$lt:endtime},"sid":23}).length;
//var wyc = db.docinfo.find({"_spec":"M-INEWS01","it":{$gt:startime,$lt:endtime},"mssid":23}).count();
var fh0 = db.docinfo.distinct("bname",{"_spec":"M-INEWS01","it":{$gt:startime,$lt:endtime},"sid":24,"uat":0});
var fh1 = db.docinfo.distinct("bname",{"_spec":"M-INEWS01","it":{$gt:startime,$lt:endtime},"sid":24,"uat":1});
var fh2 = db.docinfo.distinct("bname",{"_spec":"M-INEWS01","it":{$gt:startime,$lt:endtime},"sid":24,"uat":2});
var fh3 = db.docinfo.distinct("bname",{"_spec":"M-INEWS01","it":{$gt:startime,$lt:endtime},"sid":24,"uat":3});

//var fhl = db.docinfo.distinct("bname",{"_spec":"M-INEWS01","it":{$gt:startime,$lt:endtime},"sid":24}).length;

var tx0 = db.docinfo.distinct("bname",{"_spec":"M-INEWS01","it":{$gt:startime,$lt:endtime},"sid":26,"uat":0});
var tx1 = db.docinfo.distinct("bname",{"_spec":"M-INEWS01","it":{$gt:startime,$lt:endtime},"sid":26,"uat":1});
var tx2 = db.docinfo.distinct("bname",{"_spec":"M-INEWS01","it":{$gt:startime,$lt:endtime},"sid":26,"uat":2});
var tx3 = db.docinfo.distinct("bname",{"_spec":"M-INEWS01","it":{$gt:startime,$lt:endtime},"sid":26,"uat":3});
//var txl = db.docinfo.distinct("bname",{"_spec":"M-INEWS01","it":{$gt:startime,$lt:endtime},"sid":26}).length;

var ydzx0 = db.docinfo.distinct("bname",{"_spec":"M-INEWS01","it":{$gt:startime,$lt:endtime},"sid":36,"uat":0});
var ydzx1 = db.docinfo.distinct("bname",{"_spec":"M-INEWS01","it":{$gt:startime,$lt:endtime},"sid":36,"uat":1});
var ydzx2 = db.docinfo.distinct("bname",{"_spec":"M-INEWS01","it":{$gt:startime,$lt:endtime},"sid":36,"uat":2});
var ydzx3 = db.docinfo.distinct("bname",{"_spec":"M-INEWS01","it":{$gt:startime,$lt:endtime},"sid":36,"uat":3});

//var ydzxl = db.docinfo.distinct("bname",{"_spec":"M-INEWS01","it":{$gt:startime,$lt:endtime},"sid":36}).length;

var jrtt0 = db.docinfo.distinct("bname",{"_spec":"M-INEWS01","it":{$gt:startime,$lt:endtime},"sid":39,"uat":0});
var jrtt1 = db.docinfo.distinct("bname",{"_spec":"M-INEWS01","it":{$gt:startime,$lt:endtime},"sid":39,"uat":1});
var jrtt2 = db.docinfo.distinct("bname",{"_spec":"M-INEWS01","it":{$gt:startime,$lt:endtime},"sid":39,"uat":2});
var jrtt3 = db.docinfo.distinct("bname",{"_spec":"M-INEWS01","it":{$gt:startime,$lt:endtime},"sid":39,"uat":3});
//var jrttl = db.docinfo.distinct("bname",{"_spec":"M-INEWS01","it":{$gt:startime,$lt:endtime},"sid":39}).length;
//print("==========="+yesday+"类型统计===========");


print("*******腾讯网[26]******");
print("============PC客户端============");
print(dis(tx0,startime,endtime,26,0));
print("============移动客户端==========");
print(dis(tx1,startime,endtime,26,1));
print("============手机浏览器==========");
print(dis(tx2,startime,endtime,26,2));
print("============手机web网站=========");
print(dis(tx3,startime,endtime,26,3));

print("********新浪网[21]******");
print("============PC客户端===========");
print(dis(xl0,startime,endtime,21,0));
print("============移动客户端=========");
print(dis(xl1,startime,endtime,21,1));
print("============手机浏览器=========");
print(dis(xl2,startime,endtime,21,2));
print("============手机web网站========");
print(dis(xl3,startime,endtime,21,3));

print("*******凤凰网[24]******");
print("============PC客户端============");
print(dis(fh0,startime,endtime,24,0));
print("============移动客户端==========");
print(dis(fh1,startime,endtime,24,1));
print("============手机浏览器==========");
print(dis(fh2,startime,endtime,24,2));
print("============手机web网站=========");
print(dis(fh3,startime,endtime,24,3));

print("*******网易网[23]******");
print("============PC客户端============");
print(dis(wy0,startime,endtime,23,0));
print("============移动客户端==========");
print(dis(wy1,startime,endtime,23,1));
print("============手机浏览器==========");
print(dis(wy2,startime,endtime,23,2));
print("============手机web网站=========");
print(dis(wy3,startime,endtime,23,3));

print("*******今日头条[39]******");
print("============PC客户端============");
print(dis(jrtt0,startime,endtime,39,0));
print("============移动客户端==========");
print(dis(jrtt1,startime,endtime,39,1));
print("============手机浏览器==========");
print(dis(jrtt2,startime,endtime,39,2));
print("============手机web网站=========");
print(dis(jrtt3,startime,endtime,39,3));


print("*******一点资讯[36]*****");
print("============PC客户端=============");
print(dis(ydzx0,startime,endtime,36,0));
print("============移动客户端===========");
print(dis(ydzx1,startime,endtime,36,1));
print("============手机浏览器===========");
print(dis(ydzx2,startime,endtime,36,2));
print("============手机web网站==========");
print(dis(ydzx3,startime,endtime,36,3));

//print("网易网: "+'\t'+dis(wy,startime,endtime,23));
//print("凤凰网: "+'\t'+dis(fh,startime,endtime,24));
//print("腾讯网: "+'\t'+dis(tx,startime,endtime,26));
//print("一点资讯:"+'\t'+dis(ydzx,startime,endtime,36));
//print("今日头条:"+'\t'+dis(jrtt,startime,endtime,39));
print("==========================================");



