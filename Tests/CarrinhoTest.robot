*** Settings ***
Documentation  Suite de teste de casos relacionados ao carrinho no sistema

#Imports#
Resource       ..\\Pages\\PageBase.robot
Resource       ..\\Pages\\IndexPage.robot
Resource       ..\\Pages\\SearchResultPage.robot
Resource       ..\\Pages\\ShoppingCartPage.robot

#Tags#
Force Tags     Carrinho

#Teardown#
Test Teardown  Esvaziar carrinho

*** Test Cases ***
Cenário 01: Adicionar um item no carrinho e verificar confirmação
    Dado que estou na página inicial
    Quando realizo uma pesquisa por "shirt"
    E seleciono o(s) produto(s) 1 para por no carrinho
    Então deve aparecer uma janela confirmando que o produto foi adicionado no carrinho

Cenário 02: Adicionar um item no carrinho e verificar valor
    Dado que estou na página inicial
    Quando realizo uma pesquisa por "short"
    E seleciono o(s) produto(s) 3 para por no carrinho
    E entro na página do carrinho
    Então o carrinho deve apresentar o valor total dos produtos corretamente

Cenário 03: Adicionar dois itens no carrinho e verificar valor total
    Dado que estou na página inicial
    Quando realizo uma pesquisa por "yellow"
    E seleciono o(s) produto(s) 1 e 2 para por no carrinho
    E entro na página do carrinho
    Então o carrinho deve apresentar o valor total dos produtos corretamente

Cenário 04: Aumentar a quantidade do mesmo item no carrinho e verificar valor total
    Dado que estou na página inicial
    Quando realizo uma pesquisa por "dress"
    E seleciono o(s) produto(s) 1 para por no carrinho 
    E prossigo para a tela de checkout
    E aumento para 4 a sua quantidade
    Então o carrinho deve apresentar o valor atualizado dos produtos corretamente

*** Keywords ***
Dado que estou na página inicial
    Ir para página inicial

Quando realizo uma pesquisa por "${TERMO}"
    Pesquisar           TERMO=${TERMO}

E seleciono o(s) produto(s) ${PRODUTOS} para por no carrinho
    @{LISTA_PRODUTOS}             String to list          ${PRODUTOS}
    Selecionar produto            @{LISTA_PRODUTOS}

Então deve aparecer uma janela confirmando que o produto foi adicionado no carrinho
    Validar Modal de Confirmação         MENSAGEM_ESPERADA=Product successfully added to your shopping cart
    Fechar Modal de Confirmação

Esvaziar carrinho
    Ir para o carrinho
    Limpar carrinho

E entro na página do carrinho
    Ir para o carrinho

Então o carrinho deve apresentar o valor total dos produtos corretamente
    Calcular valor total e verificar se o valor correto é apresentado

E prossigo para a tela de checkout
    Clicar botão proceder para o checkout modal

E aumento para ${QTD_NOVA} a sua quantidade
    Aumentar quantidade de produto      POS=1       QTD_NOVA=4

Então o carrinho deve apresentar o valor atualizado dos produtos corretamente
    Calcular e validar valor da quantidade de produto       POS=1