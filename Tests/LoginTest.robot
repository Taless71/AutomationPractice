*** Settings ***
Documentation  Suite de teste de casos relacionados ao login no sistema

#Imports#
Resource       ..\\Pages\\PageBase.robot
Resource       ..\\Pages\\IndexPage.robot
Resource       ..\\Pages\\SignInPage.robot
Resource       ..\\Pages\\MyAccountPage.robot

#Tags#
Force Tags     Login

#Setup#
Test Setup     Inicializar variáveis de teste

*** Test Cases ***
Cenário 01: Login válido
    Dado que estou na página inicial
    Quando clico em "Sign in"
    E realizo um login com email "${EMAIL_VALIDO}" e senha "${SENHA_VALIDA}"
    Então a tela "My Account" deve ser mostrada
    [Teardown]    Realizar logout

Cenário 02: Login inválido - email
    Dado que estou na página inicial
    Quando clico em "Sign in"
    E realizo um login com email "${EMAIL_INVALIDO}" e senha "${SENHA_VALIDA}"
    Então a tela deve apresentar a mensagem "Authentication failed"

Cenário 03: Login inválido - senha
    Dado que estou na página inicial
    Quando clico em "Sign in"
    E realizo um login com email "${EMAIL_VALIDO}" e senha "${SENHA_INVALIDA}"
    Então a tela deve apresentar a mensagem "Authentication failed"

Cenário 04: Login inválido - e-mail e senha em branco
    Dado que estou na página inicial
    Quando clico em "Sign in"
    E realizo um login com email e senha em branco
    Então a tela deve apresentar a mensagem "An email address required"

*** Keywords ***
Inicializar variáveis de teste
    ${EMAIL_RANDOM}         Generate Random String      length=5
    ${SENHA_RANDOM}         Generate Random String      length=5
    Set Test Variable       ${EMAIL_INVALIDO}           ${EMAIL_RANDOM}@email.com
    Set Test Variable       ${SENHA_INVALIDA}           ${SENHA_RANDOM}
    Set Test Variable       ${EMAIL_VALIDO}             teste@teste.com
    Set Test Variable       ${SENHA_VALIDA}             123456

Dado que estou na página inicial
    Ir para página inicial

Quando clico em "Sign in"
    Clicar em Sign in

E realizo um login com email "${EMAIL}" e senha "${SENHA}"
    Realizar login   EMAIL=${EMAIL}   SENHA=${SENHA}

Então a tela deve apresentar a mensagem "${MENSAGEM}"
    Verificar mensagem de erro      MENSAGEM_ESPERADA=${MENSAGEM}

Realizar logout
    Clicar em Sign out

Então a tela "My Account" deve ser mostrada
    Verificar mensagem de login efetuado

E realizo um login com email e senha em branco
    Realizar login   EMAIL=${EMPTY}   SENHA=${EMPTY}