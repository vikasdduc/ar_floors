package com.example.insta_clone

import kotlin.random.Random
import androidx.annotation.NonNull
import android.os.Bundle
import android.content.res.Configuration
import android.content.pm.ActivityInfo
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.EventChannel.StreamHandler


class MainActivity: FlutterActivity() {

    var events: EventSink? = null
    var oldConfig: Configuration? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        oldConfig = Configuration(getContext().getResources().getConfiguration())
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, "example.com/channel").setStreamHandler(
            object: StreamHandler {
                override fun onListen(arguments: Any?, es: EventSink) {
                    events = es
                    events?.success(isDarkMode(oldConfig))
                }
                override fun onCancel(arguments: Any?) {
                }
            }
        );
    }

    override fun onConfigurationChanged(newConfig: Configuration) {
        super.onConfigurationChanged(newConfig)
        if(isDarkModeConfigUpdated(newConfig)) {
            events?.success(isDarkMode(newConfig))
        }
        oldConfig = Configuration(newConfig)
    }

    fun isDarkModeConfigUpdated(config: Configuration): Boolean {
        return (config.diff(oldConfig) and ActivityInfo.CONFIG_UI_MODE) != 0
                && isDarkMode(config) != isDarkMode(oldConfig);
    }

    fun isDarkMode(config: Configuration?): Boolean {
        return config!!.uiMode and Configuration.UI_MODE_NIGHT_MASK == Configuration.UI_MODE_NIGHT_YES
    }
    //...
    // Build texture sampler
//    Texture.Sampler sampler = Texture.Sampler.builder()
//    .setMinFilter(Texture.Sampler.MinFilter.LINEAR)
//    .setMagFilter(Texture.Sampler.MagFilter.LINEAR)
//    .setWrapMode(Texture.Sampler.WrapMode.REPEAT).build();
//
//    // Build texture with sampler
//    CompletableFuture<Texture> trigrid = Texture.builder()
//    .setSource(this, R.drawable.trigrid_0)
//    .setSampler(sampler).build();
//
//    // Set plane texture
//    this.sceneformFragment.getArSceneView()
//    .getPlaneRenderer()
//    .getMaterial()
//    .thenAcceptBoth(trigrid, (material, texture) -> {
//        material.setTexture(PlaneRenderer.MATERIAL_TEXTURE, texture);
//    });
    //...
//    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "example.com/channel").setMethodCallHandler {
//                call, result ->
//            if(call.method == "getRandomNumber") {
//                val rand = Random.nextInt(100)
//                result.success(rand)
//            }
//            if(call.method == "getRandomString") {
//                val limit = call.argument("len") ?: 4
//                val prefix = call.argument("prefix") ?: ""
//                val rando = ('a'..'z').shuffled().take(limit).joinToString(prefix = prefix,separator = "")
//                result.success(rando)
//            }
//            if(call.method == "isDarkMode") {
//                val mode = getContext()
//                    .getResources()
//                    .getConfiguration().uiMode and Configuration.UI_MODE_NIGHT_MASK
//                result.success(mode == Configuration.UI_MODE_NIGHT_YES)
//            }
//            else {
//                result.notImplemented()
//            }
//        }
//    }
}
