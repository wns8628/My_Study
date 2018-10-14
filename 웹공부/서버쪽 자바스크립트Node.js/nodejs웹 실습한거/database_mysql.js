var mysql = require('mysql');
var conn = mysql.createConnection({
 host     : 'localhost',
 user     : 'root',
 password : 'twiceioi',
 database : 'os'
});
conn.connect();
//연결완료
//
// var sql = 'SELECT * FROM topic';
// conn.query(sql, function(err, rows, fields){
//   if(err){
//     console.log(err);
//   } else{
//       for(var i =0; i<rows.length; i++){
//         console.log(rows[i].title);
//       }
//   }
// });

var sql ='DELETE from topic where id=?';
var params = [5];
conn.query(sql,params,function(err,rows,fields){
  if(err){
    console.log(err);
  }else{
    console.log(rows);
  }
});

//
// var sql ='INSERT INTO topic(title,description,author) VALUES(?,?,?);'
// var params = ['Supervisor','watcher','graphittie'];
// conn.query(sql,params,function(err,rows,fields){
//   if(err){
//     console.log(err);
//   }else{
//     console.log(rows);
//   }
// });


conn.end();
