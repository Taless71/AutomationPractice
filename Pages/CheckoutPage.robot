*** Settings ***
Documentation    Esse arquivo contem as funções e seletores referentes as etapas de checkout do site AutomationPractice

Resource        ..\\Resources\\Resources.robot

*** Variables ***
${ETAPA_ATUAL}              css=.step_current
${CHECKBOX_TERMOS}          css=.checker
${CHECKBOX_TERMOS_input}    id=cgv
${METODO_PAG_CHEQUE}        css=.cheque
${BOTAO_CONFIRMAR_PEDIDO}   css=.cart_navigation [type="submit"]
${MENSAGEM_SUCESSO}         css=.alert-success

*** Keywords ***
Verificar etapa atual
    [Arguments]     ${ETAPA_ESPERADA}   
    Wait Until Element is Visible       ${ETAPA_ATUAL}
    Element Text Should Be              ${ETAPA_ATUAL}      ${ETAPA_ESPERADA}

Marcar checkbox de termos de serviço
    Wait Until Element is Visible       ${CHECKBOX_TERMOS}
    Select Checkbox                     ${CHECKBOX_TERMOS_input}

Clicar método de pagamento por cheque
    Wait Until Element is Visible       ${METODO_PAG_CHEQUE}
    Scroll Element Into View            ${METODO_PAG_CHEQUE}
    Click Element                       ${METODO_PAG_CHEQUE}

Clicar botão confirmar pedido
    Wait Until Element is Visible       ${BOTAO_CONFIRMAR_PEDIDO}
    Scroll Element Into View            ${BOTAO_CONFIRMAR_PEDIDO}
    Click Element                       ${BOTAO_CONFIRMAR_PEDIDO}

Verificar mensagem de confirmação de compra
    [Arguments]                         ${MENSAGEM_ESPERADA}
    Wait Until Element is Visible       ${MENSAGEM_SUCESSO}
    Element Text Should Be              ${MENSAGEM_SUCESSO}     ${MENSAGEM_ESPERADA}        