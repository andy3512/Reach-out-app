import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  Completer<GoogleMapController> _controller=Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom:14.4746,
  );

  final List<Marker> _markers = <Marker>[
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(37.42796133580664, -122.085749655962),
      infoWindow: InfoWindow(
        title: 'Google headquarter'
      )
    )

  ];

  Future<Position> getUserCurrentLocation() async{
    await Geolocator.requestPermission().then((value){

    }).onError((error, stackTrace){
      print("error "+error.toString());
    });

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.pushNamedAndRemoveUntil(context,'phone', (route) => false);
              },
              icon: Icon(Icons.logout)
          )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        mapType: MapType.terrain,
        markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          getUserCurrentLocation().then((value) async {
            _markers.add(
             Marker(
                 markerId: MarkerId('2'),
                 position: LatLng(value.latitude,value.longitude),
                 infoWindow: InfoWindow(
                   title: 'My current location'
                 )
             )
            );

            CameraPosition cameraPosition =CameraPosition(
                target: LatLng(value.latitude,value.longitude),
              zoom: 14,
            );

            final GoogleMapController controller= await _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {});
          });
        },
        child: Icon(Icons.my_location),

      ),
    );
  }
}
