# 📋 NOTCH - Especificación de Funcionalidades

Este documento detalla todas las funcionalidades implementadas y planificadas para **NOTCH**, la aplicación de rastreo de intimidad centrada en la privacidad.

---

## 🛡️ 1. Seguridad y Privacidad (Core)

La seguridad es el pilar fundamental de NOTCH. La aplicación está diseñada para operar bajo un modelo "Offline-First" y "Privacy-First".

*   **Autenticación Biométrica:**
    *   Integración nativa con `local_auth`.
    *   Soporte para FaceID (iOS) y Huella Digital (Android).
    *   Bloqueo inmediato al iniciar la app.
*   **Sistema de Señuelo (Panic Mode / Decoy):**
    *   **PIN Real:** Desencripta y abre la base de datos real.
    *   **PIN Falso (Pánico):** Abre una interfaz simulada ("Lista de Tareas") totalmente funcional pero aburrida, para ocultar el propósito real de la app en situaciones comprometidas.
*   **Almacenamiento Seguro de Credenciales:**
    *   Uso de `flutter_secure_storage` para guardar los PINs en el Keychain (iOS) y Keystore (Android) de forma encriptada.
*   **Persistencia Local:**
    *   Base de datos **Hive** (NoSQL).
    *   Los datos nunca salen del dispositivo (sin servidores ni nube).

---

## 📝 2. Registro de Encuentros (Tracking)

El módulo de registro está diseñado para ser rápido, visual y detallado.

*   **Formulario Inteligente (`flutter_form_builder`):**
    *   Validación de campos obligatorios.
    *   Gestión eficiente del estado sin reconstrucciones innecesarias.
*   **Datos del Encuentro:**
    *   **Pareja:** Campo de texto libre para nombre o alias.
    *   **Fecha y Hora:** Registro automático del momento (editable).
    *   **Contador de Orgasmos:** Botones interactivos (+/-).
    *   **Calificación (Rating):** Slider de precisión del 1.0 al 10.0.
    *   **Estado de Ánimo (Mood):** Selector horizontal de Emojis (🔥, 🥰, 😈, etc.).
    *   **Etiquetas (Tags):** Sistema de selección múltiple (Chips) para contexto (ej. "Oral", "Rápido", "Viaje").
    *   **Salud/Protección:** Switch binario (Safe/Unsafe) para registrar uso de preservativos o PrEP.
*   **Internacionalización (i18n):**
    *   Las etiquetas y textos del sistema se traducen automáticamente entre Inglés (EN) y Español (ES) según el idioma del teléfono.

---

## 📊 3. Análisis y Visualización

Transformación de datos crudos en información visual útil.

*   **Dashboard Principal:**
    *   **Calendario Interactivo:** Vista mensual con marcadores (puntos) en los días con actividad.
    *   **Lista de Tarjetas:** Resumen diario con indicadores visuales de calidad (círculos de colores según rating) e iconos de protección (Escudo verde/rojo).
*   **Pantalla de Estadísticas:**
    *   **Scoreboard:** Tarjetas resumen con Total de Encuentros, Total de Orgasmos y Promedio de Calificación.
    *   **Gráfico de Tendencias:** Gráfico de barras (`fl_chart`) mostrando la actividad de los últimos 6 meses.
    *   **Desglose de Calidad:** Barras de progreso que clasifican los encuentros en: Legendario (9-10), Bueno (7-8), Promedio (5-6) y Malo (1-4).

---

## ✨ 4. Experiencia de Usuario (UX)

Detalles que hacen que la aplicación se sienta "Premium".

*   **Dark Mode Nativo:** Diseño optimizado para pantallas OLED con negros puros y acentos de color neón (Azul, Púrpura, Verde).
*   **Feedback Háptico (Vibración):**
    *   Vibración suave (`selectionClick`) al mover el slider de calificación.
    *   Impacto ligero al pulsar botones de incremento o tags.
    *   Impacto pesado al guardar o desbloquear con éxito.
    *   Vibración de error al introducir PIN incorrecto.
