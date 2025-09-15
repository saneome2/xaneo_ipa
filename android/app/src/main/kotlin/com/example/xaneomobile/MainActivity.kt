package com.example.xaneomobile

import android.content.Intent
import android.os.Bundle
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    // Отключаем MethodChannel для deep links
    // private val CHANNEL = "com.example.xaneomobile/deeplink"
    // private var methodChannel: MethodChannel? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // Дополнительные флаги для оптимизации производительности
        window.addFlags(WindowManager.LayoutParams.FLAG_HARDWARE_ACCELERATED)
        
        // Устанавливаем максимальную частоту обновления
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.R) {
            window.attributes.preferredRefreshRate = 120f
        }
    }
    
    // Отключаем настройку MethodChannel
    /*
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
    }
    */
    
    // Отключаем обработку onNewIntent
    /*
    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        
        // Отправляем deep link в Flutter
        val data = intent.data
        if (data != null) {
            methodChannel?.invokeMethod("onDeepLink", data.toString())
        }
    }
    */
}
