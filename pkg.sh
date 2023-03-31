ROOT_DIR=/Users/enxibaba/shine_credit/android

#参数传渠道号
assembleReleaseSingle(){
  cd $ROOT_DIR

  echo "$1正式开始打包..."
  #改名后的包路径：build/app/outputs/apk/release/
  flutter build apk --dart-define=APP_CHANNEL=$1
  cd $ROOT_DIR/../build/app/outputs/apk/release/
  cp -R *.apk $ROOT_DIR/../build/app/outputs/
}

echo "打包前的clean..."
flutter clean

assembleReleaseSingle google

echo "打包完成，打开apk目录"
open $ROOT_DIR/../build/app/outputs