*   **Animaciones:** Transiciones suaves y elementos que aparecen gradualmente (`flutter_animate`).

---

## 🔮 5. Roadmap (Funciones Futuras)

Estas son las características planificadas para futuras versiones, diseñadas para aumentar la retención y utilidad.

### 🏥 Salud (Health Passport)
*   **Log de Pruebas:** Registro de fechas de exámenes de ITS/ETS.
*   **Recordatorios:** Notificaciones locales automáticas sugiriendo chequeos basados en el tiempo transcurrido o número de parejas nuevas.

### 📒 Gestión de Parejas (Black Book / CRM)
*   **Perfiles:** Agrupación de encuentros por nombre de pareja.
*   **Notas Privadas:** Espacio para anotar gustos, disgustos, cumpleaños o datos importantes de cada pareja.
*   **Historial:** Visualización rápida de "¿Cuándo fue la última vez con X?".

### 💣 Seguridad Extrema (Kill Switch)
*   **Código de Autodestrucción:** Un tercer PIN específico (ej. `9999`) que, al ser introducido, elimina permanentemente la caja de Hive y resetea la aplicación a su estado de fábrica.

### 🏆 Gamificación
*   **Sistema de Logros:** Medallas desbloqueables.
    *   *The Sprinter:* 3 encuentros en 24h.
    *   *Safe Player:* Racha de 10 encuentros protegidos.
    *   *Globetrotter:* Encuentros en diferentes ubicaciones (si se implementa GPS).

### ☁️ Gestión de Datos
*   **Backup Encriptado:** Capacidad de exportar toda la base de datos a un archivo JSON encriptado (AES-256) para poder restaurar la información al cambiar de teléfono.
*   **Reportes PDF:** Generación de un resumen visual anual para descarga.




## 🚀 Vision & Roadmap (Futuras Funciones)

Estas son las funcionalidades en desarrollo para convertir a NOTCH en la herramienta definitiva de salud y privacidad masculina:

### 1. El "Panic Mode" (PIN Falso / Decoy System) 🕵️‍♂️
Esta es la función definitiva de privacidad ("Spy-grade privacy").

*   **El Desafío:** En situaciones comprometidas, tu pareja o un tercero podría obligarte a desbloquear la aplicación para ver su contenido.
*   **La Solución:** Implementación de un sistema de doble PIN.
    *   **PIN Real (ej. 1234):** Desencripta la base de datos y abre la app real con tus registros.
    *   **PIN Pánico (ej. 0000):** Abre una **versión falsa** de la app (una "Lista de Tareas" aburrida o una Calculadora funcional).
*   **Valor:** Tranquilidad absoluta. Nadie sabrá nunca si la app contiene datos sensibles o es simplemente una herramienta de productividad.

### 2. Registro de Protección y Pasaporte de Salud 🛡️
Transformamos la app de un simple registro de placer a una herramienta de responsabilidad sexual.

*   **Registro de Encuentro:**
    *   Campo "Protección" con opciones: *Sin protección, Condón, PrEP, Pastilla (Pareja)*.
*   **Gestión de Salud (Health Passport):**
    *   Registro de fechas de pruebas de ITS/ETS.
    *   Almacenamiento privado de resultados.
    *   **Alertas Inteligentes:** Notificaciones locales discretas (ej. "Mantenimiento sugerido") si han pasado más de 6 meses desde el último chequeo.

### 3. Cronómetro y Duración ⏱️
Métricas de rendimiento para usuarios interesados en su resistencia ("Stamina").

*   **Opción A (Manual):** Un campo numérico en el formulario para ingresar la duración estimada en minutos.
*   **Opción B (En Vivo):** Un cronómetro integrado que se inicia al comenzar el acto y se detiene al finalizar.
*   **Análisis:** Visualización en estadísticas de la "Duración Promedio" y correlación con el uso de ciertos productos o técnicas.

### 4. Feedback Háptico (Experiencia Táctil) 📳
Mejora la percepción de calidad de la app mediante respuestas físicas.

