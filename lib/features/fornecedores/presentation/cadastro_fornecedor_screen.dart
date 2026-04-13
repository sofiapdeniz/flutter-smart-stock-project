import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/femme_hub_theme.dart';

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

  @override
  void dispose() {
    _nomeController.dispose();
    _cnpjController.dispose();
    _telefoneController.dispose();
    _emailController.dispose();
    _enderecoController.dispose();
    super.dispose();
  }

  void _salvarFornecedor() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Fornecedor salvo com sucesso! ✨'),
          backgroundColor: FemmeHubTheme.rosaEscuro,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Fornecedor')),
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
                          Text(
                            'Novo Fornecedor',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFD56989)),
                          ),
                          Text(
                            'Preencha os dados do fornecedor',
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
                  labelText: 'Nome / Razão Social',
                  prefixIcon: Icon(Icons.business_center_outlined, color: Color(0xFFD56989)),
                ),
                validator: (v) => v == null || v.isEmpty ? 'Informe o nome' : null,
              ),
              const SizedBox(height: 16),

              // Campo CNPJ
              TextFormField(
                controller: _cnpjController,
                decoration: const InputDecoration(
                  labelText: 'CNPJ',
                  prefixIcon: Icon(Icons.badge_outlined, color: Color(0xFFD56989)),
                  hintText: '00.000.000/0000-00',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(14)],
                validator: (v) => v == null || v.isEmpty ? 'Informe o CNPJ' : null,
              ),
              const SizedBox(height: 16),

              // Telefone e Email
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

              // Campo Endereço
              TextFormField(
                controller: _enderecoController,
                decoration: const InputDecoration(
                  labelText: 'Endereço Completo',
                  prefixIcon: Icon(Icons.location_on_outlined, color: Color(0xFFD56989)),
                  alignLabelWithHint: true,
                ),
                maxLines: 2,
                validator: (v) => v == null || v.isEmpty ? 'Informe o endereço' : null,
              ),
              const SizedBox(height: 32),

              // Botão Salvar
              SizedBox(
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _salvarFornecedor,
                  icon: const Icon(Icons.save_rounded),
                  label: const Text('Salvar Fornecedor'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCampoTelefone() {
    return TextFormField(
      controller: _telefoneController,
      decoration: const InputDecoration(
        labelText: 'Telefone',
        prefixIcon: Icon(Icons.phone_outlined, color: Color(0xFFD56989)),
      ),
      keyboardType: TextInputType.phone,
      validator: (v) => v == null || v.isEmpty ? 'Informe o telefone' : null,
    );
  }

  Widget _buildCampoEmail() {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(
        labelText: 'Email',
        prefixIcon: Icon(Icons.email_outlined, color: Color(0xFFD56989)),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (v) {
        if (v == null || v.isEmpty) return 'Informe o email';
        if (!v.contains('@')) return 'Email inválido';
        return null;
      },
    );
  }
}
