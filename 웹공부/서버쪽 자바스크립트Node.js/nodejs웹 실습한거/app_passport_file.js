var express = require('express');
var session = require('express-session');
var FileStore = require('session-file-store')(session);
var bodyParser = require('body-parser');
var bkfd2Password = require("pbkdf2-password");
var passport = require('passport');
var LocalStrategy = require('passport-local').Strategy;
var FacebookStrategy = require('passport-facebook').Strategy;
var hasher = bkfd2Password();

var app = express();
app.use(bodyParser.urlencoded({ extended: false }));
app.use(session({
  secret: '1234DSFs@adf1234!@#$asd',
  resave: false,
  saveUninitialized: true,
  store:new FileStore()
}));
app.use(passport.initialize());
app.use(passport.session());
app.get('/count', function(req, res){
  if(req.session.count) {
    req.session.count++;
  } else {
    req.session.count = 1;
  }
  res.send('count : '+req.session.count);
});
app.get('/auth/logout', function(req, res){
  req.logout();
  req.session.save(function(){
    res.redirect('/welcome');
  });
});
app.get('/welcome', function(req, res){
  if(req.user && req.user.displayName) {
    res.send(`
      <h1>Hello, ${req.user.displayName}</h1>
      <a href="/auth/logout">logout</a>
    `);
  } else {
    res.send(`
      <h1>Welcome</h1>
      <ul>
        <li><a href="/auth/login">Login</a></li>
        <li><a href="/auth/register">Register</a></li>
      </ul>
    `);
  }
});
passport.serializeUser(function(user, done) {
  console.log('serializeUser', user);
  done(null, user.authId);
});
passport.deserializeUser(function(id, done) {
  console.log('deserializeUser', id);
  for(var i=0; i<users.length; i++){
    var user = users[i];
    if(user.authId === id){
      return done(null, user);
    }
  }
  done('There is no user.');
});
passport.use(new LocalStrategy(
  function(username, password, done){
    var uname = username;
    var pwd = password;
    for(var i=0; i<users.length; i++){
      var user = users[i];
      if(uname === user.username) {
        return hasher({password:pwd, salt:user.salt}, function(err, pass, salt, hash){
          if(hash === user.password){
            console.log('LocalStrategy', user);
            done(null, user);
          } else {
            done(null, false);
          }
        });
      }
    }
    done(null, false);
  }
));
passport.use(new FacebookStrategy({
    clientID: '1378685678861130',
    clientSecret: '1c94d03c9ed0b02fe660ebdaa58415f2',
    callbackURL: "/auth/facebook/callback",
    profileFields:['id', 'email', 'gender', 'link', 'locale', 'name', 'timezone', 'updated_time', 'verified', 'displayName']
  },
  function(accessToken, refreshToken, profile, done) {
    console.log(profile);
    var authId = 'facebook:'+profile.id;
    for(var i=0; i<users.length; i++){
      var user = users[i];
      if(user.authId === authId){
        return done(null, user);
      }
    }
    var newuser = {
      'authId':authId,
      'displayName':profile.displayName,
      'email':profile.emails[0].value
    };
    users.push(newuser);
    done(null, newuser);
  }
));
app.post(
  '/auth/login',
  passport.authenticate(
    'local',
    {
      successRedirect: '/welcome',
      failureRedirect: '/auth/login',
      failureFlash: false
    }
  )
);
app.get(
  '/auth/facebook',
  passport.authenticate(
    'facebook',
    {scope:'email'}
  )
);
app.get(
  '/auth/facebook/callback',
  passport.authenticate(
    'facebook',
    {
    //  successRedirect: '/welcome',
      failureRedirect: '/auth/login'
    }
  ),
 function(req,res){
 req.session.save(function(){
 res.redirect('/welcome')
 })
 }
);
var users = [
  {
    authId:'local:egoing',
    username:'egoing',
    password:'mTi+/qIi9s5ZFRPDxJLY8yAhlLnWTgYZNXfXlQ32e1u/hZePhlq41NkRfffEV+T92TGTlfxEitFZ98QhzofzFHLneWMWiEekxHD1qMrTH1CWY01NbngaAfgfveJPRivhLxLD1iJajwGmYAXhr69VrN2CWkVD+aS1wKbZd94bcaE=',
    salt:'O0iC9xqMBUVl3BdO50+JWkpvVcA5g2VNaYTR5Hc45g+/iXy4PzcCI7GJN5h5r3aLxIhgMN8HSh0DhyqwAp8lLw==',
    displayName:'Egoing'
  }
];
app.post('/auth/register', function(req, res){
  hasher({password:req.body.password}, function(err, pass, salt, hash){
    var user = {
      authId:'local:'+req.body.username,
      username:req.body.username,
      password:hash,
      salt:salt,
      displayName:req.body.displayName
    };
    users.push(user);
    req.login(user, function(err){
      req.session.save(function(){
        res.redirect('/welcome');
      });
    });
  });
});
app.get('/auth/register', function(req, res){
  var output = `
  <h1>Register</h1>
  <form action="/auth/register" method="post">
    <p>
      <input type="text" name="username" placeholder="username">
    </p>
    <p>
      <input type="password" name="password" placeholder="password">
    </p>
    <p>
      <input type="text" name="displayName" placeholder="displayName">
    </p>
    <p>
      <input type="submit">
    </p>
  </form>
  `;
  res.send(output);
});
app.get('/auth/login', function(req, res){
  var output = `
  <h1>Login</h1>
  <form action="/auth/login" method="post">
    <p>
      <input type="text" name="username" placeholder="username">
    </p>
    <p>
      <input type="password" name="password" placeholder="password">
    </p>
    <p>
      <input type="submit">
    </p>
  </form>
  <a href="/auth/facebook">facebook</a>
  `;
  res.send(output);
});
app.listen(3003, function(){
  console.log('Connected 3003 port!!!');
});



