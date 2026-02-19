import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../config/theme.dart';
import '../config/app_config.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: AppTheme.cardShadow,
                        ),
                        child: const Icon(Icons.arrow_back_rounded,
                            color: AppTheme.primaryMaroon),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(AppConfig.historyTitle,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppTheme.textPrimary)),
                  ],
                ),
              ).animate().fadeIn(duration: 300.ms),

              // Empty State
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryMaroon.withValues(alpha: 0.06),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.shield_rounded,
                          size: 50,
                          color: AppTheme.primaryMaroon.withValues(alpha: 0.3),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        AppConfig.historyEmptyTitle,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppTheme.textPrimary,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppConfig.historyEmptyMessage,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.textLight,
                          height: 1.5,
                        ),
                      ),
                    ],
                  )
                      .animate(delay: 300.ms)
                      .fadeIn()
                      .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
