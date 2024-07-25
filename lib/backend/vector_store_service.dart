import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:langchain_chroma/langchain_chroma.dart';
import 'package:scott_stoll_rfw_talk/app/app.dart';
import 'package:scott_stoll_rfw_talk/data/local_test_documents.dart';

// SECTION: Vector Storage Services for RAG.
/// Provides functionality for adding documents to the store and
/// running queries.
class VectorStoreService {

  Future<void> addDocumentsToVectorStore({required BuildContext context, required String documents}) async {
    final Chroma vectorStore = App.vectorStoreOf(context);
    // Add documents to the vector store
    await vectorStore.addDocuments(
      documents: Doc.documents,
    );
  }

  Future<void> queryVectorStore({
    required BuildContext context,
    required String query,
    required Map<String, String> metaTags,
  }) async {
    final Chroma chromaDb = App.vectorStoreOf(context);
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
