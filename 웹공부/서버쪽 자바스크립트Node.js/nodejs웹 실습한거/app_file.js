var express = require('express');
var app = express();
var bodyParser = require('body-parser');
var fs = require('fs');
app.use(bodyParser.urlencoded({ extended: false }));
app.use(express.static('public'));
app.set('views','./views_file');
app.set('view engine', 'jade');
app.locals.pretty = true;
app.get('/topic/new', function(req, res){
  fs.readdir('data',function(err,files){
    if(err){
      console.log(err);
      res.status(500).send('에러발생!');
    }
  res.render('new', {topics:files});
 })
})
app.get(['/topic','/topic/:id'],function(req,res){
  fs.readdir('data',function(err,files){
    if(err){
      console.log(err);
      res.status(500).send('에러발생!');
      }
      var id = req.params.id;
      if(id){
      //아디값이 있으면
        fs.readFile('data/'+id,'utf8',function(err,data){
          if(err){
            console.log(err);
            res.status(500).send('에러발생!');
          }
            res.render('view', {title:id, topics:files, description:data});
        })
      }else{ //아디값이없으면
        res.render('view', {topics:files, title:'어서오세요'});
      }
      })
})

app.post('/topic', function(req, res){
   var title = req.body.title;
   var description = req.body.description;
   fs.writeFile('data/'+title,description,function(err){
     if(err){
       console.log(err);
       res.status(500).send('에러발생!');
     }
       res.redirect('/topic/'+title);
   })
})
app.listen(3000,function(){
  console.log('Connected, 3000 port!');
})
