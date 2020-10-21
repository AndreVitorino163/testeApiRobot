***Settings ***
Documentation   http://www.omdbapi.com/
Library         RequestsLibrary
Library         Collections

***Variables***

${ID_DO_FILME}     
${API_KEY}        52ec71bf   
${URL_API}        http://www.omdbapi.com/

## Dados do filme a ser pesquisado

#Filme Válido
&{FILME_ID}          Title=The Social Network
...                  Year=2010
...                  Language=English, French

#Filme Inexistente
&{FILME_INEXISTENTE}   Response=False
...                   Error=Incorrect IMDb ID.       



***Keywords***

##Conecta API
Conectar API

    Create Session   api  ${URL_API}
  
##Consulta um filme com os parametros informados
Consultar filme "${ID_DO_FILME}" "${API_KEY2}"

    ##Faz a GET request de acordo com a Library Requests
    ${RESPOSTA}     Get Request   api   ?i=${ID_DO_FILME}&apikey=${API_KEY}
    
    log                   ${RESPOSTA.text}
    Set Test Variable     ${RESPOSTA}

##Confere o response de acordo com o codigo desejado - 200= ok
Conferir status code

    [Arguments]    ${STATUSCODE_DESEJADO}
    Should be Equal As Strings     ${RESPOSTA.status_code}    ${STATUSCODE_DESEJADO}

## Busca no Response.json pelos dados do filme pesquisado e os compara com o dicionario que contem os daods esperados para o caso
Conferir dados do filme existente

    Dictionary should Contain Item     ${RESPOSTA.json()}    Title      ${FILME_ID.Title}
    Dictionary should Contain Item     ${RESPOSTA.json()}    Year       ${FILME_ID.Year}
    Dictionary should Contain Item     ${RESPOSTA.json()}    Language   ${FILME_ID.Language}

## Busca por um filme inexistente e compara com o dicionário que contém a resposta esperada para esse caso
Conferir dados do filme Inexistente

    Dictionary should Contain Item     ${RESPOSTA.json()}    Response      ${FILME_INEXISTENTE.Response}
    Dictionary should Contain Item     ${RESPOSTA.json()}    Error       ${FILME_INEXISTENTE.Error}