var db = connect("10.136.139.21:23456/docinfo");
db.auth("w123","w123");
var now = new Date().toString();
var a = now.substring(0,16);
var b = now.substring(24,now.length);
//print(a);
//////print(b);
var time = a+"00:00:01"+b;
var timestamp = new Date(time).getTime()/1000-1;
//////昨天的23.59.59
var startime = timestamp;
var today = new Date(timestamp*1000);
var y = today.getFullYear()+"-";
var m = (today.getMonth()+1 < 10 ? '0'+(today.getMonth()+1)+'-' : today.getMonth()+1)+"-";
var d = today.getDate();
////////////////////////////////终端类型0
//新浪-- 新闻  回帖 弹幕
var xlnews0 = db.docinfo.find({"_spec":"M-INEWS01","sid":21,"it":{$gt:startime},"uat":0}).count();
var xlcomments0 = db.docinfo.find({"_spec":"M-INEWS02","sid":21,"it":{$gt:startime},"uat":0}).count();
var xlbarrage0 = db.docinfo.find({"_spec":"M-INEWS03","sid":21,"it":{$gt:startime},"uat":0}).count();
//网易--。。。。
var wynews0 = db.docinfo.find({"_spec":"M-INEWS01","sid":23,"it":{$gt:startime},"uat":0}).count();
var wycomments0 = db.docinfo.find({"_spec":"M-INEWS02","sid":23,"it":{$gt:startime},"uat":0}).count();
var wybarrage0 = db.docinfo.find({"_spec":"M-INEWS03","sid":23,"it":{$gt:startime},"uat":0}).count();
//凤凰：.....
var fhnews0 = db.docinfo.find({"_spec":"M-INEWS01","sid":24,"it":{$gt:startime},"uat":0}).count();
var fhcomments0 = db.docinfo.find({"_spec":"M-INEWS02","sid":24,"it":{$gt:startime},"uat":0}).count();
var fhbarrage0 = db.docinfo.find({"_spec":"M-INEWS03","sid":24,"it":{$gt:startime},"uat":0}).count();
//腾讯：...
var txnews0 = db.docinfo.find({"_spec":"M-INEWS01","sid":26,"it":{$gt:startime},"uat":0}).count();
var txcomments0 = db.docinfo.find({"_spec":"M-INEWS02","sid":26,"it":{$gt:startime},"uat":0}).count();
var txbarrage0 = db.docinfo.find({"_spec":"M-INEWS03","sid":26,"it":{$gt:startime},"uat":0}).count();
//一点资讯....
var ydzxnews0 = db.docinfo.find({"_spec":"M-INEWS01","sid":36,"it":{$gt:startime},"uat":0}).count();
var ydzxcomments0 = db.docinfo.find({"_spec":"M-INEWS02","sid":36,"it":{$gt:startime},"uat":0}).count();
var ydzxbarrage0 = db.docinfo.find({"_spec":"M-INEWS03","sid":36,"it":{$gt:startime},"uat":0}).count();
//今日头条
var jrttnews0 = db.docinfo.find({"_spec":"M-INEWS01","sid":39,"it":{$gt:startime},"uat":0}).count();
var jrttcomments0 = db.docinfo.find({"_spec":"M-INEWS02","sid":39,"it":{$gt:startime},"uat":0}).count();
var jrttbarrage0 = db.docinfo.find({"_spec":"M-INEWS03","sid":39,"it":{$gt:startime},"uat":0}).count();
//////////////////////////////////终端类型1
var xlnews1 = db.docinfo.find({"_spec":"M-INEWS01","sid":21,"it":{$gt:startime},"uat":1}).count();
var xlcomments1 = db.docinfo.find({"_spec":"M-INEWS02","sid":21,"it":{$gt:startime},"uat":1}).count();
var xlbarrage1 = db.docinfo.find({"_spec":"M-INEWS03","sid":21,"it":{$gt:startime},"uat":1}).count();
//网易--。。。。
var wynews1 = db.docinfo.find({"_spec":"M-INEWS01","sid":23,"it":{$gt:startime},"uat":1}).count();
var wycomments1 = db.docinfo.find({"_spec":"M-INEWS02","sid":23,"it":{$gt:startime},"uat":1}).count();
var wybarrage1 = db.docinfo.find({"_spec":"M-INEWS03","sid":23,"it":{$gt:startime},"uat":1}).count();
////凤凰：.....
var fhnews1 = db.docinfo.find({"_spec":"M-INEWS01","sid":24,"it":{$gt:startime},"uat":1}).count();
var fhcomments1 = db.docinfo.find({"_spec":"M-INEWS02","sid":24,"it":{$gt:startime},"uat":1}).count();
var fhbarrage1 = db.docinfo.find({"_spec":"M-INEWS03","sid":24,"it":{$gt:startime},"uat":1}).count();
////腾讯：...
var txnews1 = db.docinfo.find({"_spec":"M-INEWS01","sid":26,"it":{$gt:startime},"uat":1}).count();
var txcomments1 = db.docinfo.find({"_spec":"M-INEWS02","sid":26,"it":{$gt:startime},"uat":1}).count();
var txbarrage1 = db.docinfo.find({"_spec":"M-INEWS03","sid":26,"it":{$gt:startime},"uat":1}).count();
////一点资讯....
var ydzxnews1 = db.docinfo.find({"_spec":"M-INEWS01","sid":36,"it":{$gt:startime},"uat":1}).count();
var ydzxcomments1 = db.docinfo.find({"_spec":"M-INEWS02","sid":36,"it":{$gt:startime},"uat":1}).count();
var ydzxbarrage1 = db.docinfo.find({"_spec":"M-INEWS03","sid":36,"it":{$gt:startime},"uat":1}).count();
////今日头条
var jrttnews1 = db.docinfo.find({"_spec":"M-INEWS01","sid":39,"it":{$gt:startime},"uat":1}).count();
var jrttcomments1 = db.docinfo.find({"_spec":"M-INEWS02","sid":39,"it":{$gt:startime},"uat":1}).count();
var jrttbarrage1 = db.docinfo.find({"_spec":"M-INEWS03","sid":39,"it":{$gt:startime},"uat":1}).count();
////////////////////////////////终端类型2
//新浪-- 新闻  回帖 弹幕
var xlnews2 = db.docinfo.find({"_spec":"M-INEWS01","sid":21,"it":{$gt:startime},"uat":2}).count();
var xlcomments2 = db.docinfo.find({"_spec":"M-INEWS02","sid":21,"it":{$gt:startime},"uat":2}).count();
var xlbarrage2 = db.docinfo.find({"_spec":"M-INEWS03","sid":21,"it":{$gt:startime},"uat":2}).count();
//网易--。。。。
var wynews2 = db.docinfo.find({"_spec":"M-INEWS01","sid":23,"it":{$gt:startime},"uat":2}).count();
var wycomments2 = db.docinfo.find({"_spec":"M-INEWS02","sid":23,"it":{$gt:startime},"uat":2}).count();
var wybarrage2 = db.docinfo.find({"_spec":"M-INEWS03","sid":23,"it":{$gt:startime},"uat":2}).count();
////凤凰：.....
var fhnews2 = db.docinfo.find({"_spec":"M-INEWS01","sid":24,"it":{$gt:startime},"uat":2}).count();
var fhcomments2 = db.docinfo.find({"_spec":"M-INEWS02","sid":24,"it":{$gt:startime},"uat":2}).count();
var fhbarrage2 = db.docinfo.find({"_spec":"M-INEWS03","sid":24,"it":{$gt:startime},"uat":2}).count();
////腾讯：...
var txnews2 = db.docinfo.find({"_spec":"M-INEWS01","sid":26,"it":{$gt:startime},"uat":2}).count();
var txcomments2 = db.docinfo.find({"_spec":"M-INEWS02","sid":26,"it":{$gt:startime},"uat":2}).count();
var txbarrage2 = db.docinfo.find({"_spec":"M-INEWS03","sid":26,"it":{$gt:startime},"uat":2}).count();
////一点资讯....
var ydzxnews2 = db.docinfo.find({"_spec":"M-INEWS01","sid":36,"it":{$gt:startime},"uat":2}).count();
var ydzxcomments2 = db.docinfo.find({"_spec":"M-INEWS02","sid":36,"it":{$gt:startime},"uat":2}).count();
var ydzxbarrage2 = db.docinfo.find({"_spec":"M-INEWS03","sid":36,"it":{$gt:startime},"uat":2}).count();
////今日头条
var jrttnews2 = db.docinfo.find({"_spec":"M-INEWS01","sid":39,"it":{$gt:startime},"uat":2}).count();
var jrttcomments2 = db.docinfo.find({"_spec":"M-INEWS02","sid":39,"it":{$gt:startime},"uat":2}).count();
var jrttbarrage2 = db.docinfo.find({"_spec":"M-INEWS03","sid":39,"it":{$gt:startime},"uat":2}).count();
//////////////////////////////////终端类型1
//新浪
var xlnews3 = db.docinfo.find({"_spec":"M-INEWS01","sid":21,"it":{$gt:startime},"uat":3}).count();
var xlcomments3 = db.docinfo.find({"_spec":"M-INEWS02","sid":21,"it":{$gt:startime},"uat":3}).count();
var xlbarrage3 = db.docinfo.find({"_spec":"M-INEWS03","sid":21,"it":{$gt:startime},"uat":3}).count();
//网易--。。。。
var wynews3 = db.docinfo.find({"_spec":"M-INEWS01","sid":23,"it":{$gt:startime},"uat":3}).count();
var wycomments3 = db.docinfo.find({"_spec":"M-INEWS02","sid":23,"it":{$gt:startime},"uat":3}).count();
var wybarrage3 = db.docinfo.find({"_spec":"M-INEWS03","sid":23,"it":{$gt:startime},"uat":3}).count();
/////凤凰：.....
var fhnews3 = db.docinfo.find({"_spec":"M-INEWS01","sid":24,"it":{$gt:startime},"uat":3}).count();
var fhcomments3 = db.docinfo.find({"_spec":"M-INEWS02","sid":24,"it":{$gt:startime},"uat":3}).count();
var fhbarrage3 = db.docinfo.find({"_spec":"M-INEWS03","sid":24,"it":{$gt:startime},"uat":3}).count();
////腾讯：...
var txnews3 = db.docinfo.find({"_spec":"M-INEWS01","sid":26,"it":{$gt:startime},"uat":3}).count();
var txcomments3 = db.docinfo.find({"_spec":"M-INEWS02","sid":26,"it":{$gt:startime},"uat":3}).count();
var txbarrage3 = db.docinfo.find({"_spec":"M-INEWS03","sid":26,"it":{$gt:startime},"uat":3}).count();
////一点资讯....
var ydzxnews3 = db.docinfo.find({"_spec":"M-INEWS01","sid":36,"it":{$gt:startime},"uat":3}).count();
var ydzxcomments3 = db.docinfo.find({"_spec":"M-INEWS02","sid":36,"it":{$gt:startime},"uat":3}).count();
var ydzxbarrage3 = db.docinfo.find({"_spec":"M-INEWS03","sid":36,"it":{$gt:startime},"uat":3}).count();
////今日头条
var jrttnews3 = db.docinfo.find({"_spec":"M-INEWS01","sid":39,"it":{$gt:startime},"uat":3}).count();
var jrttcomments3 = db.docinfo.find({"_spec":"M-INEWS02","sid":39,"it":{$gt:startime},"uat":3}).count();
var jrttbarrage3 = db.docinfo.find({"_spec":"M-INEWS03","sid":39,"it":{$gt:startime},"uat":3}).count();

