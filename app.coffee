http = require 'http'
fs = require 'fs'
url = require 'url'
handlebars = require 'handlebars'
pageNotFound = fs.readFileSync "./views/404.html"
mainTemplate = fs.readFileSync "./views/main.html"

String::capitaliseFirst = -> @charAt(0).toUpperCase() + @slice(1)

server = http.createServer (request, response) ->

    if request.url is '/favicon.ico'
        response.writeHead 200, 'Content-Type': 'image/x-icon'
        return response.end()

    response.writeHeader 200, 'Content-Type': 'text/html'
    path = url.parse(request.url).pathname.substr(1).split '/'
    controllerName = path[0].capitaliseFirst() || 'Home'
    methodName = path[1] || 'index'

    fs.readFile "./views/#{controllerName}/#{methodName}.html", (err, view) ->
        return response.end pageNotFound if err

        try
            Controller = require "./controllers/#{controllerName}.coffee"
            controller = new Controller request, response

        return response.end pageNotFound unless controller and controller[methodName]

        template = handlebars.compile(view.toString()) controller[methodName]()

        response.end handlebars.compile(mainTemplate.toString()) body: template

server.listen 3000, ->
    console.log 'MiniXpress => localhost:8080'
