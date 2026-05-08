import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/femme_hub_theme.dart';
import '../../../core/widgets/loading_overlay.dart';
import '../../../core/utils/validadores.dart';

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
  bool _isLoading = false;

  final _nomeFocus = FocusNode();
  final _codigoFocus = FocusNode();
  final _descricaoFocus = FocusNode();
  final _precoFocus = FocusNode();

  final List<String> _unidades = ['Unidade', 'Kg', 'Litro', 'Metro', 'Caixa', 'Pacote'];

  @override
  void dispose() {
    _nomeController.dispose();
    _codigoController.dispose();
    _descricaoController.dispose();
    _precoController.dispose();
    _nomeFocus.dispose();
    _codigoFocus.dispose();
    _descricaoFocus.dispose();
    _precoFocus.dispose();
    super.dispose();
  }

  Future<void> _salvarProduto() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);

    if (mounted) {
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
      _nomeFocus.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Produto')),
      body: LoadingOverlay(
        isLoading: _isLoading,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                            Text('Novo Produto', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFD56989))),
                            Text('Preencha os dados do produto', style: TextStyle(fontSize: 13, color: Colors.black54)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                TextFormField(
                  controller: _nomeController,
                  focusNode: _nomeFocus,
                  decoration: const InputDecoration(
                    labelText: 'Nome do Produto',
                    prefixIcon: Icon(Icons.shopping_bag_outlined, color: Color(0xFFD56989)),
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => _codigoFocus.requestFocus(),
                  validator: (v) => Validadores.obrigatorio(v, 'nome'),
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _codigoController,
                  focusNode: _codigoFocus,
                  decoration: const InputDecoration(
                    labelText: 'Código',
                    prefixIcon: Icon(Icons.qr_code, color: Color(0xFFD56989)),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => _descricaoFocus.requestFocus(),
                  validator: Validadores.codigo,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _descricaoController,
                  focusNode: _descricaoFocus,
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                    prefixIcon: Icon(Icons.description_outlined, color: Color(0xFFD56989)),
                    alignLabelWithHint: true,
                  ),
                  maxLines: 3,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => _precoFocus.requestFocus(),
                  validator: (v) => Validadores.obrigatorio(v, 'descrição'),
                ),
                const SizedBox(height: 16),

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

                SizedBox(
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _salvarProduto,
                    icon: const Icon(Icons.save_rounded),
                    label: const Text('Salvar Produto'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCampoPreco() {
    return TextFormField(
      controller: _precoController,
      focusNode: _precoFocus,
      decoration: const InputDecoration(
        labelText: 'Preço Unitário',
        prefixIcon: Icon(Icons.attach_money, color: Color(0xFFD56989)),
        prefixText: 'R\$ ',
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
      textInputAction: TextInputAction.done,
      validator: Validadores.preco,
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
