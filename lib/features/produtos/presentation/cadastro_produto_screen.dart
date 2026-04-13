import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/femme_hub_theme.dart';

class CadastroProdutoScreen extends StatefulWidget {
  const CadastroProdutoScreen({super.key});

  @override
  State<CadastroProdutoScreen> createState() => _CadastroProdutoScreenState();
}

class _CadastroProdutoScreenState extends State<CadastroProdutoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _codigoController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _precoController = TextEditingController();
  String _unidadeSelecionada = 'Unidade';

  final List<String> _unidades = [
    'Unidade',
    'Kg',
    'Litro',
    'Metro',
    'Caixa',
    'Pacote',
  ];

  @override
  void dispose() {
    _nomeController.dispose();
    _codigoController.dispose();
    _descricaoController.dispose();
    _precoController.dispose();
    super.dispose();
  }

  void _salvarProduto() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Produto salvo com sucesso! ✨'),
          backgroundColor: FemmeHubTheme.rosaEscuro,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      _nomeController.clear();
      _codigoController.clear();
      _descricaoController.clear();
      _precoController.clear();
      setState(() => _unidadeSelecionada = 'Unidade');
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Produto')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header decorativo
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: FemmeHubTheme.rosaPrincipal.withOpacity(0.2),
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
                      child: const Icon(Icons.inventory_2, color: Colors.white, size: 28),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Novo Produto',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFD56989)),
                          ),
                          Text(
                            'Preencha os dados do produto',
                            style: TextStyle(fontSize: 13, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Campo Nome
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome do Produto',
                  prefixIcon: Icon(Icons.shopping_bag_outlined, color: Color(0xFFD56989)),
                ),
                validator: (v) => v == null || v.isEmpty ? 'Informe o nome' : null,
              ),
              const SizedBox(height: 16),

              // Campo Código
              TextFormField(
                controller: _codigoController,
                decoration: const InputDecoration(
                  labelText: 'Código',
                  prefixIcon: Icon(Icons.qr_code, color: Color(0xFFD56989)),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (v) => v == null || v.isEmpty ? 'Informe o código' : null,
              ),
              const SizedBox(height: 16),

              // Campo Descrição
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  prefixIcon: Icon(Icons.description_outlined, color: Color(0xFFD56989)),
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
                validator: (v) => v == null || v.isEmpty ? 'Informe a descrição' : null,
              ),
              const SizedBox(height: 16),

              // Preço e Unidade lado a lado
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 400) {
                    return Row(
                      children: [
                        Expanded(flex: 3, child: _buildCampoPreco()),
                        const SizedBox(width: 12),
                        Expanded(flex: 2, child: _buildDropdownUnidade()),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      _buildCampoPreco(),
                      const SizedBox(height: 16),
                      _buildDropdownUnidade(),
                    ],
                  );
                },
              ),
              const SizedBox(height: 32),

              // Botão Salvar
              SizedBox(
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _salvarProduto,
                  icon: const Icon(Icons.save_rounded),
                  label: const Text('Salvar Produto'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCampoPreco() {
    return TextFormField(
      controller: _precoController,
      decoration: const InputDecoration(
        labelText: 'Preço Unitário',
        prefixIcon: Icon(Icons.attach_money, color: Color(0xFFD56989)),
        prefixText: 'R\$ ',
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
      validator: (v) => v == null || v.isEmpty ? 'Informe o preço' : null,
    );
  }

  Widget _buildDropdownUnidade() {
    return DropdownButtonFormField<String>(
      initialValue: _unidadeSelecionada,
      decoration: const InputDecoration(
        labelText: 'Unidade',
        prefixIcon: Icon(Icons.straighten, color: Color(0xFFD56989)),
      ),
      items: _unidades.map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
      onChanged: (v) => setState(() => _unidadeSelecionada = v!),
    );
  }
}
