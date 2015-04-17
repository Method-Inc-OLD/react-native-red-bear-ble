#Red Bear BLE & React Native

A quick library to allow access to [Red Bear](http://redbearlab.com/)'s [iOS BLE library](https://github.com/RedBearLab/iOS) from [react native](https://facebook.github.io/react-native/).

This allows creation of react native apps which can speak to BLE boards.

The code is simple for now and just does what is necessary for my purposes. It could be extended to be more universal / useful though.

## Usage

Add the libraries git repository into your project:

```
git submodule add https://github.com/Method-Inc/react-native-red-bear-ble.git Libraries/RedBearBLE
```

And the `xcodeproj` file into your app's project and make sure `libRedBearBLE.a` is added under "Linked Frameworks and Libraries".

In your Javascript you can get a reference to the `BLE` object like so:

```
var BLE = require('NativeModules').RedBearBLE;
```

It has the following methods:

 * `connect`

And it emits the following events:
 
 * ``

## License

The code from Red Bear's [iOS BLE library](https://github.com/RedBearLab/iOS) is copyright Red Bear. Any other code is MIT licensed.
