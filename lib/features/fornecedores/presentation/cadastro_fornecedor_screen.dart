import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/femme_hub_theme.dart';
import '../../../core/widgets/loading_overlay.dart';
import '../../../core/utils/validadores.dart';

class CadastroFornecedorScreen extends StatefulWidget {
  const CadastroFornecedorScreen({super.key});

  @override
  State<CadastroFornecedorScreen> createState() => _CadastroFornecedorScreenState();
}

class _CadastroFornecedorScreenState extends State<CadastroFornecedorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _cnpjController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _enderecoController = TextEditingController();
  bool _isLoading = false;

  final _nomeFocus = FocusNode();
  final _cnpjFocus = FocusNode();
  final _telefoneFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _enderecoFocus = FocusNode();

  @override
  void dispose() {
    _nomeController.dispose();
    _cnpjController.dispose();
    _telefoneController.dispose();
    _emailController.dispose();
    _enderecoController.dispose();
    _nomeFocus.dispose();
    _cnpjFocus.dispose();
    _telefoneFocus.dispose();
    _emailFocus.dispose();
    _enderecoFocus.dispose();
    super.dispose();
  }

  Future<void> _salvarFornecedor() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Fornecedor salvo com sucesso! ✨'),
          backgroundColor: FemmeHubTheme.rosaEscuro,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      _nomeController.clear();
      _cnpjController.clear();
      _telefoneController.clear();
      _emailController.clear();
      _enderecoController.clear();
      _formKey.currentState!.reset();
      _nomeFocus.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Fornecedor')),
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
                    color: FemmeHubTheme.verdeSuave.withOpacity(0.25),
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
                        child: const Icon(Icons.business, color: Colors.white, size: 28),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Novo Fornecedor', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFD56989))),
                            Text('Preencha os dados do fornecedor', style: TextStyle(fontSize: 13, color: Colors.black54)),
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
                    labelText: 'Nome / Razão Social',
                    prefixIcon: Icon(Icons.business_center_outlined, color: Color(0xFFD56989)),
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => _cnpjFocus.requestFocus(),
                  validator: (v) => Validadores.obrigatorio(v, 'nome'),
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _cnpjController,
                  focusNode: _cnpjFocus,
                  decoration: const InputDecoration(
                    labelText: 'CNPJ',
                    prefixIcon: Icon(Icons.badge_outlined, color: Color(0xFFD56989)),
                    hintText: '00.000.000/0000-00',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(14)],
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => _telefoneFocus.requestFocus(),
                  validator: Validadores.cnpj,
                ),
                const SizedBox(height: 16),

                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 450) {
                      return Row(
                        children: [
                          Expanded(child: _buildCampoTelefone()),
                          const SizedBox(width: 12),
                          Expanded(child: _buildCampoEmail()),
                        ],
                      );
                    }
                    return Column(
                      children: [
                        _buildCampoTelefone(),
                        const SizedBox(height: 16),
                        _buildCampoEmail(),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _enderecoController,
                  focusNode: _enderecoFocus,
                  decoration: const InputDecoration(
                    labelText: 'Endereço Completo',
                    prefixIcon: Icon(Icons.location_on_outlined, color: Color(0xFFD56989)),
                    alignLabelWithHint: true,
                  ),
                  maxLines: 2,
                  textInputAction: TextInputAction.done,
                  validator: (v) => Validadores.obrigatorio(v, 'endereço'),
                ),
                const SizedBox(height: 32),

                SizedBox(
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _salvarFornecedor,
                    icon: const Icon(Icons.save_rounded),
                    label: const Text('Salvar Fornecedor'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCampoTelefone() {
    return TextFormField(
      controller: _telefoneController,
      focusNode: _telefoneFocus,
      decoration: const InputDecoration(
        labelText: 'Telefone',
        prefixIcon: Icon(Icons.phone_outlined, color: Color(0xFFD56989)),
      ),
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => _emailFocus.requestFocus(),
      validator: Validadores.telefone,
    );
  }

  Widget _buildCampoEmail() {
    return TextFormField(
      controller: _emailController,
      focusNode: _emailFocus,
      decoration: const InputDecoration(
        labelText: 'Email',
        prefixIcon: Icon(Icons.email_outlined, color: Color(0xFFD56989)),
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => _enderecoFocus.requestFocus(),
      validator: Validadores.email,
    );
  }
}
