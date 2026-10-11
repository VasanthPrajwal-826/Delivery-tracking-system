import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/order_model.dart';
import '../../services/demo_data_service.dart';
import '../../widgets/common_widgets.dart';
import '../../utils/app_utils.dart';

/// Order details screen showing full order information
class OrderDetailsScreen extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final dataService = DemoDataService();
    // Get fresh order data
    final freshOrder = dataService.getOrderById(order.orderId) ?? order;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text('#${freshOrder.orderId}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppTheme.cardGradient,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withValues(alpha: 0.25),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    freshOrder.isDelivered
                        ? Icons.check_circle
                        : Icons.local_shipping,
                    color: Colors.white,
                    size: 40,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    freshOrder.status,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    freshOrder.isDelivered
                        ? 'Delivered successfully'
                        : 'Estimated: ${freshOrder.estimatedTime ?? "Calculating..."}',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Track button
            if (freshOrder.isActive)
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: PrimaryButton(
                  text: 'Track Delivery',
                  icon: Icons.map_outlined,
                  onPressed: () {
                    Navigator.pushNamed(context, '/track_delivery',
                        arguments: freshOrder);
                  },
                ),
              ),

            // Order Info
            _buildSection('Order Information', [
              _buildInfoRow('Order ID', '#${freshOrder.orderId}'),
              _buildInfoRow('Package Type', freshOrder.packageType),
              _buildInfoRow('Weight', '${freshOrder.packageWeight} kg'),
              _buildInfoRow(
                  'Created', AppUtils.formatDateTime(freshOrder.createdAt)),
                _buildInfoRow(
                  'Preferred Date', AppUtils.formatDate(freshOrder.preferredDate)),
              if (freshOrder.notes != null && freshOrder.notes!.isNotEmpty)
                _buildInfoRow('Notes', freshOrder.notes!),
            ]),
            const SizedBox(height: 16),

            // Addresses
            _buildSection('Addresses', [
              _buildAddressItem(
                'Pickup Address',
                freshOrder.pickupAddress,
                Icons.radio_button_checked,
                AppTheme.successColor,
              ),
              const Divider(height: 20),
              _buildAddressItem(
                'Delivery Address',
                freshOrder.deliveryAddress,
                Icons.location_on,
                AppTheme.errorColor,
              ),
            ]),
            const SizedBox(height: 16),

            // Delivery Agent
            if (freshOrder.deliveryAgentName != null)
              _buildSection('Delivery Agent', [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor:
                          AppTheme.secondaryColor.withValues(alpha: 0.1),
                      child: Text(
                        freshOrder.deliveryAgentName![0],
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.secondaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            freshOrder.deliveryAgentName!,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const Text(
                            'Delivery Partner',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.successColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.phone,
                        color: AppTheme.successColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ]),

            // Rating section for delivered orders
            if (freshOrder.isDelivered) ...[
              const SizedBox(height: 16),
              if (freshOrder.rating != null)
                _buildSection('Your Rating', [
                  Row(
                    children: [
                      ...List.generate(5, (i) {
                        return Icon(
                          i < freshOrder.rating!.floor()
                              ? Icons.star
                              : Icons.star_border,
                          color: AppTheme.warningColor,
                          size: 24,
                        );
                      }),
                      const SizedBox(width: 8),
                      Text(
                        '${freshOrder.rating}',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  if (freshOrder.ratingComment != null &&
                      freshOrder.ratingComment!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      '"${freshOrder.ratingComment}"',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ])
              else
                PrimaryButton(
                  text: 'Rate This Delivery',
                  icon: Icons.star_outline,
                  onPressed: () {
                    Navigator.pushNamed(context, '/rating',
                        arguments: freshOrder);
                  },
                ),
            ],
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                color: AppTheme.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppTheme.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressItem(
      String label, String address, IconData icon, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: AppTheme.textHint,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                address,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
