import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/autenticacao/presentation/login_screen.dart';
import '../features/autenticacao/presentation/cadastro_usuario_screen.dart';
import '../features/produtos/presentation/cadastro_produto_screen.dart';
import '../features/pedidos/presentation/novo_pedido_screen.dart';
import '../features/fornecedores/presentation/cadastro_fornecedor_screen.dart';
import '../core/di/service_locator.dart';
import '../core/providers/auth_provider.dart';
import '../main.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/escolha',
  refreshListenable: getIt<AuthProvider>(),

  redirect: (BuildContext context, GoRouterState state) {
    final logado = getIt<AuthProvider>().autenticado;
    final indoParaLogin = state.matchedLocation == '/login';
    final indoParaCadastro = state.matchedLocation == '/cadastro';
    final indoParaEscolha = state.matchedLocation == '/escolha';

    if (indoParaEscolha || indoParaLogin || indoParaCadastro) {
      return null;
    }

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
