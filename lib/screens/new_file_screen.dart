import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';
import '../app/localization/app_localizations.dart';
import '../widgets/form_fields.dart';
import '../app/theme/app_theme.dart';
import '../utils/error_utils.dart';

class NewFileScreen extends StatefulWidget {
  final AuthService authService; // Service for API calls

  const NewFileScreen({
    Key? key,
    required this.authService,
  }) : super(key: key);

  @override
  State<NewFileScreen> createState() => _NewFileScreenState();
}

class _NewFileScreenState extends State<NewFileScreen> {
  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Text controllers for input fields
  final TextEditingController _governmentIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  // Dropdown selections
  String? _selectedNationality;
  String? _selectedHospital;
  String? _selectedMaritalStatus;
  String? _selectedReligion;

  bool _isLoading = false; // Loading state for button
  String? _errorMessage; // Error message to display

  // Lists for dropdowns
  List<String> _hospitals = [];
  List<String> _maritalStatuses = [];
  List<String> _religions = [];

  @override
  void initState() {
    super.initState();
    _initializeTranslatedLists(); // Populate dropdowns with translations
  }

  // Initialize hospital, marital status, and religion lists with translations
  void _initializeTranslatedLists() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final localizations = AppLocalizations.of(context);
        setState(() {
          _hospitals = [
            localizations.mouwasatHospitalRiyadh,
            localizations.mouwasatHospitalDammam,
            localizations.mouwasatHospitalKhobar,
            localizations.mouwasatHospitalMedina,
            localizations.mouwasatHospitalQatif,
          ];

          _maritalStatuses = [
            localizations.single,
            localizations.married,
            localizations.divorced,
            localizations.widowed,
          ];

          _religions = [
            localizations.muslim,
            localizations.christian,
            localizations.jewish,
            localizations.hindu,
            localizations.buddhist,
            localizations.other,
          ];
        });
      }
    });
  }

  // Open date picker and set birth date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _birthDateController.text =
        "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  // Submit form and create medical file
  Future<void> _createMedicalFile() async {
    if (!_formKey.currentState!.validate()) return; // Validate fields

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Call API to register without password
      final user = await widget.authService.registerWithoutPassword(
        governmentId: _governmentIdController.text.trim(),
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        nationality: _selectedNationality,
        hospital: _selectedHospital,
        birthDate: _birthDateController.text,
        maritalStatus: _selectedMaritalStatus,
        religion: _selectedReligion,
      );

      if (mounted) {
        // Navigate to home screen on success
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              user: user,
              changeLanguage: (locale) {}, // Placeholder
              currentLocale: const Locale('en'),
              authService: widget.authService,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = ErrorUtils.getTranslatedErrorMessage(
              e.toString(), AppLocalizations.of(context));
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Go back
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildHeader(localizations),
                SizedBox(height: 32),
                _buildGovernmentIdField(localizations),
                SizedBox(height: 16),
                _buildNameField(localizations),
                SizedBox(height: 16),
                _buildEmailField(localizations),
                SizedBox(height: 16),
                _buildNationalityField(localizations),
                SizedBox(height: 16),
                _buildHospitalField(localizations),
                SizedBox(height: 16),
                _buildBirthDateField(localizations),
                SizedBox(height: 16),
                _buildMaritalStatusField(localizations),
                SizedBox(height: 16),
                _buildReligionField(localizations),
                if (_errorMessage != null) ...[
                  SizedBox(height: 16),
                  ErrorMessageWidget(message: _errorMessage!),
                ],
                SizedBox(height: 32),
                _buildCreateButton(localizations),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Header text
  Widget _buildHeader(AppLocalizations localizations) {
    return Column(
      children: [
        Text(
          localizations.createMedicalFile,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }

  // Individual field widgets
  Widget _buildGovernmentIdField(AppLocalizations localizations) {
    return GovernmentIdField(
      controller: _governmentIdController,
      hintText: localizations.enterGovernmentId,
    );
  }

  Widget _buildNameField(AppLocalizations localizations) {
    return NameField(
      controller: _nameController,
      hintText: localizations.enterFullName,
    );
  }

  Widget _buildEmailField(AppLocalizations localizations) {
    return EmailField(
      controller: _emailController,
      hintText: localizations.enterYourEmail,
    );
  }

  Widget _buildNationalityField(AppLocalizations localizations) {
    return DropdownButtonFormField<String>(
      value: _selectedNationality,
      decoration: InputDecoration(
        labelText: localizations.nationality,
        prefixIcon: Icon(Icons.flag_outlined, color: AppTheme.primaryColor),
      ),
      items: [
        DropdownMenuItem(value: 'Saudi', child: Text(localizations.saudi)),
        DropdownMenuItem(value: 'Non-Saudi', child: Text(localizations.nonSaudi)),
      ],
      onChanged: (value) => setState(() => _selectedNationality = value),
      validator: (value) =>
      value == null ? localizations.pleaseSelectNationality : null,
    );
  }

  Widget _buildHospitalField(AppLocalizations localizations) {
    return DropdownButtonFormField<String>(
      value: _selectedHospital,
      decoration: InputDecoration(
        labelText: localizations.selectHospital,
        prefixIcon: Icon(Icons.local_hospital_outlined, color: AppTheme.primaryColor),
      ),
      items: _hospitals
          .map((hospital) => DropdownMenuItem(value: hospital, child: Text(hospital)))
          .toList(),
      onChanged: (value) => setState(() => _selectedHospital = value),
      validator: (value) =>
      value == null ? localizations.pleaseSelectHospital : null,
    );
  }

  Widget _buildBirthDateField(AppLocalizations localizations) {
    return TextFormField(
      controller: _birthDateController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: localizations.birthDate,
        hintText: localizations.selectBirthDate,
        prefixIcon: Icon(Icons.calendar_today_outlined, color: AppTheme.primaryColor),
      ),
      onTap: () => _selectDate(context), // Show date picker
      validator: (value) =>
      value == null || value.isEmpty ? localizations.pleaseSelectBirthDate : null,
    );
  }

  Widget _buildMaritalStatusField(AppLocalizations localizations) {
    return DropdownButtonFormField<String>(
      value: _selectedMaritalStatus,
      decoration: InputDecoration(
        labelText: localizations.maritalStatus,
        prefixIcon: Icon(Icons.people_outline, color: AppTheme.primaryColor),
      ),
      items: _maritalStatuses
          .map((status) => DropdownMenuItem(value: status, child: Text(status)))
          .toList(),
      onChanged: (value) => setState(() => _selectedMaritalStatus = value),
      validator: (value) =>
      value == null ? localizations.pleaseSelectMaritalStatus : null,
    );
  }

  Widget _buildReligionField(AppLocalizations localizations) {
    return DropdownButtonFormField<String>(
      value: _selectedReligion,
      decoration: InputDecoration(
        labelText: localizations.religion,
        prefixIcon: Icon(Icons.auto_awesome_outlined, color: AppTheme.primaryColor),
      ),
      items: _religions
          .map((religion) => DropdownMenuItem(value: religion, child: Text(religion)))
          .toList(),
      onChanged: (value) => setState(() => _selectedReligion = value),
      validator: (value) =>
      value == null ? localizations.pleaseSelectReligion : null,
    );
  }

  // Submit button widget
  Widget _buildCreateButton(AppLocalizations localizations) {
    return SubmitButton(
      text: localizations.createMedicalFile,
      onPressed: _createMedicalFile,
      isLoading: _isLoading,
    );
  }

  @override
  void dispose() {
    _governmentIdController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }
}