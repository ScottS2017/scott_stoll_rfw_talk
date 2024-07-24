import 'package:langchain_chroma/langchain_chroma.dart';
import 'package:scott_stoll_rfw_talk/backend/gemini_service.dart';
import 'package:scott_stoll_rfw_talk/app/app.dart';
import 'package:scott_stoll_rfw_talk/features/experimental_screen/experiemental_screen.dart';
import 'package:scott_stoll_rfw_talk/data/local_test_documents.dart';
import 'package:scott_stoll_rfw_talk/models/local_chat.dart';
import 'package:scott_stoll_rfw_talk/utils/spacing_constants.dart';
import 'package:rfw/formats.dart' show parseLibraryFile;
import 'package:rfw/rfw.dart';
import 'package:flutter/material.dart';

/// The main screen of the app.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  /// Title string for use in the [AppBar].
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Contains the logic that builds and maintains Remote Flutter Widgets.
  final Runtime _runtime = Runtime();

  /// Configuration data from the remote widgets.
  final DynamicContent _data = DynamicContent();

  /// An individual chat, with a personality, situation, and chat history.
  late LocalChat _gemini;

  /// The [GeminiService] singleton provided via the context.
  late GeminiService _geminiService;

  final _inputController = TextEditingController();
  final _inputFieldFocusNode = FocusNode();
  // FIXME currentWidgetValue is a workaround for the ValueListenableBuilder not rebuilding.
  String currentWidgetValue = '';
  double width = 1080.0;
  double height = 900.0;

  // The future used the the UI's [FutureBuilder].
  Future<void>? _futureResponse;

  /// The widget library of material widgets.
  static const LibraryName materialLibraryName = LibraryName(<String>['material', 'widgets']);

  /// The widget library of core widgets.
  static const LibraryName coreLibraryName = LibraryName(<String>['core', 'widgets']);

  /// The widget library of local custom widgets.
  static const LibraryName localLibraryName = LibraryName(<String>['local']);

  /// The widget library of local custom widgets.
  static const LibraryName remoteLibraryName = LibraryName(<String>['remote']);

  late final Chroma _vectorStore;

  // Sends the input to [GeminiService] and updates [_futureResponse].
  void _handleSubmit(String input) {
    setState(() {
      // Process the prompt.
      _futureResponse = _geminiService.handleSubmit(
          userInput: input, gemini: _gemini, geminiService: _geminiService);
      // Set focus back to the input field for the next input, then clear the text.
      _inputFieldFocusNode.requestFocus();
      _inputController.clear();
    });
  }

  void _undoToLastWidget(){
    setState(() {
      // Process the prompt.
      _futureResponse = _geminiService.handleSubmit(
          userInput: _geminiService.undoWidget, gemini: _gemini, geminiService: _geminiService);
      // Set focus back to the input field for the next input, then clear the text.
      _inputFieldFocusNode.requestFocus();
      _inputController.clear();
    });
  }

  // Handles changing the widgets.
  void _update() {
    _runtime.update(coreLibraryName, createCoreWidgets());
    _runtime.update(materialLibraryName, createMaterialWidgets());
    var rfwStringFromGemini = _geminiService.rfwString.value;
    _runtime.update(
        remoteLibraryName,
        // parseLibraryFile() takes a single string of all imports. The last is our rfwString.
        parseLibraryFile(
            'import core.widgets; import material.widgets; widget root = $rfwStringFromGemini;'));
  }

  /// Used with hot reloads/restarts. This function has no effect in production.
  @override
  void reassemble() {
    super.reassemble();
    _update();
  }

  /// Initializes this widget's [State].
  @override
  void initState() {
    super.initState();
    _gemini = App.localChatOf(context);
    _geminiService = App.geminiServiceOf(context);
    _gemini.initChat();
    _vectorStore = App.vectorStoreOf(context);
  }

  void rfwTestPrint(Map arguments) {
    debugPrint(arguments.values.first[0].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: allPadding16,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // SECTION: Text Input.
                  Expanded(
                    child: TextField(
                      controller: _inputController,
                      focusNode: _inputFieldFocusNode,
                      onSubmitted: (_) {
                        if (_geminiService.awaitingResponse) return;
                        _handleSubmit(_inputController.text);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1)),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'Me:',
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  horizontalMargin16,
                  // SECTION: Undo Button.
                  ElevatedButton(
                    onPressed: () {
                      _undoToLastWidget();
                    },
                    child: const SizedBox(
                      height: 50.0,
                      width: 80.0,
                      child: Center(
                        child: Text(
                          'Undo',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              verticalMargin16,
              // SECTION: RFW Widget.
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF000000),
                    width: 1.0,
                  ),
                ),
                child: ValueListenableBuilder(
                    // When [rfwString] changes, check to see if it's different than before and run update if it is.
                    valueListenable: _geminiService.rfwString,
                    builder: (BuildContext context, String value, _) {
                      if (currentWidgetValue != _geminiService.rfwString.value) {
                        currentWidgetValue = _geminiService.rfwString.value;
                        _update();
                      }
                      return Center(
                        child: RemoteWidget(
                          runtime: _runtime,
                          data: _data,
                          widget: const FullyQualifiedWidgetName(remoteLibraryName, 'root'),
                          onEvent: (String name, DynamicMap arguments) {
                            debugPrint('User triggered event "$name" with data: $arguments');
                            if (name == 'rfwTestPrint') {
                              rfwTestPrint(arguments);
                            }
                          },
                        ),
                      );
                    }),
              ),
              const SizedBox(height: 16.0,),
              FutureBuilder<void>(
                future: _futureResponse,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    // SECTION: The most recent message from the model, displayed in selectable text.
                    return SizedBox(
                      width: double.infinity,
                      height: 100.0,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: FutureBuilder<void>(
                          future: _futureResponse,
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (snapshot.connectionState == ConnectionState.done) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                                child: SingleChildScrollView(
                                  // Rebuilds on an updated response from the model.
                                  child: ValueListenableBuilder<String>(
                                    valueListenable: _geminiService.latestResponseFromModel,
                                    builder: (BuildContext context, String value, _) {
                                      return SelectableText(
                                        _geminiService.latestResponseFromModel.value ?? '',
                                        maxLines: 1000,
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                      ),
                    );
                  } else {
                    // TODO: Replace placeholder with something permanent.
                    return Container(
                      width: double.infinity,
                      height: 300.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 16.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _vectorStore.delete(ids: ['1', '2']);
                    },
                    child: const Text('Delete DB Entries'),
                  ),
                  const SizedBox(
                    width: 32.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _vectorStore.addDocuments(documents: LocalTestDocuments.documents);
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
