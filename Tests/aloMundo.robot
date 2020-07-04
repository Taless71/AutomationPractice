*** Settings ***
Library         SeleniumLibrary

#Setups e Teardowns
Suite Setup     Inicializar
Suite Teardown  Close Browser

#Cases
*** Test Cases ***
Alo mundo
    Go To       http://automationpractice.com/index.php

*** Keywords ***
Inicializar
    Open Browser   http://www.google.com.br     chrome
    Maximize Browser Window   