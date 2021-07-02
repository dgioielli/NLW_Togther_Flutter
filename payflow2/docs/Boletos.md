# Funcionamento do sistema de leitura Boletos

Temos aqui algumas informações importantes sobre a estrutura dos números de boletos

## Boleto comum:
- A linha digitável do boleto possui 47 caracteres.
- O Código de barras em sí é composto por 44 caracteres.
    - Exemplo de linha digitável: 001 9 05009 ( 5 ) 401448 1606 ( 9 ) 0680935031 ( 4 ) 337370000000100
    - Exemplo do código de barras equivalente: 001 9 337370000000100 05009 401448 16060680935031
- Especificação das posições da linha digitável:
    - `Posição 01-03` = identificação do banco (001 = Banco do Brasil)
    - `Posição 04-04` = código da moeda (9 = Real)
    - `Posição 05-09` = 5 primeiras posições do campo livre (*)
    - `Posição 10-10` = dígito verificador do primeiro campo
    - `Posição 11-20` = 6ª a 15ª posições do campo livre (*)
    - `Posição 21-21` = dígito verificador do segundo campo
    - `Posição 22-31` = 16ª a 25ª posições do campo livre (*)
    - `Posição 32-32` = dígito verificador do terceiro campo
    - `Posição 33-33` = dígito verificador geral
    - `Posição 34-37` = fator de vencimento (3737 = 31/12/2007) **(A data de vencimento começa a partir de  07/10/1997)**
    - `Posição 38-47` = valor do boleto (100 = R$1,00)