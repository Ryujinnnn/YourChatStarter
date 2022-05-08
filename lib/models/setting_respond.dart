// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

import 'dart:convert';

SettingRespondModel settingRespondModel(String str) =>
    SettingRespondModel.fromJson(json.decode(str));

class SettingRespondModel {
  late String status;
  late String desc;
  Preference preference = Preference(
      sId: "sId",
      userId: "userId",
      allowAutoT2s: true,
      allowPushNotification: true,
      allowVoiceRecording: true,
      voiceRate: 1.0,
      voiceSelection: "");

  SettingRespondModel({required this.status, required this.desc});

  SettingRespondModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    desc = json['desc'];
    if (json['preference'] != null) {
      preference = Preference.fromJson(json['preference']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['desc'] = this.desc;
    data['preference'] = this.preference.toJson();
    return data;
  }
}

class Preference {
  late String sId;
  late String userId;
  late bool allowAutoT2s;
  late bool allowPushNotification;
  late bool allowVoiceRecording;
  late double voiceRate;
  late String voiceSelection;

  Preference(
      {required this.sId,
      required this.userId,
      required this.allowAutoT2s,
      required this.allowPushNotification,
      required this.allowVoiceRecording,
      required this.voiceRate,
      required this.voiceSelection});

  Preference.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['user_id'];
    allowAutoT2s = json['allow_auto_t2s'];
    allowPushNotification = json['allow_push_notification'];
    allowVoiceRecording = json['allow_voice_recording'];
    voiceRate = json['voice_rate'] != null ? json['voice_rate'] + .0 : null;
    voiceSelection =
        json['voice_selection'] != null ? json['voice_selection'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user_id'] = this.userId;
    data['allow_auto_t2s'] = this.allowAutoT2s;
    data['allow_push_notification'] = this.allowPushNotification;
    data['allow_voice_recording'] = this.allowVoiceRecording;
    data['voice_rate'] = this.voiceRate;
    data['voice_selection'] = this.voiceSelection;
    return data;
  }
}
