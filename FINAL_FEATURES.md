# ✅ NOTCH - Lista Completa de Funcionalidades

Este documento detalla todas las características implementadas en la aplicación NOTCH, un rastreador de intimidad centrado en la privacidad, la gamificación y el autoconocimiento.

---

## 🛡️ 1. Seguridad y Privacidad (Nivel Élite)

La privacidad no es una opción, es el núcleo de NOTCH.

*   **Bloqueo por Defecto:** Acceso a la app protegido mediante **PIN** o **Biometría** (FaceID/Huella Digital).
*   **Bloqueo Automático:** La aplicación se bloquea instantáneamente al pasar a segundo plano, apagar la pantalla o cambiar de app.
*   **Pantalla Segura:**
    *   **Android:** Bloquea la toma de capturas de pantalla y la grabación de la pantalla. La vista previa en "apps recientes" aparece en blanco.
    *   **iOS:** Oculta el contenido de la aplicación en el selector de apps con una pantalla de privacidad.
*   **🕵️‍♂️ Modo Pánico (PIN Falso):**
    *   Permite configurar un PIN secundario que abre una **app señuelo totalmente funcional** (una lista de tareas) para proteger la privacidad en situaciones comprometidas. Los datos de la app falsa se guardan en una base de datos separada.
*   **💣 Kill Switch (PIN de Autodestrucción):**
    *   Un tercer PIN opcional que, al ser introducido, **borra permanentemente todos los datos** de la aplicación (encuentros, perfiles, salud, etc.) y la resetea a su estado de fábrica.

---

## 📝 2. Registro y Seguimiento Detallado

El núcleo de la app, diseñado para ser rápido e intuitivo.

*   **Registro de Encuentros:**
    *   Nombre de la pareja.
    *   Calificación del encuentro (1-10).
    *   Contador de orgasmos.
    *   **Etiquetas (Tags):** Para dar contexto (ej. "Mañanero", "Viaje", "Cita").
    *   **Estado de Ánimo (Mood):** Selección de un emoji para el encuentro.
    *   **Protección:** Switch para registrar si se usó protección.
*   **Almacenamiento Local:** Todos los datos se guardan en el dispositivo usando la base de datos **Hive**, garantizando que la información nunca salga del teléfono.

---

## 🏆 3. Gamificación y Progreso

Un sistema completo para motivar al usuario a través del juego y la superación personal.

*   **Sistema de Temporadas Mensuales:** El progreso de XP y medallas se reinicia cada mes, creando un ciclo de competencia y nuevos objetivos.
*   **XP y Niveles ("El Camino del Maestro"):**
    *   Cada encuentro otorga Puntos de Experiencia (XP) basados en la calidad y otros factores.
    *   Progresión a través de **18 rangos temáticos** (ej. "Iniciado", "Practicante", "Adepto", "Virtuoso", "Maestro", "Leyenda").
*   **🗺️ Camino de Maestría Visual:**
    *   Una pantalla dedicada que muestra el progreso a través de los niveles en un mapa visual interactivo, similar a un juego.
    *   La línea del camino se "llena" con color a medida que se gana XP.
    *   El siguiente nivel a alcanzar tiene una animación de "pulso" para indicar el objetivo.
*   **🏅 Logros y Medallas:**
    *   Una colección de **más de 15 insignias** que se desbloquean al cumplir condiciones específicas (ej. "Legendario", "Sprinter", "Jugador Seguro", "Maratonista").
*   **🔥 Sistema de Rachas (Streaks):**
    *   Una sección dedicada que muestra:
        *   **Racha Actual:** Días consecutivos con actividad.
        *   **Récord del Mes:** La mejor racha conseguida en la temporada actual.
        *   **Récord Histórico:** La mejor racha de todos los tiempos.
    *   **Hitos de Rachas:** El sistema propone el "próximo hito" a alcanzar (ej. 5, 7, 10 días) con una barra de progreso.
*   **🖼️ Tarjeta para Compartir:**
    *   Funcionalidad para generar una imagen personalizada y estilizada con el rango y estadísticas del mes para compartir en redes sociales.

---

## 📊 4. Análisis y Estadísticas Avanzadas

Herramientas para que el usuario entienda sus propios datos.

*   **Dashboard Principal:**
    *   **Calendario con Vista Dual:** Selector para ver la actividad por **semana** (vista por defecto) o por **mes**.
*   **Pantalla de Estadísticas:**
    *   **Filtros de Tiempo:** Permite visualizar datos de los "Últimos 30 días", "6 Meses" o "Historial Completo".
    *   **Heatmap Calendar:** Un mapa de calor anual que muestra la intensidad de la actividad a lo largo de los días.
    *   **Gráfico Circular de Tags:** Muestra la distribución porcentual de los tipos de encuentro.
*   **🧠 Pantalla de Insights (Inteligencia de Datos):**
    *   La app analiza los datos y genera conclusiones personalizadas como:
        *   Correlaciones ("Tus encuentros con 'Cita' tienen un 15% más de calificación").
        *   Tendencias ("Tu frecuencia ha aumentado un 20% este mes").
        *   Rachas de Calidad ("Llevas 3 encuentros seguidos con calificación 8+").
        *   Análisis de Parejas ("Tu mejor química es con [Nombre]").

---

## 📒 5. CRM: "Black Book"

Una gestión de contactos íntimos visual y funcional.

*   **Generación Automática:** La lista de parejas se crea a partir de los nombres registrados en los encuentros.
*   **Perfiles Detallados:** Cada pareja tiene su propio perfil que incluye:
    *   **Avatar Personalizable:** Se puede elegir entre un **avatar de inicial con color aleatorio**, una **foto de la galería** o un **emoji**.
    *   **Notas Privadas:** Espacio para guardar información relevante (gustos, fechas, etc.).
    *   **Historial Completo:** Lista de todos los encuentros registrados con esa persona.

---

## 🏥 6. Salud y Bienestar

Funciones que posicionan a NOTCH como una herramienta de salud sexual responsable.

*   **Health Passport:**
    *   Pantalla para registrar fechas y resultados de pruebas de ITS/ETS.
    *   **Recordatorios Automáticos:** La app puede programar una notificación local para recordar al usuario hacerse un chequeo después de 6 meses.

---

## ⚙️ 7. Gestión de Datos y Ajustes

Herramientas de control para el usuario.

*   **Backup y Restauración:**
    *   **Exportación:** Crea un **archivo de backup encriptado (AES)** que el usuario puede guardar en su nube personal.
    *   **Importación:** Restaura todos los datos desde un archivo de backup, ideal para cambiar de teléfono.
*   **Exportación de Reportes PDF:** Genera un documento PDF con un resumen visual de las estadísticas.
*   **Pantalla de Ajustes Completa:**
    *   Información de la app y versión.
    *   Contacto del desarrollador.
    *   Accesos directos a la configuración de Seguridad y Datos.
    *   **Restablecer App:** Opción para borrar todos los datos de forma segura desde los ajustes (con confirmación).

---

## ✨ 8. Experiencia de Usuario (UI/UX)

Detalles que hacen que la app se sienta fluida y premium.

*   **Tema Oscuro Nativo:** Interfaz optimizada para pantallas OLED.
*   **Navegación Intuitiva:** Barra de navegación inferior para un acceso rápido a las secciones principales.
*   **Feedback Háptico:** Uso de vibraciones para mejorar la sensación táctil al interactuar con la app.
*   **Orientación Vertical Fija:** La app está bloqueada en modo vertical para una experiencia consistente.