*   **Interacción:** Uso de la librería nativa de Flutter (`HapticFeedback`).
*   **Momentos Clave:**
    *   Vibración sutil (`selectionClick`) al deslizar el Slider de calificación (1-10).
    *   Impacto ligero al seleccionar etiquetas.
    *   Vibración de confirmación satisfactoria (`heavyImpact`) al guardar una "Muesca".

### 5. Exportación y Respaldo de Datos 📄
Garantiza que el historial no se pierda al cambiar de dispositivo.

*   **Backup Encriptado:** Generación de un archivo JSON encriptado (AES-256) que el usuario puede guardar en su nube personal (Google Drive/iCloud) para restaurar en otro teléfono.
*   **Reportes PDF:** Generación de un documento visual con gráficas y estadísticas anuales (potencial funcionalidad "Premium").

### 6. 🏥 The "Health Passport" (Pasaporte de Salud)
Convierte la app en una herramienta de salud responsable, no solo de placer.
*   **Funcionalidad:** Pantalla dedicada para el registro de pruebas de ITS/ETS.
    *   Fecha de última prueba y almacenamiento privado de resultados.
    *   **Recordatorios Inteligentes:** Notificaciones locales automáticas (ej: "Han pasado 6 meses, hora de un chequeo").
*   **Implementación Técnica:** Nueva Hive Box `health_logs` y uso de `flutter_local_notifications`.

### 7. 📒 "Black Book" (Gestión de Parejas / CRM)
Gestión detallada para usuarios con múltiples parejas o citas esporádicas.
*   **Funcionalidad:** Perfil único para cada pareja vinculado a los registros existentes.
    *   **Notas Privadas:** Espacio para anotar gustos, disgustos, cumpleaños ("Le gusta el vino tinto", "No le gusta X cosa").
    *   **Historial:** Visualización rápida de "¿Cuándo fue la última vez con esta persona?".
*   **Implementación Técnica:** Algoritmo de filtrado de parejas únicas extraídas de `encounters` y vistas dinámicas.

### 8. 📈 Insights Avanzados (Correlaciones)
Data Science aplicado a tu vida íntima para responder preguntas curiosas.
*   **Funcionalidad:** Algoritmos que analizan patrones y muestran datos como:
    *   "Tus mejores calificaciones (9-10) suelen ser los Sábados."
    *   "Usas protección el 85% de las veces."
    *   "Tu tag más frecuente es 'Mañanero'."
    *   "Promedio de orgasmos con [Nombre]: 2.5".
*   **Valor:** Datos concretos sobre rendimiento y preferencias.

### 9. 🏆 Gamificación y Logros
Hacer que el uso de la app sea divertido y motivante.
*   **Funcionalidad:** Desbloqueo de insignias visuales (Trofeos) al cumplir condiciones.
    *   🥇 **The Sprinter:** 3 encuentros en 24 horas.
    *   🛡️ **The Safe Player:** 10 encuentros seguidos usando protección.
    *   🌍 **Globetrotter:** Encuentros en 3 ciudades distintas (requiere geolocalización futura).
    *   🦄 **Legend:** Conseguir una calificación perfecta de 10/10.
*   **Implementación Técnica:** Sistema de "Listeners" que verifica condiciones al guardar un nuevo registro.

### 10. 💣 "Kill Switch" (Botón de Autodestrucción)
La característica definitiva para la paz mental.
*   **Funcionalidad:** Configuración de un tercer PIN específico (ej. `9999`).
*   **El Efecto:** Si se introduce ese código en la pantalla de bloqueo, la app **borra inmediatamente toda la base de datos local** y se resetea a fábrica sin pedir confirmación.
*   **Valor:** Seguridad absoluta en situaciones extremas. "Si me veo acorralado, pulso el botón rojo y todo desaparece".


```sh
keytool -genkey -v -keystore ~/Developer/certs/notch-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias notch -storepass ackKN4H8h0p641LnABkyQ6S2spV5QEqy -keypass ackKN4H8h0p641LnABkyQ6S2spV5QEqy
```
