import 'package:flutter/material.dart';

class Produto {
  final int id;
  final String nome;
  final String categoria;
  final double preco;
  final bool disponivel;

  const Produto({
    required this.id,
    required this.nome,
    required this.categoria,
    required this.preco,
    this.disponivel = true,
  });
}

class CartaoProduto extends StatelessWidget {
  final String nome;
  final String categoria;
  final double preco;
  final bool favoritado;
  final VoidCallback? aoAlternarFavorito;

  const CartaoProduto({
    super.key,
    required this.nome,
    required this.categoria,
    required this.preco,
    required this.favoritado,
    this.aoAlternarFavorito,
  });

  @override
  Widget build(BuildContext context) {
    final desabilitado = aoAlternarFavorito == null;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        onTap: aoAlternarFavorito,
        borderRadius: BorderRadius.circular(12),
        child: Opacity(
          opacity: desabilitado ? 0.4 : 1.0,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nome,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.indigo.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          categoria,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.indigo.shade800,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'R\$ ${preco.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Icon(
                  favoritado ? Icons.favorite : Icons.favorite_border,
                  color: desabilitado
                      ? Colors.grey
                      : favoritado
                          ? Colors.red
                          : Colors.grey,
                  size: 28,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ContadorFavoritos extends StatefulWidget {
  final List<Produto> produtos;

  const ContadorFavoritos({super.key, required this.produtos});

  @override
  State<ContadorFavoritos> createState() => _ContadorFavoritosState();
}

class _ContadorFavoritosState extends State<ContadorFavoritos> {
  final Set<int> _favoritosIds = {};

  void _alternarFavorito(int id) {
    setState(() {
      if (!_favoritosIds.remove(id)) {
        _favoritosIds.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Favoritos: ${_favoritosIds.length}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.produtos.length,
            itemBuilder: (context, index) {
              final p = widget.produtos[index];
              return CartaoProduto(
                nome: p.nome,
                categoria: p.categoria,
                preco: p.preco,
                favoritado: _favoritosIds.contains(p.id),
                aoAlternarFavorito:
                    p.disponivel ? () => _alternarFavorito(p.id) : null,
              );
            },
          ),
        ),
      ],
    );
  }
}

void main() {
  final produtos = [
    const Produto(id: 1, nome: 'Teclado Mecânico', categoria: 'Periféricos', preco: 349.90),
    const Produto(id: 2, nome: 'Mouse Gamer', categoria: 'Periféricos', preco: 189.50),
    const Produto(id: 3, nome: 'Monitor 27"', categoria: 'Monitores', preco: 1599.00),
    const Produto(id: 4, nome: 'Webcam HD', categoria: 'Acessórios', preco: 279.90, disponivel: false),
    const Produto(id: 5, nome: 'Headset Bluetooth', categoria: 'Áudio', preco: 459.00),
  ];

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Catálogo de Produtos')),
        body: ContadorFavoritos(produtos: produtos),
      ),
    ),
  );
}
