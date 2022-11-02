# Basalt Demo

A sample app to display the stock market report of random companies using marketstack.com api 

<p>
    <img src="https://github.com/johnebere58/screenshots/blob/master/basalt_shot.gif" width="auto" height="400px" hspace="20"/>
    <img src="https://github.com/johnebere58/Basalt/blob/master/screenshots/shot1.jpg" width="auto" height="400px" hspace="20"/>
    <img src="https://github.com/johnebere58/Basalt/blob/master/screenshots/shot2.jpg" width="auto" height="400px" hspace="20"/>
    <img src="https://github.com/johnebere58/Basalt/blob/master/screenshots/shot3.jpg" width="auto" height="400px" hspace="20"/>

</p>

## Getting Started

Register and get access key from [marketstack](https://marketstack.com)

Configure your accessToken in the '/lib/services/http_constants.dart' file 

```dart
class HttpConstants{

  static String baseUrl = "http://api.marketstack.com/v1/";

  static String accessToken = "37dd017c73b556b08084f9e141cda65c";

}
```

For help getting started with Flutter development, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

