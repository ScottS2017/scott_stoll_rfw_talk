import 'package:flutter/material.dart';
import 'package:langchain/langchain.dart';
import 'package:langchain_chroma/langchain_chroma.dart';
import 'package:scott_stoll_rfw_talk/app/app.dart';
import 'package:scott_stoll_rfw_talk/data/doc_objects.dart';
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
  Future<void> splitTextAndAddToDb({
    required Chroma vectorStore,
  }) async {
    // NOTE: The first one (commented out) will create documents from lists of ids, strings and metadata maps. The second makes the same thing but out of a list of pre-made Document objects. We're using pre-made documents for readability of the Document's content.
    // List<Document> docs = splitter.createDocuments(documentsToSplit);
    List<Document> docs = splitter.splitDocuments(docObjects);
    await vectorStore.addDocuments(documents: docs);
  }
}