import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage(this.screenSize);
  final Size screenSize;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  bool hidePassword = true;
  bool isSignUp = false;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.pink.shade700;
    }
    return Colors.pink;
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInCirc));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: widget.screenSize.height,
          width: widget.screenSize.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.blue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Positioned(
          top: widget.screenSize.height * 0.1,
          left: widget.screenSize.width / 2 - 175,
          child: Container(
            width: 350,
            padding: const EdgeInsets.all(8),
            height: widget.screenSize.height * 0.8,
            color: Colors.white,
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 40),
                    child: Text(
                      isSignUp ? 'Sign Up' : 'LOGIN',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    decoration: BoxDecoration(color: Colors.grey[300]),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.email_outlined,
                        ),
                        hintText: 'Email',
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    decoration: BoxDecoration(color: Colors.grey[300]),
                    child: TextField(
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.lock_outline,
                        ),
                        focusColor: Colors.grey,
                        suffixIcon: GestureDetector(
                            onTapDown: (details) {
                              setState(() {
                                hidePassword = false;
                              });
                            },
                            onTapUp: (details) {
                              setState(() {
                                hidePassword = true;
                              });
                            },
                            child: Icon(
                              Icons.visibility,
                              color: Colors.grey.shade600,
                            )),
                        hintText: 'Password',
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: isSignUp ? 50 : 0,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    decoration: BoxDecoration(color: Colors.grey[300]),
                    child: FadeTransition(
                      opacity: _opacityAnimation,
                      child: TextField(
                        obscureText: hidePassword,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                          border: InputBorder.none,
                          prefixIcon: !isSignUp
                              ? null
                              : Icon(
                                  Icons.lock_outline,
                                ),
                          focusColor: Colors.grey,
                          suffixIcon: GestureDetector(
                            onTapDown: (details) {
                              setState(() {
                                hidePassword = false;
                              });
                            },
                            onTapUp: (details) {
                              setState(() {
                                hidePassword = true;
                              });
                            },
                            child: !isSignUp
                                ? null
                                : Icon(
                                    Icons.visibility,
                                    color: Colors.grey.shade600,
                                  ),
                          ),
                          hintText: 'Confirm Password',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Container(
                        child: Center(
                          child: Text(
                            'LOGIN',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith(getColor),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isSignUp ? 'Already a member?' : 'Not a member?',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isSignUp = !isSignUp;
                            });
                            if (isSignUp) {
                              _controller.forward();
                            } else {
                              _controller.reverse();
                            }
                          },
                          child: Text(
                            isSignUp ? ' Login' : ' Sign up now',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              decoration: TextDecoration.underline,
                              decorationThickness: 2,
                              decorationStyle: TextDecorationStyle.dotted,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
