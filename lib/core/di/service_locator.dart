import 'package:get_it/get_it.dart';
import '../providers/auth_provider.dart';
import '../providers/produto_provider.dart';
import '../providers/pedido_provider.dart';
import '../providers/fornecedor_provider.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<AuthProvider>(() => AuthProvider());
  getIt.registerLazySingleton<ProdutoProvider>(() => ProdutoProvider());
  getIt.registerLazySingleton<PedidoProvider>(() => PedidoProvider());
  getIt.registerLazySingleton<FornecedorProvider>(() => FornecedorProvider());
}
