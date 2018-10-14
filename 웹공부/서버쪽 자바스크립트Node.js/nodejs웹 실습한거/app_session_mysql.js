var express = require('express');
var session = require('express-session');
var bodyParser = require('body-parser');
var MySQLStore = require('express-mysql-session')(session);
var app = express();

app.use(bodyParser.urlencoded({ extended: false }));
app.use(session({
  secret: 'asdasdaadsdasd fuckkfuckkcufcufkcufkcfukukfuckfuckcufkufk',
  resave: false,
  saveUninitialized: true,
  store:new MySQLStore({
    host: 'localhost',
    port: 3306,
    user: 'root',
    password: 'twiceioi',
    database: 'os'
  })
}));
app.get('/count',function(req,res){
  if(req.session.count){
    req.session.count++
  }else {
   req.session.count =1;
  }
  res.send('count : '+req.session.count);
});
app.get('/tmp', function(req,res){
  res.send('result : '+ req.session.count);
});
app.get('/auth/logout',function(req, res){
  delete req.session.displayName;
  req.session.save(function(){
  res.redirect('/welcome');
  });
});
app.get('/welcome', function(req,res){
  if(req.session.displayName){
    res.send(`
      <h1>Hello, ${req.session.displayName}</h1>
      <a href="/auth/logout">logout</a>
      `);
  } else {
    res.send(`
        <h1>welcome</h1>
        <a href="/auth/login">login</a>
      `);
  }
});

app.post('/auth/login',function(req,res){
  var user  = {
    username:'egoing',
    password:'111',
    displayName:'Egoing'
  };
  var uname = req.body.username;
  var pwd   = req.body.password;
  if(uname === user.username && pwd === user.password){
    req.session.displayName = user.displayName;
    req.session.save(function(){
      res.redirect('/welcome');
    });
  }else{
    res.send('who are you?<a href="/auth/login">login</a> ');
  }
});
app.get('/auth/login',function(req,res){
  var output =`
  <h1>Login</h1>
  <form action="/auth/login" method="post">
    <p>
      <input type="text" name ="username" placeholder="username">
    </p>
    <p>
      <input type="password" name ="password" placeholder="password">
    </p>
    <p>
      <input type="submit">
      </p>
  </form>
  `
  res.send(output);
});

app.listen(3003,function(){
  console.log('3003번포트에 연결되었습니다!');
});
