*** Settings ***
Documentation   
...             Projeto de automação de testes do site AutomationPractice
...             Esse arquivo contem as bibliotecas, variáveis e funções básicas compartilhadas por todo o projeto
...             Criador por Tales Fernando Segundo

Library         SeleniumLibrary
Library         String
Library         BuiltIn
Library         Collections
Library         Funcoes.py

*** Variables ***
${URL_BASE}     http://automationpractice.com/
${BROWSER}      chrome

*** Keywords ***
Abrir Navegador
    Set Selenium Speed              0.1 seconds
    Open Browser    about:blank     ${BROWSER}
    Maximize Browser Window   

Fechar Navegador
    Close Browser

Inicializar lista de valores
    [Documentation]
    ...     Keyword resposável por inicializar uma lista de valores quando necessário.
    ...     Utilizada para armazenar os valores de produtos adicionados no carrinho
    ...     Setada como variável de teste
    @{VALORES}      Create List
    Set Test Variable       ${VALORES}