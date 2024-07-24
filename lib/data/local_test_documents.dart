import 'package:langchain_core/documents.dart';

class LocalTestDocuments {
  static List<Document> documents = const [
    Document(
      id: '1',
      pageContent:
          " Flutter Remote Flutter Widgets widgets do not always take the same types as normal Flutter widgets. This is a key to many parameter types we're going to use with this client app. If it is a simple type then the comment will be only the type for the following parameter listed. If it is an integer then the value shown is an integer (EG: 3). If it is a double then the value shown is a double and it must be used that way. Every double must use a decimal point, even if it is only followed by a 0 (EG: 7.0). bools are shown as simply true or false. If it is more complex than that, a small description will be included. Any special notes are listed here:  // All enums are listed as the value name ONLY: ```textDirection: 'ltr,``` or ```mainAxisAlignment: 'start',```",
      metadata: {
        'framework': 'flutter',
        'package' : 'Remote Flutter Widgets',
        'nickname': 'rfw or RFW',
        'widget': 'Not Applicable',
        'topic': 'guidelines',
      },
    ),
    Document(
      id: '2',
      pageContent: '''
      This is how to use an aspectRatio with Remote Flutter Widgets. The aspectRatio must be a double or expression that resolves to a double.
      ```AspectRatio(
        aspectRatio: 3.0,
        child: Placeholder(),
      ),```''',
      metadata: {
        'framework': 'flutter',
        'package' : 'Remote Flutter Widgets',
        'nickname': 'rfw or RFW',
        'widget': 'AspectRatio',
        'topic': 'example',
      },
    ),
    Document(
      id: '3',
      pageContent: 'Any references to rag or RAG are almost always referring to Retrieval Augmented Generation, in the context of langchain.',
      metadata: {
        'framework': 'langchain',
        'nickname': 'rag or RAG',
        'topic': 'explanation',
      },
    ),
  ];
}
