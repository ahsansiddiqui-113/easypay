import 'dart:io';

import 'package:easypay/BeneficiaryManagementScreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  File? profilePhoto;
  File? photoID;
  File? selfieWithID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Registration'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Personal Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'ID'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              SizedBox(height: 20),
              Text(
                'ID Validation',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Enter Special Character'),
              ),
              SizedBox(height: 20),
              Text(
                'Photo Uploads',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  handlePhotoUpload('profile');
                },
                child: Text('Upload Profile Photo'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  handlePhotoUpload('id');
                },
                child: Text('Upload Photo ID'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  handlePhotoUpload('selfie');
                },
                child: Text('Upload Selfie with ID'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Bank/Card Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Bank Name'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Card Number'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Expiration Date'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'CVV'),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
              ),
              Text(
                'OTP Validation',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Enter OTP'),
              ),
              SizedBox(height: 20),
              Text(
                'Final Approval',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: handleFinalApproval,
                child: Text('Verify'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                ),
              ),
              // SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => BeneficiaryManagementScreen()),
              //     );
              //   },
              //   child: Text('Go to Beneficiary Management'),
              //   style: ElevatedButton.styleFrom(
              //     foregroundColor: Colors.white,
              //     backgroundColor: Colors.green,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> handlePhotoUpload(String type) async {
    final picker = ImagePicker();
    XFile? pickedFile;

    if (type == 'profile' || type == 'id') {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    } else if (type == 'selfie') {
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    }

    if (pickedFile != null) {
      File file = File(pickedFile.path);

      setState(() {
        if (type == 'profile') {
          profilePhoto = file;
        } else if (type == 'id') {
          photoID = file;
        } else if (type == 'selfie') {
          selfieWithID = file;
        }
      });
    }
  }

  void handleFinalApproval() {
    if (photoID != null && selfieWithID != null) {
      bool isValid = compareImages(photoID!, selfieWithID!);

      if (isValid) {
        grantApproval();
      } else {
        denyApproval();
      }
    } else {
      showMissingDocumentsError();
    }
  }

  bool compareImages(File photoID, File selfieWithID) {
    return photoID.path == selfieWithID.path;
  }

  void grantApproval() {
    print('Photo ID matches selfie. Approval granted.');
   
  }

  void denyApproval() {
    print('Photo ID does not match selfie. Approval denied.');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Approval Denied'),
        content: Text('Your photo ID does not match the selfie. Please upload valid documents.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void showMissingDocumentsError() {
    print('Both photo ID and selfie must be uploaded.');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text('Please upload both your photo ID and a selfie.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
