/// Institution model
class DeviceData {
  int ir;
  int ldr;
  DateTime lastSeen;

  DeviceData({
    required this.ir,
    required this.ldr,
    required this.lastSeen,
  });

  factory DeviceData.fromMap(Map data) {
    return DeviceData(
      ir: data['ir'] ?? 0,
      ldr: data['ldr'] ?? 0,
      lastSeen: DateTime.fromMillisecondsSinceEpoch(data['ts']),
    );
  }
}

class DeviceLedData {
  int led;

  DeviceLedData({
    required this.led,
  });

  factory DeviceLedData.fromMap(Map data) {
    return DeviceLedData(
      led: data['led'] ?? 0,
    );
  }
}
