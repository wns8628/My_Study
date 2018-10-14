var express = require('express');
var bodyParser = require('body-parser');
var app = express();
app.locals.pretty = true;
app.set('view engine', 'jade');
app.set('views', './views');
app.use(express.static('public'));
app.use(bodyParser.urlencoded({ extended: false }));
app.get('/form', function(req,res){
  res.render('form');
})
app.get('/form_receiver', function(req,res){
  var title = req.query.title;
  var description = req.query.description;
  res.send(title+','+description);
})
app.post('/form_receiver', function(req,res){
  var title = req.body.title;
  var description = req.body.description;
  res.send(title+','+description);
})
app.get('/template',function(req,res){
  res.render('tamp', {time:Date(), _title:'Jade'});
})
app.get('/topic', function(req,res){
  var topics = [
    'javascript is...',
    'nodejs is...',
    'express is...'
  ];
  var output = `
  <a href="/topic?id=0">JavaScript</a><br>
  <a href="/topic?id=1">노드</a><br>
  <a href="/topic?id=2">익스프레스</a><br><br>
  ${topics[req.query.id]}
  `
   res.send(output);

})
app.get('/route', function(req,res){
  res.send('hello home page, <img src="peko.png">');
})
app.get('/login',function(req,res){
  res.send('login please');
})
app.listen(3000, function(){
  console.log('Conneted 3000 port!');
});
