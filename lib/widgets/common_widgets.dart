import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/order_model.dart';
import '../utils/app_utils.dart';

/// Reusable order card widget displaying order summary
class OrderCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback? onTap;
  final bool showAgent;

  const OrderCard({
    super.key,
    required this.order,
    this.onTap,
    this.showAgent = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.dividerColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Order ID and Status Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.inventory_2_outlined,
                          color: AppTheme.primaryColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '#${order.orderId}',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          Text(
                            AppUtils.getRelativeTime(order.createdAt),
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  StatusBadge(status: order.status),
                ],
              ),
              const SizedBox(height: 14),
              // Addresses
              _buildAddressRow(Icons.radio_button_checked, order.pickupAddress,
                  AppTheme.successColor),
              Container(
                margin: const EdgeInsets.only(left: 11),
                height: 16,
                width: 1,
                color: AppTheme.dividerColor,
              ),
              _buildAddressRow(
                  Icons.location_on, order.deliveryAddress, AppTheme.errorColor),
              if (showAgent && order.deliveryAgentName != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.delivery_dining,
                          size: 18, color: AppTheme.secondaryColor),
                      const SizedBox(width: 8),
                      Text(
                        order.deliveryAgentName!,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const Spacer(),
                      if (order.estimatedTime != null)
                        Text(
                          order.estimatedTime!,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
              // Bottom: Package info
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildInfoChip(Icons.category_outlined, order.packageType),
                  const SizedBox(width: 8),
                  _buildInfoChip(
                      Icons.scale_outlined, '${order.packageWeight} kg'),
                  const Spacer(),
                  Icon(Icons.arrow_forward_ios,
                      size: 14, color: AppTheme.textHint),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressRow(IconData icon, String address, Color color) {
    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            address,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              color: AppTheme.textSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppTheme.textSecondary),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// Status badge widget showing delivery status with color coding
class StatusBadge extends StatelessWidget {
  final String status;
  final bool small;

  const StatusBadge({super.key, required this.status, this.small = false});

  Color get _backgroundColor {
    switch (status) {
      case 'Order Placed':
        return const Color(0xFFFEF3C7);
      case 'Confirmed':
        return const Color(0xFFDCFCE7);
      case 'Packed':
        return const Color(0xFFE0E7FF);
      case 'Picked Up':
        return const Color(0xFFCFFAFE);
      case 'Out for Delivery':
        return const Color(0xFFFEF9C3);
      case 'Near You':
        return const Color(0xFFFCE7F3);
      case 'Delivered':
        return const Color(0xFFDCFCE7);
      case 'Cancelled':
        return const Color(0xFFFEE2E2);
      default:
        return const Color(0xFFF1F5F9);
    }
  }

  Color get _textColor {
    switch (status) {
      case 'Order Placed':
        return const Color(0xFF92400E);
      case 'Confirmed':
        return const Color(0xFF166534);
      case 'Packed':
        return const Color(0xFF3730A3);
      case 'Picked Up':
        return const Color(0xFF155E75);
      case 'Out for Delivery':
        return const Color(0xFF854D0E);
      case 'Near You':
        return const Color(0xFF9D174D);
      case 'Delivered':
        return const Color(0xFF166534);
      case 'Cancelled':
        return const Color(0xFF991B1B);
      default:
        return AppTheme.textSecondary;
    }
  }

  IconData get _icon {
    switch (status) {
      case 'Order Placed':
        return Icons.receipt_long;
      case 'Confirmed':
        return Icons.check_circle_outline;
      case 'Packed':
        return Icons.inventory_2;
      case 'Picked Up':
        return Icons.local_shipping;
      case 'Out for Delivery':
        return Icons.delivery_dining;
      case 'Near You':
        return Icons.near_me;
      case 'Delivered':
        return Icons.task_alt;
      case 'Cancelled':
        return Icons.cancel_outlined;
      default:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: small ? 8 : 10,
        vertical: small ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_icon, size: small ? 12 : 14, color: _textColor),
          const SizedBox(width: 4),
          Text(
            status,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: small ? 10 : 12,
              fontWeight: FontWeight.w600,
              color: _textColor,
            ),
          ),
        ],
      ),
    );
  }
}

/// Dashboard statistics card
class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.dividerColor),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                color: AppTheme.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom text input field with consistent styling
class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final String? hint;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final int maxLines;
  final bool readOnly;
  final VoidCallback? onTap;

  const CustomTextField({
    super.key,
    this.controller,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          maxLines: maxLines,
          readOnly: readOnly,
          onTap: onTap,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            color: AppTheme.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, size: 20, color: AppTheme.textSecondary)
                : null,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}

/// Custom primary button
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final double? width;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

/// Tracking timeline widget showing delivery progress
class TrackingTimeline extends StatelessWidget {
  final int currentStatusIndex;

