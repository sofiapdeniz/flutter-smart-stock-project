import 'package:flutter/material.dart';
import 'core/theme/femme_hub_theme.dart';
import 'features/produtos/presentation/cadastro_produto_screen.dart';
import 'features/pedidos/presentation/novo_pedido_screen.dart';
import 'features/fornecedores/presentation/cadastro_fornecedor_screen.dart';

void main() {
  runApp(const FemmeHubApp());
}

class FemmeHubApp extends StatelessWidget {
  const FemmeHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FemmeHub',
      debugShowCheckedModeBanner: false,
      theme: FemmeHubTheme.theme,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FemmeHub')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Logo / Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [FemmeHubTheme.rosaEscuro, FemmeHubTheme.rosaPrincipal],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/logo_femmehub.png',
                  height: 160,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Cards de navegação
            _MenuCard(
              icon: Icons.inventory_2,
              title: 'Cadastro de Produto',
              subtitle: 'Cadastre e edite seus produtos',
              cor: FemmeHubTheme.rosaEscuro,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CadastroProdutoScreen()),
              ),
            ),
            _MenuCard(
              icon: Icons.receipt_long,
              title: 'Novo Pedido',
              subtitle: 'Crie pedidos de venda e compra',
              cor: FemmeHubTheme.verdeSuave,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NovoPedidoScreen()),
              ),
            ),
            _MenuCard(
              icon: Icons.business,
              title: 'Cadastro de Fornecedor',
              subtitle: 'Gerencie seus fornecedores',
              cor: FemmeHubTheme.rosaPrincipal,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CadastroFornecedorScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color cor;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.cor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: cor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: cor, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 2),
                    Text(subtitle, style: const TextStyle(fontSize: 13, color: Colors.black54)),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: cor),
            ],
          ),
        ),
      ),
    );
  }
}
