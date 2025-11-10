import 'package:flutter/material.dart';
import '../app/localization/app_localizations.dart';
import 'health_tool_screen.dart';
import '../models/health_tool_enum.dart';



extension HealthToolIcon on HealthTool {
  IconData get icon {
    switch (this) {
      case HealthTool.bmi:
        return Icons.monitor_weight;
      case HealthTool.bmr:
        return Icons.local_fire_department;
      case HealthTool.bodyFat:
        return Icons.fitness_center;
    }
  }
}

class HealthToolsScreen extends StatelessWidget {
  const HealthToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        backgroundColor: const Color(0xFF2D2B76),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          HealthToolItem(
            title: l10n.bmiCalculator,
            subtitle: l10n.bmiSubtitle,
            color: Colors.blue,
            icon: Icons.monitor_weight,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => HealthToolScreen(tool: HealthTool.bmi),
                ),
              );            },
          ),
          HealthToolItem(
            title: l10n.bmrCalculator,
            subtitle: l10n.bmrSubtitle,
            color: Colors.green,
            icon: Icons.local_fire_department,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => HealthToolScreen(tool: HealthTool.bmr),
                ),
              );            },
          ),
          HealthToolItem(
            title: l10n.bodyFatCalculator,
            subtitle: l10n.bodyFatSubtitle,
            color: Colors.orange,
            icon: Icons.fitness_center,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => HealthToolScreen(tool: HealthTool.bodyFat),
                ),
              );            },
          ),
        ],
      ),
    );
  }
}

class HealthToolItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const HealthToolItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(subtitle),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
        onTap: onTap,
      ),
    );
  }
}
