*** Settings ***
Documentation   Esse arquivo contém funções e seletores em comum entre todas as telas do sistema
Resource        ..\\Resources\\Resources.robot   

*** Variables ***
${BOTAO_SIGN_IN}    css=.login
${BOTAO_SIGN_OUT}   css=.logout
${CAMPO_PESQUISA}   css=.search_query
${BOTAO_PESQUISAR}  css=#searchbox .btn     #Seletor específico do botão "Search", para evitar problemas com o nome "submit" em outros lugares do sistema
${BOTAO_CARRINHO}   css=[title="View my shopping cart"]

*** Keywords ***
Clicar em Sign in
    Wait Until Element is Visible       ${BOTAO_SIGN_IN}
    Click Element                       ${BOTAO_SIGN_IN}

Clicar em Sign out
    Wait Until Element is Visible       ${BOTAO_SIGN_OUT}
    CLick Element                       ${BOTAO_SIGN_OUT}
    Wait Until Element is Not Visible   ${BOTAO_SIGN_OUT}

Pesquisar
    [Arguments]     ${TERMO}
    Wait Until Element is Visible       ${CAMPO_PESQUISA}
    Input Text                          ${CAMPO_PESQUISA}       ${TERMO}
    Click Element                       ${BOTAO_PESQUISAR} 

Ir para o carrinho
    Go To                               ${URL_BASE}index.php?controller=order

Inicializar lista de valores
    @{VALORES}      Create List
    Set Test Variable       ${VALORES}