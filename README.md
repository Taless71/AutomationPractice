Projeto AutomationPractice

Esse projeto implementado em Robot Framework e Python tem como objetivo executar testes automatizados em 
diversos fluxos e cenários do site http://automationpractice.com/index.php, garantindo a funcionalidade
dos componentes oferecidos por ele, bem como também a navegação pela interface.

Fluxos escolhidos para testes automatizados, seguido dos casos de testes:
    -Login
        -Válido
        -Inválido
            -E-mail inválido
            -Senha inválida
            -Campo e-mail e senha vazios

    -Carrinho
        -Adicionar um item no carrinho e verificar mensagem de confirmação
        -Adicionar múltiplos itens no carrinho e verificar soma de seus valores
        -Adicionar um item no carrinho, aumentar sua quantidade e verificar se o valor foi alterado corretamente
        -Adicionar um item no carrinho e verificar se seu valor é exibido corretamente

    -Checkout
        -Ir para o checkout deslogado, realizar o login e verificar se o sistema foi para o próximo passo com as informações corretas do usuário logado
        -Ir para o checkout logado e verificar se o sistema pulou a etapa de login e foi para a próxima etapa
        -Ir para o checkout com dois produtos no carrinho e verificar se no ultimo passo ele apresenta corretamente o valor total dos produtos comprados
        -Ir para o checkout e finalizar a compra, verificando se no fim é exibida corretamente a mensagem de sucesso e se o carrinho é esvaziado