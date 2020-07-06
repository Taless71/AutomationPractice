*** Settings ***
Documentation   Arquivo que centraliza o Suite Setup e o Suite Teardown em comum entre todos os suites de teste

Resource        ..\\Resources\\Resources.robot

Suite Setup     Abrir Navegador
Suite Teardown  Fechar Navegador