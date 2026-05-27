# Diagrama Entidade-Relacionamento - FemmeHub

## Tabelas

### usuarios
| Campo | Tipo | Restrição |
|-------|------|-----------|
| id | INTEGER | PRIMARY KEY AUTOINCREMENT |
| nome | TEXT | NOT NULL |
| email | TEXT | NOT NULL, UNIQUE |
| senha | TEXT | NOT NULL |
| tipo | TEXT | NOT NULL, ENUM (admin, cliente) |
| telefone | TEXT | |
| data_criacao | TEXT | NOT NULL |

### enderecos
| Campo | Tipo | Restrição |
|-------|------|-----------|
| id | INTEGER | PRIMARY KEY AUTOINCREMENT |
| usuario_id | INTEGER | FOREIGN KEY → usuarios(id), NOT NULL |
| endereco | TEXT | NOT NULL |
| bairro | TEXT | NOT NULL |
| numero | TEXT | NOT NULL |
| complemento | TEXT | |
| principal | INTEGER | NOT NULL, DEFAULT 0 (0=não, 1=sim) |

### produtos
| Campo | Tipo | Restrição |
|-------|------|-----------|
| id | INTEGER | PRIMARY KEY AUTOINCREMENT |
| nome | TEXT | NOT NULL |
| codigo | INTEGER | NOT NULL, UNIQUE |
| descricao | TEXT | NOT NULL |
| preco_unitario | REAL | NOT NULL |
| unidade_medida | TEXT | NOT NULL |
| data_criacao | TEXT | NOT NULL |
| data_atualizacao | TEXT | NOT NULL |

### fornecedores
| Campo | Tipo | Restrição |
|-------|------|-----------|
| id | INTEGER | PRIMARY KEY AUTOINCREMENT |
| nome | TEXT | NOT NULL |
| cnpj | TEXT | NOT NULL, UNIQUE |
| telefone | TEXT | NOT NULL |
| email | TEXT | NOT NULL |
| endereco | TEXT | NOT NULL |
| data_criacao | TEXT | NOT NULL |
| data_atualizacao | TEXT | NOT NULL |

### pedidos
| Campo | Tipo | Restrição |
|-------|------|-----------|
| id | INTEGER | PRIMARY KEY AUTOINCREMENT |
| usuario_id | INTEGER | FOREIGN KEY → usuarios(id), NOT NULL |
| endereco_id | INTEGER | FOREIGN KEY → enderecos(id) |
| tipo_entrega | TEXT | NOT NULL, ENUM (entrega, retirada) |
| valor_total | REAL | NOT NULL |
| data_criacao | TEXT | NOT NULL |

### itens_pedido
| Campo | Tipo | Restrição |
|-------|------|-----------|
| id | INTEGER | PRIMARY KEY AUTOINCREMENT |
| pedido_id | INTEGER | FOREIGN KEY → pedidos(id), NOT NULL |
| produto_id | INTEGER | FOREIGN KEY → produtos(id), NOT NULL |
| quantidade | INTEGER | NOT NULL |
| preco_unitario | REAL | NOT NULL |

### produto_fornecedor
| Campo | Tipo | Restrição |
|-------|------|-----------|
| produto_id | INTEGER | FOREIGN KEY → produtos(id) |
| fornecedor_id | INTEGER | FOREIGN KEY → fornecedores(id) |
| PRIMARY KEY | | (produto_id, fornecedor_id) |

## Relacionamentos

```
usuarios  (1) ──────── (N) enderecos
usuarios  (1) ──────── (N) pedidos
pedidos   (N) ──────── (1) enderecos
pedidos   (1) ──────── (N) itens_pedido
produtos  (1) ──────── (N) itens_pedido
produtos  (N) ──────── (N) fornecedores  [via produto_fornecedor]
```

- Um usuário pode ter vários endereços cadastrados (casa, trabalho, etc.)
- Um usuário pode ter vários pedidos (tanto admin quanto cliente)
- Um pedido referencia um endereço (quando tipo_entrega = entrega)
- Um pedido possui vários itens
- Um produto pode aparecer em vários itens de pedidos diferentes
- Um produto pode ter vários fornecedores e vice-versa

## Diagrama Visual

```
┌──────────────┐       ┌──────────────┐
│   usuarios   │       │   produtos   │
├──────────────┤       ├──────────────┤
│ id (PK)      │       │ id (PK)      │
│ nome         │       │ nome         │
│ email        │       │ codigo       │
│ senha        │       │ descricao    │
│ tipo         │       │ preco_unit.  │
│ telefone     │       │ unid_medida  │
│ data_criacao │       │ data_criacao │
└──┬───────┬───┘       │ data_atualiz.│
   │       │           └──────┬───────┘
   │ 1:N   │ 1:N              │
   │       │                  │ 1:N
   ▼       ▼                  │
┌────────────┐  ┌──────────┐  │   ┌───────────────────┐
│ enderecos  │  │ pedidos  │  │   │ produto_fornecedor│
├────────────┤  ├──────────┤  │   ├───────────────────┤
│ id (PK)    │  │ id (PK)  │  │   │ produto_id (FK)   │
│ usuario_id │◄─┤endereco_id  │   │ fornecedor_id (FK)│
│ endereco   │  │usuario_id│  │   └────────┬──────────┘
│ bairro     │  │tipo_entr.│  │            │
│ numero     │  │valor_tot.│  │            │ N:N
│ complemento│  │data_cria.│  │            ▼
│ principal  │  └────┬─────┘  │   ┌──────────────┐
└────────────┘       │        │   │ fornecedores │
                     │ 1:N    │   ├──────────────┤
                     ▼        ▼   │ id (PK)      │
              ┌──────────────┐    │ nome         │
              │ itens_pedido │    │ cnpj         │
              ├──────────────┤    │ telefone     │
              │ id (PK)      │    │ email        │
              │ pedido_id(FK)│    │ endereco     │
              │ produto_id(FK)    │ data_criacao │
              │ quantidade   │    │ data_atualiz.│
              │ preco_unit.  │    └──────────────┘
              └──────────────┘
```

## Observações

- O campo `endereco_id` em pedidos é NULL quando `tipo_entrega = retirada`
- O campo `principal` em enderecos indica qual é o endereço padrão do usuário
- O telefone fica em usuarios pois tanto admin quanto cliente podem ter telefone
- Admin não precisa cadastrar endereço, cliente pode ter vários