//新浪统计所有
var xlnewsall = xlnews0 + xlnews1 + xlnews2 + xlnews3;
var xlcommentsall = xlcomments0 + xlcomments1 + xlcomments2 + xlcomments3;
var xlbarrageall = xlbarrage0 + xlbarrage1 + xlbarrage2 + xlbarrage3;
////网易
var wynewsall = wynews0 + xlnews1 + wynews2 + wynews3;
var wycommentsall = wycomments0 + wycomments1 + wycomments2 + wycomments3;
var wybarrageall = wybarrage0 + wybarrage1 + wybarrage2 + wybarrage3;
////凤凰
var fhnewsall = fhnews0 + fhnews1 + fhnews2 + fhnews3;
var fhcommentsall = fhcomments0 + fhcomments1 + fhcomments2 + fhcomments3;
var fhbarrageall = fhbarrage0 + fhbarrage1 + fhbarrage2 + fhbarrage3;
////腾讯
var txnewsall = txnews0 + txnews1 + txnews2 + txnews3;
var txcommentsall = txcomments0 + txcomments1 + txcomments2 + txcomments3;
var txbarrageall = txbarrage0 + txbarrage1 + txbarrage2 + txbarrage3;
////一点资讯
var ydzxnewsall = ydzxnews0 + ydzxnews1 + ydzxnews2 + ydzxnews3;
var ydzxcommentsall = ydzxcomments0 + ydzxcomments1 + ydzxcomments2 + ydzxcomments3;
var ydzxbarrageall = ydzxbarrage0 + ydzxbarrage1 +ydzxbarrage2 + ydzxbarrage3;
////今日头条
var jrttnewsall = jrttnews0 + jrttnews1 + jrttnews2 + jrttnews3;
var jrttcommentsall = jrttcomments0 + jrttcomments1 + jrttcomments2 + jrttcomments3;
var jrttbarrageall = jrttbarrage0 + jrttbarrage1 + jrttbarrage2 + jrttbarrage3;

