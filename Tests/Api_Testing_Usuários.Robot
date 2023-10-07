*** Settings ***
Resource    ../Resources/Api_Testing_Usuários.Resource


*** Variables ***



*** Test Cases ***

Cenário 01: Cadastrar um novo usuário com sucesso na ServeRest
        Criar um usuário novo
        Cadastrar o usuário criado na ServeRest
        Conferir se o usuário foi cadastrado corretamente
