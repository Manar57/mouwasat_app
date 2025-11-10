import 'package:flutter/material.dart';
import '../app/localization/app_localizations.dart';
import '../app/theme/app_theme.dart';
import '../utils/number_utils.dart';
import '../models/health_tool_enum.dart';
import 'dart:math';


extension HealthToolExtension on HealthTool {
  IconData get icon {
    switch (this) {
      case HealthTool.bmi:
        return Icons.monitor_weight;
      case HealthTool.bmr:
        return Icons.local_fire_department;
      case HealthTool.bodyFat:
        return Icons.pie_chart;
    }
  }
}

class HealthInputData {
  String genderKey = "male";
  final Map<String, TextEditingController> controllers = {
    'age': TextEditingController(), 'weight': TextEditingController(), 'height': TextEditingController(),
    'fat': TextEditingController(), 'muscle': TextEditingController(), 'waist': TextEditingController(),
    'neck': TextEditingController(), 'hip': TextEditingController(),
  };
  void dispose() => controllers.values.forEach((c) => c.dispose());
}

class HealthResult {
  final double? value;
  final String categoryKey;
  final Color color;
  final String descriptionKey;
  final Map<String, dynamic>? additionalData;
  final Map<String, dynamic> calculationData;

  HealthResult({
    this.value,
    required this.categoryKey,
    required this.color,
    required this.descriptionKey,
    this.additionalData,
    required this.calculationData
  });

  HealthResult.error(String message) :
        value = null,
        categoryKey = "error",
        color = Colors.red,
        descriptionKey = "errorInCalculation",
        additionalData = null,
        calculationData = {'errorMessage': message};

  String getCategoryText(AppLocalizations l10n) {
    switch (categoryKey) {
      case 'underweight': return l10n.underweight;
      case 'normalWeight': return l10n.normalWeight;
      case 'overweight': return l10n.overweight;
      case 'obese': return l10n.obese;
      case 'essentialFat': return l10n.essentialFat;
      case 'athletic': return l10n.athletic;
      case 'fitness': return l10n.fitness;
      case 'average': return l10n.average;
      case 'error': return l10n.error;
      default: return categoryKey;
    }
  }

  String getDescription(AppLocalizations l10n) {
    if (categoryKey == "error") {
      return calculationData['errorMessage'] ?? l10n.errorInCalculation;
    }

    switch (descriptionKey) {
      case 'bmiDescription':
        final bmi = value!;
        final category = getCategoryText(l10n);
        final weightToChange = calculationData['weightToChange'];
        final isUnderweight = calculationData['isUnderweight'];
        final isNormal = calculationData['isNormal'];

        String advice;
        if (isUnderweight) {
          advice = "${l10n.needToGain} ${weightToChange.toStringAsFixed(1)} ${l10n.kgToReachNormal}";
        } else if (isNormal) {
          advice = l10n.greatBmiInRange;
        } else {
          advice = "${l10n.needToLose} ${weightToChange.toStringAsFixed(1)} ${l10n.kgToReachNormal}";
        }

        String description = "${l10n.bmi}: ${bmi.toStringAsFixed(1)}\n${l10n.status}: $category\n\n$advice";

        final fat = calculationData['fatPercentage'];
        final muscle = calculationData['musclePercentage'];
        if (fat != null) {
          description += "\n\n${l10n.bodyFatPercentage}: ${fat.toStringAsFixed(1)}%";
        }
        if (muscle != null) {
          description += "\n${l10n.muscleMassPercentage}: ${muscle.toStringAsFixed(1)}%";
        }

        return description;

      case 'bmrDescription':
        return l10n.bmrDescription;

      case 'bodyFatDescription':
        return l10n.bodyFatDescription;

      default:
        return descriptionKey;
    }
  }
}

class HealthCalculatorService {
  static HealthResult calculate(HealthTool tool, HealthInputData data, AppLocalizations l10n) {
    try {
      switch (tool) {
        case HealthTool.bmi: return _calculateBMI(data, l10n);
        case HealthTool.bmr: return _calculateBMR(data, l10n);
        case HealthTool.bodyFat: return _calculateBodyFat(data, l10n);
      }
    } catch (e) {
      return HealthResult.error(l10n.errorInCalculation);
    }
  }

