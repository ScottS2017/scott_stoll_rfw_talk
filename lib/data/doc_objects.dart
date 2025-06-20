import 'package:langchain_core/documents.dart';

List<Document> docObjects = const [
  Document(
      id: 'Guidelines',
      pageContent:
          " Flutter Remote Flutter Widgets widgets do not always take the same types as normal Flutter widgets. This is a key to many parameter types we're going to use with this client app. If it is a simple type then the comment will be only the type for the following parameter listed. If it is an integer then the value shown is an integer (EG: 3). If it is a double then the value shown is a double and it must be used that way. Every double must use a decimal point, even if it is only followed by a 0 (EG: 7.0). bools are shown as simply true or false. If it is more complex than that, a small description will be included. Any special notes are listed here:  // All enums are listed as the value name ONLY: ```textDirection: 'ltr,``` or ```mainAxisAlignment: 'start',```",
     ),
  Document(
    id: 'AspectRatio',
    pageContent: '''
      This is how to use an aspectRatio with Remote Flutter Widgets. The aspectRatio must be a double or expression that resolves to a double.
      ```AspectRatio(
        aspectRatio: 3.0,
        child: Placeholder(),
      ),```''',
  ),
];
