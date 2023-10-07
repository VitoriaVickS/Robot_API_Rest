*** Settings ***
Library        RequestsLibrary
Library        String
Library    Collections

*** Keywords ***
 Criar um usuário novo
     ${Palavra_Aleatória}    Generate Random String  length=4    chars=[LETTERS]
     ${Palavra_Aleatória}    Convert To Lower Case   ${Palavra_Aleatória} 
     Set Test Variable    ${EMAIL_TESTE}    ${Palavra_Aleatória}@emailteste.com
     Log     ${EMAIL_TESTE} 

Cadastrar o usuário criado na ServeRest

    ${Body}        Create Dictionary    
    ...            nome=Fulano da Silva    
    ...            email=${EMAIL_TESTE}    
    ...            password=1234    
    ...            administrador=true
    Log    ${Body} 

    Criar Sessão na ServeRest 

    ${Resposta}    POST On Session
    ...            alias=ServeRest 
    ...            url=/usuarios
    ...            json=${Body}
    
    Log    ${Resposta.json()}
    Set Test Variable    ${RESPOSTA}    ${Resposta.json()}
 
Criar Sessão na ServeRest
     ${Headers}     Create Dictionary     accept=application/json    Content-Type=application/json
     Create Session    alias=ServeRest    url=https://serverest.dev    headers= ${Headers}  

Conferir se o usuário foi cadastrado corretamente
      Log    ${RESPOSTA}
    Dictionary Should Contain Item    ${RESPOSTA}   message     Cadastro realizado com sucesso
    Dictionary Should Contain Key     ${RESPOSTA}   _id