  static HealthResult _calculateBMI(HealthInputData data, AppLocalizations l10n) {
    final age = _parseInt(data.controllers['age']!.text);
    final weight = _parseDouble(data.controllers['weight']!.text);
    final height = _parseDouble(data.controllers['height']!.text);
    final fat = _parseDouble(data.controllers['fat']!.text);
    final muscle = _parseDouble(data.controllers['muscle']!.text);

    if (age == null || weight == null || height == null) {
      return HealthResult.error(l10n.pleaseEnterAllNumbers);
    }

    final heightM = height / 100;
    final bmi = weight / (heightM * heightM);
    if (bmi < 10 || bmi > 60) {
      return HealthResult.error("${l10n.calculationError}\n${l10n.calculated} ${bmi.toStringAsFixed(1)}");
    }

    final categoryKey = _getBMICategoryKey(bmi);
    final color = _getBMIColor(bmi);
    final minNormal = 18.5 * (heightM * heightM);
    final maxNormal = 24.9 * (heightM * heightM);

    final isUnderweight = bmi < 18.5;
    final isNormal = bmi >= 18.5 && bmi < 25;
    final weightToChange = isUnderweight ? (minNormal - weight) : (weight - maxNormal);

    final calculationData = {
      'heightM': heightM,
      'weight': weight,
      'weightToChange': weightToChange,
      'isUnderweight': isUnderweight,
      'isNormal': isNormal,
      'fatPercentage': fat,
      'musclePercentage': muscle,
    };

    return HealthResult(
      value: bmi,
      categoryKey: categoryKey,
      color: color,
      descriptionKey: 'bmiDescription',
      calculationData: calculationData,
    );
  }

  static HealthResult _calculateBMR(HealthInputData data, AppLocalizations l10n) {
    final age = _parseInt(data.controllers['age']!.text);
    final weight = _parseDouble(data.controllers['weight']!.text);
    final height = _parseDouble(data.controllers['height']!.text);
    if (age == null || weight == null || height == null) {
      return HealthResult.error(l10n.pleaseEnterAllNumbers);
    }

    final bmr = data.genderKey == "male"
        ? (10 * weight) + (6.25 * height) - (5 * age) + 5
        : (10 * weight) + (6.25 * height) - (5 * age) - 161;
    if (bmr < 500 || bmr > 5000) {
      return HealthResult.error("${l10n.calculationError}\n${l10n.calculated} ${bmr.toStringAsFixed(0)} ${l10n.calories}");
    }

    return HealthResult(
      value: bmr,
      categoryKey: "bmr",
      color: const Color(0xFF10B981),
      descriptionKey: 'bmrDescription',
      additionalData: _getActivityLevels(bmr),
      calculationData: {'bmr': bmr},
    );
  }

  static HealthResult _calculateBodyFat(HealthInputData data, AppLocalizations l10n) {
    final age = _parseInt(data.controllers['age']!.text);
    final height = _parseDouble(data.controllers['height']!.text);
    final waist = _parseDouble(data.controllers['waist']!.text);
    final neck = _parseDouble(data.controllers['neck']!.text);

    final hip = data.genderKey == "female" ? _parseDouble(data.controllers['hip']!.text) : 0.0;
    if (age == null || height == null || waist == null || neck == null || (data.genderKey == "female" && hip == null)) {
      return HealthResult.error(l10n.pleaseEnterAllNumbers);
    }

    final bodyFat = data.genderKey == "male"
        ? _calculateMaleBodyFat(waist, neck, height)
        : _calculateFemaleBodyFat(waist, neck, hip!, height);
    if (bodyFat < 3 || bodyFat > 50) {
      return HealthResult.error("${l10n.calculationError}\n${l10n.calculated} ${bodyFat.toStringAsFixed(1)}%");
    }

    final categoryKey = _getBodyFatCategoryKey(bodyFat, data.genderKey);
    final color = _getBodyFatColor(bodyFat, data.genderKey);

    return HealthResult(
      value: bodyFat,
      categoryKey: categoryKey,
      color: color,
      descriptionKey: 'bodyFatDescription',
      calculationData: {
        'bodyFat': bodyFat,
        'gender': data.genderKey,
      },
    );
  }

