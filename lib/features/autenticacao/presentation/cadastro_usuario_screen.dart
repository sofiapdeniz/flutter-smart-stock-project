import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/femme_hub_theme.dart';

class CadastroUsuarioScreen extends StatefulWidget {
  const CadastroUsuarioScreen({super.key});

  @override
  State<CadastroUsuarioScreen> createState() => _CadastroUsuarioScreenState();
}

class _CadastroUsuarioScreenState extends State<CadastroUsuarioScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();
  bool _senhaVisivel = false;

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    _confirmarSenhaController.dispose();
    super.dispose();
  }

  void _cadastrar() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Conta criada com sucesso! ✨'),
          backgroundColor: FemmeHubTheme.rosaEscuro,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar Conta')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Crie sua conta',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFD56989)),
              ),
              const SizedBox(height: 8),
              const Text(
                'Preencha seus dados para começar',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome completo',
                  prefixIcon: Icon(Icons.person_outline, color: Color(0xFFD56989)),
                ),
                validator: (v) => v == null || v.isEmpty ? 'Informe o nome' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
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
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _senhaController,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFFD56989)),
                  suffixIcon: IconButton(
                    icon: Icon(_senhaVisivel ? Icons.visibility_off : Icons.visibility, color: const Color(0xFFD56989)),
                    onPressed: () => setState(() => _senhaVisivel = !_senhaVisivel),
                  ),
                ),
                obscureText: !_senhaVisivel,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Informe a senha';
                  if (v.length < 6) return 'Mínimo 6 caracteres';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _confirmarSenhaController,
                decoration: const InputDecoration(
                  labelText: 'Confirmar senha',
                  prefixIcon: Icon(Icons.lock_outline, color: Color(0xFFD56989)),
                ),
                obscureText: !_senhaVisivel,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Confirme a senha';
                  if (v != _senhaController.text) return 'Senhas não coincidem';
                  return null;
                },
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: _cadastrar,
                  child: const Text('Cadastrar'),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => context.pop(),
                child: const Text(
                  'Já tem conta? Faça login',
                  style: TextStyle(color: Color(0xFFD56989)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
