---
title: RN Bitrise一键集成打包android/ios测试包
date: 2016/11/10 20:46:25
banner: http://oeyxehw3i.bkt.clouddn.com/public/16-11-10/44640160.jpg
tags:
- react native
- auto
categories:
- ReactNative
---
## RN Bitrise一键集成打包android/ios测试包

> https://www.bitrise.io

 ### Android

```
---
format_version: 1.1.0
default_step_lib_source: https://github.com/bitrise-io/bitrise-steplib.git
trigger_map:
- push_branch: master
  workflow: primary
- pull_request_source_branch: master
  workflow: primary
workflows:
  primary:
    steps:
    - activate-ssh-key@3.1.1:
        title: Activate App SSH key
        inputs:
        - ssh_key_save_path: "$HOME/.ssh/steplib_ssh_step_id_rsa"
    - git-clone: {}
    - script@1.1.3:
        title: npm install
        inputs:
        - content: |-
            #!/bin/bash

            npm install
    - install-react-native@0.1.0: {}
    - react-native-bundle@1.0.1:
        inputs:
        - platform: android
        - entry_file: "./index.android.js"
        - out: android/app/src/main/assets/index.android.bundle
        - dev: 'false'
    - script@1.1.3:
        title: gradlew
        inputs:
        - content: "#!/bin/bash\n\ncd android \n./gradlew  assembleRelease"
          opts:
            is_expand: true
    - sign-apk@1.1.1:
        inputs:
        - apk_path: "/bitrise/src/android/app/build/outputs/apk/app-release-unsigned.apk"
        - keystore_url: "$KEY_PATH"
        - keystore_password: "$KEY_PASS"
        - keystore_alias: tellmewhy.keystore
        - private_key_password: "$KEY_PASS"
    - script@1.1.3:
        title: cp apk
        inputs:
        - content: |-
            #!/bin/bash

             cp $BITRISE_SIGNED_APK_PATH $BITRISE_DEPLOY_DIR/signed-app-release.apk
    - deploy-to-bitrise-io@1.2.5:
        is_always_run: false
    envs:
    - opts:
        is_expand: true
      KEY_PATH: xxx
    - opts:
        is_expand: true
      KEY_PASS: xxx
    - opts:
        is_expand: true
      KEY_ALIAS: xxx

```

因为android 默认了release 用的是assets/index.android.bundle，所以用react-native bundle 生成到正确的位置即可，sign-apk配置上签名文件和密码,alias即可。省略了npm test 测试。做比较少修改即可一次编译成功。



### IOS

ios 需要p12和描述文件，苹果帐号

```
npm install
react-native bundle --entry-file ./index.ios.js --platform ios --bundle-output ios/bundle/main.jsbundle --dev false --assets-dest ios/bundle/assets
fastlane ios beta
```

* bundle 这里打包了main.jsbundle/assets 在xcode中要用folder reference(引用后是蓝色文件+) ,要先创建bundle目录

* fastlane 外国工具 直接上https://github.com/fastlane/fastlane/tree/master/gym 看它和gym 的Readme，最好本机先安装fastlane init 测试下，gym 好6,这里我们只需要用它的fastlane ios beta 即可。还可以测试截图，以后再补充。

  ```
  # fastfile
  fastlane_version "1.107.0"

  default_platform :ios


  platform :ios do
    before_all do
      # ENV["SLACK_URL"] = "https://hooks.slack.com/services/..."
      ENV["BITRISE_DEPLOY_DIR"] = "./build/"
      
    end

    desc "Runs all the tests"
    lane :test do
      scan
    end

    desc "Submit a new Beta Build to Apple TestFlight"
    desc "This will also make sure the profile is up to date"
    lane :beta do
      # match(type: "appstore") # more information: https://codesigning.guide
      gym(use_legacy_build_api: true,scheme:"goodidea",output_directory:"./build/")# Build your app - more options available
      #pilot
      sh("cp ../build/goodidea.ipa $BITRISE_DEPLOY_DIR")
      #sh "your_script.sh"
      # You can also use other beta testing services here (run `fastlane actions`)
    end

    desc "Deploy a new version to the App Store"
    lane :release do
      # match(type: "appstore")
      # snapshot
      gym # Build your app - more options available
      deliver(force: true)
      # frameit
    end

    # You can define as many lanes as you want

    after_all do |lane|
      # This block is called, only if the executed lane was successful

      # slack(
      #   message: "Successfully deployed new App Update."
      # )
    end

    error do |lane, exception|
      # slack(
      #   message: exception.message,
      #   success: false
      # )
    end
  end


  # More information about multiple platforms in fastlane: https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Platforms.md
  # All available actions: https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Actions.md

  # fastlane reports which actions are used
  # No personal data is recorded. Learn more at https://github.com/fastlane/enhancer

  ```

* 执行cp 时总找不到文件，原来它去了fastlane这个目录，sh "pwd && ../build/goodidea.ipa $BITRISE_DEPLOY_DIR"

最后，fastlane 只读取目录下的fastlane配置，ios 在再下一级目录，在working directory 设置 ./ios 即可。

ios10有个bug 一定要设置好sign，这个我build了5,6次终于green了，坑。

有问题留言我上传些图，没有就这样了..

