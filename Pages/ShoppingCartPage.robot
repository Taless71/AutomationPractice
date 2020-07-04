*** Settings ***
Documentation   Esse arquivo contém as funções e seletores referentes a tela de carrinho do usuário do site AutomationPractice
Resource        ..\\Resources\\Resources.robot

*** Variables ***
${BOTAO_APAGAR_REGISTRO}        css=tbody tr:first-child .cart_quantity_delete    #Esse seletor é sempre referente ao botão delete do primeiro registro
${TOTAL_DOS_PRODUTOS}           id=total_product  
${ALERTA_CARRINHO_VAZIO}        css=.alert            

*** Keywords ***
Limpar carrinho
    Wait Until Element is Visible       ${BOTAO_APAGAR_REGISTRO}
    Click Element                       ${BOTAO_APAGAR_REGISTRO}                   #Apaga o primeiro registro da lista
    ${STATUS}           Run Keyword and return status       Wait until Element is Not Visible   ${BOTAO_APAGAR_REGISTRO}    2s      
    #Verifica se o botão de excluir ainda está visível, se sim, retorna o status FALSE, fazendo em seguida com que a keyword seja executada novamente até não
    #existirem mais botões de excluir
    Run Keyword If      "${STATUS}"=="False"                Limpar carrinho
    Element text should Be              ${ALERTA_CARRINHO_VAZIO}        Your shopping cart is empty.

Calcular valor total e verificar se o valor correto é apresentado
    ${TOTAL}                Set Variable        0
    FOR     ${VALOR}        IN          @{VALORES}
            ${TOTAL}        Evaluate    ${TOTAL} + ${VALOR}
    END
    Wait Until Element is Visible       ${TOTAL_DOS_PRODUTOS}
    ${TOTAL_ATUAL}      Get Text        ${TOTAL_DOS_PRODUTOS}
    ${TOTAL_ATUAL}      Remove String   ${TOTAL_ATUAL}        $     
    Should Be Equal As Strings          ${TOTAL_ATUAL}        ${TOTAL}