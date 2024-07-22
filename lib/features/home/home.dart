import 'package:flutter/material.dart';
import 'package:langchain_chroma/langchain_chroma.dart';
import 'package:scott_stoll_rfw_talk/app/app.dart';
import 'package:scott_stoll_rfw_talk/backend/retriever.dart';
import 'package:scott_stoll_rfw_talk/backend/text_splitter.dart';
import 'package:scott_stoll_rfw_talk/data/local_test_documents.dart';
import 'package:scott_stoll_rfw_talk/models/rag_return.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _promptController = TextEditingController();

  Future <void> onSubmit({required BuildContext context, required String prompt}) async {
    String result = '';
    final Splitter splitter = App.splitterOf(context);
    final LlmRetriever retriever = App.retrieverOf(context);
    final RagReturn ragReturn = App.regReturnOf(context);
    await splitter.splitTextAndAddToDb(context: context, document: prompt);
    // There is nothing happening in processPrompt() that would be a problem across an async gap.
    // ignore: use_build_context_synchronously
    result = await retriever.processPrompt(context: context, prompt: prompt);
    setState(() {
      ragReturn.returnedValue = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final RagReturn ragReturn = App.regReturnOf(context);
    final Chroma vectorStore = App.vectorStoreOf(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('P2'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: TextField(
                  onSubmitted: (_) => onSubmit(context: context, prompt: _promptController.text),
                  controller: _promptController,
                  maxLines: 10,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  ragReturn.returnedValue = '';
                     onSubmit(context: context, prompt: _promptController.text);
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
                    // Returned text from the LLM (OpenAI in this demo).
                    child: SingleChildScrollView(
                      child: Text(ragReturn.returnedValue),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      vectorStore.delete(ids: ['1', '2']);
                    },
                    child: const Text('Delete DB Entries'),
                  ),
                  const SizedBox(
                    width: 32.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      vectorStore.addDocuments(documents: LocalTestDocuments.documents);
                    },
                    child: const Text('Add Documents'),
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
