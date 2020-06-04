import 'package:flutter/material.dart';
import 'package:http_request/model/ApiService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_request/landing/Landing_page.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class _LoginState extends State<Login> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool hidePassword = true;
  bool _isLoading = false;
  bool _isValidUsername;
  bool _isValidPassword;
  ApiService apiService = ApiService();

  savePref(
      String id, String name, int status, String lastname, String kode) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      pref.setString("lastName", lastname);
      pref.setInt("status", status);
      pref.setString("id", id);
      pref.setString("name", name);
      pref.setString("kode_pdm", kode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _buildLogin(),
    );
  }

  Widget _buildLogin() {
    return Scaffold(
      key: _scaffoldState,
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Stack(overflow: Overflow.visible, children: <Widget>[
          Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(35)),
                  color: Colors.blueAccent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/logo/logo_jempolan.png",
                    width: 100.0,
                    height: 100.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "JEMPOLAN",
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ],
              )),
          Align(
            alignment: Alignment(0, 0.8),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: Colors.white),
              child: ListView(
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "Login Pendamping",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextField(
                          controller: username,
                          onChanged: (value) {
                            bool _isFieldValid = value.trim().isNotEmpty;
                            if (_isFieldValid != _isValidUsername) {
                              setState(() {
                                _isValidUsername = _isFieldValid;
                              });
                            }
                          },
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              errorText:
                                  _isValidUsername == null || _isValidUsername
                                      ? null
                                      : "Username Harus di isi!!",
                              fillColor: Colors.blue,
                              prefixIcon: Icon(Icons.person),
                              labelText: "Masukan Username"),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextField(
                          controller: password,
                          expands: false,
                          obscureText: hidePassword,
                          onChanged: (value) {
                            bool _isFiledValid = value.trim().isNotEmpty;
                            if (_isFiledValid != _isValidPassword) {
                              setState(() {
                                _isValidPassword = _isFiledValid;
                              });
                            }
                          },
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              fillColor: Colors.blue,
                              errorText:
                                  _isValidPassword == null || _isValidPassword
                                      ? null
                                      : "Password Harus di isi !!",
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                                icon: Icon(hidePassword == false
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                              labelText: "Masukan Password"),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        RaisedButton(
                          onPressed: () {
                            if (_isValidPassword == null ||
                                _isValidUsername == null ||
                                !_isValidUsername ||
                                !_isValidPassword) {
                              _scaffoldState.currentState.showSnackBar(SnackBar(
                                backgroundColor: Colors.redAccent,
                                content: Text("From Masih Ada yang kosong"),
                              ));
                              return;
                            }
                            setState(() {
                              _isLoading = true;
                            });
                            String user = username.text;
                            String pass = password.text;
                            apiService.login(user, pass).then((value) {
                              setState(() {
                                _isLoading = false;
                              });
                              if (value['status'] == 200) {
                                Map result = value['resutl'];
                                String id = result['id'];
                                String name = result['first_name'];
                                String lastName = result['last_name'];
                                String kodePdm = result['KD_PDM'];
                                int status = value['status'];
                                savePref(id, name, status, lastName, kodePdm);
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (_) {
                                  return new Landingpage();
                                }));
                              } else {
                                _scaffoldState.currentState
                                    .showSnackBar(SnackBar(
                                  backgroundColor: Colors.redAccent,
                                  content: Text(
                                      "Maaf Login Gagal!!Cek username Dan Password"),
                                ));
                              }
                            });
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          color: Colors.blueAccent,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _isLoading
              ? Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: 0.3,
                      child: ModalBarrier(
                        dismissible: false,
                        color: Colors.grey,
                      ),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                )
              : Container()
        ]),
      ),
    );
  }
}
