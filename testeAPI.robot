***Settings ***
Documentation   http://www.omdbapi.com/
Resource        resource.robot
Suite Setup     Conectar API


*** Test Case ***

Buscar Filme especifico (GET)

    Consultar filme "tt1285016" "${API_KEY}"
    Conferir status code    200
    Conferir dados do filme existente

Buscar Filme Inexistente (GET)

    Consultar filme "123" "${API_KEY}"
    Conferir status code    200
    Conferir dados do filme Inexistente
    
    
    


