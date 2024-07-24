import 'package:flutter/material.dart';
import 'package:langchain/langchain.dart';
import 'package:langchain_chroma/langchain_chroma.dart';
import 'package:langchain_ollama/langchain_ollama.dart';
import 'package:scott_stoll_rfw_talk/app/app.dart';

// SECTION: Class is the Retriever for RAG.
/// Provides functionality for processing the prompt and retrieving the
/// response.
class LlmRetriever {
  // FIXME convert the setup to a singleton and provide it via context.

  /// Prepares the prompt for processing sends it to the LLM, and gets the
  /// response.
  Future <String> processPrompt({required Chroma vectorStore, required String prompt}) async {
    // SECTION: Retriever.
    final retriever = vectorStore.asRetriever();
    final setupAndRetrieval = Runnable.fromMap<String>({
      'context': retriever.pipe(
        Runnable.mapInput((docs) => docs.map((d) => d.pageContent).join('\n')),
      ),
      'question': Runnable.passthrough(),
    });
    // SECTION: Prompt Template.
    final promptTemplate = ChatPromptTemplate.fromTemplates(const [
      (
      ChatMessageType.system,
      'Answer the question based on only the following context:\n{context}'
      ),
      (ChatMessageType.human, '\n{question}'),
    ]);
    // SECTION LLM.
    String responseFromLLM = '';
    final llm = ChatOllama(
      // URL of your Ollama llm.
      baseUrl: 'http://localhost:11434/api',
      defaultOptions: const ChatOllamaOptions(
        temperature: 0.1,
        // Model is optional, could be llama3, among others. If null, default is llama3.
        model: 'gemma2:9b',
      ),
    );
    // SECTION: LCEL & Output.
    const outputParser = StringOutputParser<ChatResult>();
    final chain = setupAndRetrieval.pipe(promptTemplate).pipe(llm).pipe(outputParser);
    final result = chain.stream(prompt);
    await for (var text in result) {
      responseFromLLM += text;
    }
     return responseFromLLM;
  }
}