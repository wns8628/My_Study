var express = require('express');
var app = express();
var bodyParser = require('body-parser');
var fs = require('fs');
var mysql = require('mysql');
var conn = mysql.createConnection({
 host     : 'localhost',
 user     : 'root',
 password : 'twiceioi',
 database : 'os'
});
conn.connect();
app.use(bodyParser.urlencoded({ extended: false }));
app.use(express.static('public'));
app.set('views','./views_mysql');
app.set('view engine', 'jade');
app.locals.pretty = true;
app.get('/topic/add', function(req, res){
  var sql ='SELECT id,title FROM topic;';
  conn.query(sql,function(err, topics, fields){
    if(err){
      console.log(err);
      res.status(500).send('에러발생!');
    }
  res.render('add', {topics:topics});
});
});
app.post('/topic/add', function(req, res){
    var title = req.body.title;
    var description = req.body.description;
    var author = req.body.author;
    var sql = 'INSERT INTO topic (title ,description ,author) VALUES( ?, ?, ?);';
    conn.query(sql,[title, description , author],function(err,result, fields){
      if(err){
        console.log(err);
        res.status(500).send('에러발생!');
      }else{
        res.redirect('/topic/'+result.insertId)
      }
    });
 })
app.get(['/topic/:id/edit'],function(req, res){
      var sql = 'SELECT id,title FROM topic';
      conn.query(sql, function(err, topics, fields){
      var id = req.params.id
            if(id){
              var sql = 'SELECT * FROM topic WHERE id =?';
              conn.query(sql,[id],function(err, topic,fields){
                if(err){
                  console.log(err)
                  res.status(500).send('에러발생 에러발생')
                }else{
                  res.render('edit',{topics:topics, topic:topic[0]})
                }
              });
            }else{
              console.log('아디없다 씨발아')
              res.status(500).send('에러임')
            }
      });
});
app.post(['/topic/:id/edit'],function(req, res){
  var title = req.body.title;
  var description = req.body.description;
  var author= req.body.author;
  var id = req.params.id;
  var sql= 'UPDATE topic SET title=?, description=?, author=? where id=?';
  conn.query(sql,[title,description,author,id],function(err, rows, fields){
    if(err){
      console.log(err);
      res.status(500).send('internal server error');
    }else{
      res.redirect('/topic/'+id);
    }
  });
});
app.post('/topic/:id/delete',function(req,res){
  var id = req.params.id;
  var sql='DELETE FROM topic WHERE id=?';
  conn.query(sql,[id],function(err,rows){
    res.redirect('./');
  });
});

app.get(['/topic','/topic/:id'],function(req,res){
  var sql ='SELECT id,title FROM topic;';
  conn.query(sql,function(err, topics, fields){
    var id = req.params.id;
    if(id){
        //상세보기
        var sql ='SELECT * FROM topic WHERE id=?;';
        conn.query(sql, [id], function(err, topic, fields){
            if(err){
              res.status(500).send('에러발생!');
              console.log(err);
            }else{
              res.render('view', {topics:topics, topic:topic[0]});
            }
        });
    }else{
    res.render('view', {topics:topics});
   }
  });
})
app.listen(3000,function(){
  console.log('Connected, 3000 port!');
})
