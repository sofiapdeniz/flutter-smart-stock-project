import 'package:get_it/get_it.dart';
import '../providers/auth_provider.dart';
import '../providers/produto_provider.dart';
import '../providers/pedido_provider.dart';
import '../providers/fornecedor_provider.dart';
import '../../data/repositories/usuario_repository.dart';
import '../../data/repositories/produto_repository.dart';
import '../../data/repositories/fornecedor_repository.dart';
import '../../data/repositories/pedido_repository.dart';
import '../../data/repositories/item_pedido_repository.dart';
import '../../data/repositories/endereco_repository.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<UsuarioRepository>(() => UsuarioRepository());
  getIt.registerLazySingleton<ProdutoRepository>(() => ProdutoRepository());
  getIt.registerLazySingleton<FornecedorRepository>(() => FornecedorRepository());
  getIt.registerLazySingleton<PedidoRepository>(() => PedidoRepository());
  getIt.registerLazySingleton<ItemPedidoRepository>(() => ItemPedidoRepository());
  getIt.registerLazySingleton<EnderecoRepository>(() => EnderecoRepository());

  getIt.registerLazySingleton<AuthProvider>(() => AuthProvider());
  getIt.registerLazySingleton<ProdutoProvider>(() => ProdutoProvider());
  getIt.registerLazySingleton<PedidoProvider>(() => PedidoProvider());
  getIt.registerLazySingleton<FornecedorProvider>(() => FornecedorProvider());
}
