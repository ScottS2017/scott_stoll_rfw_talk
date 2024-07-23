/// A collection of various rules to follow when working with RFW widgets.
/// Entries are alphabetized.
class RfwRules {
  static const String animationDefaults = 'The default duration that [ArgumentsDecoder.duration] defaults to 200ms when this is null, and its default curve is fastOutSlowIn';
  static const String argumentDecodersClassInstructions = '''
  The argument decoders in RFW decode structured values from a [DataSource]. These methods
  take a [DataSource] and a `key`. The `key` is a path to the
  part of the [DataSource] that the value should be read from. This may
  identify a map, a list, or a leaf value, depending on the needs of the
  method.
  ''';
  static const String borderRadius = '''
  borderRadius is a list of maps. There will be one or four values. If the values for all four corners are the same
  then just use one map and it will be used for all four corners. Each map has an x and y key. The x key always
  represents the horizontal component of a corner, the y is optional and, if present, always represents the vertical component of that same corner. If there is only an x key and no y, then the x value is used for both. The order
  of maps in the borderRadius list is topStart, topEnd, bottomStart, bottomEnd. As with many alignments in Flutter
  start and end are defined as the start and end sides of a sentence in the user's language, rtl or ltr.
  Examples:
  // 1) All four corners will have their horizontal half use a radius of 50.0, and a vertical half radius of 10.0
  borderRadius:
    [
      {x: 50.0, y: 10.0},
    ],
    
    // 2)  x and y are the same since y isn't provided. The top corners will be a radius of 10.0, and bottom 20.0.
  borderRadius:
    [
      {x: 10.0},
      {x: 10.0},
      {x: 20.0},
      {x: 20.0},
    ],
  ''';
  static const String colorsAreNumbers = "Colors are always their ARGB hex number.";
  static const String iconsAreNumbers =  "Icons are passed in with their hex number and family name as a string, instead of an Icon constructor the way it's done in regular Flutter code.";
  static const String paddingListOfDoubles = '''padding is just a list of four doubles. The order is left, top, right, bottom. EG this is the same as normal Flutter's symmetric padding set to 16.0 horizontal and 10.0 vertical:
  padding: [16.0,10.0,16.0,10.0,]''';
  static const String sizesAreDoubles = "Sizes are always doubles, with the decimal point.";

  static String allRules(){
    const result = '$animationDefaults $argumentDecodersClassInstructions $borderRadius $colorsAreNumbers $iconsAreNumbers $paddingListOfDoubles $sizesAreDoubles';
    return result;
  }
}