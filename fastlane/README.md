fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios do_publish_prod
```
fastlane ios do_publish_prod
```
Deploy a new version to the App Store
### ios do_publish_lib
```
fastlane ios do_publish_lib
```
Release new private pod version
### ios do_publish_beta
```
fastlane ios do_publish_beta
```
Publish a beta version
### ios do_publish_test
```
fastlane ios do_publish_test
```
Publish a test version

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
