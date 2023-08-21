//import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

// class NotificationController {
//   static ReceivedAction? initialAction;

//   ///  *********************************************
//   ///     INITIALIZATIONS
//   ///  *********************************************
//   ///
  
//   static void requestNotificationPermission(){
//   AwesomeNotifications().requestPermissionToSendNotifications();
// }


//   static Future<void> initializeLocalNotifications() async {
//     await AwesomeNotifications().initialize(
//         null, //'resource://drawable/res_app_icon',//
//         [
//           NotificationChannel(
//               channelKey: 'alerts',
//               channelName: 'Alerts',
//               channelDescription: 'Notification tests as alerts',
//               playSound: true,
//               onlyAlertOnce: true,
//               groupAlertBehavior: GroupAlertBehavior.Children,
//               importance: NotificationImportance.High,
//               defaultPrivacy: NotificationPrivacy.Private,
//               defaultColor: Colors.deepPurple,
//               ledColor: Colors.deepPurple)
//         ],
//         debug: true);

//     // Get initial notification action is optional
//     initialAction = await AwesomeNotifications()
//         .getInitialNotificationAction(removeFromActionEvents: false);
//   }



//   static Future<void> createNewNotification() async {
//     bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
//     //if (!isAllowed) isAllowed = await displayNotificationRationale();
//     if (!isAllowed) return;

//     await AwesomeNotifications().createNotification(
//         content: NotificationContent(
//             id: -1, // -1 is replaced by a random number
//             channelKey: 'alerts',
//             title: 'Huston! The eagle has landed!',
//             body:
//                 "A small step for a man, but a giant leap to Flutter's community!",
//             bigPicture: 'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
//             largeIcon: 'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
//             //'asset://assets/images/balloons-in-sky.jpg',
//             notificationLayout: NotificationLayout.BigPicture,
//             payload: {'notificationId': '1234567890'}),
//         actionButtons: [
//           NotificationActionButton(key: 'REDIRECT', label: 'Redirect'),
//           NotificationActionButton(
//               key: 'REPLY',
//               label: 'Reply Message',
//               requireInputText: true,
//               actionType: ActionType.SilentAction
//           ),
//           NotificationActionButton(
//               key: 'DISMISS',
//               label: 'Dismiss',
//               actionType: ActionType.DismissAction,
//               isDangerousOption: true)
//         ]);
//   }


//   static Future<void> showNotificationFromJson(
//       Map<String, Object> jsonData) async {
//     await AwesomeNotifications().createNotificationFromJsonData(jsonData);
//   }



//   ///  *********************************************
//   ///     NOTIFICATION EVENTS LISTENER
//   ///  *********************************************
//   ///  Notifications events are only delivered after call this method
//   static Future<void> startListeningNotificationEvents() async {
//     AwesomeNotifications()
//         .setListeners(onActionReceivedMethod: onActionReceivedMethod,
//         onDismissActionReceivedMethod: onDismissActionReceivedMethod
        
        
//         );
  
  
  
  
//   }

//   ///  *********************************************
//   ///     NOTIFICATION EVENTS
//   ///  *********************************************
//   ///
//   @pragma('vm:entry-point')
//   static Future<void> onActionReceivedMethod(
//       ReceivedAction receivedAction) async {

//     if(
//       receivedAction.actionType == ActionType.SilentAction ||
//       receivedAction.actionType == ActionType.SilentBackgroundAction
//     ){
//       // For background actions, you must hold the execution until the end
//       print('Message sent via notification input: "${receivedAction.buttonKeyInput}"');
//       // await executeLongTaskInBackground();
//     }
//     else {
//     //   MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
//     //       '/notification-page',
//     //           (route) =>
//     //       (route.settings.name != '/notification-page') || route.isFirst,
//     //       arguments: receivedAction);
//     // }
//   }


//       }

//   @pragma("vm:entry-point")
//   static Future <void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {
//     // Your code goes here
  
//       print('the notofication displayed called------------');

//   }

//   /// Use this method to detect if the user dismissed a notification
//   @pragma("vm:entry-point")
//   static Future <void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {

//     print('the dismiss called------------');
//     // Your code goes here
//   }
//   static Future<void> showNotificationWithPayloadContent(int id) async {
//     await AwesomeNotifications().createNotification(
//         content: NotificationContent(
//             id: id,
//             channelKey: 'basic_channel',
//             title: 'Simple notification',
//             body: 'Only a simple notification',
//             payload: {'uuid': 'uuid-test'}));
//   }

//   /// Use this method to detect when the user taps on a notification or action button
// }