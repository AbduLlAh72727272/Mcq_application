import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:usefulmcqapp/view_model/fetch_mcqs.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';


class DisplayMcqs extends StatefulWidget {
  const DisplayMcqs({Key? key}) : super(key: key);

  @override
  State<DisplayMcqs> createState() => _DisplayMcqsState();
}

class _DisplayMcqsState extends State<DisplayMcqs> {
  // List<McqsModel> mcqs=[
  //   McqsModel(question: 'Whats the Average Weight of adult elephant?', answer1: '1000', answer2: '2000', answer3: '3000', answer4: '4000', image: 'https://cdn-icons-png.flaticon.com/512/3065/3065702.png',correct: '3'),
  //   McqsModel(question: 'whats the average height of a giraffe?', answer1: '5.1', answer2: '5.9', answer3: '2.7', answer4: '7', image: 'https://cdn-icons-png.flaticon.com/512/3065/3065712.png',correct: '2'),
  //   McqsModel(question: 'whats the speed of lightening?', answer1: '300,000', answer2: '200,000', answer3: '400,000', answer4: '100,000', image: 'https://cdn-icons-png.flaticon.com/512/3640/3640263.png',correct: '1'),
  //   McqsModel(question: 'whats the radius of earth?', answer1: '6000', answer2: '1500', answer3: '7000', answer4: '6371', image: 'https://cdn-icons-png.flaticon.com/512/2072/2072299.png',correct: '4'),
  //
  //
  //
  // ];
  int i=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF7456F5),
        onPressed: (){
          if(i<=context.read<FetchMcqs>().listById.length){
            setState(() {
              ++i;
            });
          }
          else{
            setState(() {
              i=0;
            });

          }


        },
        child: Icon(
          Icons.arrow_forward
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 80,
                    child: Row(
                      children: [
                        InkWell(
                          onTap:(){
                            Navigator.pop(context);


              },
                          child: Icon(
                            Icons.arrow_back,
                            color: Color(0xFF979799),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Text('Back',
                          style: TextStyle(
                              color: Color(0xFF979799)
                          ),
                        )
                      ],
                    ),
                  ),
                  CircularStepProgressIndicator(
                    totalSteps: context.watch<FetchMcqs>().sum+1,
                    currentStep: i,

                    stepSize: 1,
                    selectedColor:  Color(0xFF7456F5),
                    unselectedColor: Colors.grey[200],
                    padding: 0,
                    width: 30,
                    height: 30,
                    selectedStepSize: 5,
                    roundedCap: (_, __) => true,
                  ),

                ],
              ),
            ),
            SizedBox(
              height: 150,
            ),
            Text('Question ${context.watch<FetchMcqs>().sum+1}',
              style: TextStyle(
                color: Color(0xFF979799),
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListView.builder(
                itemCount: context.watch<FetchMcqs>().listById.length,
                shrinkWrap: true,
                padding: EdgeInsets.all(0),
                itemBuilder: (BuildContext context, int index) {
                  return  index==i?Column(

                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width/1.1,
                        height: 50,
                        child: Text(
                          context.watch<FetchMcqs>().listById[index].question,
                          // overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CachedNetworkImage(
                        imageUrl:  'https://cdn-icons-png.flaticon.com/512/3261/3261308.png',
                        height: 80,
                        width: 80,
                        fit: BoxFit.fill,
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      // Image.network(
                      //   'https://cdn-icons-png.flaticon.com/512/3261/3261308.png',
                      //   height: 150,
                      //   width: 150,
                      //   fit: BoxFit.fill,
                      //
                      //   loadingBuilder: (BuildContext context, Widget child,
                      //       ImageChunkEvent? loadingProgress) {
                      //     if (loadingProgress == null) return child;
                      //     return Container(
                      //       height: 150,
                      //       width: 150,
                      //       child: Center(
                      //         child: CircularProgressIndicator(
                      //           color: Color(0xFF7456F5),
                      //           value: loadingProgress.expectedTotalBytes != null
                      //               ? loadingProgress.cumulativeBytesLoaded /
                      //               loadingProgress.expectedTotalBytes!
                      //               : null,
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ),
                      // Image.network(
                      //   'https://cdn-icons-png.flaticon.com/512/3065/3065702.png',
                      //   height: 150,
                      //   width: 150,
                      //   fit: BoxFit.fill,
                      // ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          mcqAnswerRow(ansNumber: '1',answer: context.watch<FetchMcqs>().listById[index].answer1,
                            borderColor:context.watch<FetchMcqs>().listById[index].correctAnswer=='A'?Colors.deepPurple:Color(0xFFF2F2F2),),
                          SizedBox(width: 5,),

                          mcqAnswerRow(ansNumber: '2',answer:context.watch<FetchMcqs>().listById[index].answer2,borderColor:context.watch<FetchMcqs>().listById[index].correctAnswer=='B'?Colors.deepPurple:Color(0xFFF2F2F2)),


                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          mcqAnswerRow(ansNumber: '3',answer: context.watch<FetchMcqs>().listById[index].answer3,borderColor: context.watch<FetchMcqs>().listById[index].correctAnswer=='C'?Colors.deepPurple:Color(0xFFF2F2F2),),
                          SizedBox(width: 5,),

                          mcqAnswerRow(ansNumber: '4',answer: context.watch<FetchMcqs>().listById[index].answer4,borderColor: context.watch<FetchMcqs>().listById[index].correctAnswer=='D'?Colors.deepPurple:Color(0xFFF2F2F2),),


                        ],
                      ),
                    ],
                  ):Container();

                }),





          ],
        ),
      ),

    );
  }
}

class mcqAnswerRow extends StatelessWidget {
  String ansNumber;
  String answer;
  Color borderColor;
  mcqAnswerRow({
    Key? key,required this.ansNumber,required this.answer,required this.borderColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 50,
          width: 170,
          decoration: BoxDecoration(
            border: Border.all(
                color: borderColor
            ),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
               // mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Color(0xFFF6F5F8),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: Center(
                    child: Text(ansNumber,
                    overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                // SizedBox(
                //   width: 5,
                // ),
                SizedBox(
                   width: 125,
                  child: Text(answer,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.black

                    ),
                  ),
                ),
                // Container(
                //   height: 30,
                //   width: 30,
                //   decoration: BoxDecoration(
                //     color: Color(0xFFF6F5F8),
                //     borderRadius: BorderRadius.circular(60),
                //   ),
                //   child: Center(
                //     child: Text('1'),
                //   ),
                // ),

              ],
            ),
          ),
        )

      ],
    );
  }
}

// class McqsModel{
//   String question;
//   String answer1;
//   String answer2;
//   String answer3;
//   String answer4;
//   String image;
//   String correct;
//   McqsModel({required this.question,required this.answer1,required this.answer2,required this.answer3,required this.answer4,
//     required this.image,required this.correct
//   });
// }
