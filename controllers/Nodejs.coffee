Controller = require "./Controller"

module.exports = class HomeController extends Controller

    index: ->
        comentario: "it's me!"

    atributos: ->
        comentario: "eu sou:"
        list: [
            'rápido'
            'simples'
            'escalavel'
        ]

    teste: ->
        comentario: @request.url.split('/teste')[1]
