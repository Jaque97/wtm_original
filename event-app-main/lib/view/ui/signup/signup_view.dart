import 'package:event_app/app/constants.dart';
import 'package:event_app/view/ui/signup/signup_viewmodel.dart';
import 'package:event_app/view/widgets/inputfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController firstNameCon = TextEditingController();
  TextEditingController lastNameCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController phoneCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();
  TextEditingController confirmPasswordCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: model.loading,
          child: Column(
            children: [
              Image.asset("assets/top_image.png"),
              Expanded(
                child: SingleChildScrollView(
                  physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: hMargin),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.08,
                        ),
                        Center(
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 24,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.04,
                        ),
                        InputFieldWidget(
                          hint: "Name",
                          prefixIcon: Icons.person,
                          controller: firstNameCon,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InputFieldWidget(
                          hint: "Email",
                          prefixIcon: Icons.email,
                          controller: emailCon,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InputFieldWidget(
                          hint: "Phone",
                          prefixIcon: Icons.phone,
                          controller: phoneCon,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InputFieldWidget(
                          hint: "Password",
                          prefixIcon: Icons.lock,
                          obscure: true,
                          controller: passwordCon,
                        ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // InputFieldWidget(
                        //   hint: "Confirm Password",
                        //   prefixIcon: Icons.lock,
                        //   obscure: true,
                        //   controller: confirmPasswordCon,
                        // ),
                        SizedBox(
                          height: Get.height * 0.04,
                        ),
                        InkWell(
                          onTap: () {
                            model.signUpUser(firstNameCon.text, emailCon.text,
                                phoneCon.text, passwordCon.text);
                          },
                          child: Container(
                            width: Get.width * 0.45,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28.50),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Center(
                              child: Text(
                                "REGISTER",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.28,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.05,
                        ),
                        Row(
                          children: [
                            Spacer(),
                            Text(
                              'Already have an account?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 14,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Text(
                                ' Login',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => SignUpViewModel(),
    );
  }
}
