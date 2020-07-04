*** Settings ***
Documentation   
...             Esse arquivo contem as funções e seletores referentes a tela Index do site AutomationPractice
Resource        ..\\Resources\\Resources.robot

*** Variables ***

*** Keywords ***
Ir para página inicial
    Go To       ${URL_BASE}