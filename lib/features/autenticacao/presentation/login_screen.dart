import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/femme_hub_theme.dart';
import '../../../core/widgets/loading_overlay.dart';
import '../../../core/utils/validadores.dart';
import '../../../core/providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  final String? redirect;
  const LoginScreen({super.key, this.redirect});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _senhaVisivel = false;
  bool _isLoading = false;

  final _emailFocus = FocusNode();
  final _senhaFocus = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    _emailFocus.dispose();
    _senhaFocus.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));

    final tipo = (widget.redirect == 'pedido' || widget.redirect == '/cliente/pedido')
        ? 'cliente'
        : 'admin';

    await context.read<AuthProvider>().login(
          email: _emailController.text,
          nome: _emailController.text.split('@').first,
          tipo: tipo,
        );

    setState(() => _isLoading = false);

    if (mounted) {
      if (tipo == 'cliente') {
        context.go('/cliente/pedido');
      } else {
        context.go('/admin');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: LoadingOverlay(
        isLoading: _isLoading,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                Icon(Icons.storefront, size: 64, color: FemmeHubTheme.rosaEscuro),
                const SizedBox(height: 16),
                const Text(
                  'FemmeHub',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFFD56989)),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Entre na sua conta',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _emailController,
                  focusNode: _emailFocus,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined, color: Color(0xFFD56989)),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => _senhaFocus.requestFocus(),
                  validator: Validadores.email,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _senhaController,
                  focusNode: _senhaFocus,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFFD56989)),
                    suffixIcon: IconButton(
                      icon: Icon(_senhaVisivel ? Icons.visibility_off : Icons.visibility, color: const Color(0xFFD56989)),
                      onPressed: () => setState(() => _senhaVisivel = !_senhaVisivel),
                    ),
                  ),
                  obscureText: !_senhaVisivel,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _login(),
                  validator: Validadores.senha,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    child: const Text('Entrar'),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => context.push('/cadastro'),
                  child: const Text(
                    'Não tem conta? Cadastre-se',
                    style: TextStyle(color: Color(0xFFD56989)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
