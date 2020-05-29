import 'package:flutter/material.dart';
import 'package:parent_app/components/digi_appbar.dart';
import 'package:parent_app/components/digicampus_appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LiveScreen extends StatelessWidget {
  const LiveScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: Container(
                padding:const EdgeInsets.only(top: 20),
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child: Builder(
                  builder: (context) {
                    return WebView(
                      onPageFinished: (_){},
                      initialUrl: 'https://buydigicampus.com/zoom-meetings/?pak=bU5TTkh1N1UrYjR6WitNL3htZ0xIUT09&join=NUc0V0drYXUva0FIWEtDYUdDUjdzdz09&type=meeting',
                      javascriptMode: JavascriptMode.unrestricted,
                    );
                  }
                ),
              ),
          ),
          DigiCampusAppbar()
        ],
      ),
    );
  }
}
