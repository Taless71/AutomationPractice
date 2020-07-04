*** Settings ***
Documentation   
...             Esse arquivo contem as funções e seletores referentes a tela de login do site AutomationPractice
Resource        ..\\Resources\\Resources.robot

*** Variables ***
${EMAIL_LOGIN}          id=email
${SENHA_LOGIN}          id=passwd
${BOTAO_SUBMIT_LOGIN}   id=SubmitLogin
${ALERTA_ERRO}          css=.alert:not([style="display:none"])  #Esse seletor pega somente o alerta atualmente visível na tela

*** Keywords ***
Realizar login
    [Arguments]        ${EMAIL}         ${SENHA}
    Wait Until Element is Visible       ${EMAIL_LOGIN}
    Input Text         ${EMAIL_LOGIN}         ${EMAIL}      #Preenche campo email
    Input Text         ${SENHA_LOGIN}         ${SENHA}      #Preenche campo senha
    Click Element      ${BOTAO_SUBMIT_LOGIN}                #Clica no botão Sign in

Verificar mensagem de erro
    [Arguments]        ${MENSAGEM_ESPERADA}
    Wait Until Element is Visible               ${ALERTA_ERRO}
    Element Should Contain     ${ALERTA_ERRO}   ${MENSAGEM_ESPERADA}