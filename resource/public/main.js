// var express = require('express');
// var app = express();
// var router = express.Router();

// router.get('/', function(req, res) {
//     console.log('main.js is loaded');
//     res.sendfile('./test.html');
// });

function sendLoginAction() {
	try {
        console.log('sendLoginAction is called')
	    webkit.messageHandlers.loginAction.postMessage(
	    	document.getElementById("email").value + " " + document.getElementById("password").value
	    );
    } catch(err) {
        console.log('The native context does not exist yet');
    }
}

function mobileHeader() {
    console.log('mobileHeader is called.')
    document.querySelector('h1').innerHTML = "WKWebView Mobile";
}

// module.exports = router;