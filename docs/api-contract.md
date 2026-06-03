# Contrato da API - FemmeHub

## Base URL
```
http://localhost:5000/api
```

## Endpoints

### Produto

| Método | Endpoint | Descrição | Body | Resposta |
|--------|----------|-----------|------|----------|
| GET | /Produto | Lista todos os produtos | - | 200: List<Produto> |
| GET | /Produto/{id} | Busca produto por ID | - | 200: Produto / 404 |
| POST | /Produto | Cria novo produto | ProdutoPostDTO | 201: Produto |
| PUT | /Produto/{id} | Atualiza produto | ProdutoPutDTO | 200: Produto / 404 |
| PATCH | /Produto/{id} | Atualiza parcial | ProdutoPatchDTO | 200: Produto / 404 |
| DELETE | /Produto/{id} | Remove produto | - | 200 / 404 |

**ProdutoPostDTO:**
```json
{
  "nome": "string",
  "codigo": 0,
  "descricao": "string",
  "precoUnitario": 0.0,
  "unidadeMedida": "string"
}
```

**Resposta Produto:**
```json
{
  "id": 0,
  "nome": "string",
  "codigo": 0,
  "descricao": "string",
  "precoUnitario": 0.0,
  "unidadeMedida": "string",
  "dataCriacao": "2025-01-01T00:00:00",
  "dataAtualizacao": "2025-01-01T00:00:00"
}
```

### Fornecedor

| Método | Endpoint | Descrição | Body | Resposta |
|--------|----------|-----------|------|----------|
| GET | /Fornecedor | Lista todos | - | 200: List<Fornecedor> |
| GET | /Fornecedor/{id} | Busca por ID | - | 200: Fornecedor / 404 |
| POST | /Fornecedor | Cria novo | FornecedorPostDTO | 201: Fornecedor |
| PUT | /Fornecedor/{id} | Atualiza | FornecedorPutDTO | 200: Fornecedor / 404 |
| PATCH | /Fornecedor/{id} | Atualiza parcial | FornecedorPatchDTO | 200: Fornecedor / 404 |
| DELETE | /Fornecedor/{id} | Remove | - | 200 / 404 |

**FornecedorPostDTO:**
```json
{
  "nome": "string",
  "cnpj": "string",
  "telefone": "string",
  "email": "string",
  "endereco": "string"
}
```

**Resposta Fornecedor:**
```json
{
  "id": 0,
  "nome": "string",
  "cnpj": "string",
  "telefone": "string",
  "email": "string",
  "endereco": "string",
  "dataCriacao": "2025-01-01T00:00:00",
  "dataAtualizacao": "2025-01-01T00:00:00"
}
```

### PedidoVenda

| Método | Endpoint | Descrição | Body | Resposta |
|--------|----------|-----------|------|----------|
| GET | /PedidoVenda | Lista todos | - | 200: List<PedidoVenda> |
| GET | /PedidoVenda/{id} | Busca por ID | - | 200: PedidoVenda / 404 |
| POST | /PedidoVenda | Cria novo | PedidoVendaPostDTO | 201: PedidoVenda |
| PUT | /PedidoVenda/{id} | Atualiza | PedidoVenda | 200: PedidoVenda / 404 |
| DELETE | /PedidoVenda/{id} | Remove | - | 200 / 404 |

**PedidoVendaPostDTO:**
```json
{
  "clienteNome": "string",
  "tipoEntrega": 0,
  "enderecoEntrega": "string",
  "bairroEntrega": "string",
  "numeroEnderecoEntrega": 0,
  "telefoneCliente": "string",
  "lojaRetirada": "string",
  "itensPedido": [
    {
      "produtoId": 0,
      "quantidade": 0,
      "precoUnitario": 0.0,
      "unidadeMedida": "string"
    }
  ]
}
```

**Resposta PedidoVenda:**
```json
{
  "id": 0,
  "clienteNome": "string",
  "valorTotal": 0.0,
  "tipoEntrega": 0,
  "enderecoEntrega": "string",
  "bairroEntrega": "string",
  "numeroEnderecoEntrega": 0,
  "telefoneCliente": "string",
  "lojaRetirada": "string",
  "itensPedido": [],
  "dataCriacao": "2025-01-01T00:00:00",
  "dataAtualizacao": "2025-01-01T00:00:00"
}
```

## Enums

### TipoEntrega
| Valor | Descrição |
|-------|-----------|
| 0 | Entrega |
| 1 | Retirada |

## Códigos de Resposta

| Código | Descrição |
|--------|-----------|
| 200 | Sucesso |
| 201 | Criado com sucesso |
| 400 | Erro de validação |
| 404 | Não encontrado |
| 500 | Erro interno do servidor |
