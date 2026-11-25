# flutter_prueba_01 — Proyecto base para estudiantes

## Objetivo
Implementar el intercambio de datos entre tres pantallas de Flutter, sin gestores de estado compartido ni variables globales.

## Estado inicial entregado
- Las tres pantallas están diseñadas siguiendo el esquema de la evaluación.
- Los botones **Siguiente** de las pantallas 1 y 2 permiten navegar hasta la pantalla 3.
- Los botones **Cerrar** y **Mostrar resultados** están deshabilitados.
- No hay validaciones, retorno de datos, cálculos ni edición de registros implementados.
- Los campos grises son de solo lectura; los blancos son editables.

## Preparación en Visual Studio Code
El paquete contiene los archivos fuente de Flutter. Los archivos nativos de plataforma se generan localmente con el SDK de Flutter.

1. Descomprimir el archivo y abrir la carpeta `flutter_prueba_01` en VS Code.
2. Abrir una terminal en esa carpeta.
3. Ejecutar `flutter create --platforms=android .` (solo la primera vez).
4. Ejecutar `flutter pub get`.
5. Ejecutar `flutter run` con un dispositivo Android conectado.

**Importante:** no ejecutar `flutter create` con un nombre distinto ni reemplazar los archivos de `lib/`.

## Trabajo de evaluación
El docente entregará el enunciado y las condiciones de evaluación por separado. Los comentarios TODO señalan únicamente las zonas generales de intervención.

## Restricciones
No usar Provider ni variables globales para comunicar las pantallas.

## Nota
Este proyecto base no incluye la solución de la prueba. El botón Atrás del sistema o de la barra superior permite salir de una pantalla durante la exploración inicial; el comportamiento exigido para la evaluación se especificará en el enunciado.
