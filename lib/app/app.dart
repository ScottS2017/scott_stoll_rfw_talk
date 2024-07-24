import 'package:flutter/material.dart';
import 'package:langchain/langchain.dart';
import 'package:langchain_chroma/langchain_chroma.dart';
import 'package:langchain_openai/langchain_openai.dart';
import 'package:scott_stoll_rfw_talk/backend/gemini_service.dart';
import 'package:scott_stoll_rfw_talk/backend/retriever.dart';
import 'package:scott_stoll_rfw_talk/backend/text_splitter.dart';
import 'package:scott_stoll_rfw_talk/backend/vector_store_service.dart';
import 'package:scott_stoll_rfw_talk/data/api_keys.dart';
import 'package:scott_stoll_rfw_talk/features/home/home.dart';
import 'package:scott_stoll_rfw_talk/models/current_widget.dart';
import 'package:scott_stoll_rfw_talk/models/history.dart';
import 'package:scott_stoll_rfw_talk/models/local_chat.dart';
import 'package:scott_stoll_rfw_talk/models/model.dart';
import 'package:scott_stoll_rfw_talk/models/rag_return.dart';

class App extends StatefulWidget {
  const App({super.key});

  /// Provides access to the CurrentWidget singleton.
  static CurrentWidget currentWidgetOf(BuildContext context) {
    final AppState state = context.findAncestorStateOfType<AppState>()!;
    return state._currentWidgetOf;
  }

  /// Provides access to the History singleton.
  static History historyOf(BuildContext context) {
    final AppState state = context.findAncestorStateOfType<AppState>()!;
    return state._historyOf;
  }

  /// Provides access to the Model singleton.
  static Model modelOf(BuildContext context) {
    final AppState state = context.findAncestorStateOfType<AppState>()!;
    return state._modelOf;
  }

  /// Provides access to the RagReturn singleton.
  static RagReturn regReturnOf(BuildContext context) {
    final AppState state = context.findAncestorStateOfType<AppState>()!;
    return state._ragReturnOf;
  }

  /// Provides access to the RagReturn singleton.
  static OpenAIEmbeddings openAIEmbeddingsOf(BuildContext context) {
    final AppState state = context.findAncestorStateOfType<AppState>()!;
    return state._openAIEmbeddingsOf;
  }

  /// Provides access to the RagReturn singleton.
  static Chroma vectorStoreOf(BuildContext context) {
    final AppState state = context.findAncestorStateOfType<AppState>()!;
    return state._vectorStoreOf;
  }

  /// Provides access to the Splitter singleton.
  static Splitter splitterOf(BuildContext context) {
    final AppState state = context.findAncestorStateOfType<AppState>()!;
    return state._splitterOf;
  }

  /// Provides access to the LlmRetriever singleton.
  static LlmRetriever retrieverOf(BuildContext context) {
    final AppState state = context.findAncestorStateOfType<AppState>()!;
    return state._retrieverOf;
  }

  /// Provides access to the LlmRetriever singleton.
  static VectorStoreService vectorStoreServiceOf(BuildContext context) {
    final AppState state = context.findAncestorStateOfType<AppState>()!;
    return state._vectorStoreServiceOf;
  }

  /// A method that returns a singleton [LocalChat] object, providing it to
  /// the entire app via the context.
  static LocalChat localChatOf(BuildContext context) {
    final AppState state = context.findAncestorStateOfType<AppState>()!;
    return state._providedLocalChat;
  }

  /// A method that returns a singleton [GeminiService] object, providing it to
  /// the entire app via the context.
  static GeminiService geminiServiceOf(BuildContext context) {
    final AppState state = context.findAncestorStateOfType<AppState>()!;
    return state._providedGeminiServiceOf;
  }

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  /// Singleton instance of CurrentWidget used throughout the app.
  late CurrentWidget _currentWidgetOf;

  /// Singleton instance of History used throughout the app.
  late History _historyOf;

  /// Singleton instance of Model used throughout the app.
  late Model _modelOf;

  /// Singleton instance of RagReturn used throughout the app.
  late RagReturn _ragReturnOf;

  /// Singleton instance of RagReturn used throughout the app.
  late OpenAIEmbeddings _openAIEmbeddingsOf;

  /// Singleton instance of RagReturn used throughout the app.
  late Chroma _vectorStoreOf;

  /// Singleton instance of RagReturn used throughout the app.
  late Splitter _splitterOf;

  /// Singleton instance of RagReturn used throughout the app.
  late LlmRetriever _retrieverOf;

  /// Singleton instance of RagReturn used throughout the app.
  late VectorStoreService _vectorStoreServiceOf;

  /// The singleton [LocalChat] object returned by
  /// [widget.localChatOf].
  late LocalChat _providedLocalChat;

  /// The singleton [GeminiService] object returned by
  /// [widget.geminiServiceOf].
  late GeminiService _providedGeminiServiceOf;


  @override
  void initState() {
    super.initState();
    _currentWidgetOf = CurrentWidget();
    _historyOf = History();
    _modelOf = Model();
    _ragReturnOf = RagReturn();
    _openAIEmbeddingsOf = OpenAIEmbeddings(apiKey: openAiApiKey);
    _vectorStoreOf = Chroma(
      // The embeddings that go in the Vector Database.
      embeddings: _openAIEmbeddingsOf,
      // The URI of the the Vector Database.
      baseUrl: 'http://localhost:44556',
    );
    _splitterOf = Splitter();
    _retrieverOf = LlmRetriever();
    _vectorStoreServiceOf = VectorStoreService();
    _providedGeminiServiceOf = GeminiService();
    _providedLocalChat = LocalChat();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}
