# Esboços das Telas Principais - FemmeHub

## Paleta de Cores
- **Rosa Principal**: #E99CAE
- **Verde Suave**: #C2DD80
- **Rosa Escuro (Destaque)**: #D56989
- **Rosa Claro (Background)**: #F3EEF2

## 1. Tela de Cadastro/Edição de Produto
Formulário com campos: Nome do Produto, Código, Descrição, Preço Unitário e Unidade de Medida. AppBar com título e ícone de voltar. Botão de salvar estilizado na parte inferior. Usa SingleChildScrollView para evitar overflow em telas menores.

## 2. Tela de Novo Pedido de Venda/Compra
Formulário com dados da cliente (nome, telefone, endereço, bairro, número), seleção de produtos com quantidade, tipo de entrega (entrega ou retirada) e cálculo automático do valor total. Lista de itens adicionados com opção de remover. Resumo do pedido na parte inferior.

## 3. Tela de Cadastro/Edição de Fornecedor
Formulário com campos: Nome, CNPJ, Telefone, Email e Endereço. AppBar com título e ícone de voltar. Botão de salvar estilizado na parte inferior. Usa SingleChildScrollView para evitar overflow.

## Fluxo de Navegação
Home → [Cadastro Produto | Novo Pedido | Cadastro Fornecedor]

## Padrão Visual
- Material Design 3
- Paleta rosa e verde voltada ao público feminino
- Ícones do Material Icons
- Feedback visual para ações (SnackBars)
- SingleChildScrollView em formulários para evitar overflow
- Expanded e Flexible para adaptação a diferentes tamanhos de tela
