#!/bin/bash

FRAMEWORK=RWUIControlsFramework

BUILD=build
FRAMEWORK_PATH=$FRAMEWORK.framework

# iOS
rm -Rf $FRAMEWORK/$BUILD

xcodebuild archive -project $FRAMEWORK/$FRAMEWORK.xcodeproj -scheme $FRAMEWORK -sdk iphoneos SYMROOT=$BUILD

xcodebuild build -project $FRAMEWORK/$FRAMEWORK.xcodeproj -target $FRAMEWORK -sdk iphonesimulator SYMROOT=$BUILD


cp -RL $FRAMEWORK/$BUILD/Release-iphoneos $FRAMEWORK/$BUILD/Release-universal
cp -RL $FRAMEWORK/$BUILD/Release-iphonesimulator/$FRAMEWORK_PATH/Modules/$FRAMEWORK.swiftmodule/* $FRAMEWORK/$BUILD/Release-universal/$FRAMEWORK_PATH/Modules/$FRAMEWORK.swiftmodule

lipo -create $FRAMEWORK/$BUILD/Release-iphoneos/$FRAMEWORK_PATH/$FRAMEWORK $FRAMEWORK/$BUILD/Release-iphonesimulator/$FRAMEWORK_PATH/$FRAMEWORK -output $FRAMEWORK/$BUILD/Release-universal/$FRAMEWORK_PATH/$FRAMEWORK
