# Pokémon App - Prueba Técnica Bodytech

Aplicación móvil desarrollada en Flutter que implementa un sistema completo de autenticación con Firebase, consumo de API REST (PokéAPI), persistencia local con Hive y gestión de estado con GetX.

##  Características

-  **Autenticación con Firebase**
  - Registro de usuarios con email y contraseña
  - Inicio de sesión
  - Cierre de sesión
  - Persistencia de sesión con Hive
  - Validación de formularios

-  **Consumo de API REST**
  - Integración con PokéAPI
  - Lista de 151 Pokémon de primera generación
  - Detalles completos de cada Pokémon
  - Búsqueda de Pokémon por nombre

-  **Persistencia Local con Hive**
  - Almacenamiento de datos de Pokémon
  - Almacenamiento de sesión de usuario
  - Modo offline funcional
  - Evita duplicación de datos

-  **Gestión de Estado con GetX**
  - Controllers para lógica de negocio
  - Navegación declarativa
  - Estados reactivos (loading, error, data)

##  Pantallas

1. **Login**: Autenticación de usuarios
2. **Registro**: Creación de nuevas cuentas
3. **Home**: Lista de Pokémon con búsqueda
4. **Detalle**: Información completa del Pokémon

##  Arquitectura

El proyecto sigue una arquitectura limpia y escalable:

```
lib/
├── core/
│   ├── constants/      # Constantes de la app
│   ├── routes/         # Rutas con GetX
│   ├── theme/          # Tema de la aplicación
│   
├── data/
│   ├── models/         # Modelos de datos con Hive
│   └── repositories/   # Repositorios para acceso a datos
├── presentation/
│   ├── controllers/    # Controllers de GetX
│   ├── pages/          # Páginas de la UI
│   └── widgets/        # Widgets reutilizables
└── services/          # Servicios (Auth, etc.)
```

##  Instalación y Configuración

### Requisitos Previos

- Flutter 3.x o superior
- Dart SDK
- Android Studio o VS Code
- Cuenta de Firebase

### Paso 1: Clonar el Repositorio

```bash
git https://github.com/Leonardocajassdev/Poke-app.git
cd pokemon_app_bodytech
```

### Paso 3: Instalar Dependencias

```bash
flutter pub get
```

### Paso 3: Configurar Firebase

1. **Crear proyecto en Firebase Console**
   - Ve a [Firebase Console](https://console.firebase.google.com/)
   - Crea un nuevo proyecto o usa uno existente
   - Habilita **Authentication** → **Email/Password**

2. **Configurar Android**
   - En Firebase Console, añade una app Android
   - Package name: `com.bodytech.pokemon_app_bodytech`
   - Descarga `google-services.json`
   - Colócalo en `android/app/`

4. **Instalar FlutterFire CLI** (Recomendado)
   ```bash
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```

### Paso 4: Generar Código Hive

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Paso 5: Ejecutar la Aplicación

```bash
flutter run
```

## Dependencias Principales

```yaml
dependencies:
  get: ^4.6.6                      # State management & Navigation
  firebase_core: ^2.24.2           # Firebase core
  firebase_auth: ^4.16.0           # Firebase authentication
  hive: ^2.2.3                     # Local database
  hive_flutter: ^1.1.0             # Hive Flutter adapter
  dio: ^5.4.0                      # HTTP client
  connectivity_plus: ^5.0.2        # Network connectivity
  cached_network_image: ^3.3.1     # Image caching
```

## Funcionalidades Implementadas

### Autenticación

- **Registro**: Validación de email y contraseña (mínimo 6 caracteres)
- **Login**: Autenticación con Firebase Auth
- **Persistencia**: La sesión se guarda localmente con Hive
- **Auto-login**: Si ya hay sesión, entra directamente a Home

### Pantalla Principal

- **Lista de Pokémon**: Grid view con 151 Pokémon
- **Búsqueda**: Filtrado en tiempo real
- **Modo Offline**: Muestra datos guardados sin conexión
- **Pull to Refresh**: Actualizar datos desde la API
- **Indicador de conexión**: Banner cuando no hay internet

### Detalle de Pokémon

- **Información completa**: Tipos, altura, peso, habilidades
- **Imágenes de alta calidad**: Official artwork
- **Hero animation**: Transición suave desde la lista
- **Colores dinámicos**: Según el tipo del Pokémon

##  Seguridad

- Contraseñas validadas con mínimo 6 caracteres
- Emails validados con expresión regular
- Manejo seguro de errores de Firebase
- Sesiones encriptadas en Hive

##  Buenas Prácticas Implementadas

-  Arquitectura limpia y escalable
-  Separación de responsabilidades
-  Código documentado
-  Manejo de errores robusto
-  Estados de carga y error
-  UI/UX intuitiva
-  Responsive design
-  Optimización de imágenes con caché
-  Validación de formularios
-  Navegación fluida con animaciones

## Testing

Para ejecutar tests (cuando estén implementados):

```bash
flutter test
```

##  Compilación

### Android APK

```bash
flutter build apk --release
```

### Android App Bundle

```bash
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

##  Solución de Problemas

### Error: Firebase not initialized

Asegúrate de haber configurado correctamente `google-services.json` (Android) o `GoogleService-Info.plist` (iOS).

### Error: Hive adapters not registered

Ejecuta el comando de build_runner:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Error: Network connectivity

Verifica los permisos de internet en `AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
```

## Recursos

- [Flutter Documentation](https://flutter.dev/docs)
- [GetX Documentation](https://pub.dev/packages/get)
- [Hive Documentation](https://docs.hivedb.dev/)
- [Firebase Documentation](https://firebase.google.com/docs)
- [PokéAPI Documentation](https://pokeapi.co/docs/v2)

##  Desarrollo

Desarrollado por: Leonardo Cajas
Fecha: Febrero 2026
Empresa: Bodytech

## Licencia

Este proyecto fue desarrollado como parte de una prueba técnica para Bodytech.

---

## Notas Adicionales

### Decisiones Técnicas

1. **GetX sobre Bloc/Provider**: Por su simplicidad y menor boilerplate
2. **Hive sobre SQLite**: Por su velocidad y facilidad de uso
3. **Dio sobre http**: Por sus interceptors y manejo de errores
4. **PokéAPI**: API pública confiable y bien documentada

### Mejoras Futuras

- [ ] Implementar tests unitarios y de widgets
- [ ] Agregar animaciones más complejas
- [ ] Implementar paginación para cargar más Pokémon
- [ ] Agregar filtros por tipo de Pokémon
- [ ] Implementar favoritos
- [ ] Modo oscuro
- [ ] Soporte multiidioma

### Consideraciones de Rendimiento

- Caché de imágenes con `cached_network_image`
- Lazy loading en la lista de Pokémon
- Almacenamiento local para reducir llamadas a la API
- Optimización de builds con `const` constructors

