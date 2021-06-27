class AppVersionCheck {
  final String latestVersionAndroid;
  final String latestVersionIos;
  final bool isForcedUpdateAndroid;
  final bool isForcedUpdateIos;

  AppVersionCheck(this.latestVersionAndroid, this.latestVersionIos,
      this.isForcedUpdateAndroid, this.isForcedUpdateIos);

  AppVersionCheck.fromJson(Map<String, dynamic> json)
      : latestVersionAndroid = json['latest_version_android'],
        latestVersionIos = json['latest_version_ios'],
        isForcedUpdateAndroid = json['is_forced_update_android'],
        isForcedUpdateIos = json['is_forced_update_ios'];
}
