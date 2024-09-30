import 'package:flutter/material.dart';
class LoginText extends StatelessWidget{
  final Function()? onTap;
  const LoginText({super.key,
    required this.onTap
  });
  @override
  Widget build(BuildContext context) {

return GestureDetector(
  onTap: onTap,
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal:25.0),
    child: Row(mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('Don\'t have an account? Register here.', style: TextStyle(color:Colors.grey[600]),
        ),
      ],
    ),
  ),
);
  }


}