  static double _calculateMaleBodyFat(double waist, double neck, double height) {
    final logWaistNeck = _log10(waist - neck);
    final logHeight = _log10(height);
    return 495 / (1.0324 - 0.19077 * logWaistNeck + 0.15456 * logHeight) - 450;
  }

  static double _calculateFemaleBodyFat(double waist, double neck, double hip, double height) {
    final logWaistHipNeck = _log10(waist + hip - neck);
    final logHeight = _log10(height);
    return 495 / (1.29579 - 0.35004 * logWaistHipNeck + 0.221 * logHeight) - 450;
  }

  static double _log10(double x) => log(x) / ln10;

  static String _getBMICategoryKey(double bmi) {
    if (bmi < 18.5) return 'underweight';
    if (bmi < 25) return 'normalWeight';
    if (bmi < 30) return 'overweight';
    return 'obese';
  }

  static Color _getBMIColor(double bmi) {
    if (bmi < 18.5) return const Color(0xFF60A5FA);
    if (bmi < 25) return const Color(0xFF10B981);
    if (bmi < 30) return const Color(0xFFF59E0B);
    return const Color(0xFFEF4444);
  }

  static String _getBodyFatCategoryKey(double bodyFat, String genderKey) {
    if (genderKey == "male") {
      if (bodyFat < 6) return 'essentialFat';
      if (bodyFat < 14) return 'athletic';
      if (bodyFat < 18) return 'fitness';
      if (bodyFat < 25) return 'average';
      return 'obese';
    } else {
      if (bodyFat < 14) return 'essentialFat';
      if (bodyFat < 21) return 'athletic';
      if (bodyFat < 25) return 'fitness';
      if (bodyFat < 32) return 'average';
      return 'obese';
    }
  }

  static Color _getBodyFatColor(double bodyFat, String genderKey) {
    if (genderKey == "male") {
      if (bodyFat < 14) return const Color(0xFF10B981);
      if (bodyFat < 18) return const Color(0xFF22C55E);
      if (bodyFat < 25) return const Color(0xFFF59E0B);
      return const Color(0xFFEF4444);
    } else {
      if (bodyFat < 21) return const Color(0xFF10B981);
      if (bodyFat < 25) return const Color(0xFF22C55E);
      if (bodyFat < 32) return const Color(0xFFF59E0B);
      return const Color(0xFFEF4444);
    }
  }

  static Map<String, dynamic> _getActivityLevels(double bmr) {
    return {
      'levels': [
        {'levelKey': 'sedentary', 'descriptionKey': 'sedentaryDesc', 'multiplier': 1.2, 'icon': Icons.weekend_rounded, 'color': const Color(0xFF3B82F6)},
        {'levelKey': 'lightlyActive', 'descriptionKey': 'lightlyActiveDesc', 'multiplier': 1.375, 'icon': Icons.directions_walk_rounded, 'color': const Color(0xFF10B981)},
        {'levelKey': 'moderatelyActive', 'descriptionKey': 'moderatelyActiveDesc', 'multiplier': 1.55, 'icon': Icons.directions_run_rounded, 'color': const Color(0xFFF59E0B)},
        {'levelKey': 'veryActive', 'descriptionKey': 'veryActiveDesc', 'multiplier': 1.725, 'icon': Icons.fitness_center_rounded, 'color': const Color(0xFFEF4444)},
        {'levelKey': 'extraActive', 'descriptionKey': 'extraActiveDesc', 'multiplier': 1.9, 'icon': Icons.sports_martial_arts_rounded, 'color': const Color(0xFF8B5CF6)},
      ],
      'bmr': bmr,
    };
  }

  static int? _parseInt(String text) => NumberUtils.tryParseInt(text);
  static double? _parseDouble(String text) => NumberUtils.tryParseDouble(text);
}

class HealthToolScreen extends StatefulWidget {
  final HealthTool tool;
  const HealthToolScreen({super.key, required this.tool});

  @override
  State<HealthToolScreen> createState() => _HealthToolScreenState();
}

class _HealthToolScreenState extends State<HealthToolScreen> {
  final HealthInputData _inputData = HealthInputData();
  HealthResult? _result;

  @override
  void initState() {
    super.initState();
    _inputData.controllers.forEach((key, controller) {
      controller.addListener(() => setState(() {}));
    });
  }

