# react-native-icloudstore 📱☁️📱

[![npm version](https://badge.fury.io/js/react-native-icloudstore.svg)](http://badge.fury.io/js/react-native-icloudstore)

A drop in replacement for [React Native](https://github.com/facebook/react-native)'s [AsyncStorage](https://facebook.github.io/react-native/docs/asyncstorage.html) API that wraps the [iCloud Ubiquitous Key-Value Store](https://developer.apple.com/library/content/documentation/General/Conceptual/iCloudDesignGuide/Chapters/DesigningForKey-ValueDataIniCloud.html).

## Usage

In your target's "capabilities" tab in Xcode, make sure that iCloud is switched on as well as make sure that the "Key-value storage" option is checked.

`react-native-icloudstore` mimicks the same promise-based API as [AsyncStorage](https://facebook.github.io/react-native/docs/asyncstorage.html). In addition to all of the `AsyncStorage` methods, there is one additional feature: a native event (`iCloudStoreDidChangeRemotely`) that lets you know when your store changed due to a remote change (i.e. from another device on the same iCloud account). See the example below for a *very* basic way to make use of that in your React Native application. For apps that use [redux](http://redux.js.org), you may want to call an appropriate [action creator](http://redux.js.org/docs/basics/Actions.html) upon receiving the event.

```javascript
import { NativeEventEmitter } from 'react-native';
import iCloudStorage from '@photon-sdk/react-native-icloudstore';

...

  componentWillMount() {
    this.eventEmitter = new NativeEventEmitter(iCloudStorage);
    this.eventEmitter.addListener('iCloudStoreDidChangeRemotely', this.loadData);
  }

  componentWillUnmount() {
    this.eventEmitter.remove();
  }

  loadData = (userInfo) => {
    const changedKeys = userInfo.changedKeys;
    if (changedKeys != null && changedKeys.includes('MY_STORAGE_KEY')) {
      iCloudStorage.getItem('MY_STORAGE_KEY').then(result => this.setState({ storage: result }));
    }
  }
  
...
  
```

## Install

```shell
npm install --save @photon-sdk/react-native-icloudstore
```

## Automatically link

#### With React Native 0.27+

```shell
react-native link @photon-sdk/react-native-icloudstore
```

#### With older versions of React Native

You need [`rnpm`](https://github.com/rnpm/rnpm) (`npm install -g rnpm`)

```shell
rnpm link @photon-sdk/react-native-icloudstore
```

## Manually link

### iOS (via Cocoa Pods)
Add the following line to your build targets in your `Podfile`

`pod 'RNICloudStore', :path => '../node_modules/@photon-sdk/react-native-icloudstore'`

Then run `pod install`

### iOS (without Cocoa Pods)

In XCode, in the project navigator:
- Right click _Libraries_
- Add Files to _[your project's name]_
- Go to `node_modules/@photon-sdk/react-native-icloudstore`
- Add the `.xcodeproj` file

In XCode, in the project navigator, select your project.
- Add the `libicloudstorage.a` from the _deviceinfo_ project to your project's _Build Phases ➜ Link Binary With Libraries_
- Click `.xcodeproj` file you added before in the project navigator and go the _Build Settings_ tab. Make sure _All_ is toggled on (instead of _Basic_).
- Look for _Header Search Paths_ and make sure it contains both `$(SRCROOT)/../react-native/React` and `$(SRCROOT)/../../React`
- Mark both as recursive (should be OK by default).

Run your project (Cmd+R)

### Android

Android isn't supported - importing will simply return `AsyncStorage` so your app should continue to work.

## Feedback

Questions? Comments? Feel free to [email me](mailto:mani.ghasemlou@icloud.com). 

If you have an issue, please create an issue under the "Issues" tab above. Or, feel free to issue a pull request. 🤓
