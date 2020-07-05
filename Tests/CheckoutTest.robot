*** Settings ***
Documentation  Suite de teste de casos relacionados ao dar checkout nas compras do sistema

#Imports#
Resource       ..\\Pages\\PageBase.robot
Resource       ..\\Pages\\IndexPage.robot
Resource       ..\\Pages\\SearchResultPage.robot
Resource       ..\\Pages\\ShoppingCartPage.robot
Resource       ..\\Pages\\SignInPage.robot
Resource       ..\\Pages\\AddressesPage.robot
Resource       ..\\Pages\\CheckoutPage.robot

#Tags#
Force Tags     Checkout

*** Test Cases ***
Cenário 01: Fazer checkout de um produto deslogado
    Dado que eu possuo um item no carrinho e prossegui para o checkout
    E entro com as minhas credenciais de login
    Então o sistema deve prosseguir para a tela de endereços e apresentar a rua Rua da Pitanga 123 e cidade, estado e zip Cenouralandia, Alabama 12345  
    [Teardown]      Esvaziar carrinho e deslogar 

Cenário 02: Fazer checkout de um produto logado
    Dado que eu estou logado no sistema 
    E possuo um item no carrinho e prossegui para o checkout
    Então o sistema deve pular a etapa de login e ir para a de endereço
    [Teardown]      Esvaziar carrinho e deslogar

Cenário 03: Fazer checkout de dois produtos
    Dado que eu estou logado no sistema 
    E possuo dois itens no carrinho e prossegui para o checkout
    E confirmei meu endereço
    E concordei com os termos de serviço 
    Então o sistema deve apresentar a tela de pagamento, com o valor somado correto dos produtos
    [Teardown]      Esvaziar carrinho e deslogar

Cenário 04: Finalizar checkout e verificar carrinho vazio
    Dado que eu estou logado no sistema 
    E possuo dois itens no carrinho e prossegui para o checkout
    E confirmei meu endereço
    E concordei com os termos de serviço
    E selecionei o método de pagamento por cheque e confirmo
    Então o sistema deve exibir a mensagem "Your order on My Store is complete." e esvaziar o carrinho

*** Keywords ***
Dado que eu possuo um item no carrinho e prossegui para o checkout
    Ir para página inicial
    Pesquisar  TERMO=shirt
    Selecionar produto   1
    Ir para o carrinho
    Clicar botão proceder para o checkout resumo      #Utilizar especificamente o botão de proceder do resumo, já que todos os botões de "proceed to checkout" tem atributos diferentes

E entro com as minhas credenciais de login
    Realizar login  EMAIL=teste@teste.com  SENHA=123456

Então o sistema deve prosseguir para a tela de endereços e apresentar a rua ${RUA_ESPERADA} e cidade, estado e zip ${CIDADE_ESTADO_ZIP_ESPERADO}  
    Verificar endereço exibido      RUA_ESPERADA=Rua da Pitanga 123     CIDADE_ESTADO_ZIP_ESPERADO=Cenouralandia, Alabama 12345

Esvaziar carrinho e deslogar
    Ir para o carrinho
    Limpar carrinho  
    Clicar em Sign out  

Dado que eu estou logado no sistema    
    Ir para página inicial
    Clicar em Sign in
    Realizar login  EMAIL=teste@teste.com  SENHA=123456

E possuo um item no carrinho e prossegui para o checkout
    Pesquisar  TERMO=yellow
    Selecionar produto   2
    Ir para o carrinho
    Clicar botão proceder para o checkout resumo

Então o sistema deve pular a etapa de login e ir para a de endereço
    Verificar etapa atual       ETAPA_ESPERADA=03. Address

E possuo dois itens no carrinho e prossegui para o checkout
    Pesquisar  TERMO=summer
    @{LISTA_PRODUTOS}             String to list          1 e 3
    Selecionar produto            @{LISTA_PRODUTOS}
    Ir para o carrinho
    Clicar botão proceder para o checkout resumo

E confirmei meu endereço
    Clicar botão proceder para o checkout endereço

E concordei com os termos de serviço
    Marcar checkbox de termos de serviço
    Clicar botão proceder para o checkout envio

Então o sistema deve apresentar a tela de pagamento, com o valor somado correto dos produtos
    Calcular valor total e verificar se o valor correto é apresentado

E selecionei o método de pagamento por cheque e confirmo
    Clicar método de pagamento por cheque
    Clicar botão confirmar pedido

Então o sistema deve exibir a mensagem "${MENSAGEM_ESPERADA}" e esvaziar o carrinho
    Verificar mensagem de confirmação de compra  MENSAGEM_ESPERADA=${MENSAGEM_ESPERADA}
    Ir para o carrinho
    Verificar se carrinho está vazio