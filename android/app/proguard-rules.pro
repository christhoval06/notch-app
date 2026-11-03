#################################
# Reglas por defecto de Flutter #
#################################
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.embedding.**  { *; }

################################
# Reglas para Librerías Usadas #
################################

# flutter_local_notifications
-keep class com.dexterous.flutterlocalnotifications.** { *; }

# flutter_secure_storage
-keep class io.flutter.plugins.flutter_secure_storage.** { *; }

# url_launcher
-keep class io.flutter.plugins.urllauncher.** { *; }

# share_plus
-keep class dev.fluttercommunity.plus.share.** { *; }
-keep class androidx.core.content.FileProvider { *; }

# package_info_plus
-keep class dev.fluttercommunity.plus.packageinfo.** { *; }

# printing & pdf
-keep class net.nfet.printing.** { *; }

# file_picker
-keep class com.mr.flutter.plugin.filepicker.** { *; }

# encrypt (Usa APIs de seguridad de Java)
-keep class java.security.** { *; }
-keep class javax.crypto.** { *; }

# Flutter embedding still references legacy Play Core task types for deferred
# components, but this app does not use deferred components at runtime.
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task

# Kotlin Coroutines (Muchas librerías modernas la usan por debajo)
-keep class kotlinx.coroutines.** { *; }
-keepclassmembers class ** {
    @kotlin.jvm.JvmField ** f;
    @kotlin.jvm.JvmStatic ** m(...);
}