db = connect("10.136.139.21:23456/yw_user");
db.auth("w123","w123");
var user = db.yw_user.find({"_spec":"U-INEWS04"}).count();
var usertime = db.yw_user.find({"_spec":"U-INEWS04","uopt":{$gt:startime}}).count();
//用户
//新浪
print("================================================"+y+m+d+"要闻原始数据量统计======================================================");
//print("==========="+yesday+"类型统计===========");
print(" 企业 : =========pc端=========|======移动客户端=======|=====手机浏览器========|======手机web网站=====|===========合计============");
print("        新闻    跟帖    弹幕  | 新闻    跟帖    弹幕  | 新闻    跟帖    弹幕  | 新闻    跟帖    弹幕 | 新闻合计-跟帖合计-弹幕合计");
print("腾讯网[26]: "+txnews0+'\t'+txcomments0+'\t'+txbarrage0+'\t'+txnews1+'\t'+txcomments1+'\t'+txbarrage1+'\t'+txnews2+'\t'+txcomments2+'\t'+txbarrage2+'\t'+txnews3+'\t'+txcomments3+'\t'+txbarrage3+'\t'+txnewsall+'\t'+txcommentsall+'\t'+txbarrageall);
print("新浪网[21]: "+xlnews0+'\t'+xlcomments0+'\t'+xlbarrage0+'\t'+xlnews1+'\t'+xlcomments1+'\t'+xlbarrage1+'\t'+xlnews2+'\t'+xlcomments2+'\t'+xlbarrage2+'\t'+xlnews3+'\t'+xlcomments3+'\t'+xlbarrage3+'\t'+xlnewsall+'\t'+xlcommentsall+'\t'+xlbarrageall);
print("凤凰网[24]: "+fhnews0+'\t'+fhcomments0+'\t'+fhbarrage0+'\t'+fhnews1+'\t'+fhcomments1+'\t'+fhbarrage1+'\t'+fhnews2+'\t'+fhcomments2+'\t'+fhbarrage2+'\t'+fhnews3+'\t'+fhcomments3+'\t'+fhbarrage3+'\t'+fhnewsall+'\t'+fhcommentsall+'\t'+fhbarrageall);
print("网易网[23]: "+wynews0+'\t'+wycomments0+'\t'+wybarrage0+'\t'+wynews1+'\t'+wycomments1+'\t'+wybarrage1+'\t'+wynews2+'\t'+wycomments2+'\t'+wybarrage2+'\t'+wynews3+'\t'+wycomments3+'\t'+wybarrage3+'\t'+wynewsall+'\t'+wycommentsall+'\t'+wybarrageall);
print("今日头条[39]:"+jrttnews0+'\t'+jrttcomments0+'\t'+jrttbarrage0+'\t'+jrttnews1+'\t'+jrttcomments1+'\t'+jrttbarrage1+'\t'+jrttnews2+'\t'+jrttcomments2+'\t'+jrttbarrage2+'\t'+jrttnews3+'\t'+jrttcomments3+'\t'+jrttbarrage3+'\t'+jrttnewsall+'\t'+jrttcommentsall+'\t'+jrttbarrageall);
print("一点资讯[36]:"+ydzxnews0+'\t'+ydzxcomments0+'\t'+ydzxbarrage0+'\t'+ydzxnews1+'\t'+ydzxcomments1+'\t'+ydzxbarrage1+'\t'+ydzxnews2+'\t'+ydzxcomments2+'\t'+ydzxbarrage2+'\t'+ydzxnews3+'\t'+ydzxcomments3+'\t'+ydzxbarrage3+'\t'+ydzxnewsall+'\t'+ydzxcommentsall+'\t'+ydzxbarrageall);
print(y+m+d+"用户处理统计"+usertime)
print("全部要闻用户："+user);
print("=================================================================================================================================");
