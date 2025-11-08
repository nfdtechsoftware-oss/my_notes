package com.nfdtech.mynotes.my_notes

import android.os.Bundle
import androidx.core.view.WindowCompat
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        // Enable edge-to-edge display for Android 15+ compatibility
        // This resolves deprecated API warnings for setStatusBarColor, setNavigationBarColor, etc.
        WindowCompat.setDecorFitsSystemWindows(window, false)

        super.onCreate(savedInstanceState)
    }
}
