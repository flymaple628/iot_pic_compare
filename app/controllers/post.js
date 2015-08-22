module.paths.push('/usr/local/lib/node_modules');
var querystring = require('querystring');
var http = require('http');

var data = querystring.stringify({
      data: "yourUsernameValue"
    });

var options = {
    host: 'iot_pic_compare.enjoymaple.com',
    port: 80,
    path: '/test_datas',
    method: 'POST',
    headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Content-Length': Buffer.byteLength(data)
    }
};

var req = http.request(options, function(res) {
    res.setEncoding('utf8');
    res.on('data', function (chunk) {
        console.log("body: " + chunk);
    });
});

req.write(data);
req.end();