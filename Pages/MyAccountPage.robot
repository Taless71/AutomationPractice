*** Settings ***
Documentation   
...             Esse arquivo contem as funções e seletores referentes a tela do usuário do site AutomationPractice
Resource        ..\\Resources\\Resources.robot

*** Variables ***
${MENSAGEM_WELCOME}     css=.info-account

*** Keywords ***
Verificar mensagem de login efetuado
    Wait Until Element is Visible   ${MENSAGEM_WELCOME}
    Element Should Contain          ${MENSAGEM_WELCOME}     Welcome to your account