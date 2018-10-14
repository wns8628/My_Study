var express = require('express');
var app = express();
app.set('view engine', 'jade');
app.set('views', 'jade');


app.get('/view', function(req, res){
    res.render('view');
})
app.get('/add',function(req, res){
  res.render('add');
})

//-----------------------------------
app.listen(3003, function(){
  console.log('connect 3003 port!')
});
