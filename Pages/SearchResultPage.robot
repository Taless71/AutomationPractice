*** Settings ***
Documentation   Esse arquivo contém as funções e seletores referentes a tela de listagem de registros encontrados na busca do site AutomationPractice
Resource        ..\\Resources\\Resources.robot

*** Variables ***
${PRODUTOS_LISTADOS}                css=.product_list li
${BOTAO_FECHAR_MODAL}               css=#layer_cart .cross
${MENSAGEM_CONFIRMACAO_MODAL}       css=#layer_cart .layer_cart_product h2
${VALOR_PRODUTO_MODAL}              id=layer_cart_product_price
${BOTAO_PROCEDER_CHECKOUT_MODAL}    css=#layer_cart [title="Proceed to checkout"]
${BOTAO_}

*** Keywords ***
Selecionar produto 
    [Arguments]     @{POSICAO_PRODUTOS}
    Inicializar lista de valores
    ${QTD_PRODUTOS}             Get Length      ${POSICAO_PRODUTOS}
    FOR     ${POS}      IN      @{POSICAO_PRODUTOS}
        ${SELETOR_PRODUTO_SELECIONADO}          Set Variable        ${PRODUTOS_LISTADOS}:nth-child(${POS}) .product-container
        Wait Until Element is Visible           ${SELETOR_PRODUTO_SELECIONADO}        
        ${BOTAO_ADD_CARRINHO}                   Set Variable        ${SELETOR_PRODUTO_SELECIONADO} [title="Add to cart"]
        Focar Produto                           ${SELETOR_PRODUTO_SELECIONADO}      ${BOTAO_ADD_CARRINHO}           
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

Clicar botão proceder para o checkout modal
    Wait Until Element is Visible           ${BOTAO_PROCEDER_CHECKOUT_MODAL}
    Scroll Element Into View                ${BOTAO_PROCEDER_CHECKOUT_MODAL}
    Click Element                           ${BOTAO_PROCEDER_CHECKOUT_MODAL}

Focar Produto
    [Arguments]                 ${SELETOR_PRODUTO}      ${BOTAO_ADD_CARRINHO}
    Scroll Element Into View    ${SELETOR_PRODUTO}
    Mover cursor do mouse       0   0   
    #Caso o cursor esteja posicionado em cima do produto durante a execução dos testes, o robot não consegue executar o comando Mouse Over
    #Uma solução foi criar essa keyword em python que nada mais faz do que mover o cursor para determinada posição da tela
    Mouse Over                  ${SELETOR_PRODUTO}
    ${STATUS}                   Run Keyword and Return Status           Wait Until Element is Visible           ${BOTAO_ADD_CARRINHO}  
    Run Keyword If              "${STATUS}"=="False"                    Focar Produto       ${SELETOR_PRODUTO}  ${BOTAO_ADD_CARRINHO}