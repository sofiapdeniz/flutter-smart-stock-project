import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/autenticacao/presentation/login_screen.dart';
import '../features/autenticacao/presentation/cadastro_usuario_screen.dart';
import '../features/produtos/presentation/cadastro_produto_screen.dart';
import '../features/pedidos/presentation/novo_pedido_screen.dart';
import '../features/fornecedores/presentation/cadastro_fornecedor_screen.dart';
import '../main.dart';

// Variável booleana simples para controle de autenticação
// (autenticação real será implementada no Módulo 11)
class AuthState extends ChangeNotifier {
  bool _autenticado = false;

  bool get autenticado => _autenticado;

  void login() {
    _autenticado = true;
    notifyListeners();
  }

  void logout() {
    _autenticado = false;
    notifyListeners();
  }
}

final authState = AuthState();

final GoRouter appRouter = GoRouter(
  initialLocation: '/escolha',
  refreshListenable: authState,

  // Guard de navegação: redireciona para login se não autenticado
  redirect: (BuildContext context, GoRouterState state) {
    final logado = authState.autenticado;
    final indoParaLogin = state.matchedLocation == '/login';
    final indoParaCadastro = state.matchedLocation == '/cadastro';
    final indoParaEscolha = state.matchedLocation == '/escolha';
    final indoParaCliente = state.matchedLocation == '/cliente/pedido';

    // Rotas públicas: escolha, login e cadastro
    if (indoParaEscolha || indoParaLogin || indoParaCadastro) {
      return null;
    }

    // Se não está logado e tenta acessar rota protegida (admin), redireciona pro login
    if (!logado) {
      return '/login?redirect=${state.matchedLocation}';
    }

    return null;
  },

  routes: [
    GoRoute(
      path: '/escolha',
      builder: (context, state) => const EscolhaPerfilScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) {
        final redirect = state.uri.queryParameters['redirect'];
        return LoginScreen(redirect: redirect);
      },
    ),
    GoRoute(
      path: '/cadastro',
      builder: (context, state) => const CadastroUsuarioScreen(),
    ),
    GoRoute(
      path: '/admin',
      builder: (context, state) => const AdminHomeScreen(),
      routes: [
        // Subrotas do admin
        GoRoute(
          path: 'produto',
          builder: (context, state) => const CadastroProdutoScreen(),
        ),
        GoRoute(
          path: 'pedido',
          builder: (context, state) => const NovoPedidoScreen(),
        ),
        GoRoute(
          path: 'fornecedor',
          builder: (context, state) => const CadastroFornecedorScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/cliente/pedido',
      builder: (context, state) => const NovoPedidoScreen(isCliente: true),
    ),
    // Rotas diretas (mantidas para deep linking)
    GoRoute(
      path: '/produto',
      builder: (context, state) => const CadastroProdutoScreen(),
    ),
    GoRoute(
      path: '/pedido',
      builder: (context, state) => const NovoPedidoScreen(),
    ),
    GoRoute(
      path: '/fornecedor',
      builder: (context, state) => const CadastroFornecedorScreen(),
    ),
  ],
);
