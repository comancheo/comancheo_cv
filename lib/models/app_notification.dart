  /// Provides notification logic: containc model, JSON object (de)serialization

import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:collection/collection.dart';

enum OpenNotificationFrom {backgound, foreground}

class AppNotification {
  int? id; 
  String? title;
  String? body;
  DateTime? timestamp;
  String? hiveId;
  String? patientId;
  DateTimeComponents? dateTimeComponent;
  String? objectType;
  OpenNotificationFrom? openNotificationFrom;
  

  AppNotification({this.id, this.title, this.body, this.timestamp, this.hiveId, this.patientId, this.dateTimeComponent, this.objectType, this.openNotificationFrom});

  ///This method doesn't work with periods as dayOfMonthAndTime and dateAndTime
  ///In app are using only time and dayOfWeekAndTime period types right now
  AppNotification get nextAppNotification {
    DateTime now = DateTime.now();
    var updatedNotification = this;

    while(timestamp!.isBefore(now) &&
      (dateTimeComponent == DateTimeComponents.time || dateTimeComponent == DateTimeComponents.dayOfWeekAndTime))
    {
      switch(dateTimeComponent!){
        case DateTimeComponents.time:
          updatedNotification.timestamp = timestamp!.add(const Duration(days: 1));
          break;
        case DateTimeComponents.dayOfWeekAndTime:
          updatedNotification.timestamp = timestamp!.add(const Duration(days: 7));
          break;
        case DateTimeComponents.dayOfMonthAndTime:
          break;
        case DateTimeComponents.dateAndTime:
          break;
      }
    }

    return updatedNotification;
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'title' : title,
      'body' : body,
      'plannedTimestamp' : timestamp?.toIso8601String(),
      'hiveId' : hiveId,
      'userId' : patientId,
      'dateTimeComponent': dateTimeComponent.toString(),
      'objectType' : objectType,
      'openNotificationFrom': openNotificationFrom?.toString(),
    };
  }

  AppNotification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    timestamp = json['plannedTimestamp']==null ? null : DateTime.parse(json['plannedTimestamp']).toLocal();
    hiveId = json['hiveId'];
    patientId = json['userId'];
    dateTimeComponent = DateTimeComponents.values.firstWhereOrNull((element) { return element.toString()==json['dateTimeComponent']; });
    objectType = json['objectType'];
    openNotificationFrom = OpenNotificationFrom.values.firstWhereOrNull((element) { return element.toString()==json['openNotificationFrom']; });
  }

  @override
  String toString() => jsonEncode(toJson());

  bool isSameAs(AppNotification? appNotification) {
    
    if (appNotification==null) return false;
    
    return (
      // appNotification.id==id &&
      appNotification.title==title &&
      appNotification.body==body &&
      (
        (appNotification.timestamp==null && timestamp==null) ||
        (appNotification.timestamp!=null && timestamp!=null && appNotification.timestamp!.isAtSameMomentAs(timestamp!))
      ) &&
      appNotification.hiveId==hiveId &&
      appNotification.patientId==patientId &&
      appNotification.dateTimeComponent==dateTimeComponent &&
      appNotification.objectType==objectType &&
      appNotification.openNotificationFrom==openNotificationFrom
    );
  }
}
