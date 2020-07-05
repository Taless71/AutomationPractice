*** Settings ***
Documentation    Esse arquivo contem as funções e seletores referentes a tela de endereços do usuário do site AutomationPractice
Resource        ..\\Resources\\Resources.robot

*** Variables ***
${BOTAO_ADD_ENDERECO}           css=[title="Add an address"]
${RUA_ENDERECO_ENTREGA}         css=#address_delivery .address_address1         #css pra não conflitar com a rua do endereço de cobrança
${CIDADE_ESTADO_ZIP}            css=.address_city
${RUA_ENDERECO_ENTREGA}         css=#address_delivery .address_address1         

*** Keywords ***
Verificar endereço exibido
    [Arguments]     ${RUA_ESPERADA}     ${CIDADE_ESTADO_ZIP_ESPERADO}
    Wait Until Element is Visible       ${RUA_ENDERECO_ENTREGA}
    Element Text Should Be              ${RUA_ENDERECO_ENTREGA}     ${RUA_ESPERADA}
    Element Text Should Be              ${CIDADE_ESTADO_ZIP}        ${CIDADE_ESTADO_ZIP_ESPERADO}