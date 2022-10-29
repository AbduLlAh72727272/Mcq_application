import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:usefulmcqapp/view_model/fetch_mcqs.dart';

import 'mcqhome.dart';
import 'package:provider/provider.dart';


class SplashForMcqs extends StatefulWidget {
  const SplashForMcqs({Key? key}) : super(key: key);

  @override
  State<SplashForMcqs> createState() => _SplashForMcqsState();
}

class _SplashForMcqsState extends State<SplashForMcqs> {
  late final Future<LottieComposition> _composition;

  @override
  void initState() {
    super.initState();

    _composition = _loadComposition();
     context.read<FetchMcqs>().getCategory();

    Timer(Duration(seconds: 10),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                    HomeScreenForMcqs()
            )
        )
    );
  }

  Future<LottieComposition> _loadComposition() async {

    var assetData = await rootBundle.load('assets/reading.json');

    return await LottieComposition.fromByteData(assetData);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<LottieComposition>(
              future: _composition,
              builder: (context, snapshot) {
                var composition = snapshot.data;
                if (composition != null) {
                  return Lottie(composition: composition,
                  height: 200,
                    width: 200,
                    fit: BoxFit.fill,
                    // frameRate: FrameRate.max,
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            // Container(
            //   // height: 200,
            //   // width: 200,
            //     child:Lottie.network(
            //
            //       'https://assets4.lottiefiles.com/packages/lf20_aorkkcxr.json',
            //       width: 200,
            //       height: 200,
            //       frameRate: FrameRate.max,
            //       fit: BoxFit.fill,
            //     )
            // ),
            const SizedBox(
              height: 20,
            ),



            /// this one is good
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Learn To Grow',
                  textStyle: const TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7456F5)
                  ),
                  speed: const Duration(milliseconds: 300),
                ),
              ],

              totalRepeatCount: 4,
              pause: const Duration(milliseconds: 1000),
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            ),
            //
            //
            SizedBox(
              height: 50,
            ),

            CircularProgressIndicator(
              color: Color(0xFF7456F5),

            )

            // Container(
            //   height: 150,
            //   width: MediaQuery.of(context).size.width,
            //   child: const Center(
            //     child: Text('Its okay'),
            //   ),
            // )


          ],
        ),
      ),
    );
  }
}
