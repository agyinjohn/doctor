import 'package:flutter/material.dart';
import 'package:flutter_voximplant/flutter_voximplant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Voximplant Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CallScreen(),
    );
  }
}

class CallScreen extends StatefulWidget {
  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  VIClient client = Voximplant().getClient();

  VICall? _currentCall;

  @override
  void initState() {
    super.initState();
    loginWithPassword('doctor.apex-code.n2.voximplant.com', '123456Apex2');
  }

  Future<String> loginWithPassword(String username, String password) async {
    VIClientState clientState = await client.getClientState();
    if (clientState == VIClientState.LoggedIn) {
      return clientState.name;
    }
    if (clientState == VIClientState.Disconnected) {
      await client.connect(
        node: VINode.Node1,
      );
    }
    VIAuthResult authResult = await client.login(username, password);
    final _displayName = authResult.displayName;
    return _displayName;
  }

  void _hangUpCall() {
    _currentCall?.hangup();
    setState(() {
      _currentCall = null;
    });
  }

  void _muteCall() {
    _currentCall?.sendAudio(false); // Mute microphone
  }

  void _makeCall() {
    client.call('+233531656697');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voximplant Call'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _currentCall == null ? _makeCall : null,
              child: Text('Make Call'),
            ),
            ElevatedButton(
              onPressed: _currentCall != null ? _hangUpCall : null,
              child: Text('Hang Up'),
            ),
            ElevatedButton(
              onPressed: _currentCall != null ? _muteCall : null,
              child: Text('Mute'),
            ),
          ],
        ),
      ),
    );
  }
}
