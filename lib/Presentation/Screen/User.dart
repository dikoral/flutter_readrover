import 'dart:convert';
import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_readrover/Presentation/Constanta/Colors/Colors.dart';
import 'package:flutter_readrover/Presentation/Constanta/Colors/button.dart';
import 'package:flutter_readrover/generated/locale_keys.g.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final String? base64Image = prefs.getString('profile_image_base64');

    if (base64Image != null) {
      setState(() {
        _imageBytes = base64Decode(base64Image);
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      final String base64Image = base64Encode(bytes);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image_base64', base64Image);

      setState(() {
        _imageBytes = bytes;
      });
    }
  }

  Future<Map<String, dynamic>> _getUserData() async {
    var documentSnapshot = await _firestore.collection('users').doc(userId).get();

    if (documentSnapshot.exists) {
      return documentSnapshot.data()!;
    } else {
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.User_Profile.tr(), style: TextStyle(color: MyColors.Constthree)),
        backgroundColor: Colors.purple,
        actions: [
            LanguageSwitchButton(),
          ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              var data = snapshot.data!;
              return SingleChildScrollView(
                child: Container(
                  color: MyColors.Consttwo,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        backgroundImage: _imageBytes != null ? MemoryImage(_imageBytes!) : null,
                        radius: 50.0,
                        child: _imageBytes == null ? Icon(Icons.add_a_photo, size: 50, color: MyColors.Constsix) : null,
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildUserInfoCard(LocaleKeys.Email.tr(), data['email']),
                    _buildUserInfoCard(LocaleKeys.Name.tr(), data['name']),
                    _buildUserInfoCard(LocaleKeys.Age.tr(), data['age'].toString()),
                    _buildStatisticsCard(LocaleKeys.Books_read.tr(), '15'),
                    _buildStatisticsCard(LocaleKeys.Favourite_book.tr(), 'Властелин колец'),
                    _buildFavoriteQuoteCard(),
                    _buildStatisticsRow(),
                  ],
                ),
                ),
              );
            } else {
              return Center(child: Text('No user data found.'));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildUserInfoCard(String title, String value) {
    return Card(
      color: MyColors.Constthree,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
        leading: Icon(Icons.person, color: Colors.black),
      ),
    );
  }

  Widget _buildStatisticsCard(String title, String value) {
    return Card(
      color: MyColors.Constthree,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
        leading: Icon(Icons.book, color: Colors.black),
      ),
    );
  }

  Widget _buildFavoriteQuoteCard() {
    String favoriteQuote = LocaleKeys.What.tr();
    return Card(
      color: MyColors.Constthree,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListTile(
        title: Text(LocaleKeys.Quote_of_week.tr(), style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(favoriteQuote),
        leading: Icon(Icons.format_quote, color: Colors.black),
      ),
    );
  }

  Widget _buildStatisticsRow() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _buildStatisticsCard(LocaleKeys.Reading_time.tr(), '20 часов'),
          ),
          SizedBox(width: 20),
          Expanded(
            child: _buildStatisticsCard(LocaleKeys.Pages_read.tr(), '500'),
          ),
        ],
      ),
    );
  }
}