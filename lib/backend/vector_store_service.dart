import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:langchain/langchain.dart';
import 'package:langchain_chroma/langchain_chroma.dart';
import 'package:langchain_core/documents.dart';

import '../data/doc_objects.dart';

// SECTION: Vector Storage Services for RAG.
/// Provides functionality for adding documents to the store and
/// running queries.
class DatabaseService {

  /// Splits the text into smaller chunks to be turned into embeddings.
  final splitter = const RecursiveCharacterTextSplitter(
    chunkSize: 2000,
    chunkOverlap: 400,
  );

  Future<void> addDocumentsToDatabase({required Chroma database, required List<Document> documents}) async {
    // NOTE: The first one (commented out) will create documents from lists of ids, strings and metadata maps. The second makes the same thing but out of a list of pre-made Document objects. We're using pre-made documents for readability of the Document's content.
    // List<Document> docs = splitter.createDocuments(documentsToSplit);
    List<Document> docs = splitter.splitDocuments(documents);
    await database.addDocuments(documents: docs);
  }

  // FIXME: Need to be using this for queries that access the db.
  Future<void> queryVectorStore({
    required Chroma chromaDb,
    required String query,
    Map<String, String>? metaTags,
  }) async {
    final res = await chromaDb.similaritySearch(
      query: query,
      config: ChromaSimilaritySearch(
        k: 1,
        scoreThreshold: 0.4,
        where: metaTags,
      ),
    );
    debugPrint(res.toString());
  }
}
