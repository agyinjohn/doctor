// import 'package:doctor/utils/authmethods.dart';
// import 'package:doctor/utils/models/firebas_method.dart';
// import 'package:jitsi_meet/feature_flag/feature_flag.dart';
// import 'package:jitsi_meet/jitsi_meet.dart';

// class JitsiMeetMethods {
//   final Authentication _authMethods = Authentication();
//   final FirestoreMethods _firestoreMethods = FirestoreMethods();

//   void createMeeting({
//     required String roomName,
//     required bool isAudioMuted,
//     required bool isVideoMuted,
//     String username = '',
//   }) async {
//     try {
//       FeatureFlag featureFlag = FeatureFlag();
//       featureFlag.welcomePageEnabled = false;
//       featureFlag.resolution = FeatureFlagVideoResolution
//           .MD_RESOLUTION; // Limit video resolution to 360p
//       String name;
//       if (username.isEmpty) {
//         name = _authMethods.user.displayName!;
//       } else {
//         name = username;
//       }
//       var options = JitsiMeetingOptions(room: roomName)
//         ..userDisplayName = name
//         ..userEmail = _authMethods.user.email
//         ..userAvatarURL = _authMethods.user.photoURL
//         ..audioMuted = isAudioMuted
//         ..videoMuted = isVideoMuted;

//       _firestoreMethods.addToMeetingHistory(roomName);
//       await JitsiMeet.joinMeeting(options);
//     } catch (error) {
//       print("error: $error");
//     }
//   }
// }
