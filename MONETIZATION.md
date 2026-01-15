# 💰 Modelo de Monetización: NOTCH y NOTCH Premium

Este documento describe la estrategia de monetización para la aplicación NOTCH, separando las funcionalidades en un nivel gratuito (Core) y un nivel de pago (Premium).

**Filosofía:** La funcionalidad básica de registro es gratuita para enganchar al usuario y demostrar el valor principal de la app. Las herramientas de poder, seguridad avanzada y personalización son Premium.

---

## ✅ Versión Gratuita (Core)
El objetivo de la versión gratuita es que el usuario genere un historial de datos valioso y se acostumbre a la app, creando una necesidad por las funciones avanzadas.

### Funcionalidades Gratuitas:

*   **📝 Registro Ilimitado de Encuentros:**
    *   Registrar Pareja, Calificación, Orgasmos y Tags.
    *   Este es el núcleo de la app y debe ser ilimitado.

*   **🔒 Seguridad Básica:**
    *   Bloqueo por PIN y Biometría (FaceID/Huella).
    *   Bloqueo automático al minimizar la aplicación.

*   **📅 Calendario Visual:**
    *   Vista de mes con marcadores en los días de actividad.
    *   Lista de encuentros del día seleccionado.

*   **📊 Estadísticas Básicas (Limitadas):**
    *   **Scoreboard:** Total de encuentros y promedio de calificación.
    *   **Limitación Sugerida:** El gráfico de tendencias podría mostrar solo los últimos 3 meses en lugar del historial completo.

---

## 💎 NOTCH Premium (Suscripción o Pago Único)
Aquí se encuentran las "joyas de la corona", las funciones que un usuario avanzado o preocupado por la privacidad ("power user") estará dispuesto a pagar.

### Funcionalidades Premium:

*   **🕵️‍♂️ Seguridad Avanzada (El "Paquete Paranoia"):**
    *   **Modo Pánico (PIN Falso):** Habilidad de abrir una app señuelo funcional (lista de tareas). Este es el principal argumento de venta Premium.
    *   **Kill Switch (PIN de Autodestrucción):** La tranquilidad de poder borrar todos los datos en una emergencia.

*   **📄 Backup y Restauración de Datos:**
    *   **Copia de Seguridad Encriptada:** Capacidad de no perder el historial al cambiar de teléfono.
    *   **Restauración de Datos:** Importar el backup en un nuevo dispositivo.

*   **📒 Black Book (CRM Avanzado):**
    *   **Perfiles con Fotos y Emojis:** Personalización visual completa del CRM.
    *   **Notas Privadas:** Guardar detalles específicos de cada pareja.
    *   *Limitación Opcional:* La versión gratuita podría mostrar la lista de nombres, pero al hacer clic, solicitaría la versión Premium para ver el perfil detallado.

*   **📈 Insights Avanzados y Reportes:**
    *   **Pantalla de Insights:** Acceso a todas las correlaciones ("Tu mejor día es el Sábado", "Tu tag más frecuente...").
    *   **Exportación de Reportes PDF:** Generar un resumen anual visual de la actividad.

*   **🏥 Health Passport (Pasaporte de Salud):**
    *   **Registro de Pruebas Médicas:** Historial de chequeos de ITS/ETS.
    *   **Recordatorios Automáticos:** Notificación programada para el siguiente chequeo.

*   **🏆 Gamificación Completa:**
    *   **Historial de Temporadas:** Acceso a los rangos y medallas de meses anteriores.
    *   **Compartir Tarjeta de Nivel:** Generación y compartición de la imagen de rango en redes sociales.

---

## 💡 Estrategia de Monetización Sugerida

*   **Suscripción (Recomendado):**
    *   **Modelo:** "NOTCH Pro" con planes mensuales o anuales.
    *   **Ventaja:** Genera ingresos recurrentes y predecibles.
    *   **Precio Sugerido:** Un precio bajo (ej. 1-2 USD/mes) puede ser muy atractivo y tener una alta tasa de conversión.

*   **Pago Único ("Lifetime"):**
    *   **Modelo:** "Desbloquea todo para siempre".
    *   **Ventaja:** Atrae a usuarios que odian las suscripciones.

### Implementación Técnica

Se utilizaría un paquete como `in_app_purchase` para manejar las transacciones con las tiendas de Apple y Google. La lógica de la aplicación se basaría en una variable de estado del usuario.

**Ejemplo en Dart:**
```dart
// Servicio que gestiona el estado de la suscripción
bool isUserPremium = await PurchaseService.isSubscribed();

// En la UI, se muestra contenido condicionalmente:
if (isUserPremium) {
  // Muestra el botón para acceder a Insights
  InsightsButton();
} else {
  // Muestra un botón que lleva a la pantalla de pago
  UpgradeToPremiumButton();
}
```
