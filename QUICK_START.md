# Guía de Inicio Rápido

##  Setup Rápido 

### 1. Clonar e Instalar
```bash
# Opción 1: Si tienes el repo en GitHub
git clone <tu-repositorio>
cd pokemon_app_bodytech
flutter pub get
```

### 2. Configurar Firebase
```bash
# Instalar FlutterFire CLI
dart pub global activate flutterfire_cli

# Configurar Firebase (seguir prompts)
flutterfire configure
```

**Importante**: Habilita Email/Password en Firebase Console:
- Firebase Console → Authentication → Sign-in method
- Habilita "Email/Password"

### 3. Generar Código Hive
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. Ejecutar
```bash
flutter run
```

##  Probar la App

### Usuario de Prueba
1. Abre la app
2. Toca "Regístrate"
3. Email: `test@bodytech.com`
4. Contraseña: `123456`
5. Confirma contraseña: `123456`
6. Toca "Registrarse"

### Funcionalidades para Probar
-  Registro de usuario
-  Login
-  Ver lista de Pokémon
-  Buscar Pokémon
-  Ver detalles de Pokémon
-  Modo sin conexión (activa modo avión)
-  Cerrar sesión

##  Comandos Útiles

```bash
# Limpiar proyecto
flutter clean && flutter pub get

# Ver dispositivos disponibles
flutter devices

# Ejecutar en dispositivo específico
flutter run -d <device-id>

# Build APK
flutter build apk --release

# Ver logs
flutter logs
```

## Solución Rápida de Errores

**Error: "MissingPluginException"**
```bash
flutter clean
flutter pub get
flutter run
```

**Error: "Firebase not initialized"**
- Verifica que `google-services.json` esté en `android/app/`
- Ejecuta: `flutterfire configure`

**Error: "Hive not found"**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Soporte

Si encuentras problemas:
1. Revisa el README completo
2. Verifica FIREBASE_SETUP.md
3. Consulta la documentación oficial de Flutter
