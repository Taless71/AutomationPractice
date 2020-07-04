*** Settings ***
Documentation   Esse arquivo contém funções e seletores em comum entre todas as telas do sistema
Resource        ..\\Resources\\Resources.robot   

*** Variables ***
${BOTAO_SIGN_IN}    css=.login
${BOTAO_SIGN_OUT}   css=.logout

*** Keywords ***
Clicar em Sign in
    Wait Until Element is Visible       ${BOTAO_SIGN_IN}
    Click Element                       ${BOTAO_SIGN_IN}

Clicar em Sign out
    Wait Until Element is Visible       ${BOTAO_SIGN_OUT}
    CLick Element                       ${BOTAO_SIGN_OUT}
    Wait Until Element is Not Visible   ${BOTAO_SIGN_OUT}