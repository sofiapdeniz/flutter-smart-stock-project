import 'package:flutter/material.dart';
import '../theme/femme_hub_theme.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingOverlay({super.key, required this.isLoading, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.3),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: FemmeHubTheme.rosaEscuro),
                    const SizedBox(height: 16),
                    const Text('Salvando...', style: TextStyle(fontSize: 14, color: Colors.black54)),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
