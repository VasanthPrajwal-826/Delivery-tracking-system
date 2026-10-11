import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../services/demo_data_service.dart';
import '../../widgets/common_widgets.dart';
import '../../utils/app_utils.dart';

/// Create new delivery order form
class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({super.key});

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _pickupController = TextEditingController();
  final _deliveryController = TextEditingController();
  final _weightController = TextEditingController();
  final _notesController = TextEditingController();

  String _selectedPackageType = 'Standard';
  DateTime _preferredDate = DateTime.now().add(const Duration(days: 1));
  bool _isLoading = false;

  final _dataService = DemoDataService();

  final List<String> _packageTypes = [
    'Standard',
    'Electronics',
    'Documents',
    'Food',
    'Clothing',
    'Medicine',
    'Books',
    'Fragile',
    'Heavy',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    final user = _dataService.currentUser;
    if (user != null) {
      _nameController.text = user.name;
      _phoneController.text = user.phone;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _pickupController.dispose();
    _deliveryController.dispose();
    _weightController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _preferredDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: AppTheme.primaryColor),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _preferredDate = picked);
    }
  }

  Future<void> _submitOrder() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final order = await _dataService.createOrder(
      customerName: _nameController.text.trim(),
      customerPhone: _phoneController.text.trim(),
      pickupAddress: _pickupController.text.trim(),
      deliveryAddress: _deliveryController.text.trim(),
      packageType: _selectedPackageType,
      packageWeight: double.tryParse(_weightController.text) ?? 0.0,
      notes: _notesController.text.trim(),
      preferredDate: _preferredDate,
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    // Show success dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.successColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                color: AppTheme.successColor,
                size: 48,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Order Created!',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your order #${order.orderId} has been placed successfully.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '#${order.orderId}',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              text: 'View My Orders',
              onPressed: () {
                Navigator.pop(context); // close dialog
                Navigator.pop(context); // go back to home
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Create Order'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section: Contact Info
                _buildSectionTitle('Contact Information', Icons.person_outline),
                const SizedBox(height: 14),
                CustomTextField(
                  controller: _nameController,
                  label: 'Customer Name',
                  hint: 'Enter your name',
                  prefixIcon: Icons.person_outline,
                  validator: (v) => AppUtils.validateRequired(v, 'Name'),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _phoneController,
                  label: 'Phone Number',
                  hint: 'Enter phone number',
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: AppUtils.validatePhone,
                ),

                const SizedBox(height: 28),

                // Section: Addresses
                _buildSectionTitle('Addresses', Icons.location_on_outlined),
                const SizedBox(height: 14),
                CustomTextField(
                  controller: _pickupController,
                  label: 'Pickup Address',
                  hint: 'Enter pickup location',
                  prefixIcon: Icons.radio_button_checked,
                  maxLines: 2,
                  validator: (v) => AppUtils.validateRequired(v, 'Pickup address'),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _deliveryController,
                  label: 'Delivery Address',
                  hint: 'Enter delivery location',
                  prefixIcon: Icons.location_on_outlined,
                  maxLines: 2,
                  validator: (v) =>
                      AppUtils.validateRequired(v, 'Delivery address'),
                ),

                const SizedBox(height: 28),

                // Section: Package Details
                _buildSectionTitle('Package Details', Icons.inventory_2_outlined),
                const SizedBox(height: 14),

                // Package Type
                const Text(
                  'Package Type',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.borderColor),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedPackageType,
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: AppTheme.textPrimary,
                      ),
                      items: _packageTypes.map((type) {
                        return DropdownMenuItem(value: type, child: Text(type));
                      }).toList(),
                      onChanged: (value) {
                        setState(() => _selectedPackageType = value!);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: _weightController,
                  label: 'Package Weight (kg)',
                  hint: 'e.g., 2.5',
                  prefixIcon: Icons.scale_outlined,
                  keyboardType: TextInputType.number,
                  validator: (v) =>
                      AppUtils.validateRequired(v, 'Package weight'),
                ),

                const SizedBox(height: 28),

                // Section: Delivery Date
                _buildSectionTitle('Preferred Delivery Date', Icons.calendar_today),
                const SizedBox(height: 14),
                GestureDetector(
                  onTap: _selectDate,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.borderColor),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today,
                            size: 20, color: AppTheme.textSecondary),
                        const SizedBox(width: 12),
                        Text(
                          AppUtils.formatDate(_preferredDate),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.edit_calendar,
                            size: 18, color: AppTheme.primaryColor),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // Section: Notes
                _buildSectionTitle('Additional Notes', Icons.note_outlined),
                const SizedBox(height: 14),
                CustomTextField(
                  controller: _notesController,
                  label: 'Notes (Optional)',
                  hint: 'Any special instructions for delivery...',
                  maxLines: 3,
                ),

                const SizedBox(height: 32),

                // Submit Button
                PrimaryButton(
                  text: 'Place Order',
                  icon: Icons.check_circle_outline,
                  isLoading: _isLoading,
                  onPressed: _submitOrder,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppTheme.primaryColor),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }
}