  void _calculate() {
    final l10n = AppLocalizations.of(context);
    setState(() => _result = HealthCalculatorService.calculate(widget.tool, _inputData, l10n));
  }

  void _recalculateOnLanguageChange() {
    if (_result != null) {
      final l10n = AppLocalizations.of(context);
      setState(() => _result = HealthCalculatorService.calculate(widget.tool, _inputData, l10n));
    }
  }

  Widget _buildGenderSelector(AppLocalizations l10n) {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(l10n.gender, Icons.person_rounded),
          const SizedBox(height: 16),
          Row(children: [
            _buildGenderOption("male", l10n.male, Icons.male_rounded, const Color(0xFF3B82F6)),
            const SizedBox(width: 12),
            _buildGenderOption("female", l10n.female, Icons.female_rounded, const Color(0xFFEC4899)),
          ]),
        ],
      ),
    );
  }

  Widget _buildGenderOption(String genderKey, String genderText, IconData icon, Color color) {
    final isSelected = _inputData.genderKey == genderKey;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _inputData.genderKey = genderKey),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected ? color.withOpacity(0.1) : Colors.grey.shade50,
            border: Border.all(color: isSelected ? color : Colors.grey.shade200, width: 2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(children: [
            Icon(icon, size: 32, color: isSelected ? color : Colors.grey.shade400),
            const SizedBox(height: 8),
            Text(genderText, style: TextStyle(fontWeight: FontWeight.w600, color: isSelected ? color : Colors.grey.shade600, fontSize: 14)),
          ]),
        ),
      ),
    );
  }

  Widget _buildInputField(String key, String label, String suffix, IconData icon, AppLocalizations l10n) {
    final controller = _inputData.controllers[key]!;
    final hasError = controller.text.isNotEmpty && _hasError(key, controller.text);
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(label, icon),
          const SizedBox(height: 12),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "$label...",
              suffixText: suffix,
              errorText: hasError ? _getErrorMessage(key, l10n) : null,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }

  bool _hasError(String key, String value) {
    final numValue = NumberUtils.tryParseDouble(value) ?? NumberUtils.tryParseInt(value);
    if (numValue == null) return true;
    final doubleValue = numValue.toDouble();
    switch (key) {
      case 'age': return doubleValue <= 0 || doubleValue > 120;
      case 'weight': return doubleValue <= 20 || doubleValue >= 300;
      case 'height': return doubleValue <= 50 || doubleValue >= 250;
      case 'fat': return doubleValue < 2 || doubleValue > 60;
      case 'muscle': return doubleValue < 20 || doubleValue > 60;
      case 'waist': return doubleValue < 50 || doubleValue > 200;
      case 'neck': return doubleValue < 20 || doubleValue > 60;
      case 'hip': return doubleValue < 60 || doubleValue > 200;
      default: return false;
    }
  }

  String _getErrorMessage(String key, AppLocalizations l10n) {
    switch (key) {
      case 'age': return l10n.errorAge;
      case 'weight': return l10n.errorWeight;
      case 'height': return l10n.errorHeight;
      case 'fat': return l10n.errorBodyFat;
      case 'muscle': return l10n.errorMuscleMass;
      case 'waist': return l10n.errorWaist;
      case 'neck': return l10n.errorNeck;
      case 'hip': return l10n.errorHip;
      default: return l10n.invalidValue;
    }
  }

  List<Widget> _buildRequiredFields(AppLocalizations l10n) {
    switch (widget.tool) {
      case HealthTool.bmi:
        return [
          _buildInputField('age', l10n.age, l10n.years, Icons.calendar_today_rounded, l10n),
          _buildInputField('weight', l10n.weight, l10n.kg, Icons.monitor_weight_rounded, l10n),
          _buildInputField('height', l10n.height, l10n.cm, Icons.straighten_rounded, l10n),
          _buildInputField('fat', l10n.bodyFatPercentage, "%", Icons.pie_chart_rounded, l10n),
          _buildInputField('muscle', l10n.muscleMassPercentage, "%", Icons.fitness_center_rounded, l10n),
        ];
      case HealthTool.bmr:
        return [
          _buildInputField('age', l10n.age, l10n.years, Icons.calendar_today_rounded, l10n),
          _buildInputField('weight', l10n.weight, l10n.kg, Icons.monitor_weight_rounded, l10n),
          _buildInputField('height', l10n.height, l10n.cm, Icons.straighten_rounded, l10n),
        ];
      case HealthTool.bodyFat:
        final fields = [
          _buildInputField('age', l10n.age, l10n.years, Icons.calendar_today_rounded, l10n),
          _buildInputField('height', l10n.height, l10n.cm, Icons.straighten_rounded, l10n),
          _buildInputField('waist', l10n.waist, l10n.cm, Icons.square_rounded, l10n),
          _buildInputField('neck', l10n.neck, l10n.cm, Icons.circle_rounded, l10n),
        ];

        if (_inputData.genderKey == "female") {
          fields.add(_buildInputField('hip', l10n.hip, l10n.cm, Icons.rounded_corner_rounded, l10n));
        }
        return fields;
    }
  }

  Widget _buildResultCard(AppLocalizations l10n) {
    if (_result == null) return const SizedBox();


    return _buildCard(
      child: Column(children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: _result!.color.withOpacity(0.1), shape: BoxShape.circle),
          child: Icon(_getResultIcon(), size: 40, color: _result!.color),
        ),
        const SizedBox(height: 16),
        Text(_getResultTitle(l10n), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: _result!.color)),
        const SizedBox(height: 16),
        if (_result!.value != null) Text(_getResultValue(), style: TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: _result!.color)),
        if (_result!.value != null) const SizedBox(height: 12),
        if (_result!.value != null) Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(color: _result!.color.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
          child: Text(_result!.getCategoryText(l10n), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _result!.color)),
        ),

        if (widget.tool == HealthTool.bmi && _result!.value != null) ...[
          const SizedBox(height: 24),
          _buildBMIColorScale(l10n),
        ],

        const SizedBox(height: 20),
        Text(_result!.getDescription(l10n), style: const TextStyle(fontSize: 16, height: 1.6, color: Color(0xFF6B7280), fontWeight: FontWeight.w500), textAlign: TextAlign.center),

        if (widget.tool == HealthTool.bmi && _result!.value != null) ...[
          const SizedBox(height: 20),
          _buildFatMuscleCards(l10n),
        ],

        if (_result!.additionalData != null && _result!.additionalData!['levels'] != null) _buildActivityLevels(l10n),
      ]),
    );
  }

  Widget _buildBMIColorScale(AppLocalizations l10n) {
    final bmiValue = _result!.value!;
    final isRTL = Directionality.of(context) == TextDirection.rtl;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(l10n.bmiScale, Icons.auto_graph_rounded),
        const SizedBox(height: 16),
        Container(
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              colors: [
                Color(0xFF60A5FA),
                Color(0xFF34D399),
                Color(0xFF10B981),
                Color(0xFFF59E0B),
                Color(0xFFEF4444),
              ],
              stops: [0.0, 0.23, 0.38, 0.62, 1.0],
              begin: isRTL ? Alignment.centerRight : Alignment.centerLeft,
              end: isRTL ? Alignment.centerLeft : Alignment.centerRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                left: isRTL ? null : '18.5'.length * 3.0,
                right: isRTL ? '18.5'.length * 3.0 : null,
                top: 0,
                bottom: 0,
                child: Container(width: 2, color: Colors.white.withOpacity(0.5)),
              ),
              Positioned(
                left: isRTL ? null : '25'.length * 8.0,
                right: isRTL ? '25'.length * 8.0 : null,
                top: 0,
                bottom: 0,
                child: Container(width: 2, color: Colors.white.withOpacity(0.5)),
              ),
              Positioned(
                left: isRTL ? null : '30'.length * 13.5,
                right: isRTL ? '30'.length * 13.5 : null,
                top: 0,
                bottom: 0,
                child: Container(width: 2, color: Colors.white.withOpacity(0.5)),
              ),

              Positioned(
                left: isRTL ? null : _calculateBMIPosition(bmiValue, isRTL),
                right: isRTL ? _calculateBMIPosition(bmiValue, isRTL) : null,
                top: -10,
                child: Column(
                  children: [
                    Icon(Icons.arrow_drop_down, size: 30, color: Colors.white),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _result!.color,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(bmiValue.toStringAsFixed(1),
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("18.5", style: TextStyle(color: const Color(0xFF60A5FA), fontWeight: FontWeight.bold)),
            Text("25", style: TextStyle(color: const Color(0xFF10B981), fontWeight: FontWeight.bold)),
            Text("30", style: TextStyle(color: const Color(0xFFF59E0B), fontWeight: FontWeight.bold)),
            Text("40+", style: TextStyle(color: const Color(0xFFEF4444), fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(l10n.underweight, style: TextStyle(color: const Color(0xFF60A5FA), fontSize: 12)),
            Text(l10n.normalWeight, style: TextStyle(color: const Color(0xFF10B981), fontSize: 12)),
            Text(l10n.overweight, style: TextStyle(color: const Color(0xFFF59E0B), fontSize: 12)),
            Text(l10n.obese, style: TextStyle(color: const Color(0xFFEF4444), fontSize: 12)),
          ],
        ),
      ],
    );
  }

  double _calculateBMIPosition(double bmi, bool isRTL) {
    final width = MediaQuery.of(context).size.width - 80;
    double position;

    if (bmi <= 18.5) {
      position = (bmi / 18.5) * 0.25 * width;
    } else if (bmi <= 25) {
      position = 0.25 * width + ((bmi - 18.5) / 6.5) * 0.25 * width;
    } else if (bmi <= 30) {
      position = 0.5 * width + ((bmi - 25) / 5) * 0.25 * width;
    } else {
      position = 0.75 * width + (min((bmi - 30) / 10, 1.0)) * 0.25 * width;
    }

    if (isRTL) {
      position = width - position;
    }

    return position;
  }

  Widget _buildFatMuscleCards(AppLocalizations l10n) {
    final additionalData = _result!.calculationData;
    final fat = additionalData['fatPercentage'] as double?;
    final muscle = additionalData['musclePercentage'] as double?;

    return Column(
      children: [
        if (fat != null || muscle != null)
          _buildSectionTitle(l10n.bodyComposition, Icons.pie_chart_rounded),
        const SizedBox(height: 16),
        Row(
          children: [
            if (fat != null) Expanded(child: _buildCompositionCard(
              l10n.bodyFatPercentage,
              "${fat.toStringAsFixed(1)}%",
              _getFatColor(fat),
              Icons.pie_chart_rounded,
            )),
            if (fat != null && muscle != null) const SizedBox(width: 12),
            if (muscle != null) Expanded(child: _buildCompositionCard(
              l10n.muscleMassPercentage,
              "${muscle.toStringAsFixed(1)}%",
              _getMuscleColor(muscle),
              Icons.fitness_center_rounded,
            )),
          ],
        ),
      ],
    );
  }

  Widget _buildCompositionCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: color),
          const SizedBox(height: 8),
          Text(title, style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Color _getFatColor(double fat) {
    if (fat < 15) return const Color(0xFF10B981);
    if (fat < 25) return const Color(0xFFF59E0B);
    return const Color(0xFFEF4444);
  }

  Color _getMuscleColor(double muscle) {
    if (muscle > 40) return const Color(0xFF10B981);
    if (muscle > 30) return const Color(0xFFF59E0B);
    return const Color(0xFFEF4444);
  }

  Widget _buildActivityLevels(AppLocalizations l10n) {
    final levels = _result!.additionalData!['levels'] as List;
    final bmr = _result!.additionalData!['bmr'] as double;
    return Column(
      children: levels.map((level) {
        final multiplier = level['multiplier'] as double;
        final calories = (bmr * multiplier).round();
        final color = level['color'] as Color;
        final icon = level['icon'] as IconData;
        final levelKey = level['levelKey'] as String;

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "$levelKey: $calories cal",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActivityCard(Map level, double bmr, AppLocalizations l10n) {
    final calories = (bmr * (level['multiplier'] as double)).round();
    final color = level['color'] as Color;
    final levelKey = level['levelKey'] as String;
    final descriptionKey = level['descriptionKey'] as String;

    String levelText;
    String descriptionText;

    switch (levelKey) {
      case 'sedentary': levelText = l10n.sedentary; break;
      case 'lightlyActive': levelText = l10n.lightlyActive; break;
      case 'moderatelyActive': levelText = l10n.moderatelyActive; break;
      case 'veryActive': levelText = l10n.veryActive; break;
      case 'extraActive': levelText = l10n.extraActive; break;
      default: levelText = levelKey;
    }

    switch (descriptionKey) {
      case 'sedentaryDesc': descriptionText = l10n.sedentaryDesc; break;
      case 'lightlyActiveDesc': descriptionText = l10n.lightlyActiveDesc; break;
      case 'moderatelyActiveDesc': descriptionText = l10n.moderatelyActiveDesc; break;
      case 'veryActiveDesc': descriptionText = l10n.veryActiveDesc; break;
      case 'extraActiveDesc': descriptionText = l10n.extraActiveDesc; break;
      default: descriptionText = descriptionKey;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: color.withOpacity(0.05), borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withOpacity(0.2))),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(level['icon'] as IconData, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(levelText, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: color)),
            const SizedBox(height: 4),
            Text(descriptionText, style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
            const SizedBox(height: 4),
            Text("BMR × ${level['multiplier']}", style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
          ])),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(20), border: Border.all(color: color.withOpacity(0.3))),
            child: Column(children: [
              Text("$calories", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: color)),
              Text("${l10n.calories}/day", style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w600)),
            ]),
          ),
        ]),
      ),
    );
  }

  IconData _getResultIcon() {
    switch (widget.tool) {
      case HealthTool.bmi: return Icons.monitor_weight_rounded;
      case HealthTool.bmr: return Icons.local_fire_department_rounded;
      case HealthTool.bodyFat: return Icons.pie_chart_rounded;
    }
  }

  String _getResultTitle(AppLocalizations l10n) {
    switch (widget.tool) {
      case HealthTool.bmi: return l10n.yourBmiResult;
      case HealthTool.bmr: return l10n.yourBmrResult;
      case HealthTool.bodyFat: return l10n.yourBodyFatResult;
    }
  }

  String _getResultValue() {
    if (_result!.value == null) return "";
    switch (widget.tool) {
      case HealthTool.bmi: return _result!.value!.toStringAsFixed(1);
      case HealthTool.bmr: return _result!.value!.toStringAsFixed(0);
      case HealthTool.bodyFat: return "${_result!.value!.toStringAsFixed(1)}%";
    }
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 4))],
      ),
      child: Padding(padding: const EdgeInsets.all(20), child: child),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(children: [
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: AppTheme.primaryColor, size: 20),
      ),
      const SizedBox(width: 12),
      Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.primaryColor,
      )),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_getScreenTitle(l10n)),
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_rounded, size: 20), onPressed: () => Navigator.pop(context)),
        actions: [
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFFF8FAFF), Color(0xFFEFF4FF)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(children: [
            _buildGenderSelector(l10n),
            ..._buildRequiredFields(l10n),
            const SizedBox(height: 24),
            Material(
              borderRadius: BorderRadius.circular(16),
              elevation: 4,
              child: Container(
                decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF0A1986), Color(0xFF1E3A8A)]), borderRadius: BorderRadius.circular(16)),
                child: ElevatedButton(
                  onPressed: _calculate,
                  style: ElevatedButton.styleFrom(
                    // backgroundColor: Colors.transparent, shadowColor: Colors.transparent,
                    backgroundColor: AppTheme.primaryColor,

                    minimumSize: const Size(double.infinity, 60), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Icon(Icons.calculate_rounded, color: Colors.white, size: 24),
                    const SizedBox(width: 12),
                    Text(_getCalculateButtonText(l10n), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
                  ]),
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (_result != null) _buildResultCard(l10n),
          ]),
        ),
      ),
    );
  }

  String _getScreenTitle(AppLocalizations l10n) {
    switch (widget.tool) {
      case HealthTool.bmi: return l10n.advancedBmiCalculator;
      case HealthTool.bmr: return l10n.bmrCalculator;
      case HealthTool.bodyFat: return l10n.bodyFatCalculator;
    }
  }

  String _getCalculateButtonText(AppLocalizations l10n) {
    switch (widget.tool) {
      case HealthTool.bmi: return l10n.calculateBmi;
      case HealthTool.bmr: return l10n.calculateBmr;
      case HealthTool.bodyFat: return l10n.calculateBodyFat;
    }
  }

  @override
  void dispose() {
    _inputData.dispose();
    super.dispose();
  }
}