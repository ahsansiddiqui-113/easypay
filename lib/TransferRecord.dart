import './beneficiary.dart';

class TransferRecord {
  final Beneficiary beneficiary;
  final double amount;
  final DateTime date;

  TransferRecord({
    required this.beneficiary,
    required this.amount,
    required this.date,
  });
}
