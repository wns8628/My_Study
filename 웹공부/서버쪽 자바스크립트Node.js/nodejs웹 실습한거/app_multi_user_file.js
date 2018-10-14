var express = require('express');
var session = require('express-session');
var bodyParser = require('body-parser');
var FileStore = require('session-file-store')(session);//의좀
var bkfd2Password = require('pbkdf2-password');
var hasher = bkfd2Password();

var app = express();

app.use(bodyParser.urlencoded({ extended: false }));
app.use(session({
  secret: 'asdasdaadsdasd fuckkfuckkcufcufkcufkcfukukfuckfuckcufkufk',
  resave: false,
  saveUninitialized: true,
  store:new FileStore()
//  cookie: { secure: true }
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
  res.redirect('/welcome');
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
        <ul>
          <li><a href="/auth/login">login</a></li>
          <li><a href="/auth/Register">Register</a></li>
        </ul>
      `);
  }
});
var users = [
  {
    username:'egoing',
    password:'/aeXWCEMf15jR1afWiY9m4olQk4teFRyo7fqziZS+M6hQPf1lEXVwLOmOfJPGpL2WHmAS82tlkMrQOE4yWO4GUPjGdKAUNVqP2fJiihr9P/uCd855KxWdOxxAAbxSFc7lj3yi5RMN3+fP/oAQlycvOsR6krFuJLoP/xa8ddEtAc=',
    salt:'1CM2Gb2S7fNc9TN1RHSCTxXVSJIvEqmQ6CyhYr5grVTEY1hRdn5b60KeoEaJyXL+sk5A5coawcmFFOKai/g8aQ==',
    displayName:'Egoing'
  }


]
app.post('/auth/Register',function(req,res){
    hasher({password:req.body.password},function(err,pass,salt,hash){
      var user = {
        username:req.body.username,
        password:hash,
        salt:salt,
        displayName:req.body.displayName,
      };
      users.push(user);
      res.redirect('/welcome');
    });
});
app.get('/auth/Register',function(req,res){
  var output = `
  <h1>Register</h1>
  <form action="/auth/Register" method="post">
      <p>
        <input type="text" name ="username" placeholder="username">
      </p>
      <p>
        <input type="password" name ="password" placeholder="password">
      </p>
      <p>
        <input type="text" name ="displayName" placeholder="displayName">
      </p>
        <p>
      <input type="submit">
      </p>
  </form>
  `;
res.send(output);
});
app.post('/auth/login',function(req,res){
  var uname = req.body.username;
  var pwd   = req.body.password;

  for(var i=0; i<users.length; i++){
    var user = users[i];
    if(uname === user.username) {
     return  hasher({password:pwd, salt:user.salt}, function(err,pass,salt,hash){
          if(hash === user.password){
            req.session.displayName= user.displayName;
            req.session.save(function(){
              res.redirect('/welcome');
            })
          } else {
            res.send('who are you?<a href="/auth/login">login</a> ');
          }
      });
    }
    // if(uname === user.username && md5(pwd+user.salt) === user.password){
    //   req.session.displayName = user.displayName;
    //   return req.session.save(function(){
    //          res.redirect('/welcome');
    //   });
    // }
  }
  res.send('who are you?<a href="/auth/login">login</a> ');
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
