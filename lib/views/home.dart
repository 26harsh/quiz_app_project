import 'package:flutter/material.dart';
import 'package:quizz_app_2/services/database.dart';
import 'package:quizz_app_2/widgets/widgets.dart';

import 'create_quiz.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Stream quizStream;
  DatabaseService databaseService = new DatabaseService();
  Widget quizList() {
    return Container(
      child: StreamBuilder(
          stream: quizStream,
          builder: (context, AsyncSnapshot snapshot) {
            return snapshot.data == null
                ? Container()
                : ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      return Container();
                      // ignore: dead_code
                      QuizTile(
                        imgeUrl: snapshot.data!.docs[index].data["quizImgUrl"],
                        desc: snapshot.data.docs[index].data["quizDesc"],
                        title: snapshot.data.docs[index].data["quizTitle"],
                      );
                    });
          }),
    );
  }

  @override
  void initState() {
    databaseService.getQuizData().then((val) {
      setState(() {
        quizStream = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: quizList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateQuiz()));
        },
      ),
    );
  }
}

class QuizTile extends StatelessWidget {
  late final String imgeUrl, title, desc;

  QuizTile({required this.imgeUrl, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Image.network(imgeUrl),
          Container(
            child: Column(
              children: [Text(title), Text(desc)],
            ),
          )
        ],
      ),
    );
  }
}
