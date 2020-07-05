*** Settings ***
Documentation   Esse arquivo contém as funções e seletores referentes a tela de carrinho do usuário do site AutomationPractice
Resource        ..\\Resources\\Resources.robot

*** Variables ***
${BOTAO_APAGAR_REGISTRO}            css=tbody tr:first-child .cart_quantity_delete                 #Esse seletor é sempre referente ao botão delete do primeiro registro
${TOTAL_DOS_PRODUTOS}               id=total_product  
${ALERTA_CARRINHO_VAZIO}            css=.alert  
${BOTAO_PROC_CHECKOUT_RESUMO}       css=.cart_navigation [title="Proceed to checkout"]
${BOTAO_PROC_CHECKOUT_ENDERECO}     css=[name="processAddress"]
${BOTAO_PROC_CHECKOUT_ENVIO}        css=[name="processCarrier"]      

*** Keywords ***
Limpar carrinho
    Wait Until Element is Visible       ${BOTAO_APAGAR_REGISTRO}
    Click Element                       ${BOTAO_APAGAR_REGISTRO}                   #Apaga o primeiro registro da lista
    ${STATUS}           Run Keyword and return status       Wait until Element is Not Visible   ${BOTAO_APAGAR_REGISTRO}    4s      
    #Verifica se o botão de excluir ainda está visível, se sim, retorna o status FALSE, fazendo em seguida com que a keyword seja executada novamente até não
    #existirem mais botões de excluir
    Run Keyword If      "${STATUS}"=="False"                Limpar carrinho
    Verificar se carrinho está vazio

Calcular valor total e verificar se o valor correto é apresentado
    ${TOTAL}                Somar Valores da lista      ${VALORES}
    Wait Until Element is Visible       ${TOTAL_DOS_PRODUTOS}
    ${TOTAL_ATUAL}      Get Text        ${TOTAL_DOS_PRODUTOS}
    ${TOTAL_ATUAL}      Remove String   ${TOTAL_ATUAL}        $     
    Should Be Equal As Strings          ${TOTAL_ATUAL}        ${TOTAL}

Aumentar quantidade de produto
    [Arguments]         ${POS}          ${QTD_NOVA}
    ${SELETOR_PRODUTO}  Set Variable    css=tbody tr:nth-child(${POS}) .cart_quantity_input
    Wait Until Element is Visible       ${SELETOR_PRODUTO}
    Input Text                          ${SELETOR_PRODUTO}      ${QTD_NOVA}
    Press Keys                          None                    TAB
    #Uma forma de tirar o foco do campo para assim a tela atualizar o valor

Calcular e validar valor da quantidade de produto
    [Arguments]         ${POS}
    ${SELETOR_PRODUTO}                  Set Variable    css=tbody tr:nth-child(${POS}) .cart_quantity_input
    ${SELETOR_VALOR_UNITARIO_PROD}      Set Variable    css=tbody tr:nth-child(${POS}) .price span:first-child
    ${SELETOR_TOTAL_UNITARIO_PROF}      Set Variable    css=tbody tr:nth-child(${POS}) .cart_total
    Wait Until Element is Visible       ${SELETOR_PRODUTO}
    ${QTD_ATUAL}        Get Element Attribute      ${SELETOR_PRODUTO}     value
    ${VALOR_UNITARIO}   Get Text        ${SELETOR_VALOR_UNITARIO_PROD}
    ${VALOR_UNITARIO}   Remove String   ${VALOR_UNITARIO}           $
    ${VALOR_TOTAL_ESPERADO}             Evaluate        ${VALOR_UNITARIO}*${QTD_ATUAL}
    Wait Until Keyword Succeeds         5s      0.5s    Element text should be              ${SELETOR_TOTAL_UNITARIO_PROF}           $${VALOR_TOTAL_ESPERADO}
    #Uma forma de esperar a página atualizar o valor. 

Clicar botão proceder para o checkout resumo
    Wait Until Element is Visible       ${BOTAO_PROC_CHECKOUT_RESUMO}
    Scroll Element Into View            ${BOTAO_PROC_CHECKOUT_RESUMO}
    Click Element                       ${BOTAO_PROC_CHECKOUT_RESUMO}
    
Clicar botão proceder para o checkout endereço
    Wait Until Element is Visible       ${BOTAO_PROC_CHECKOUT_ENDERECO}
    Scroll Element Into View            ${BOTAO_PROC_CHECKOUT_ENDERECO}
    Click Element                       ${BOTAO_PROC_CHECKOUT_ENDERECO}
    
Clicar botão proceder para o checkout envio
    Wait Until Element is Visible       ${BOTAO_PROC_CHECKOUT_ENVIO}
    Scroll Element Into View            ${BOTAO_PROC_CHECKOUT_ENVIO}
    Click Element                       ${BOTAO_PROC_CHECKOUT_ENVIO}

Verificar se carrinho está vazio
    Wait Until Element is Visible       ${ALERTA_CARRINHO_VAZIO}
    Element text should Be              ${ALERTA_CARRINHO_VAZIO}        Your shopping cart is empty.