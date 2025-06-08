import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

class LocationServices {
  static final LocationServices _instance = LocationServices._internal();
  factory LocationServices() => _instance;

  LocationServices._internal(){
    _location = Location();
  }

  late Location _location;
  bool _serviceEnabled = false;
  PermissionStatus? _grantedPermission;
  LocationData? locationInitialData;
  static final ValueNotifier<bool> runReady = ValueNotifier(false);

  static void setRunReady(bool value) {
    runReady.value = value;
  }

  Future<bool> _checkPermission() async{
    if(await _checkService()){
      _grantedPermission = await _location.hasPermission();
      if(_grantedPermission == PermissionStatus.denied){
        _grantedPermission = await _location.requestPermission();
      }
    }
    return _grantedPermission == PermissionStatus.granted;
  }

  Future<bool> _checkService() async{
    try{
      _serviceEnabled = await _location.serviceEnabled();
      if(!_serviceEnabled){
        _serviceEnabled = await _location.requestService();
      }
    }on PlatformException catch(e){
      print("Error code: ${e.code} and error message: ${e.message}");
      _serviceEnabled = false;
      await _checkService();
    }

    return _serviceEnabled;
  }

  Future <LocationData?> getLocation() async {

    if(await _checkPermission()){
      final locationData = _location.getLocation();
      return locationData;
    }
    return null;
  }

  Future<void> setInitialLocation() async {
    locationInitialData = await getLocation();
  }

  Future <LocationData?> getInitialLocation() async {
    return locationInitialData;
  }
  
}