package com.galong.lend.ease.hub

import android.graphics.Color;
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    /// 设置状态栏透明，导航栏沉浸。
    window.statusBarColor = Color.WHITE;
  }

}
