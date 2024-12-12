import io.flutter.app.FlutterApplication
import com.google.firebase.auth.FirebaseAuth

class MyApplication : FlutterApplication() {
    override fun onCreate() {
        super.onCreate()
        FirebaseAuth.getInstance().apply {
            languageCode = "ja"
            settings.forceRecaptchaFlowForTesting(false)
        }
    }
}
