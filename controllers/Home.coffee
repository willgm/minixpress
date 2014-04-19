Controller = require "./Controller"

module.exports =  class HomeController extends Controller

    index: ->
        body: "Bem Vindo!!"
