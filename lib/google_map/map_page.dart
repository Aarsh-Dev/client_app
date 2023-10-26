import 'dart:async';
import 'dart:convert';
import 'package:client_app/constant/vars.dart';
import 'package:client_app/google_map/pin_pill_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

import 'search_location.dart';

class MapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {

  RxBool isLoading = false.obs;


  double CAMERA_ZOOM = 16;
  double CAMERA_TILT = 80;
  double CAMERA_BEARING = 30;
  LatLng SOURCE_LOCATION = const LatLng(42.747932, -71.167889);
  LatLng DEST_LOCATION = const LatLng(37.335685, -122.0605916);

  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set<Marker>();

// for my drawn routes on the map
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
   String googleAPIKey = 'AIzaSyDLSoI_Kx2le7KxpiCM2nupGNP2I6yjN_8';

// for my custom marker pins
  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;

// the user's initial location and current location
// as it moves
  late LocationData currentLocation;

// a reference to the destination location
  late LocationData destinationLocation;

// wrapper around the location API
  late Location location;
  double pinPillPosition = -100;
  PinInformation currentlySelectedPin = PinInformation(
      pinPath: '',
      avatarPath: '',
      location: const LatLng(0, 0),
      locationName: '',
      labelColor: Colors.grey);
   PinInformation? sourcePinInfo;
  late PinInformation destinationPinInfo;




  @override
  void initState() {
    super.initState();
    loadingSomeSec();
    currentLocation=LocationData.fromMap({
      "latitude": SOURCE_LOCATION.latitude,
      "longitude": SOURCE_LOCATION.longitude
    });
    setSourceAndDestinationIcons();

    // create an instance of Location
    location = Location();
    polylinePoints = PolylinePoints();

    // subscribe to changes in the user's location
    // by "listening" to the location's onLocationChanged event
    location.onLocationChanged.listen((LocationData cLoc) {
      currentLocation = cLoc;
      updatePinOnMap();
    });
    setInitialLocation();
  }




