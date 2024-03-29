import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothDeviceListEntry extends StatelessWidget {
  final Function onTap;
  final BluetoothDevice device;

  BluetoothDeviceListEntry({this.onTap, @required this.device});

  @override
  Widget build(BuildContext context) {
    print(device.name);
    //if (device.name == 'HC-05') {
    return ListTile(
      onTap: onTap,
      leading: Icon(Icons.devices),
      title: Text(device.name ?? "Unknown device"),
      subtitle: Text(device.address.toString()),
      trailing: TextButton(
        child: Text(
          'Connect',
          style: TextStyle(color: Color(0xff333333)),
        ),
        onPressed: onTap,
      ),
    );
    // } else {
    // return SizedBox.shrink();
    //}
  }
}
