import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
TextFormField reusableEmailTextFiled(String text, IconData icon, bool isPasswordType, TextEditingController controller){
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: text,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        prefixIcon: Icon(icon),
        contentPadding:
        const EdgeInsets.only(
            left: 8.0,
            bottom: 8.0,
            top: 8.0),
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        focusedBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color:Color(0xff7FD1AE),)),
      helperText: "",
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color:Colors.red,)),

    ),
    obscureText: isPasswordType,
    autocorrect: !isPasswordType,
    enableSuggestions: !isPasswordType,
    keyboardType: isPasswordType ? TextInputType.visiblePassword: TextInputType.emailAddress,

    validator: MultiValidator(
      [
        EmailValidator(errorText: 'Not a valid Email'),
        RequiredValidator(errorText: 'Required'),
      ]
    ),

  );
}
TextFormField reusablePassTextFiled(String text, IconData icon, bool isPasswordType, TextEditingController controller){
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: text,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        prefixIcon: Icon(icon),
        contentPadding:
        const EdgeInsets.only(
            left: 8.0,
            bottom: 8.0,
            top: 8.0),
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        focusedBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color:Color(0xff7FD1AE),)),
      helperText: " ",
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color:Colors.red,)),
    ),
    obscureText: isPasswordType,
    autocorrect: !isPasswordType,
    enableSuggestions: !isPasswordType,
    keyboardType: isPasswordType ? TextInputType.visiblePassword: TextInputType.emailAddress,

    validator: MultiValidator(
        [
          MinLengthValidator(6, errorText: 'password must be at least 6 digits long'),
          RequiredValidator(errorText: 'Required'),
        ]
    ),
  );

}
TextFormField reusableTextFiled(String text, IconData icon, bool isPasswordType, TextEditingController controller) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: text,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        prefixIcon: Icon(icon),
        contentPadding:
        const EdgeInsets.only(
            left: 8.0,
            bottom: 8.0,
            top: 8.0),
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Color(0xff7FD1AE),)),
      helperText: " ",
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color:Colors.red,)),
    ),
    obscureText: isPasswordType,
    autocorrect: !isPasswordType,
    enableSuggestions: !isPasswordType,
    keyboardType: isPasswordType ? TextInputType.visiblePassword : TextInputType
        .emailAddress,
    validator: MultiValidator(
        [

          RequiredValidator(errorText: 'Required'),
        ]
    ),

  );
}
SizedBox signInSignOut(
    BuildContext context, bool isLogin, Function onTap
    ){

  return SizedBox(
    width: 200.0,
    height: 50.0,
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text( isLogin ? "LOGIN": "SIGN IN",
        style:TextStyle(fontSize: 20.0),
      ),

      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states){
          if(states.contains(MaterialState.pressed))
          {
            return Colors.blueAccent;
          }
          return Color(0xff7FD1AE);

        }),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        elevation: MaterialStateProperty.all(10.0),
      ),

    ),
  );
}
