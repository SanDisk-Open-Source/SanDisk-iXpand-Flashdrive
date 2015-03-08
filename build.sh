#!/bin/sh

XCODE_BASE=/Applications/Xcode.app
RESULT_DIR="./app/iXpand Sync.app"

cp embedded.mobileprovision "$RESULT_DIR"

$XCODE_BASE/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang -std=c++11 -stdlib=libstdc++ \
 -arch armv7 -arch arm64 \
 -isysroot $XCODE_BASE/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS8.1.sdk \
 "iXpand Sync Core.a" \
 -dead_strip -ObjC \
 -Llib -Fframeworks \
 -lc++ -lstdc++ -lz -lbz2 -liconv -lxml2 -lsqlite3 -lLocalyticsAMP_x64 -lPods-apptentive-ios -lPods-BlocksKit -lPods-CocoaAsyncSocket -lPods-CocoaHTTPServer -lPods-CocoaLumberjack -lPods-DFCache -lPods-FXKeychain -lPods-NSLogger -lPods-NSLogger-CocoaLumberjack-connector -lPods-RHAddressBook -lPods-SVWebViewController \
 -fobjc-link-runtime -miphoneos-version-min=7.1 \
 -framework CFNetwork -framework CoreData -framework CoreGraphics -framework CoreText -framework ExternalAccessory -framework Foundation -framework MediaPlayer -framework MobileCoreServices -framework QuartzCore -framework Security -framework SystemConfiguration -framework UIKit -framework HockeySDK -framework MobileVLCKit \
 -o "$RESULT_DIR/iXpand Sync"

plutil -convert xml1 -o "iXpand Sync.xcent" "Entitlements.plist"

export CODESIGN_ALLOCATE=$XCODE_BASE/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/codesign_allocate
export PATH="$XCODE_BASE/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin:$XCODE_BASE/Contents/Developer/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin"
#/usr/bin/codesign --force --sign $IDENTITY --resource-rules="ResourceRules.plist" --entitlements "iXpand Sync.xcent" "$RESULT_DIR"
/usr/bin/codesign --force --sign $"YOUR_IDENTITY" --resource-rules="ResourceRules.plist" --entitlements "iXpand Sync.xcent" "$RESULT_DIR"
