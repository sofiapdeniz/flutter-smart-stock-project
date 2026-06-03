import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'core/theme/femme_hub_theme.dart';
import 'core/di/service_locator.dart';
import 'core/providers/auth_provider.dart';
import 'core/providers/produto_provider.dart';
import 'core/providers/pedido_provider.dart';
import 'core/providers/fornecedor_provider.dart';
import 'router/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  setupServiceLocator();
  runApp(const FemmeHubApp());
}

class FemmeHubApp extends StatelessWidget {
  const FemmeHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: getIt<AuthProvider>()),
        ChangeNotifierProvider.value(value: getIt<ProdutoProvider>()),
        ChangeNotifierProvider.value(value: getIt<PedidoProvider>()),
        ChangeNotifierProvider.value(value: getIt<FornecedorProvider>()),
      ],
      child: MaterialApp.router(
        title: 'FemmeHub',
        debugShowCheckedModeBanner: false,
        theme: FemmeHubTheme.theme,
        routerConfig: appRouter,
      ),
    );
  }
}

class EscolhaPerfilScreen extends StatelessWidget {
  const EscolhaPerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: FemmeHubTheme.rosaEscuro.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.storefront, size: 48, color: FemmeHubTheme.rosaEscuro),
                ),
                const SizedBox(height: 16),
                const Text(
                  'FemmeHub',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFFD56989)),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Como deseja acessar?',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 36),
                Row(
                  children: [
                    Expanded(
                      child: _PerfilCard(
                        icon: Icons.shopping_bag_outlined,
                        title: 'Cliente',
                        subtitle: 'Fazer pedido',
                        cor: FemmeHubTheme.verdeSuave,
                        onTap: () => context.push('/login?redirect=pedido'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _PerfilCard(
                        icon: Icons.admin_panel_settings_outlined,
                        title: 'Admin',
                        subtitle: 'Gerenciar',
                        cor: FemmeHubTheme.rosaEscuro,
                        onTap: () => context.push('/login'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PerfilCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color cor;
  final VoidCallback onTap;

  const _PerfilCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.cor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: cor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: cor, size: 30),
              ),
              const SizedBox(height: 10),
              Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.black54), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ProdutoProvider>().carregarProdutos();
      context.read<PedidoProvider>().carregarPedidos();
      context.read<FornecedorProvider>().carregarFornecedores();
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('FemmeHub'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
            onPressed: () {
              context.read<AuthProvider>().logout();
              context.go('/escolha');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Olá, ${auth.nome.isNotEmpty ? auth.nome : 'Administradora'} 👋',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'O que deseja fazer hoje?',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 24),

            LayoutBuilder(
              builder: (context, constraints) {
                final crossCount = constraints.maxWidth > 500 ? 3 : 2;
                return GridView.count(
                  crossAxisCount: crossCount,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.1,
                  children: [
                    _GridCard(
                      icon: Icons.add_box_outlined,
                      title: 'Novo Produto',
                      cor: FemmeHubTheme.rosaEscuro,
                      onTap: () => context.push('/produto'),
                    ),
                    _GridCard(
                      icon: Icons.receipt_long_outlined,
                      title: 'Novo Pedido',
                      cor: FemmeHubTheme.verdeSuave,
                      onTap: () => context.push('/pedido'),
                    ),
                    _GridCard(
                      icon: Icons.local_shipping_outlined,
                      title: 'Fornecedor',
                      cor: FemmeHubTheme.rosaPrincipal,
                      onTap: () => context.push('/fornecedor'),
                    ),
                    _GridCard(
                      icon: Icons.inventory_outlined,
                      title: 'Estoque',
                      cor: const Color(0xFF9BC4CB),
                      onTap: () => context.push('/produto'),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 28),

            const Text(
              'Resumo',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Consumer3<ProdutoProvider, PedidoProvider, FornecedorProvider>(
              builder: (context, produtoP, pedidoP, fornecedorP, _) {
                return Row(
                  children: [
                    Expanded(
                      child: _ResumoCard(
                        label: 'Produtos',
                        valor: '${produtoP.totalProdutos}',
                        icon: Icons.inventory_2,
                        cor: FemmeHubTheme.rosaEscuro,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ResumoCard(
                        label: 'Pedidos',
                        valor: '${pedidoP.totalPedidos}',
                        icon: Icons.receipt,
                        cor: FemmeHubTheme.verdeSuave,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ResumoCard(
                        label: 'Fornecedores',
                        valor: '${fornecedorP.totalFornecedores}',
                        icon: Icons.business,
                        cor: FemmeHubTheme.rosaPrincipal,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _GridCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color cor;
  final VoidCallback onTap;

  const _GridCard({
    required this.icon,
    required this.title,
    required this.cor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: cor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: cor, size: 28),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResumoCard extends StatelessWidget {
  final String label;
  final String valor;
  final IconData icon;
  final Color cor;

  const _ResumoCard({
    required this.label,
    required this.valor,
    required this.icon,
    required this.cor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: cor, size: 22),
          const SizedBox(height: 6),
          Text(valor, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: cor)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 11, color: Colors.black54)),
        ],
      ),
    );
  }
}

typedef HomeScreen = AdminHomeScreen;
