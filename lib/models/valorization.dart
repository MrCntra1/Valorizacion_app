class Valorization {
  final String orderNumber;
  final double totalQuantity;
  final double contractAmount;
  final String contractorName;
  final String serviceDescription;
  final DateTime serviceDate;
  final String serviceName;

  Valorization({
    required this.orderNumber,
    required this.totalQuantity,
    required this.contractAmount,
    required this.contractorName,
    required this.serviceDescription,
    required this.serviceDate,
    required this.serviceName,
  });
}
