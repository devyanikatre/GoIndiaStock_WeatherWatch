import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_india_stocks_assignment/providers/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart';

class Weather extends ConsumerStatefulWidget {
  final String city;
  const Weather({super.key, required this.city});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WeatherState();
}

class _WeatherState extends ConsumerState<Weather> {
  @override
  Widget build(BuildContext context) {
    var weather = ref.watch(weatherProvider);
    return Scaffold(
        backgroundColor: const Color(0x000b0c1e),
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: const Color(0x000b0c1e),
          title: const Text(
            "Today's Weather",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: weather.getWeather(widget.city),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data!;
              return Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.blue,
                        size: 4.h,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        widget.city,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  SizedBox(
                    width: 30.w,
                    height: 20.h,
                    child: Image.network(
                      "https://openweathermap.org/img/w/${data['icon']}.png",
                      color: Colors.white,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Center(
                    child: Text(
                      "Its ${data['conditon']}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${data['temperature'].toStringAsFixed(2)}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 40),
                      ),
                      const Text(
                        "° ",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 60),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Image.asset('assets/hum.png'),
                          Text(
                            "${data['humidity']} %",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                          const Text(
                            "Humidity",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'assets/wind.png',
                            width: 20.w,
                          ),
                          Text(
                            "${data['windSpeed'].toStringAsFixed(2)} km/h",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text("Error fetching Weather"));
            } else {
              return Center(
                  child: Lottie.asset('assets/loader.json',
                      width: 50.w, height: 50.h));
            }
          },
        ));
  }
}
