import 'package:google_maps_flutter/google_maps_flutter.dart';

class ModelSuggestion {
  final String placeId;
  final String address;
  final String name;
  final String fullAddress;
  final LatLng latLng;

  ModelSuggestion(this.placeId, this.address, this.name,this.fullAddress,this.latLng);
}