  const TrackingTimeline({super.key, required this.currentStatusIndex});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(OrderModel.allStatuses.length, (index) {
        final isCompleted = index < currentStatusIndex;
        final isCurrent = index == currentStatusIndex;
        final isPending = index > currentStatusIndex;

        return _buildTimelineItem(
          status: OrderModel.allStatuses[index],
          isCompleted: isCompleted,
          isCurrent: isCurrent,
          isPending: isPending,
          isLast: index == OrderModel.allStatuses.length - 1,
          index: index,
        );
      }),
    );
  }

  Widget _buildTimelineItem({
    required String status,
    required bool isCompleted,
    required bool isCurrent,
    required bool isPending,
    required bool isLast,
    required int index,
  }) {
    Color dotColor;
    IconData dotIcon;
    Color lineColor;
    FontWeight fontWeight;
    Color textColor;

    if (isCompleted) {
      dotColor = AppTheme.successColor;
      dotIcon = Icons.check_circle;
      lineColor = AppTheme.successColor;
      fontWeight = FontWeight.w500;
      textColor = AppTheme.textSecondary;
    } else if (isCurrent) {
      dotColor = AppTheme.primaryColor;
      dotIcon = Icons.radio_button_checked;
      lineColor = AppTheme.dividerColor;
      fontWeight = FontWeight.w600;
      textColor = AppTheme.primaryColor;
    } else {
      dotColor = AppTheme.dividerColor;
      dotIcon = Icons.radio_button_unchecked;
      lineColor = AppTheme.dividerColor;
      fontWeight = FontWeight.w400;
      textColor = AppTheme.textHint;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline indicator
        SizedBox(
          width: 30,
          child: Column(
            children: [
              Icon(dotIcon, color: dotColor, size: 24),
              if (!isLast)
                Container(
                  width: 2,
                  height: 36,
                  color: lineColor,
                ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        // Status text
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: fontWeight,
                    color: textColor,
                  ),
                ),
                if (isCurrent)
                  const Text(
                    'Current Status',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                if (isCompleted)
                  Text(
                    _getTimeForStatus(index),
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      color: AppTheme.textHint,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getTimeForStatus(int index) {
    final now = DateTime.now();
    final time = now.subtract(Duration(hours: (currentStatusIndex - index) * 2));
    return AppUtils.formatDateTime(time);
  }
}

/// Placeholder map widget for tracking screen
class PlaceholderMap extends StatelessWidget {
  final String pickupAddress;
  final String deliveryAddress;
  final String? agentName;

  const PlaceholderMap({
    super.key,
    required this.pickupAddress,
    required this.deliveryAddress,
    this.agentName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFFE8F4FD), Color(0xFFD4ECFC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: AppTheme.dividerColor),
      ),
      child: Stack(
        children: [
          // Grid lines simulating a map
          ...List.generate(8, (i) {
            return Positioned(
              left: 0,
              right: 0,
              top: i * 28.0,
              child: Container(
                height: 0.5,
                color: Colors.blue.withValues(alpha: 0.08),
              ),
            );
          }),
          ...List.generate(12, (i) {
            return Positioned(
              top: 0,
              bottom: 0,
              left: i * 32.0,
              child: Container(
                width: 0.5,
                color: Colors.blue.withValues(alpha: 0.08),
              ),
            );
          }),
          // Route line
          Positioned.fill(
            child: CustomPaint(
              painter: _RoutePainter(),
            ),
          ),
          // Pickup marker
          Positioned(
            left: 30,
            top: 60,
            child: _buildMarker(
              Icons.radio_button_checked,
              AppTheme.successColor,
              'Pickup',
            ),
          ),
          // Delivery marker
          Positioned(
            right: 30,
            bottom: 50,
            child: _buildMarker(
              Icons.location_on,
              AppTheme.errorColor,
              'Delivery',
            ),
          ),
          // Agent marker
          if (agentName != null)
            Positioned(
              left: MediaQuery.of(context).size.width * 0.35,
              top: 90,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.delivery_dining,
                            size: 14, color: Colors.white),
                        const SizedBox(width: 4),
                        Text(
                          agentName!.split(' ').first,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: AppTheme.primaryColor,
                    size: 20,
                  ),
                ],
              ),
            ),
          // Map overlay text
          Positioned(
            left: 12,
            bottom: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.map_outlined,
                      size: 14, color: AppTheme.textSecondary),
                  SizedBox(width: 4),
                  Text(
                    'Map placeholder — Configure Google Maps',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarker(IconData icon, Color color, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 4,
              ),
            ],
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ),
        Icon(icon, color: color, size: 28),
      ],
    );
  }
}

/// Custom paint for the route line on the placeholder map
class _RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.primaryColor.withValues(alpha: 0.5)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final dashPaint = Paint()
      ..color = AppTheme.primaryColor.withValues(alpha: 0.3)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(55, 95);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.3,
      size.width - 55,
      size.height - 70,
    );
    canvas.drawPath(path, paint);

    // Draw dash effect
    final dashPath = Path();
    dashPath.moveTo(55, 95);
    dashPath.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.3,
      size.width - 55,
      size.height - 70,
    );
    canvas.drawPath(dashPath, dashPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Empty state widget
class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? buttonText;
  final VoidCallback? onButtonPressed;

  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.buttonText,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 48, color: AppTheme.primaryColor),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (buttonText != null && onButtonPressed != null) ...[
              const SizedBox(height: 24),
              PrimaryButton(
                text: buttonText!,
                onPressed: onButtonPressed,
                width: 200,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
