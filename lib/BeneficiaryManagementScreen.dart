import 'package:easypay/TransferRecord.dart';
import 'package:easypay/beneficiary.dart';
import 'package:flutter/material.dart';

class BeneficiaryManagementScreen extends StatefulWidget {
  @override
  _BeneficiaryManagementScreenState createState() => _BeneficiaryManagementScreenState();
}

class _BeneficiaryManagementScreenState extends State<BeneficiaryManagementScreen> {
  final List<Beneficiary> _beneficiaries = [];
  final List<TransferRecord> _transferRecords = [];

  final _nameController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _bankNameController = TextEditingController();

  void _addBeneficiary() {
    final name = _nameController.text;
    final accountNumber = _accountNumberController.text;
    final bankName = _bankNameController.text;

    if (name.isNotEmpty && accountNumber.isNotEmpty && bankName.isNotEmpty) {
      final beneficiary = Beneficiary(
        name: name,
        accountNumber: accountNumber,
        bankName: bankName,
      );
      
      setState(() {
        _beneficiaries.add(beneficiary);
      });

      _nameController.clear();
      _accountNumberController.clear();
      _bankNameController.clear();
    }
  }

  void _addTransferRecord(Beneficiary beneficiary, double amount) {
    final record = TransferRecord(
      beneficiary: beneficiary,
      amount: amount,
      date: DateTime.now(),
    );

    setState(() {
      _transferRecords.add(record);
    });
  }

  void _quickReTransfer(TransferRecord record) {
    _addTransferRecord(record.beneficiary, record.amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beneficiary Management'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Register Beneficiary',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: _accountNumberController,
                decoration: InputDecoration(labelText: 'Account Number'),
              ),
              TextFormField(
                controller: _bankNameController,
                decoration: InputDecoration(labelText: 'Bank Name'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addBeneficiary,
                child: Text('Add Beneficiary'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.green,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Beneficiaries',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _beneficiaries.length,
                itemBuilder: (context, index) {
                  final beneficiary = _beneficiaries[index];
                  return ListTile(
                    title: Text(beneficiary.name),
                    subtitle: Text('${beneficiary.bankName} - ${beneficiary.accountNumber}'),
                  );
                },
              ),
              SizedBox(height: 20),
              Text(
                'Transfer Records',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _transferRecords.length,
                itemBuilder: (context, index) {
                  final record = _transferRecords[index];
                  return ListTile(
                    title: Text(record.beneficiary.name),
                    subtitle: Text('${record.amount} - ${record.date.toLocal()}'),
                    trailing: IconButton(
                      icon: Icon(Icons.repeat),
                      onPressed: () => _quickReTransfer(record),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
