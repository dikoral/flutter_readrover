import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_readrover/Domain/Use_Case/ListUseCase.dart';
import 'package:flutter_readrover/Presentation/Bloc/User/user_bloc.dart';
import 'package:flutter_readrover/Presentation/Bloc/User/user_event.dart';
import 'package:flutter_readrover/Presentation/Constanta/Colors/Colors.dart';
import 'package:flutter_readrover/Presentation/Constanta/Colors/button.dart';
import 'package:flutter_readrover/Presentation/Screen/DropMenu.dart';
import 'package:flutter_readrover/generated/locale_keys.g.dart';


class RegistrationPage extends StatelessWidget {
  final GetBooksUseCase getBooksUseCase;

  RegistrationPage({Key? key, required this.getBooksUseCase}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final ageController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.Register.tr(), style: TextStyle(color: MyColors.Constthree)),
        backgroundColor: MyColors.Constone,
        actions: [
            LanguageSwitchButton(),
          ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 100),
              _buildTextField(nameController,LocaleKeys.Name.tr(), Icons.person),
              SizedBox(height: 10),
              _buildTextField(ageController, LocaleKeys.Age.tr(), Icons.calendar_today),
              SizedBox(height: 10),
              _buildTextField(emailController, LocaleKeys.Email.tr(), Icons.email),
              SizedBox(height: 10),
              _buildTextField(passwordController, LocaleKeys.Password.tr(), Icons.lock, isPassword: true),
              SizedBox(height: 20),
              _buildElevatedButton(context, LocaleKeys.Register.tr(), MyColors.Constone, MyColors.Constthree, () {
                BlocProvider.of<AuthenticationBloc>(context).add(
                  SignUpEvent(
                    emailController.text,
                    passwordController.text,
                    nameController.text,
                    int.tryParse(ageController.text) ?? 0,
                  ),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Menu(getBooksUseCase)),
                );
              }),
            ],
          ),
        ),
      ),
      backgroundColor: MyColors.Consttwo,
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(),
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildElevatedButton(BuildContext context, String text, Color color, Color secondaryColor, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: secondaryColor, backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: EdgeInsets.symmetric(vertical: 15),
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      child: Text(text),
    );
  }
}
