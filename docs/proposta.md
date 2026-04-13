# Proposta do Projeto - FemmeHub

## Nome do Aplicativo
**FemmeHub**

## Problema que Resolve
O FemmeHub é um sistema de controle de estoque voltado para empreendedoras e negócios femininos, permitindo gerenciar produtos, fornecedores, pedidos de compra e pedidos de venda de forma prática e intuitiva através de dispositivos móveis. O aplicativo resolve a necessidade de mulheres empreendedoras que precisam controlar seu estoque em tempo real, registrar entradas e saídas de produtos, e gerenciar relacionamentos com fornecedores — tudo com uma interface acolhedora e pensada para o público feminino.

## Público-Alvo
- Mulheres empreendedoras que necessitam controlar estoque
- Pequenas e médias empresas lideradas por mulheres
- Gestoras de estoque que precisam de mobilidade
- Comerciantes que desejam digitalizar o controle de produtos
- Empreendedoras que já utilizam a API FemmeHub e precisam de uma interface mobile

## Funcionalidades Principais

### 1. Autenticação
- Login de usuárias
- Controle de acesso ao sistema

### 2. Gestão de Produtos
- Cadastro de produtos (nome, código, descrição, preço, unidade de medida)
- Listagem de produtos em estoque
- Edição e exclusão de produtos
- Busca e filtros de produtos

### 3. Gestão de Fornecedores
- Cadastro de fornecedores (nome, CNPJ, telefone, email, endereço)
- Listagem de fornecedores
- Vinculação de produtos aos fornecedores
- Edição e exclusão de fornecedores

### 4. Pedidos de Compra
- Criação de pedidos de compra
- Seleção de fornecedor
- Adição de itens ao pedido
- Visualização de histórico de pedidos de compra

### 5. Pedidos de Venda
- Criação de pedidos de venda
- Registro de dados da cliente
- Seleção de produtos e quantidades
- Escolha entre entrega ou retirada
- Cálculo automático do valor total

## Paleta de Cores
- **Rosa Principal**: #E99CAE
- **Verde Suave**: #C2DD80
- **Rosa Escuro**: #D56989
- **Rosa Claro (Background)**: #F3EEF2

## Recursos Técnicos Utilizados

### Recursos Nativos do Dispositivo
- **Câmera**: Para escanear códigos de barras dos produtos
- **Armazenamento Local**: Para cache de dados e funcionamento offline
- **Notificações**: Para alertas de estoque baixo

### Tecnologias
- **Flutter**: Framework principal
- **Provider**: Gerenciamento de estado
- **HTTP**: Comunicação com a API REST em C#
- **GetIt**: Injeção de dependências
- **Shared Preferences**: Armazenamento local

### Integração
- API REST FemmeHub desenvolvida em C# com Entity Framework
- Endpoints para CRUD de produtos, fornecedores e pedidos

## Arquitetura
O projeto segue a arquitetura hexagonal com organização feature-first:
- **Domain**: Modelos e lógica de negócio
- **Data**: Repositórios e comunicação com API
- **Presentation**: Telas, widgets e providers

## Equipe
- Aryane Caroline - 2013047
- Jeniffer Scarpini - 1993338
- Sofia Deniz - 2010932
