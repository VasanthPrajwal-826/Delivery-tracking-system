import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/order_model.dart';
import '../models/notification_model.dart';
import 'package:uuid/uuid.dart';

/// Demo/Mock authentication and data service.
/// This service provides realistic demo data so the app runs without Firebase.
/// When Firebase is configured, replace calls to this service with Firebase services.
class DemoDataService extends ChangeNotifier {
  static final DemoDataService _instance = DemoDataService._internal();
  factory DemoDataService() => _instance;
  DemoDataService._internal() {
    _initializeDemoData();
  }

  final Uuid _uuid = const Uuid();

  // Current logged-in user
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  // Data stores
  final List<UserModel> _users = [];
  final List<OrderModel> _orders = [];
  final List<NotificationModel> _notifications = [];

  List<UserModel> get users => List.unmodifiable(_users);
  List<OrderModel> get orders => List.unmodifiable(_orders);
  List<NotificationModel> get notifications => List.unmodifiable(_notifications);

  int _orderCounter = 1003;

  /// Initialize demo data
  void _initializeDemoData() {
    // Demo Users
    _users.addAll([
      UserModel(
        uid: 'customer001',
        name: 'Rahul Sharma',
        email: 'customer@demo.com',
        role: 'customer',
        phone: '+91 98765 43210',
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
      ),
      UserModel(
        uid: 'customer002',
        name: 'Priya Patel',
        email: 'priya@demo.com',
        role: 'customer',
        phone: '+91 98765 43211',
        createdAt: DateTime.now().subtract(const Duration(days: 25)),
      ),
      UserModel(
        uid: 'customer003',
        name: 'Amit Kumar',
        email: 'amit@demo.com',
        role: 'customer',
        phone: '+91 98765 43212',
        createdAt: DateTime.now().subtract(const Duration(days: 20)),
      ),
      UserModel(
        uid: 'agent001',
        name: 'Vikram Singh',
        email: 'agent@demo.com',
        role: 'delivery_agent',
        phone: '+91 98765 11111',
        createdAt: DateTime.now().subtract(const Duration(days: 60)),
      ),
      UserModel(
        uid: 'agent002',
        name: 'Suresh Reddy',
        email: 'suresh@demo.com',
        role: 'delivery_agent',
        phone: '+91 98765 22222',
        createdAt: DateTime.now().subtract(const Duration(days: 45)),
      ),
      UserModel(
        uid: 'agent003',
        name: 'Deepak Nair',
        email: 'deepak@demo.com',
        role: 'delivery_agent',
        phone: '+91 98765 33333',
        createdAt: DateTime.now().subtract(const Duration(days: 40)),
      ),
      UserModel(
        uid: 'admin001',
        name: 'Admin User',
        email: 'admin@demo.com',
        role: 'admin',
        phone: '+91 98765 00000',
        createdAt: DateTime.now().subtract(const Duration(days: 90)),
      ),
    ]);

    // Demo Orders
    _orders.addAll([
      OrderModel(
        orderId: 'ORD1001',
        customerId: 'customer001',
        customerName: 'Rahul Sharma',
        customerPhone: '+91 98765 43210',
        deliveryAgentId: 'agent001',
        deliveryAgentName: 'Vikram Singh',
        pickupAddress: '123, MG Road, Bengaluru, Karnataka 560001',
        deliveryAddress: '456, Sayyaji Rao Road, Mysuru, Karnataka 570001',
        packageType: 'Electronics',
        packageWeight: 2.5,
        status: 'Out for Delivery',
        estimatedTime: '25 mins',
        notes: 'Handle with care - Fragile item',
        createdAt: DateTime.now().subtract(const Duration(hours: 6)),
      ),
      OrderModel(
        orderId: 'ORD1002',
        customerId: 'customer001',
        customerName: 'Rahul Sharma',
        customerPhone: '+91 98765 43210',
        deliveryAgentId: 'agent002',
        deliveryAgentName: 'Suresh Reddy',
        pickupAddress: '789, Brigade Road, Bengaluru, Karnataka 560025',
        deliveryAddress: '321, Lalbagh Road, Bengaluru, Karnataka 560004',
        packageType: 'Documents',
        packageWeight: 0.5,
        status: 'Delivered',
        estimatedTime: 'Delivered',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
        rating: 4.5,
        ratingComment: 'Great service, on time delivery!',
      ),
      OrderModel(
        orderId: 'ORD1003',
        customerId: 'customer001',
        customerName: 'Rahul Sharma',
        customerPhone: '+91 98765 43210',
        pickupAddress: '555, Koramangala, Bengaluru, Karnataka 560034',
        deliveryAddress: '777, Whitefield, Bengaluru, Karnataka 560066',
        packageType: 'Clothing',
        packageWeight: 1.0,
        status: 'Confirmed',
        estimatedTime: '2 hours',
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      OrderModel(
        orderId: 'ORD1004',
        customerId: 'customer002',
        customerName: 'Priya Patel',
        customerPhone: '+91 98765 43211',
        deliveryAgentId: 'agent001',
        deliveryAgentName: 'Vikram Singh',
        pickupAddress: '100, Indiranagar, Bengaluru, Karnataka 560038',
        deliveryAddress: '200, HSR Layout, Bengaluru, Karnataka 560102',
        packageType: 'Food',
        packageWeight: 3.0,
        status: 'Picked Up',
        estimatedTime: '40 mins',
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      ),
      OrderModel(
        orderId: 'ORD1005',
        customerId: 'customer003',
        customerName: 'Amit Kumar',
        customerPhone: '+91 98765 43212',
        deliveryAgentId: 'agent002',
        deliveryAgentName: 'Suresh Reddy',
        pickupAddress: '900, JP Nagar, Bengaluru, Karnataka 560078',
        deliveryAddress: '800, Electronic City, Bengaluru, Karnataka 560100',
        packageType: 'Books',
        packageWeight: 4.0,
        status: 'Packed',
        estimatedTime: '1 hour',
        createdAt: DateTime.now().subtract(const Duration(hours: 4)),
      ),
      OrderModel(
        orderId: 'ORD1006',
        customerId: 'customer002',
        customerName: 'Priya Patel',
        customerPhone: '+91 98765 43211',
        deliveryAgentId: 'agent003',
        deliveryAgentName: 'Deepak Nair',
        pickupAddress: '150, Jayanagar, Bengaluru, Karnataka 560041',
        deliveryAddress: '350, Malleshwaram, Bengaluru, Karnataka 560003',
        packageType: 'Medicine',
        packageWeight: 0.3,
        status: 'Delivered',
        estimatedTime: 'Delivered',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        updatedAt: DateTime.now().subtract(const Duration(days: 4)),
        rating: 5.0,
        ratingComment: 'Excellent delivery!',
      ),
    ]);

    // Demo Notifications
    _notifications.addAll([
      NotificationModel(
        id: 'notif001',
        userId: 'customer001',
        title: 'Order Out for Delivery',
        message: 'Your order #ORD1001 is out for delivery. Estimated time: 25 mins.',
        orderId: 'ORD1001',
        createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
      ),
      NotificationModel(
        id: 'notif002',
        userId: 'customer001',
        title: 'Order Confirmed',
        message: 'Your order #ORD1003 has been confirmed and is being prepared.',
        orderId: 'ORD1003',
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      NotificationModel(
        id: 'notif003',
        userId: 'agent001',
        title: 'New Delivery Assigned',
        message: 'A new delivery #ORD1001 has been assigned to you.',
        orderId: 'ORD1001',
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      ),
    ]);
  }

  // ─── Authentication ───

  /// Login with email and password (demo mode)
  Future<UserModel?> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 800));
    // Demo credentials check
    if (password != '123456') return null;
    try {
      final user = _users.firstWhere((u) => u.email == email);
      _currentUser = user;
      notifyListeners();
      return user;
    } catch (_) {
      return null;
    }
  }

  /// Register a new user (demo mode)
  Future<UserModel?> register({
    required String name,
    required String email,
    required String password,
    required String role,
    String phone = '',
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));

    // Check if email already exists
    if (_users.any((u) => u.email == email)) return null;

    final user = UserModel(
      uid: _uuid.v4(),
      name: name,
      email: email,
      role: role,
      phone: phone,
    );
    _users.add(user);
    _currentUser = user;
    notifyListeners();
    return user;
  }

  /// Logout
  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  // ─── Orders ───

  /// Get orders for a specific customer
  List<OrderModel> getCustomerOrders(String customerId) {
    return _orders.where((o) => o.customerId == customerId).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  /// Get active orders for a customer
  List<OrderModel> getCustomerActiveOrders(String customerId) {
    return _orders
        .where((o) => o.customerId == customerId && o.isActive)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  /// Get orders assigned to a delivery agent
  List<OrderModel> getAgentOrders(String agentId) {
    return _orders.where((o) => o.deliveryAgentId == agentId).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  /// Get active deliveries for an agent
  List<OrderModel> getAgentActiveDeliveries(String agentId) {
    return _orders
        .where((o) => o.deliveryAgentId == agentId && o.isActive)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  /// Get completed deliveries for an agent
  List<OrderModel> getAgentCompletedDeliveries(String agentId) {
    return _orders
        .where((o) => o.deliveryAgentId == agentId && o.isDelivered)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  /// Get all orders (for admin)
  List<OrderModel> getAllOrders() {
    return _orders.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  /// Get order by ID
  OrderModel? getOrderById(String orderId) {
    try {
      return _orders.firstWhere((o) => o.orderId == orderId);
    } catch (_) {
      return null;
    }
  }

  /// Create a new order
  Future<OrderModel> createOrder({
    required String customerName,
    required String customerPhone,
    required String pickupAddress,
    required String deliveryAddress,
    required String packageType,
    required double packageWeight,
    String? notes,
    DateTime? preferredDate,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _orderCounter++;
    final order = OrderModel(
      orderId: 'ORD$_orderCounter',
      customerId: _currentUser!.uid,
      customerName: customerName,
      customerPhone: customerPhone,
      pickupAddress: pickupAddress,
      deliveryAddress: deliveryAddress,
      packageType: packageType,
      packageWeight: packageWeight,
      status: 'Order Placed',
      estimatedTime: 'Calculating...',
      notes: notes,
      preferredDate: preferredDate ?? DateTime.now(),
    );
    _orders.add(order);
    notifyListeners();
    return order;
  }

  /// Update order status
  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _orders.indexWhere((o) => o.orderId == orderId);
    if (index != -1) {
      final statusIndex = OrderModel.allStatuses.indexOf(newStatus);
      String estimatedTime;
      if (newStatus == 'Delivered') {
        estimatedTime = 'Delivered';
      } else if (statusIndex >= 4) {
        estimatedTime = '${(6 - statusIndex) * 15} mins';
      } else {
        estimatedTime = '${(6 - statusIndex) * 30} mins';
      }
      _orders[index] = _orders[index].copyWith(
        status: newStatus,
        updatedAt: DateTime.now(),
        estimatedTime: estimatedTime,
      );
      notifyListeners();
    }
  }

  /// Assign delivery agent to an order
  Future<void> assignAgent(String orderId, String agentId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final orderIndex = _orders.indexWhere((o) => o.orderId == orderId);
    final agent = getUserById(agentId);
    if (orderIndex != -1 && agent != null) {
      _orders[orderIndex] = _orders[orderIndex].copyWith(
        deliveryAgentId: agentId,
        deliveryAgentName: agent.name,
        status: _orders[orderIndex].status == 'Order Placed'
            ? 'Confirmed'
            : _orders[orderIndex].status,
      );
      notifyListeners();
    }
  }

  /// Rate an order
  Future<void> rateOrder(String orderId, double rating, String comment) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _orders.indexWhere((o) => o.orderId == orderId);
    if (index != -1) {
      _orders[index] = _orders[index].copyWith(
        rating: rating,
        ratingComment: comment,
      );
      notifyListeners();
    }
  }

  // ─── Users ───

  /// Get user by ID
  UserModel? getUserById(String uid) {
    try {
      return _users.firstWhere((u) => u.uid == uid);
    } catch (_) {
      return null;
    }
  }

  /// Get all customers
  List<UserModel> getCustomers() {
    return _users.where((u) => u.role == 'customer').toList();
  }

  /// Get all delivery agents
  List<UserModel> getDeliveryAgents() {
    return _users.where((u) => u.role == 'delivery_agent').toList();
  }

  /// Toggle user active status
  Future<void> toggleUserStatus(String uid) async {
    final index = _users.indexWhere((u) => u.uid == uid);
    if (index != -1) {
      _users[index] = _users[index].copyWith(isActive: !_users[index].isActive);
      notifyListeners();
    }
  }

  // ─── Stats ───

  int get totalCustomers => _users.where((u) => u.role == 'customer').length;
  int get totalAgents => _users.where((u) => u.role == 'delivery_agent').length;
  int get totalOrders => _orders.length;
  int get activeDeliveries => _orders.where((o) => o.isActive).length;
  int get completedDeliveries => _orders.where((o) => o.isDelivered).length;
  int get pendingOrders =>
      _orders.where((o) => o.status == 'Order Placed' || o.status == 'Confirmed').length;

  /// Get notifications for a user
  List<NotificationModel> getUserNotifications(String userId) {
    return _notifications.where((n) => n.userId == userId).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  /// Get unassigned orders
  List<OrderModel> getUnassignedOrders() {
    return _orders.where((o) => o.deliveryAgentId == null && o.isActive).toList();
  }
}
