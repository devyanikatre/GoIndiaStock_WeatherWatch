import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import '../providers/search.dart';
import 'weather.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searchHistory = ref.watch(searchHistoryProvider);
    final searchNotifier = ref.watch(searchHistoryProvider.notifier);
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text.rich(
              TextSpan(
                text: 'Hello DK here Check weather here', // default text style
              ),
            ),
            SizedBox(height: 2.h), // add some space
            Image.asset('assets/Weather_APP.png', width: 50, height: 50), // add the image
            SizedBox(height: 2.h), // add some space
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    width: 90.w,
                    child: TextFormField(
                      controller: textEditingController,
                      decoration: const InputDecoration(
                        // suffixIcon: sicon,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            borderSide: BorderSide(color: Colors.black)),
                        labelText: "City",
                        labelStyle: TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            borderSide: BorderSide(color: Colors.black)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        searchNotifier.addSearch(textEditingController.text);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                Weather(city: textEditingController.text)));
                      }
                    },
                    child: Container(
                      width: 90.w,
                      height: 6.h,
                      color: Color.fromARGB(255, 108, 163, 224),
                      child: const Center(
                          child: Text(
                        'Search',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            const Text("Search History"),
            SizedBox(
              height: 20.h,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(searchHistory[index]),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            Weather(city: searchHistory[index]),
                      ));
                    },
                  );
                },
                itemCount: searchHistory.length,
              ),
            )
          ],
        ));
  }
}
