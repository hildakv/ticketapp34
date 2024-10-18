import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
// import 'package:ticket_app/app/modules/dashboard/views/dashboard_view.dart';

import '../../../../routes/app_pages.dart';
import '../../../../utils/global_widgets.dart';
import '../../../../utils/theme_data.dart';
import '../../controllers/login_controller.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      // color: Colors.black26,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: FormBuilder(
          key: Get.find<LoginController>().loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: const Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.black26),
                ),
              ),
              SizedBox(height: 10),
              HEIGHT_12,
              FormBuilderTextField(
                name: 'username',
                maxLength: 36,
                decoration: const InputDecoration(
                  border: customOutlineInputBorder,
                  labelText: 'Username',
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
                textInputAction: TextInputAction.next,
              ),
              HEIGHT_12,
              GetBuilder<LoginController>(
                builder: (_) => FormBuilderTextField(
                  name: 'password',
                  // maxLength: 4,
                  obscureText: !_.showPassword,
                  decoration: InputDecoration(
                    border: customOutlineInputBorder,
                    labelText: 'Password',
                    counter: const SizedBox(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _.showPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: textColorGrey,
                      ),
                      onPressed: () => _.showPassword = !_.showPassword,
                    ),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(
                      6,
                      errorText: 'Please enter a valid password',
                    ),
                  ]),
                  onSubmitted: (val) => _.login(),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: Get.width,
                height: 46,
                child: GetBuilder<LoginController>(
                  builder: (_) => ElevatedButton(
                    // onPressed: () =>
                    //     _.isLogging ? null : Get.offAllNamed(Routes.DASHBOARD),
                    onPressed: _.isLogging ? null : _.login,
                    child: Text(
                      _.isLogging ? 'Please wait...' : 'Login',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
