http = require 'http'
fs = require 'fs'

server = http.createServer (request, response) ->
    fs.readFile __dirname + '/index.html', (err, html) ->
        response.writeHeader 200, 'Content-Type': 'text/html'
        response.write(html)
        response.end()

server.listen 3000, ->
    console.log 'Executando Site Pessoal'
