*** Settings ***
Documentation   Esse arquivo contém as funções e seletores referentes a tela de listagem de registros encontrados na busca do site AutomationPractice
Resource        ..\\Resources\\Resources.robot

*** Variables ***
${PRODUTOS_LISTADOS}           css=.product_list li
${BOTAO_FECHAR_MODAL}          css=#layer_cart .cross
${MENSAGEM_CONFIRMACAO_MODAL}  css=#layer_cart .layer_cart_product h2
${VALOR_PRODUTO_MODAL}         id=layer_cart_product_price
${BOTAO_PROCEDER_CHECKOUT}     css=[title="Proceed to checkout"]

*** Keywords ***
Selecionar produto 
    [Arguments]     @{POSICAO_PRODUTOS}
    Wait Until Element is Visible               id=center_column
    Execute Javascript                          document.getElementById("center_column").scrollIntoView()   #Faz rolar a tela pra centralizar a lista de produtos
    ${QTD_PRODUTOS}             Get Length      ${POSICAO_PRODUTOS}
    FOR     ${POS}      IN      @{POSICAO_PRODUTOS}
        ${SELETOR_PRODUTO_SELECIONADO}          Set Variable        ${PRODUTOS_LISTADOS}:nth-child(${POS}) .product-container
        Wait Until Element is Visible           ${SELETOR_PRODUTO_SELECIONADO}        
        Mouse Over                              ${SELETOR_PRODUTO_SELECIONADO}
        ${BOTAO_ADD_CARRINHO}                   Set Variable        ${SELETOR_PRODUTO_SELECIONADO} [title="Add to cart"]
        Wait Until Element is Visible           ${BOTAO_ADD_CARRINHO}        
        Click Element                           ${BOTAO_ADD_CARRINHO}
        Obter valor do produto no Modal
        Run Keyword If          "${QTD_PRODUTOS}">"1"    Fechar Modal de Confirmação
    END

Obter valor do produto no Modal
    Wait Until Element is Visible           ${VALOR_PRODUTO_MODAL}
    ${VALOR}                                Get Text            ${VALOR_PRODUTO_MODAL}
    ${VALOR}                                Remove String       ${VALOR}        $
    Append To List                          ${VALORES}          ${VALOR}

Validar Modal de Confirmação            
    [Arguments]                             ${MENSAGEM_ESPERADA}
    Wait Until Element is Visible           ${MENSAGEM_CONFIRMACAO_MODAL}
    Element Text Should be                  ${MENSAGEM_CONFIRMACAO_MODAL}       ${MENSAGEM_ESPERADA}

Fechar Modal de Confirmação
    Wait Until Element is Visible           ${BOTAO_FECHAR_MODAL}
    Click Element                           ${BOTAO_FECHAR_MODAL}

Clicar botão proceder para o checkout
    Wait Until Element is Visible           ${BOTAO_PROCEDER_CHECKOUT}
    Click Element                           ${BOTAO_PROCEDER_CHECKOUT}