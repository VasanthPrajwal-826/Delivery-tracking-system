/// Order model representing a delivery order
class OrderModel {
  final String orderId;
  final String customerId;
  final String customerName;
  final String customerPhone;
  final String? deliveryAgentId;
  final String? deliveryAgentName;
  final String pickupAddress;
  final String deliveryAddress;
  final String packageType;
  final double packageWeight;
  final String status;
  final String? estimatedTime;
  final String? notes;
  final DateTime preferredDate;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final double? rating;
  final String? ratingComment;

  // All possible delivery statuses in order
  static const List<String> allStatuses = [
    'Order Placed',
    'Confirmed',
    'Packed',
    'Picked Up',
    'Out for Delivery',
    'Near You',
    'Delivered',
  ];

  OrderModel({
    required this.orderId,
    required this.customerId,
    required this.customerName,
    this.customerPhone = '',
    this.deliveryAgentId,
    this.deliveryAgentName,
    required this.pickupAddress,
    required this.deliveryAddress,
    this.packageType = 'Standard',
    this.packageWeight = 0.0,
    this.status = 'Order Placed',
    this.estimatedTime,
    this.notes,
    DateTime? preferredDate,
    DateTime? createdAt,
    this.updatedAt,
    this.rating,
    this.ratingComment,
  })  : preferredDate = preferredDate ?? DateTime.now(),
        createdAt = createdAt ?? DateTime.now();

  /// Get the index of the current status in the timeline
  int get statusIndex => allStatuses.indexOf(status);

  /// Check if the order is completed
  bool get isDelivered => status == 'Delivered';

  /// Check if the order is active
  bool get isActive => !isDelivered && status != 'Cancelled';

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'customerId': customerId,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'deliveryAgentId': deliveryAgentId,
      'deliveryAgentName': deliveryAgentName,
      'pickupAddress': pickupAddress,
      'deliveryAddress': deliveryAddress,
      'packageType': packageType,
      'packageWeight': packageWeight,
      'status': status,
      'estimatedTime': estimatedTime,
      'notes': notes,
      'preferredDate': preferredDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'rating': rating,
      'ratingComment': ratingComment,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'] ?? '',
      customerId: map['customerId'] ?? '',
      customerName: map['customerName'] ?? '',
      customerPhone: map['customerPhone'] ?? '',
      deliveryAgentId: map['deliveryAgentId'],
      deliveryAgentName: map['deliveryAgentName'],
      pickupAddress: map['pickupAddress'] ?? '',
      deliveryAddress: map['deliveryAddress'] ?? '',
      packageType: map['packageType'] ?? 'Standard',
      packageWeight: (map['packageWeight'] ?? 0.0).toDouble(),
      status: map['status'] ?? 'Order Placed',
      estimatedTime: map['estimatedTime'],
      notes: map['notes'],
      preferredDate: map['preferredDate'] != null
          ? DateTime.parse(map['preferredDate'])
          : DateTime.now(),
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'])
          : null,
      rating: map['rating']?.toDouble(),
      ratingComment: map['ratingComment'],
    );
  }

  OrderModel copyWith({
    String? orderId,
    String? customerId,
    String? customerName,
    String? customerPhone,
    String? deliveryAgentId,
    String? deliveryAgentName,
    String? pickupAddress,
    String? deliveryAddress,
    String? packageType,
    double? packageWeight,
    String? status,
    String? estimatedTime,
    String? notes,
    DateTime? preferredDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? rating,
    String? ratingComment,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      deliveryAgentId: deliveryAgentId ?? this.deliveryAgentId,
      deliveryAgentName: deliveryAgentName ?? this.deliveryAgentName,
      pickupAddress: pickupAddress ?? this.pickupAddress,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      packageType: packageType ?? this.packageType,
      packageWeight: packageWeight ?? this.packageWeight,
      status: status ?? this.status,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      notes: notes ?? this.notes,
      preferredDate: preferredDate ?? this.preferredDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rating: rating ?? this.rating,
      ratingComment: ratingComment ?? this.ratingComment,
    );
  }
}
