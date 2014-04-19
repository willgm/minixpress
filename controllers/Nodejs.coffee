Controller = require "./Controller"

module.exports = class HomeController extends Controller

    index: ->
        body: "it's me!"

    atributos: ->
        body: "eu sou:"
        list: [
            'rápido'
            'simples'
            'escalavel'
        ]
