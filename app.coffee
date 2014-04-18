http = require 'http'
fs = require 'fs'
url = require 'url'

server = http.createServer (request, response) ->
    path = url.parse(request.url).pathname.substr(1) or 'index'
    fs.readFile "./views/#{path}.html", (err, html) ->
        response.writeHeader 200, 'Content-Type': 'text/html'
        response.write unless err then html else "Page Not Found!"
        response.end()

server.listen 3000, ->
    console.log 'MiniXpress => localhost:8080'
