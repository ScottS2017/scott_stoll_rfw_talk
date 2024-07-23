/// The screen shown on startup.
const initializingRfwWidget = '''
Container(
  width: 500.0,
  height: 800.0,
  color: 0xFFF0F0F0,
  child: Center(
    child: SizedBox(
      width: 400.0,
      height: 700.0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: 0xFF0000FF,
          title: Center(
            child: Text(
              text: ['hi there'],
              style: {
                color: 0xFFFFFFFF,
              },
            ),
          ),
        ),
        body: Row(
          mainAxisAlignment: "spaceBetween",
          crossAxisAlignment: "stretch",
          children: [
            Container(
              width: 50.0,
              color: 0xFF00FFFFF,
            ),
            Column(
             mainAxisAlignment: "spaceEvenly",
             crossAxisAlignment: "center",
              children: [
                ElevatedButton(
                onPressed: event "rfwTestPrint"  { arguments: ["Test String in args"] },
                child: Container(
                  width: 225.0,
                  height: 120.0,
                  color: 0xFFFFFF00,
                ),
                ),
                Container(
                  width: 225.0,
                  height: 120.0,
                  decoration: {
                  type: "box",
                    image: {
                      source: "https://assets3.thrillist.com/v1/image/3082123/792x446/scale;webp=auto;jpeg_quality=60;progressive.jpg",
                      fit: "cover",
                    },
                    borderRadius: [
                      {
                        x: 50.0,
                        y: 50.0,
                      },
                    ],
                    boxShadow: [
                      {
                        color: 0x7F000000,
                        offset: {
                          x: 4.0,
                          y: 4.0,
                        },
                        blurRadius: 4.0,
                      },
                    ],
                  },
                ),
                Container(
                  width: 225.0,
                  height: 120.0,
                  decoration: {
                  type: "box",
                    image: {
                      source: "https://assets3.thrillist.com/v1/image/3082123/792x446/scale;webp=auto;jpeg_quality=60;progressive.jpg",
                      fit: "cover",
                    },
                    borderRadius: [
                      {
                        x: 50.0,
                        y: 50.0,
                      },
                    ],
                    boxShadow: [
                      {
                        color: 0x7F000000,
                        offset: {
                          x: 4.0,
                          y: 4.0,
                        },
                        blurRadius: 4.0,
                      },
                    ],
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  ),
)
''';