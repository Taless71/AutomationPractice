*** Settings ***
Documentation  Suite de teste de casos relacionados ao carrinho no sistema
Resource       ..\\Pages\\PageBase.robot
Resource       ..\\Pages\\IndexPage.robot
Resource       ..\\Pages\\SearchResultPage.robot
Resource       ..\\Pages\\ShoppingCartPage.robot

Force Tags     Carrinho

Test Teardown  Esvaziar carrinho

*** Test Cases ***
Cenário 01: Adicionar um item no carrinho e verificar confirmação
    Dado que estou na página inicial
    Quando realizo uma pesquisa por "shirt"
    E adiciono o primeiro resultado no carrinho
    Então deve aparecer uma janela confirmando que o produto foi adicionado no carrinho

Cenário 02: Adicionar um item no carrinho e verificar valor
    Dado que estou na página inicial
    Quando realizo uma pesquisa por "short"
    E adiciono o terceiro resultado no carrinho 
    E entro na página do carrinho
    Então o carrinho deve apresentar o valor total dos produtos corretamente

Cenário 03: Adicionar dois itens no carrinho e verificar valor total
    Dado que estou na página inicial
    Quando realizo uma pesquisa por "yellow"
    E adiciono o primeiro e segundo resultados no carrinho 
    E entro na página do carrinho
    Então o carrinho deve apresentar o valor total dos produtos corretamente

# Teste
#     Teste
#     ${TESTE}    Teste
#     Log         ${TESTE}

*** Keywords ***
Dado que estou na página inicial
    Ir para página inicial

Quando realizo uma pesquisa por "${TERMO}"
    Pesquisar           TERMO=${TERMO}

E adiciono o primeiro resultado no carrinho
    Selecionar produto  POSICAO_PRODUTO=1

Então deve aparecer uma janela confirmando que o produto foi adicionado no carrinho
    Validar Modal de Confirmação         MENSAGEM_ESPERADA=Product successfully added to your shopping cart
    Fechar Modal de Confirmação

Esvaziar carrinho
    Ir para o carrinho
    Limpar carrinho

E adiciono o terceiro resultado no carrinho
    Inicializar lista de valores
    Selecionar produto      POSICAO_PRODUTO=3
    Obter valor do produto no Modal
    Fechar Modal de Confirmação

E entro na página do carrinho
    Ir para o carrinho

Então o carrinho deve apresentar o valor total dos produtos corretamente
    Calcular valor total e verificar se o valor correto é apresentado

E adiciono o primeiro e segundo resultados no carrinho
    Inicializar lista de valores
    Selecionar produto      POSICAO_PRODUTO=1
    Obter valor do produto no Modal
    Fechar Modal de Confirmação
    Selecionar produto      POSICAO_PRODUTO=2
    Obter valor do produto no Modal
    Fechar Modal de Confirmação