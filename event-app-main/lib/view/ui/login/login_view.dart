import 'package:event_app/app/constants.dart';
import 'package:event_app/view/ui/signup/signup_view.dart';
import 'package:event_app/view/widgets/filled_button.dart';
import 'package:event_app/view/widgets/inputfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'login_viewmodel.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.black,
              body: ModalProgressHUD(
                inAsyncCall: model.loading,
                child: Column(
                  children: [
                    //Image.asset("assets/top_image.png"),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                        child: Container(
                          color: Colors.black,
                          padding: EdgeInsets.symmetric(horizontal: hMargin),
                          child: Column(
                            children: [
                              SizedBox(
                                height: Get.height * 0.05,
                              ),
                              Image.asset("assets/logo.png",
                                height: 150,
                                width: 300,
                              ),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: Center(
                                    child: Text(
                                      'WTM',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                height: Get.height * 0.04,
                              ),
                              InputFieldWidget(
                                hint: "Email",
                                prefixIcon: Icons.person,
                                controller: emailCon,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              InputFieldWidget(
                                hint: "Password",
                                prefixIcon: Icons.lock,
                                obscure: true,
                                controller: passwordCon,
                              ),
                              SizedBox(
                                height: Get.height * 0.04,
                              ),
                              InkWell(
                                onTap: () {
                                  model.loginUser(
                                      emailCon.text, passwordCon.text);
                                },
                                child: FilledButton(
                                  title: "LOGIN",
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: SignInButton(
                                    Buttons.Twitter,
                                    text: "Sign up with Twitter",
                                    onPressed: () {},
                                  )),
                              // SizedBox(
                              //   height: 16,
                              // ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Flexible(
                              //       child: Row(
                              //         children: [
                              //           Transform.scale(
                              //             scale: 0.7,
                              //             child: CupertinoSwitch(
                              //                 value: model.isRemember,
                              //                 activeColor: Theme.of(context)
                              //                     .primaryColor,
                              //                 onChanged: model.setIsRemember),
                              //           ),
                              //           Text(
                              //             'Remember me',
                              //             style: TextStyle(
                              //               color:
                              //                   Theme.of(context).accentColor,
                              //               fontSize: 14,
                              //               fontWeight: FontWeight.normal,
                              //             ),
                              //           )
                              //         ],
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              Padding(
                                  padding: EdgeInsets.all(1.0),
                                  child: SignInButton(
                                    Buttons.FacebookNew,
                                    text: "Sign up with Facebook",
                                    onPressed: () {},
                                  )),
                              Padding(
                                  padding: EdgeInsets.all(1.0),
                                  child: SignInButton(
                                    Buttons.Email,
                                    text: "Sign up with Email",
                                    onPressed: () {},
                                  )),
                              SizedBox(
                                height: Get.height * 0.05,
                              ),
                              Row(
                                children: [
                                  Spacer(),
                                  Text(
                                    'Don’t have an account?',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => Get.to(SignUpView()),
                                    child: Text(
                                      ' Register now',
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
                                height: 100,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
