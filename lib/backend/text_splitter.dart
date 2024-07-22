import 'package:flutter/material.dart';
import 'package:langchain/langchain.dart';
import 'package:langchain_chroma/langchain_chroma.dart';
import 'package:scott_stoll_rfw_talk/app/app.dart';
import 'package:uuid/uuid.dart';

// SECTION: Text Splitter for RAG.
/// Provides functionality for splitting and adding data to the db.
class Splitter {

  /// Splits the text into smaller chunks to be turned into embeddings.
  final splitter = const RecursiveCharacterTextSplitter(
    chunkSize: 2000,
    chunkOverlap: 400,
  );

  /// Splits the text into chunks and sends them to the Vector DB.
  Future <void> splitTextAndAddToDb({required BuildContext context, required String document}) async {
    final Chroma vectorStore = App.vectorStoreOf(context);
    final splitLists = splitter.splitText(document);
    final ids = splitLists
        .map(
          (e) => const Uuid().v4(),
    )
        .toList();
    List<Document> docs = splitter.createDocuments(splitLists, ids: ids);
    await vectorStore.addDocuments(documents: docs);
  }
}