
var express       = require('express');
var cookieParser  = require('cookie-parser');

var app           = express();

app.use(cookieParser('2%@#!%@%@!CC!#!DCAASE@#!R%!%$!$!$@'));

var products ={
  1:{title:'THE history of web 1'},
  2:{title:'the next web'}
};//데이타베이스대신에이걸쓴다

app.get('/products',function(req, res) {
  var output = '';
 for(var name in products){
   output +=
        `
        <li>
        <a href="/cart/${name}">${products[name].title}</a>
        </li>

        `}
  res.send(`<h1>Products</h1><ul>${output}</ul><a href="/cart">cart</a>`);
});
app.get('/cart/:id',function(req,res){
var id = req.params.id;
if(req.signedCookies.cart){
  var cart = req.signedCookies.cart;
}else {
  var cart = {};
}
if(!cart[id]){   //카트에 아디가없을떄(제품을처음클릭했을떄)
  cart[id]=0;    //카트의 새로운 제품을추가 이거안하면 처음에 null임
}
cart[id]= cart[id]+1; //카트의 수량을 하나증가
res.cookie('cart', cart , {signed:true});
res.redirect('/cart');
});
app.get('/cart',function(req,res){
  var cart = req.cookies.cart;
  if(!cart){
    res.send('카트가 비어있습니다.');
  }else{
      var output = '';
      for(id in cart){
        output += `<li>${products[id].title} (${cart[id]})</li>`
      }
  }
  res.send(`<h1>Cart</h1>
            <ul>${output}</ul>
            <a href="/products">리스트로돌아가기</a>`)
});


app.get('/count',function(req,res){
 if(req.signedCookies.count){
  var count = parseInt(req.signedCookies.count);
}else{
    var count = 0;
}
count = count+1;
  res.cookie('count', count, {signed:true});
  res.send('count : '+count);
})

app.listen(3003,function(){
  console.log('3003번포트에 연결되었습니다!');
});
