http = require 'http'
fs = require 'fs'
url = require 'url'

String::capitaliseFirst = -> @charAt(0).toUpperCase() + @slice(1)

server = http.createServer (request, response) ->

    if request.url is '/favicon.ico'
        response.writeHead 200, 'Content-Type': 'image/x-icon'
        return response.end()

    path = url.parse(request.url).pathname.substr 1
    view = fs.readFileSync "./views/#{ path || 'index' }.html"
    TypeController = require "./controllers/#{path.capitaliseFirst() || 'Home'}.coffee"
    controller = new TypeController

    response.writeHeader 200, 'Content-Type': 'text/html'
    unless controller and view
        response.write "Page Not Found!"
    else
        response.write view.toString().replace '{{body}}', controller.index()
    response.end()

server.listen 3000, ->
    console.log 'MiniXpress => localhost:8080'
