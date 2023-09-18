package com.example.channel_test

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorManager
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel

class MainActivity: FlutterActivity() {
    private val METHOD_CHANNEL_NAME = "com.example.app/method_channel"
    private val EVENT_CHANNEL_NAME = "com.example.app/event_channel"

    private var methodChannel: MethodChannel? = null
    private lateinit var sensorManager: SensorManager
    private var eventChannel: EventChannel? = null
    private var streamHandler: StreamHandler? = null

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        //setup channels
        setupChannels(context = this,flutterEngine.dartExecutor.binaryMessenger)

    };

    override fun onDestroy() {
        teardownChannels()
        super.onDestroy()
    }


    private fun setupChannels(context:Context, messenger: BinaryMessenger) {
        sensorManager = context.getSystemService(Context.SENSOR_SERVICE) as SensorManager

        methodChannel = MethodChannel(messenger, METHOD_CHANNEL_NAME)
        methodChannel!!.setMethodCallHandler {
            call, result ->
            if (call.method == "isSensorAvailable") {
                result.success(sensorManager!!.getSensorList(Sensor.TYPE_PRESSURE).isNotEmpty())
            } else {
                result.notImplemented()
            }
        }

        eventChannel = EventChannel(messenger, EVENT_CHANNEL_NAME)
        streamHandler = StreamHandler(sensorManager!!, Sensor.TYPE_PRESSURE)
        eventChannel!!.setStreamHandler(streamHandler)
    }

    private fun teardownChannels() {
        methodChannel!!.setMethodCallHandler(null)
        eventChannel!!.setStreamHandler(null)
    }

}