// var express = require('express');
// var session = require('express-session');
// var bodyParser = require('body-parser');
// var FileStore = require('session-file-store')(session);//의좀
// var bkfd2Password = require('pbkdf2-password');
// var passport = require('passport')
// var LocalStrategy = require('passport-local').Strategy;
// var FacebookStrategy = require('passport-facebook').Strategy;
//
// var hasher = bkfd2Password();
//
// var app = express();
//
// app.use(bodyParser.urlencoded({ extended: false }));
// app.use(session({
//   secret: 'asdasdaadsdasd fuckkfuckkcufcufkcufkcfukukfuckfuckcufkufk',
//   resave: false,
//   saveUninitialized: true,
//   store:new FileStore()
// //  cookie: { secure: true }
// }));
// app.use(passport.initialize());
// app.use(passport.session());   //패스포트초기화 하고 우리의레고에조합한거겟지  인증에세션을하용하겟다.
// app.get('/count',function(req,res){
//   if(req.session.count){
//     req.session.count++
//   }else {
//    req.session.count =1;
//   }
//   res.send('count : '+req.session.count);
// });
// app.get('/tmp', function(req,res){
//   res.send('result : '+ req.session.count);
// });
// app.get('/auth/logout',function(req, res){
//
//   req.logout();
//   req.session.save(function(){
//   res.redirect('/welcome');
//   });
//   // delete req.session.displayName;
// });
// app.get('/welcome', function(req,res){
//   if(req.user && req.user.displayName){
//     res.send(`
//       <h1>Hello, ${req.user.displayName} </h1>
//       <a href="/auth/logout">logout</a>
//       `);
//   } else {
//     res.send(`
//         <h1>welcome</h1>
//         <ul>
//           <li><a href="/auth/login">login</a></li>
//           <li><a href="/auth/Register">Register</a></li>
//         </ul>
//       `);
//   }
// });
// var users = [
//   {
//     authId:'local:egoing',
//     username:'egoing',
//     password:'/aeXWCEMf15jR1afWiY9m4olQk4teFRyo7fqziZS+M6hQPf1lEXVwLOmOfJPGpL2WHmAS82tlkMrQOE4yWO4GUPjGdKAUNVqP2fJiihr9P/uCd855KxWdOxxAAbxSFc7lj3yi5RMN3+fP/oAQlycvOsR6krFuJLoP/xa8ddEtAc=',
//     salt:'1CM2Gb2S7fNc9TN1RHSCTxXVSJIvEqmQ6CyhYr5grVTEY1hRdn5b60KeoEaJyXL+sk5A5coawcmFFOKai/g8aQ==',
//     displayName:'Egoing'
//   }
//
//
// ]
// app.post('/auth/Register',function(req,res){
//     hasher({password:req.body.password},function(err,pass,salt,hash){
//       var user = {
//         authId:'local:'+req.body.username,
//         username:req.body.username,
//         password:hash,
//         salt:salt,
//         displayName:req.body.displayName,
//       };
//       users.push(user);
//       req.login(user,function(){
//         req.session.save(function(){
//           res.redirect('/welcome');
//         });
//       });
//    });
// });
// app.get('/auth/Register',function(req,res){
//   var output = `
//   <h1>Register</h1>
//   <form action="/auth/Register" method="post">
//       <p>
//         <input type="text" name ="username" placeholder="username">
//       </p>
//       <p>
//         <input type="password" name ="password" placeholder="password">
//       </p>
//       <p>
//         <input type="text" name ="displayName" placeholder="displayName">
//       </p>
//         <p>
//       <input type="submit">
//       </p>
//   </form>
//   `;
// res.send(output);
// });
//
// //아디비번이맞다면 이게실행
// passport.serializeUser(function(user, done) { //user인자랑 done(null,user)인자랑같아야함
//   done(null, user.authId);  //한명한명구별하는식별자를 넣어줘야됨 =>세션등록
// });
//
// //처음말고 나중에 다시접속했을때 이콜백이실행 즉 식별자 user.username 이 id로오겠지
// passport.deserializeUser(function(id, done) {
//   for(var i=0; i<users.length; i++){
//     var user =users[i];
//     if(user.authId === id){
//      return  done(null, user);
//     }
//   }
//   done('There is no user.');
// });
//
// passport.use(new LocalStrategy(
//   function(username,password,done){
//       var uname = username;
//       var pwd   = password;
//
//       for(var i=0; i<users.length; i++){
//         var user = users[i];
//         if(uname === user.username) {
//          return  hasher({password:pwd, salt:user.salt}, function(err,pass,salt,hash){
//               if(hash === user.password){
//                 done(null, user); //아디비번이 맞다면
//                 // req.session.displayName= user.displayName;
//                 // req.session.save(function(){
//                 //   res.redirect('/welcome');
//                 // })
//               } else {
//                 done(null, false);
//                 // res.send('who are you?<a href="/auth/login">login</a> ');
//               }
//           });
//         }
//       }
//       done(null, false);
//       // res.send('who are you?<a href="/auth/login">login</a> ');
//   }
// ));
//
// //페북스트레티지
// passport.use(new FacebookStrategy({
//     clientID: '1378685678861130',
//     clientSecret: '1c94d03c9ed0b02fe660ebdaa58415f2',
//     callbackURL: "/auth/facebook/callback",
//     profileFields:['id','email','gender','link','locale',
//    'name', 'timezone', 'updated_time', 'verified', 'displayName']
//   },
//   function(accessToken, refreshToken, profile, done) {
//     console.log(profile);
//     var authId = 'facebook:'+ profile.id;
//     for(var i=0; i<users.length; i++){
//       var user = users[i];
//       if(user.authId == authId){
//          return done(null, user);
//       }
//     }
//     var newuser ={
//       'authId':authId,
//       'displayName': profile.displayName,
//       'email':profile.emails[0].value
//     };
//     users.push(newuser);
//     done(null, newuser);
//   }
// ));
//
// app.post('/auth/login',
//   passport.authenticate(
//     'local',
//      { successRedirect: '/welcome',
//        failureRedirect: '/auth/login',
//        failureFlash: false
//      }
//      )
//    );
// app.get('/auth/facebook',
//  passport.authenticate(
//   'facebook',
//   {scope:'email'}
//   )
// );
//
// app.get('/auth/facebook/callback',
//   passport.authenticate('facebook', { successRedirect: '/welcome',
//                                       failureRedirect: '/auth/login' }));
//
// app.get('/auth/login',function(req,res){
//   var output =`
//   <h1>Login</h1>
//   <form action="/auth/login" method="post">
//     <p>
//       <input type="text" name ="username" placeholder="username">
//     </p>
//     <p>
//       <input type="password" name ="password" placeholder="password">
//     </p>
//     <p>
//       <input type="submit">
//       </p>
//       <a href="/auth/facebook">facebook</a>
//   </form>
//   `
//   res.send(output);
// });
//
// app.listen(3003,function(){
//   console.log('3003번포트에 연결되었습니다!');
// });
