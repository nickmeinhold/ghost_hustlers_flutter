package co.enspyr.ghost_hustlers_flutter

import android.content.Intent
import android.os.Bundle
import com.unity3d.player.UnityPlayerActivity
import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    private val CHANNEL = "co.enspyr.ghost_hustlers_flutter/unity"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
            // Note: this method is invoked on the main thread.
            if (call.method == "showUnity") {
                val intent = Intent(this, UnityPlayerActivity::class.java).apply {
//                    putExtra(EXTRA_MESSAGE, message)
                }
                startActivity(intent)
            } else {
                result.notImplemented()
            }
        }
    }
}
