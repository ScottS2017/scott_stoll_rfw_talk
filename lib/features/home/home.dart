import 'package:flutter/material.dart';
import 'package:langchain_chroma/langchain_chroma.dart';
import 'package:scott_stoll_rfw_talk/app/app.dart';
import 'package:scott_stoll_rfw_talk/backend/retriever.dart';
import 'package:scott_stoll_rfw_talk/backend/text_splitter.dart';
import 'package:scott_stoll_rfw_talk/data/doc_objects.dart';
import 'package:scott_stoll_rfw_talk/data/local_test_documents.dart';
import 'package:scott_stoll_rfw_talk/features/experimental_screen/experiemental_screen.dart';
import 'package:scott_stoll_rfw_talk/features/home/home_screen.dart';
import 'package:scott_stoll_rfw_talk/models/rag_return.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _promptController = TextEditingController();
  late final RagReturn _ragReturn;
  late final Chroma _vectorStore;
  late final Splitter _splitter;
  late final LlmRetriever _retriever;

  Future<void> _onSubmit({required BuildContext context, required String prompt}) async {
    String result = '';
    result = await _retriever.processPrompt(vectorStore: _vectorStore, prompt: prompt);
    setState(() {
      _ragReturn.returnedValue = result;
    });
  }

  @override
  void initState() {
    super.initState();
    _ragReturn = App.regReturnOf(context);
    _vectorStore = App.vectorStoreOf(context);
    _splitter = App.splitterOf(context);
    _retriever = App.retrieverOf(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('New Home Screen'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: TextField(
                  onSubmitted: (_) => _onSubmit(context: context, prompt: _promptController.text),
                  controller: _promptController,
                  maxLines: 10,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _ragReturn.returnedValue = '';
                  _onSubmit(context: context, prompt: _promptController.text);
                  _promptController.clear();
                },
                child: const Text('Submit Query'),
              ),
              SizedBox(
                width: 600.0,
                height: 400.0,
                child: ColoredBox(
                  color: Colors.grey[200]!,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 32.0,
                    ),
                    // SECTION: Returned text from the LLM (OpenAI in this demo).
                    child: SingleChildScrollView(
                      child: Text(_ragReturn.returnedValue),
                    ),
                  ),
                ),
              ),
              // SECTION: Bottom button row.
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final docIds = <String>[];
                      for(final(doc) in docObjects){
                        docIds.add(doc.id!);
                      }
                      _vectorStore.delete(ids: docIds);
                    },
                    child: const Text('Delete DB Entries'),
                  ),
                  const SizedBox(
                    width: 32.0,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _splitter.splitTextAndAddToDb(
                        vectorStore: _vectorStore,
                      );
                    },
                    child: const Text('Add Documents'),
                  ),
                  const SizedBox(
                    width: 32.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ExperimentalScreen(),
                        ),
                      );
                    },
                    child: const Text('Experimental Screen'),
                  ),
                  const SizedBox(
                    width: 32.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(title: 'Talk Home Screen'),
                        ),
                      );
                    },
                    child: const Text('Talk Home Screen'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
