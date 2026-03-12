# SmartStock Mobile

Sistema de controle de estoque desenvolvido em Flutter para a disciplina de Sistemas Móveis.

## Equipe
- Aryane Caroline - 2013047
- Jeniffer Scarpini - 1993338
- Sofia Deniz - 2010932

## Sobre o Projeto

O SmartStock Mobile é um aplicativo de controle de estoque que se integra com a API SmartStock desenvolvida em C#. O sistema permite gerenciar produtos, fornecedores, pedidos de compra e pedidos de venda de forma prática através de dispositivos móveis.

## Funcionalidades

- ✅ Autenticação de usuários
- ✅ Gestão de produtos (CRUD)
- ✅ Gestão de fornecedores (CRUD)
- ✅ Criação de pedidos de compra
- ✅ Criação de pedidos de venda
- ✅ Integração com API REST

## Estrutura do Projeto

O projeto segue a arquitetura hexagonal com organização feature-first:

```
lib/
├── core/              # Código compartilhado
│   ├── theme/         # Cores, tipografia
│   ├── widgets/       # Widgets reutilizáveis
│   ├── utils/         # Funções utilitárias
│   └── di/            # Injeção de dependência
└── features/          # Funcionalidades
    ├── autenticacao/
    ├── produtos/
    ├── fornecedores/
    └── pedidos/
```

## Como Executar

1. Clone o repositório:
```bash
git clone <url-do-repositorio>
cd "Projeto Flutter"
```

2. Instale as dependências:
```bash
flutter pub get
```

3. Execute o aplicativo:
```bash
flutter run
```

## Tecnologias

- Flutter 3.0+
- Provider (gerenciamento de estado)
- HTTP (comunicação com API)
- GetIt (injeção de dependências)
- Shared Preferences (armazenamento local)

## API Backend

O projeto se integra com a API SmartStock desenvolvida em C# com Entity Framework, localizada em:
`~/Imagens/UnimarProjects/Plataforma de Desenvolvimento/Project_SmartStock/`

## Documentação

- [Proposta do Projeto](docs/proposta.md)
- [Esboços das Telas](docs/esbocos/telas_principais.md)

## Commits

Este projeto segue o padrão Conventional Commits:
- `feat:` nova funcionalidade
- `fix:` correção de bug
- `docs:` documentação
- `style:` formatação
- `refactor:` refatoração
- `test:` testes
