# NOTCH 🔒
### Private Intimacy Tracker | Rastreador de Intimidad

![Flutter](https://img.shields.io/badge/Flutter-3.0%2B-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.0%2B-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Hive](https://img.shields.io/badge/Hive-NoSQL-FFA000?style=for-the-badge&logo=firebase&logoColor=white)
![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20Android-lightgrey?style=for-the-badge)

**NOTCH** es una aplicación móvil desarrollada en Flutter diseñada para el registro privado y seguro de la actividad sexual (Quantified Self). 

El objetivo es ofrecer una herramienta discreta, con una interfaz "Dark Mode" elegante y masculina, donde la **privacidad es la prioridad absoluta**. Los datos nunca salen del dispositivo.

---

## 📱 Capturas de Pantalla (Screenshots)

| Autenticación | Calendario (Home) | Nueva Muesca | Estadísticas |
|:---:|:---:|:---:|:---:|
| <img src="assets/screenshots/auth.png" width="200"/> | <img src="assets/screenshots/home.png" width="200"/> | <img src="assets/screenshots/add.png" width="200"/> | <img src="assets/screenshots/stats.png" width="200"/> |

*(Nota: Reemplaza estas rutas con tus imágenes reales en la carpeta assets)*

---

## ✨ Características Principales

### 🔒 Privacidad y Seguridad Extrema
*   **Biometría:** Acceso rápido mediante FaceID o Huella Digital.
*   **🕵️‍♂️ Modo Pánico (Decoy System):** Configura dos PINs.
    *   **PIN Real:** Abre NOTCH y tus datos privados.
    *   **PIN Pánico:** Abre una **interfaz falsa** totalmente funcional (una lista de tareas aburrida). Ideal para situaciones comprometidas donde te ves obligado a desbloquear la app.

### 📝 Registro Detallado
*   **Datos Clave:** Nombre de pareja, fecha, notas y contador de orgasmos.
*   **🛡️ Salud Sexual:** Registro de uso de protección (Safe/Unsafe) con indicadores visuales.
*   **🏷️ Tags Inteligentes:** Etiquetas (Oral, Kinky, Viaje...) con traducción automática Inglés/Español.
*   **😎 Mood Tracker:** Selección de emojis para registrar el estado de ánimo.
*   **⭐ Gamificación:** Sistema de calificación (1-10) con feedback visual por colores.

### 📊 Análisis
*   **Calendario Interactivo:** Visualización de actividad mensual.
*   **Estadísticas:** Gráficos de barras (`fl_chart`) para analizar rendimiento y preferencias.

---

## 🛠️ Stack Tecnológico

*   **Core:** [Flutter](https://flutter.dev/) & Dart.
*   **Base de Datos:** [Hive](https://docs.hivedb.dev/) (NoSQL local de alto rendimiento).
*   **Seguridad:** 
    *   `local_auth` (Biometría).
    *   `flutter_secure_storage` (Encriptación de PINs en Keychain/Keystore).
*   **UI/UX:** 
    *   `flutter_form_builder` (Formularios avanzados).
    *   `fl_chart` (Gráficos).
    *   `table_calendar`.
*   **Utils:** `intl`, `uuid`, `google_fonts`.

---

## 🚀 Instalación y Configuración

Sigue estos pasos para correr el proyecto en tu máquina local:

1.  **Clonar el repositorio:**
    ```bash
    git clone https://github.com/tu-usuario/notch_app.git
    cd notch_app
    ```

2.  **Instalar dependencias:**
    ```bash
    flutter pub get
    ```

3.  **Generar adaptadores de Hive:**
    Como usamos Hive con generación de código para los modelos, es necesario ejecutar:
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```

4.  **Ejecutar la App:**
    ```bash
    flutter run
    ```

---

## 📂 Estructura del Proyecto

```text
lib/
├── main.dart             # Punto de entrada y configuración de Hive
├── core/                 # Configuraciones globales
├── models/
│   ├── encounter.dart    # Modelo de datos (Hive Object)
│   └── encounter.g.dart  # Adaptador generado automáticamente
├── screens/
│   ├── auth_screen.dart      # Pantalla de bloqueo biométrico
│   ├── home_screen.dart      # Dashboard y Calendario
│   ├── add_entry_screen.dart # Formulario de registro
│   └── stats_screen.dart     # Gráficas y reportes
└── utils/
    └── translations.dart     # Gestión de textos ES/EN
```

---

## 🎨 Gestión de Assets (Iconos & Splash)

Este proyecto utiliza generadores automáticos para manejar los iconos de la app y la pantalla de carga (Splash Screen) nativa, evitando la configuración manual en Android/iOS.

### Configuración
El archivo `pubspec.yaml` contiene las configuraciones bajo `flutter_launcher_icons` y `flutter_native_splash`.
*   **Imagen fuente:** `assets/icon.png` (Recomendado 1024x1024px).
*   **Color de fondo:** `#121212` (Dark Mode).

### Comandos de Generación
Si cambias el archivo `assets/icon.png`, ejecuta estos comandos para actualizar todos los recursos nativos:

```bash
# 1. Generar iconos para Android e iOS
dart run flutter_launcher_icons

# 2. Generar Splash Screen nativo (Pantalla de carga)
dart run flutter_native_splash:create
```
---

## 🆔 Identificación de la App

Para cambiar el nombre visible o el identificador único (Bundle ID) sin editar archivos nativos manualmente, usamos la herramienta global `rename`.

### Comandos de Configuración

```bash
# 1. Instalar herramienta (solo una vez)
flutter pub global activate rename

# 2. Cambiar Nombre Visible (Debajo del icono)
rename setAppName --targets ios,android --value "NOTCH"

# 3. Cambiar Bundle ID (Identificador único en Tiendas)
# Formato recomendado: com.tuorganizacion.notch
rename setBundleId --targets ios,android --value "com.tudominio.notch"
```


## 🔮 Roadmap & Funciones a Futuro

Nuestra visión es convertir NOTCH en el estándar de privacidad y salud masculina.

### ✅ Completado
- [x] **Core:** Base de datos local y estructura segura.
- [x] **Modo Pánico:** Interfaz de señuelo (Decoy) con PIN falso.
- [x] **Salud Sexual:** Registro de protección (Safe/Unsafe).
- [x] **UX Premium:** Feedback háptico en sliders y botones.
- [x] **Internacionalización:** Tags y textos en ES/EN.

### 🚧 En Desarrollo / Futuras Versiones
- [ ] **🏥 Health Passport:**
    - Registro de fechas de pruebas ITS/ETS.
    - Recordatorios automáticos para chequeos periódicos.
- [ ] **📒 Black Book (CRM de Parejas):**
    - Perfiles individuales por pareja.
    - Notas privadas (gustos, cumpleaños, historial).
- [ ] **💣 Kill Switch (Autodestrucción):**
    - Un tercer código de seguridad que, al introducirse, borra permanentemente toda la base de datos local y resetea la app.
- [ ] **🏆 Gamificación y Logros:**
    - Medallas desbloqueables (ej. "The Sprinter", "Safe Player", "Legend").
- [ ] **📈 Insights Avanzados:**
    - Algoritmos de correlación (ej. "¿Qué día de la semana tienes mejores calificaciones?").
- [ ] **☁️ Backup Encriptado:**
    - Exportación de datos a archivo AES/JSON para migración de dispositivo.

---

## ⚠️ Aviso de Privacidad

NOTCH está diseñada bajo el principio de **Privacidad Local**.
*   Todos los datos residen en el almacenamiento interno de tu teléfono.
*   Si eliminas la aplicación sin hacer un respaldo manual (futura función), los datos se perderán.
*   **No hay servidores.** Tus datos son tuyos y de nadie más.

---

## 🤝 Contribución

Las contribuciones son bienvenidas.

1.  Haz un Fork del proyecto.
2.  Crea tu rama (`git checkout -b feature/AmazingFeature`).
3.  Haz Commit de tus cambios (`git commit -m 'Add some AmazingFeature'`).
4.  Haz Push a la rama (`git push origin feature/AmazingFeature`).
5.  Abre un Pull Request.

---

**Desarrollado con ❤️ y privacidad.**
