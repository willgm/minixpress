Controller = require "./Controller"

module.exports =  class HomeController extends Controller

    index: ->
        body: "meus atributos:"
        list: [
            'rápido'
            'simples'
            'escalavel'
        ]