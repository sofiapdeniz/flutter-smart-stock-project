import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/theme/femme_hub_theme.dart';
import '../../../router/app_router.dart';

class NovoPedidoScreen extends StatefulWidget {
  final bool isCliente;
  const NovoPedidoScreen({super.key, this.isCliente = false});

  @override
  State<NovoPedidoScreen> createState() => _NovoPedidoScreenState();
}

class _NovoPedidoScreenState extends State<NovoPedidoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _clienteNomeController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _bairroController = TextEditingController();
  final _numeroController = TextEditingController();

  String _tipoEntrega = 'Entrega';
  final List<_ItemPedidoLocal> _itens = [];
  bool _clienteLogado = false;

  final List<Map<String, dynamic>> _produtosDisponiveis = [
    {'nome': 'Creme Hidratante', 'preco': 45.90},
    {'nome': 'Batom Matte', 'preco': 32.50},
    {'nome': 'Perfume Floral', 'preco': 120.00},
    {'nome': 'Kit Skincare', 'preco': 89.90},
    {'nome': 'Esmalte Gel', 'preco': 18.00},
  ];

  double get _valorTotal => _itens.fold(0, (sum, item) => sum + (item.preco * item.quantidade));

  @override
  void initState() {
    super.initState();
    _carregarDadosSalvos();
  }

  Future<void> _carregarDadosSalvos() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _clienteLogado = prefs.getBool('cliente_logado') ?? false;
      _clienteNomeController.text = prefs.getString('cliente_nome') ?? '';
      _telefoneController.text = prefs.getString('cliente_telefone') ?? '';
      _enderecoController.text = prefs.getString('cliente_endereco') ?? '';
      _bairroController.text = prefs.getString('cliente_bairro') ?? '';
      _numeroController.text = prefs.getString('cliente_numero') ?? '';
    });
  }

  Future<void> _salvarDadosCliente() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('cliente_logado', true);
    await prefs.setString('cliente_nome', _clienteNomeController.text);
    await prefs.setString('cliente_telefone', _telefoneController.text);
    await prefs.setString('cliente_endereco', _enderecoController.text);
    await prefs.setString('cliente_bairro', _bairroController.text);
    await prefs.setString('cliente_numero', _numeroController.text);
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    authState.logout();
    if (mounted) context.go('/escolha');
  }

  @override
  void dispose() {
    _clienteNomeController.dispose();
    _telefoneController.dispose();
    _enderecoController.dispose();
    _bairroController.dispose();
    _numeroController.dispose();
    super.dispose();
  }

  void _adicionarItem() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => _BottomSheetAdicionarItem(
        produtos: _produtosDisponiveis,
        onAdicionar: (nome, preco, qtd) {
          setState(() => _itens.add(_ItemPedidoLocal(nome: nome, preco: preco, quantidade: qtd)));
          Navigator.pop(ctx);
        },
      ),
    );
  }

  void _removerItem(int index) {
    setState(() => _itens.removeAt(index));
  }

  void _salvarPedido() {
    if (!_formKey.currentState!.validate()) return;
    if (_itens.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Adicione pelo menos um item ao pedido'),
          backgroundColor: Colors.orange[700],
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }
    _salvarDadosCliente();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Pedido salvo com sucesso! ✨'),
        backgroundColor: FemmeHubTheme.rosaEscuro,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    setState(() => _itens.clear());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Pedido'),
        actions: widget.isCliente
            ? [
                IconButton(
                  icon: const Icon(Icons.logout),
                  tooltip: 'Sair',
                  onPressed: _logout,
                ),
              ]
            : null,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: FemmeHubTheme.verdeSuave.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: FemmeHubTheme.rosaEscuro,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.receipt_long, color: Colors.white, size: 28),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Novo Pedido',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFD56989)),
                          ),
                          Text('Preencha os dados do pedido', style: TextStyle(fontSize: 13, color: Colors.black54)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Seção: Dados da Cliente
              _buildSectionTitle('Dados da Cliente', Icons.person_outline),
              const SizedBox(height: 12),
              TextFormField(
                controller: _clienteNomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome da Cliente',
                  prefixIcon: Icon(Icons.person, color: Color(0xFFD56989)),
                ),
                validator: (v) => v == null || v.isEmpty ? 'Informe o nome' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _telefoneController,
                decoration: const InputDecoration(
                  labelText: 'Telefone',
                  prefixIcon: Icon(Icons.phone, color: Color(0xFFD56989)),
                ),
                keyboardType: TextInputType.phone,
                validator: (v) => v == null || v.isEmpty ? 'Informe o telefone' : null,
              ),
              const SizedBox(height: 20),

              // Seção: Tipo de Entrega
              _buildSectionTitle('Tipo de Entrega', Icons.local_shipping_outlined),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _buildEntregaChip('Entrega', Icons.delivery_dining)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildEntregaChip('Retirada', Icons.store)),
                ],
              ),
              const SizedBox(height: 12),

              if (_tipoEntrega == 'Entrega') ...[
                TextFormField(
                  controller: _enderecoController,
                  decoration: const InputDecoration(
                    labelText: 'Endereço',
                    prefixIcon: Icon(Icons.location_on, color: Color(0xFFD56989)),
                  ),
                  validator: (v) => _tipoEntrega == 'Entrega' && (v == null || v.isEmpty) ? 'Informe o endereço' : null,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: _bairroController,
                        decoration: const InputDecoration(
                          labelText: 'Bairro',
                          prefixIcon: Icon(Icons.map, color: Color(0xFFD56989)),
                        ),
                        validator: (v) =>
                            _tipoEntrega == 'Entrega' && (v == null || v.isEmpty) ? 'Informe o bairro' : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: _numeroController,
                        decoration: const InputDecoration(labelText: 'Nº'),
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        validator: (v) =>
                            _tipoEntrega == 'Entrega' && (v == null || v.isEmpty) ? 'Nº' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
              const SizedBox(height: 8),

              // Seção: Itens do Pedido
              _buildSectionTitle('Itens do Pedido', Icons.shopping_cart_outlined),
              const SizedBox(height: 12),

              if (_itens.isEmpty)
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: FemmeHubTheme.rosaPrincipal.withOpacity(0.3)),
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.add_shopping_cart, size: 40, color: Color(0xFFE99CAE)),
                      SizedBox(height: 8),
                      Text('Nenhum item adicionado', style: TextStyle(color: Colors.black54)),
                    ],
                  ),
                )
              else
                ...List.generate(_itens.length, (i) {
                  final item = _itens[i];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: FemmeHubTheme.rosaPrincipal.withOpacity(0.2),
                        child: const Icon(Icons.shopping_bag, color: Color(0xFFD56989), size: 20),
                      ),
                      title: Text(item.nome, style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text('${item.quantidade}x  •  R\$ ${item.preco.toStringAsFixed(2)}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () => _removerItem(i),
                      ),
                    ),
                  );
                }),

              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _adicionarItem,
                icon: const Icon(Icons.add),
                label: const Text('Adicionar Item'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: FemmeHubTheme.rosaEscuro,
                  side: const BorderSide(color: Color(0xFFD56989)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 24),

              // Resumo do Pedido
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: FemmeHubTheme.rosaEscuro.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: FemmeHubTheme.rosaEscuro.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total do Pedido', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    Text(
                      'R\$ ${_valorTotal.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD56989),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Botão Finalizar
              SizedBox(
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _salvarPedido,
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('Finalizar Pedido'),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: FemmeHubTheme.rosaEscuro, size: 20),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFD56989))),
      ],
    );
  }

  Widget _buildEntregaChip(String label, IconData icon) {
    final selecionado = _tipoEntrega == label;
    return GestureDetector(
      onTap: () => setState(() => _tipoEntrega = label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: selecionado ? FemmeHubTheme.rosaEscuro : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: FemmeHubTheme.rosaEscuro),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: selecionado ? Colors.white : FemmeHubTheme.rosaEscuro, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: selecionado ? Colors.white : FemmeHubTheme.rosaEscuro,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomSheetAdicionarItem extends StatefulWidget {
  final List<Map<String, dynamic>> produtos;
  final void Function(String nome, double preco, int quantidade) onAdicionar;

  const _BottomSheetAdicionarItem({required this.produtos, required this.onAdicionar});

  @override
  State<_BottomSheetAdicionarItem> createState() => _BottomSheetAdicionarItemState();
}

class _BottomSheetAdicionarItemState extends State<_BottomSheetAdicionarItem> {
  int? _produtoSelecionadoIndex;
  int _quantidade = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Adicionar Item',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFD56989)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<int>(
            decoration: const InputDecoration(
              labelText: 'Selecione o Produto',
              prefixIcon: Icon(Icons.shopping_bag_outlined, color: Color(0xFFD56989)),
            ),
            items: List.generate(
              widget.produtos.length,
              (i) => DropdownMenuItem(
                value: i,
                child: Text('${widget.produtos[i]['nome']} - R\$ ${(widget.produtos[i]['preco'] as double).toStringAsFixed(2)}'),
              ),
            ),
            onChanged: (v) => setState(() => _produtoSelecionadoIndex = v),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: _quantidade > 1 ? () => setState(() => _quantidade--) : null,
                icon: const Icon(Icons.remove_circle_outline),
                color: FemmeHubTheme.rosaEscuro,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: FemmeHubTheme.rosaClaro,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('$_quantidade', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              IconButton(
                onPressed: () => setState(() => _quantidade++),
                icon: const Icon(Icons.add_circle_outline),
                color: FemmeHubTheme.rosaEscuro,
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _produtoSelecionadoIndex != null
                ? () {
                    final p = widget.produtos[_produtoSelecionadoIndex!];
                    widget.onAdicionar(p['nome'] as String, p['preco'] as double, _quantidade);
                  }
                : null,
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }
}

class _ItemPedidoLocal {
  final String nome;
  final double preco;
  final int quantidade;
  _ItemPedidoLocal({required this.nome, required this.preco, required this.quantidade});
}
