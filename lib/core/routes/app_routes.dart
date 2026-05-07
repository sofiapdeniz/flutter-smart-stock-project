import 'package:go_router/go_router.dart';
import '../../features/autenticacao/presentation/login_screen.dart';
import '../../features/autenticacao/presentation/cadastro_usuario_screen.dart';
import '../../features/produtos/presentation/cadastro_produto_screen.dart';
import '../../features/pedidos/presentation/novo_pedido_screen.dart';
import '../../features/fornecedores/presentation/cadastro_fornecedor_screen.dart';
import '../../main.dart';

final GoRouter router = GoRouter(
  initialLocation: '/escolha',
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
