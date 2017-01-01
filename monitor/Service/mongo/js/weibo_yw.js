//舆情库
//docinfo库\docinfo表：10.136.139.21:23456		      
//wb_user库\wb_user表：10.136.139.21:23456
//t_user_microblog库\t_user_microblog表：10.136.142.126:23456  10.136.142.127:23456 10.136.142.128:23456
var now = new Date().toString();
var a = now.substring(0,16);
var b = now.substring(24,now.length);
var time = a+"00:00:00"+b;
var timestamp = new Date(time).getTime()/1000;
var startime = timestamp-86400*1;
var endtime = timestamp;


var db = connect("10.136.142.127:23456/tp_msg_microblog");
db.auth("w123","w123");
//Mongo微博库（加载）：
//1、腾讯微博消息：
//var msg_tenc_load_it = db.tp_msg_microblog.find({'asp':'TWeibo','it':{$gt:startime,$lt:endtime}}).count();
//var msg_tenc_load_ut = db.tp_msg_microblog.find({'asp':'TWeibo','ut':{$gt:startime,$lt:endtime}}).count();
//var msg_tenc_load = msg_tenc_load_it + msg_tenc_load_ut;
//print(msg_tenc_load);
////3、新浪微博消息：
//var msg_sina_load_it = db.tp_msg_microblog.find({'asp':'Weibo','it':{$gt:startime,$lt:endtime}}).count();
//var msg_sina_load_ut = db.tp_msg_microblog.find({'asp':'Weibo','ut':{$gt:startime,$lt:endtime}}).count();
//var msg_sina_load = msg_sina_load_it + msg_sina_load_ut;
//print(msg_sina_load);
//Mongo微博库（业务）：
//1、腾讯微博消息：
var msg_tenc = db.tp_msg_microblog.find({'asp':'TWeibo','pt':{$gt:startime,$lt:endtime}}).count();
print("腾讯新库: ", msg_tenc)
//2、新浪微博消息：
var msg_sina = db.tp_msg_microblog.find({'asp':'Weibo','pt':{$gt:startime,$lt:endtime}}).count();
print("新浪新库: ", msg_sina)


//var db = connect("10.136.142.127:23456/t_user_microblog");
//db.auth("w123","w123");
//Mongo微博库（加载）：
//2、腾讯微博用户：
//var user_tenc_load_it = db.t_user_microblog.find({'_id':{$regex:'ttenc',$options:'i'},'it':{$gt:startime,$lt:endtime}}).count();
//var user_tenc_load_ut = db.t_user_microblog.find({'_id':{$regex:'ttenc',$options:'i'},'ut':{$gt:startime,$lt:endtime}}).count();
//var user_tenc_load = user_tenc_load_it + user_tenc_load_ut;
//print(user_tenc_load);
////4、新浪微博用户：
//var user_sina_load_it = db.t_user_microblog.find({'_id':{$regex:'tsina',$options:'i'},'it':{$gt:startime,$lt:endtime}}).count();
//var user_sina_load_ut = db.t_user_microblog.find({'_id':{$regex:'tsina',$options:'i'},'ut':{$gt:startime,$lt:endtime}}).count();
//var user_sina_load = user_sina_load_it + user_sina_load_ut;
//print(user_sina_load);
//
//Mongo微博库（业务）：
//2、腾讯微博用户：
//var user_tenc = db.t_user_microblog.find({'_id':{$regex:'ttenc',$options:'i'},'gt':{$gt:startime,$lt:endtime}}).count();
//print(user_tenc);
//4、新浪微博用户：
//var user_sina = db.t_user_microblog.find({'_id':{$regex:'tsina',$options:'i'},'gt':{$gt:startime,$lt:endtime}}).count();
//print(user_sina);
