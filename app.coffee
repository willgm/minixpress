http = require 'http'
fs = require 'fs'
url = require 'url'
handlebars = require 'handlebars'

String::capitaliseFirst = -> @charAt(0).toUpperCase() + @slice(1)

server = http.createServer (request, response) ->

    if request.url is '/favicon.ico'
        response.writeHead 200, 'Content-Type': 'image/x-icon'
        return response.end()

    path = url.parse(request.url).pathname.substr(1).split '/'
    controllerName = path[0].capitaliseFirst() || 'Home'
    methodName = path[1] || 'index'

    view = fs.readFileSync "./views/#{controllerName}/#{methodName}.html"
    TypeController = require "./controllers/#{controllerName}.coffee"
    controller = new TypeController
    method = controller[methodName]

    response.writeHeader 200, 'Content-Type': 'text/html'
    unless controller and view and method
        response.write "Page Not Found!"
    else
        response.write handlebars.compile(view.toString())(method())
    response.end()

server.listen 3000, ->
    console.log 'MiniXpress => localhost:8080'
