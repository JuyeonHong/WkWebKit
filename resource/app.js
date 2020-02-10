var express = require('express');
var app = express();

// var main = require('./main'); // main 모듈 불러오기

// app.use('/main', main); // /main으로 들어오면 main을 불러라

// 주소가 '/' 최상위 url로 들어오면 Hello hello 내보냄
app.get('/', function(req,res) {
    res.send("<h1>hello hello</h1>");
})

app.get('/main', function(req, res) {
    console.log('main.js is loaded');
    res.sendfile('./test.html');
})

// 3000번 포트로 들어오면 열어주는 부분
app.listen(3000, function() {
    console.log('example app listening on port 3000');
})