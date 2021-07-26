package com.example.batterylevel

import android.os.Handler
import io.flutter.plugin.common.EventChannel

class RandomNumberStreamHandler : EventChannel.StreamHandler {
    private var sink: EventChannel.EventSink? = null
    private var handler: Handler? = null

    private val runnable = Runnable {
        sendNewRandomNumber()
    }

    private fun sendNewRandomNumber() {
        val randomNumber = (1..6).random()
        sink?.success(randomNumber)
        handler?.postDelayed(runnable, 1000)
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        sink = events
        handler = Handler()
        handler?.post(runnable)
    }

    override fun onCancel(arguments: Any?) {
        sink = null
        handler?.removeCallbacks(runnable)
    }
}