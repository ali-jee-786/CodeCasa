import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quiz_app/result_screen.dart';
import 'package:quiz_app/quiz_model.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int questionIndex = 0;
  int totalRight = 0;
  bool attempted = false;
  // int notAttempt = 0;
  int totalWrong = 0;
  final _pageController = PageController(initialPage: 0);
  QuizModel quizModel = QuizModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE3C5FF),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          title: Text('Question ${questionIndex + 1} of ${quizModel.quizData.length}'),
          centerTitle: true,
          backgroundColor: Colors.purpleAccent.shade700,
          automaticallyImplyLeading: false,
          leading: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios_new)),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  itemCount: QuizModel().quizData.length,
                  controller: _pageController,
                  onPageChanged: (page){
                    setState(() {
                      questionIndex = page;
                      attempted = false;
                    });
                  },
                  itemBuilder: (context, index){
                    return Column(
                      // mainAxisAlignment: MainAxisAlignment.,
                      children: [
                        const SizedBox(height: 45,),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Container(
                            height: 180,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xffBB7BF5),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Padding(
                              padding:  const EdgeInsets.symmetric(horizontal: 20),
                              child: Center(child: Text(quizModel.quizData[index]['question'],textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26),)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30,),

                        //loop for getting options from model:
                        ...quizModel.quizData[index]['options'].
                        map((data) =>
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: (){
                                  setState(() {
                                    attempted = true;
                                  });
                                  if(quizModel.quizData[index]['has_answered'] == 0){
                                    setState(() {
                                      if(data['value'] == quizModel.quizData[index]['answer']){
                                        data['color'] = '0xff95DF3D';
                                        totalRight++;
                                      }
                                      else{
                                        data['color'] = '0xffFF0000';

                                        //'2' means wrong and it is useful in line 137:
                                        quizModel.quizData[index]['answer_status_right_or_wrong'] = 2;
                                        totalWrong++;
                                      }
                                    });
                                    quizModel.quizData[index]['has_answered'] = 1;
                                  }
                                  // print('total right $totalRight');
                                  // print('total wrong $totalWrong');
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                        height : 65,
                                        width: 240,
                                        decoration: BoxDecoration(
                                          color: Color(int.parse(data['color'])),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Center(child: Text(data['value'], style: const TextStyle(color: Colors.white, fontSize: 16),))
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                          borderRadius: BorderRadius.circular(15)
                                        ),
                                        child: Center(child: Text(data['option'], style: const TextStyle(fontSize: 25),)),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        quizModel.quizData[index]['answer_status_right_or_wrong'] == 2
                            ?
                             Text('Sorry, the correct answer is ${quizModel.quizData[index]['answer']}', style: const TextStyle(color: Colors.red),)
                            : const Text('')
                      ],
                    );

                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.purpleAccent.shade700,
          onPressed: (){
            if(questionIndex == quizModel.quizData.length - 1 ){
              //for submit::
              attempted ?
              Navigator.push(context, PageTransition(
                  child: ResultScreen(totalR: totalRight),
                  type: PageTransitionType.fade, duration: Duration(seconds: 1))
              )
                  :
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please Attempt first!'),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.redAccent,)
              );

            }
            else{
              //for next::
              attempted ?
              _pageController.nextPage(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.linear,

              )
              :
             ScaffoldMessenger.of(context).showSnackBar(
                 const SnackBar(
                   content: Text('Please Attempt first!'),
                   duration: Duration(seconds: 2),
                   backgroundColor: Colors.redAccent,)
             );

            }
          },
          label: Text(questionIndex == quizModel.quizData.length - 1 ? 'Submit' : 'Next' ),
      ),
    );
  }
}
