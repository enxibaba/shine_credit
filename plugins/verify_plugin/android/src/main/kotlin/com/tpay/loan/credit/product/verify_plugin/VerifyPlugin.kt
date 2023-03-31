package com.tpay.loan.credit.product.verify_plugin

import android.app.Activity
import android.app.Activity.RESULT_OK
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.util.Log
import androidx.annotation.NonNull
import com.liveness.dflivenesslibrary.DFTransferResultInterface
import com.liveness.dflivenesslibrary.liveness.DFSilentLivenessActivity
import com.liveness.dflivenesslibrary.net.DFNetworkUtil

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import java.io.File
import java.io.FileOutputStream

/** VerifyPlugin */
class VerifyPlugin : FlutterPlugin, MethodCallHandler, ActivityAware,
    PluginRegistry.ActivityResultListener {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    var activity: Activity? = null
    val TAG = "VerifyPlugin:"
    val detectionRequestCode = 101
    val HOST_URL = "https://cloudapi.accuauth.com/"

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "verify_plugin")
        channel.setMethodCallHandler(this)
    }


    var isAntiHack: Boolean = false
    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "launchDetection") {
            activity?.also {
                isAntiHack = call.argument<Boolean>("antiHack") ?: false
                launchDetection(it)
                result.success("1")
            } ?: kotlin.run {
                result.error("-1", "activity is null", null)
            }

        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }


    private fun launchDetection(activity: Activity) {
        Log.d(TAG, "launchDetection: ")
        activity.startActivityForResult(
            Intent(
                activity,
                DFSilentLivenessActivity::class.java
            ).also {
                it.putExtra(DFSilentLivenessActivity.KEY_HOST_URL, HOST_URL)
                it.putExtra(DFSilentLivenessActivity.KEY_ANTI_HACK, isAntiHack)
                it.putExtra(DFSilentLivenessActivity.KEY_DETECT_IMAGE_RESULT, true)
                it.putExtra(DFSilentLivenessActivity.KEY_SHOW_DECLARATION, false)
            }, detectionRequestCode
        )
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        binding.addActivityResultListener(this)
        activity = binding.activity
        Log.d(TAG, "onAttachedToActivity: ")
    }

    override fun onDetachedFromActivityForConfigChanges() {
        Log.d(TAG, "onDetachedFromActivityForConfigChanges: ")
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        Log.d(TAG, "onReattachedToActivityForConfigChanges: ")
    }

    override fun onDetachedFromActivity() {
        Log.d(TAG, "onDetachedFromActivity: ")
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        Log.d(TAG, "onActivityResult: ")
        if (resultCode == RESULT_OK&&requestCode==detectionRequestCode) {
            val app = activity?.application
            if (app is DFTransferResultInterface) {
                val result = app.result
                val map: HashMap<String, Any> = hashMapOf()
                map["status"] = 1
                val livenessImageResults = result.livenessImageResults
                if (livenessImageResults != null && livenessImageResults.isNotEmpty()) {
                    val dfLivenessImageResult = livenessImageResults[0]
                    val decodeByteArray = BitmapFactory.decodeByteArray(
                        dfLivenessImageResult.image,
                        0,
                        dfLivenessImageResult.image.size
                    )
                    val cacheDir = app.cacheDir
                    val file = File(cacheDir, "detection-${System.currentTimeMillis()}.png")
                    val fileOutputStream = FileOutputStream(file)
                    val compress = decodeByteArray.compress(
                        Bitmap.CompressFormat.PNG,
                        100,
                        fileOutputStream
                    )
                    fileOutputStream.flush()
                    fileOutputStream.close()
                    map["file"] = file.absolutePath
                }

                if (isAntiHack) {
                    val doAntiHack = DFNetworkUtil.doAntiHack(result.livenessEncryptResult)
                    doAntiHack.mNetworkResultStatus
                    map["detectionStatus"] = doAntiHack.mNetworkResultStatus
                } else {
                    map["encryptResult"] = result.livenessEncryptResult
                }
                Log.d(TAG, "onActivityResult: map=${map}")
                channel.invokeMethod("detectionResult", map, null)
            } else {
                val map: HashMap<String, Any> = hashMapOf()
                map["status"] = -1
                channel.invokeMethod("detectionResult", map, null)
                Log.d(TAG, "the application is not DFTransferResultInterface")
            }
        }
        return false
    }
}
