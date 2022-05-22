class SubscribePushRequestModel {
  late SubscribeData subscribeData;

  SubscribePushRequestModel({required this.subscribeData});

  SubscribePushRequestModel.fromJson(Map<String, dynamic> json) {
    subscribeData = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = subscribeData;
    return data;
  }
}

class SubscribeData {
  late String subscribeId;

  SubscribeData({required this.subscribeId});

  SubscribeData.fromJson(Map<String, dynamic> json) {
    subscribeId = json['subscriber_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subscriber_id'] = subscribeId;
    return data;
  }
}