  void setSourceAndDestinationIcons() async {
    BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.0),
        'assets/driving_pin.png')
        .then((onValue) {
      sourceIcon = onValue;
    });

    BitmapDescriptor.fromAssetImage(const ImageConfiguration(devicePixelRatio: 2.0),
        'assets/destination_map_marker.png')
        .then((onValue) {
      destinationIcon = onValue;
    });
  }

  void setInitialLocation() async {
    currentLocation = await location.getLocation();
    destinationLocation = LocationData.fromMap({
      "latitude": DEST_LOCATION.latitude,
      "longitude": DEST_LOCATION.longitude
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition =  CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: SOURCE_LOCATION);
    initialCameraPosition = CameraPosition(
        target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING);
    return SafeArea(child:Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
              myLocationEnabled: true,
              compassEnabled: true,
              zoomControlsEnabled: false,
              tiltGesturesEnabled: false,
              markers: _markers,
              polylines: _polylines,
              mapType: MapType.normal,
              initialCameraPosition: initialCameraPosition,
              onTap: (LatLng loc) {
                pinPillPosition = -100;
              },
              onMapCreated: (GoogleMapController controller) {
                controller.setMapStyle(mapStyles);
                _controller.complete(controller);
                // showPinsOnMap();
              }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 16.0,
                ),
                autoCompleteSource(),
                const SizedBox(
                  height: 16.0,
                ),
                autoCompleteDestination(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          polylineCoordinates.clear();
          setPolylines();
        },
        backgroundColor: Colors.blue,
        child: const Text(
          "GO",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    ));
  }

  static LatLng destination = const LatLng(21.2419558, 72.7880514);
  static LatLng sourceLocation = const LatLng(21.226599, 72.788248);

  TextEditingController yourLocationController = TextEditingController();
  TextEditingController destinationLocationController = TextEditingController();

  TextEditingValue sourceValue = const TextEditingValue();
  TextEditingValue destinationValue = const TextEditingValue();

  autoCompleteSource() {
    return Autocomplete<Suggestion>(
      onSelected: (option) async {
        FocusManager.instance.primaryFocus!.unfocus();
        debugPrint(option.toString());
        sourceLocation = option.latLng;

        _markers.add(Marker(
            markerId: const MarkerId('sourcePin'),
            position: option.latLng,
            onTap: () {
              setState(() {
                currentlySelectedPin = sourcePinInfo!;
                pinPillPosition = 0;
              });
            },
            icon: sourceIcon));

        setState(() {});
        polylineCoordinates.clear();
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController fieldTextEditingController,
          FocusNode fieldFocusNode,
          VoidCallback onFieldSubmitted) {
        yourLocationController = fieldTextEditingController;
        return InkWell(
          onTap: (){
            Get.to(const SearchLocation());
          },
          child: Container(
            height: 45,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: Colors.black26)),
            child: TextField(
              controller: fieldTextEditingController,
              focusNode: fieldFocusNode,
              textAlignVertical: TextAlignVertical.center,
              maxLines: 1,
              enabled: false,
              readOnly: true,
              onTap: () {
                suggestionList.clear();
              },
              onChanged: (value) {
                fetchSuggestions(value);
              },
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 5.0),
                hintText: "Your location",
                hintStyle: TextStyle(fontSize: 14, color: Colors.black26),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                prefixIcon: Icon(
                  Icons.my_location_rounded,
                  color: Colors.blue,
                  size: 16,
                ),
              ),
            ),
          ),
        );
      },
      optionsBuilder: (TextEditingValue? textEditingValue) {
        sourceValue = textEditingValue!;
        return suggestionList
            .where((Suggestion modelSearch) => modelSearch.name
            .toLowerCase()
            .contains(sourceValue.text.toLowerCase()))
            .toList();
      },
      displayStringForOption: (Suggestion hotel) => hotel.name,
    );
  }

  autoCompleteDestination() {
    return Autocomplete<Suggestion>(
      onSelected: (option) {
        FocusManager.instance.primaryFocus!.unfocus();
        destination = option.latLng;
        destinationLocation = LocationData.fromMap({
          "latitude": option.latLng.latitude,
          "longitude": option.latLng.longitude
        });
        _markers.add(Marker(
            markerId: const MarkerId('destPin'),
            position: option.latLng,
            onTap: () {
              setState(() {
                currentlySelectedPin = destinationPinInfo;
                pinPillPosition = 0;
              });
            },
            icon: destinationIcon));

        setState(() {});
        polylineCoordinates.clear();
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController fieldTextEditingController,
          FocusNode fieldFocusNode,
          VoidCallback onFieldSubmitted) {
        destinationLocationController = fieldTextEditingController;
        return Container(
          height: 45,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(color: Colors.black26)),
          child: TextField(
            controller: fieldTextEditingController,
            focusNode: fieldFocusNode,
            textAlignVertical: TextAlignVertical.center,
            maxLines: 1,
            onTap: () {
              suggestionList.clear();
            },
            onChanged: (value) {
              fetchSuggestions(value);
            },
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(left: 5.0),
              hintText: "Choose destination",
              hintStyle: TextStyle(fontSize: 14, color: Colors.black26),
              focusedBorder:
              OutlineInputBorder(borderSide: BorderSide.none),
              enabledBorder:
              OutlineInputBorder(borderSide: BorderSide.none),
              prefixIcon: Icon(
                Icons.location_on,
                color: Colors.red,
                size: 16,
              ),
            ),
          ),
        );
      },
      optionsBuilder: (TextEditingValue? textEditingValue) {
        destinationValue = textEditingValue!;
        return suggestionList
            .where((Suggestion modelSearch) => modelSearch.name
            .toLowerCase()
            .contains(destinationValue.text.toLowerCase()))
            .toList();
      },
      displayStringForOption: (Suggestion hotel) => hotel.name,
    );
  }

  List<Suggestion> suggestionList = [];

  fetchSuggestions(String input) async {
    // final request = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&location=${currentLocation!.latitude},${currentLocation!.longitude}&types=shop&radius=500&language=en&key=$apiKey';
    final request = 'https://maps.googleapis.com/maps/api/place/textsearch/json?query=$input&location=${currentLocation.latitude},${currentLocation.longitude}&key=$apiKey';
    final response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        List data = result['results'];
        suggestionList.clear();

        for (int i = 0; i < data.length; i++) {
          suggestionList.add(Suggestion(
              data[i]['place_id'],
              data[i]['formatted_address'],
              data[i]['name'],
              LatLng(data[i]['geometry']['location']['lat'],
                  data[i]['geometry']['location']['lng'])));
        }

        // compose suggestions in a list
        // suggestionList = result['predictions']
        //     .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
        //     .toList();
        setState(() {});
        debugPrint("");
        // return result['predictions']
        //     .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
        //     .toList();
      }
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  void showPinsOnMap() {
    // get a LatLng for the source location
    // from the LocationData currentLocation object
    var pinPosition =
    LatLng(currentLocation.latitude!, currentLocation.longitude!);
    // get a LatLng out of the LocationData object
    var destPosition =
    LatLng(destinationLocation.latitude!, destinationLocation.longitude!);

    sourcePinInfo = PinInformation(
        locationName: "Start Location",
        location: SOURCE_LOCATION,
        pinPath: "assets/driving_pin.png",
        avatarPath: "assets/friend1.jpg",
        labelColor: Colors.blueAccent);

    destinationPinInfo = PinInformation(
        locationName: "End Location",
        location: DEST_LOCATION,
        pinPath: "assets/destination_map_marker.png",
        avatarPath: "assets/friend2.jpg",
        labelColor: Colors.purple);

    // add the initial source location pin
    _markers.add(Marker(
        markerId: const MarkerId('sourcePin'),
        position: pinPosition,
        onTap: () {
          setState(() {
            currentlySelectedPin = sourcePinInfo!;
            pinPillPosition = 0;
          });
        },
        icon: sourceIcon));
    // destination pin
    _markers.add(Marker(
        markerId: const MarkerId('destPin'),
        position: destPosition,
        onTap: () {
          setState(() {
            currentlySelectedPin = destinationPinInfo;
            pinPillPosition = 0;
          });
        },
        icon: destinationIcon));
    // set the route lines on the map from source to destination
    // for more info follow this tutorial
    setPolylines();
  }

  void setPolylines() async {
    // List<PointLatLng> result = await polylinePoints.getRouteBetweenCoordinates(
    //     googleAPIKey,
    //     currentLocation.latitude!,
    //     currentLocation.longitude!,
    //     destinationLocation.latitude!,
    //     destinationLocation.longitude!);

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPIKey, // Your Google Map Key
      PointLatLng(currentLocation.latitude!, currentLocation.longitude!),
      PointLatLng(
          destinationLocation.latitude!, destinationLocation.longitude!),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        _polylines.add(Polyline(
            width: 10, // set the width of the polylines
            polylineId: const PolylineId("poly"),
            color: Colors.blue,
            points: polylineCoordinates));
      });
    }
  }

  void updatePinOnMap() async {
    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    // do this inside the setState() so Flutter gets notified
    // that a widget update is due
    setState(() {
      // updated position
      var pinPosition =
      LatLng(currentLocation.latitude!, currentLocation.longitude!);

      sourcePinInfo?.location = pinPosition;

      // the trick is to remove the marker (by id)
      // and add it again at the updated location
      _markers.removeWhere((m) => m.markerId.value == 'sourcePin');
      _markers.add(Marker(
          markerId: const MarkerId('sourcePin'),
          onTap: () {
            setState(() {
              currentlySelectedPin = sourcePinInfo!;
              pinPillPosition = 0;
            });
          },
          position: pinPosition, // updated position
          icon: sourceIcon));
    });
  }

  loadingSomeSec(){
    isLoading.value = true;
    Future.delayed(Duration(
      seconds: 5
    ),() {
      isLoading.value = false;
    },);
  }

}

class Suggestion {
  final String placeId;
  final String address;
  final String name;
  final LatLng latLng;

  Suggestion(this.placeId, this.address, this.name, this.latLng);
}