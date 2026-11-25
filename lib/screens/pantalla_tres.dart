import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// formateador para permitir unicamente numeros enteros mayores a cero
class _SoloNumerosMayoresACeroFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final texto = newValue.text;
    if (texto.isEmpty) return newValue;

    // solo permitir numeros
    if (!RegExp(r'^[0-9]+$').hasMatch(texto)) {
      return oldValue;
    }

    // no permitir que empiece con cero para que siempre sea mayor a cero
    if (texto.startsWith('0')) {
      return oldValue;
    }

    // maximo 7 digitos
    if (texto.length > 7) {
      return oldValue;
    }

    return newValue;
  }
}

// tercera ventana del examen con statelesswidget
class PantallaTres extends StatelessWidget {
  final String nombres;
  final String apellidos;

  PantallaTres({
    super.key,
    required this.nombres,
    required this.apellidos,
  }) {
    // cargar nombres y apellidos recibidos
    _controladorNombres.text = nombres;
    _controladorApellidos.text = apellidos;
  }

  // controladores para los campos de texto
  final TextEditingController _controladorNombres = TextEditingController();
  final TextEditingController _controladorApellidos = TextEditingController();
  final TextEditingController _controladorDividendo = TextEditingController();
  final TextEditingController _controladorDivisor = TextEditingController();
  final TextEditingController _controladorNumero = TextEditingController();

  // notificador para habilitar el boton cerrar en statelesswidget
  final ValueNotifier<bool> _botonCerrarHabilitado = ValueNotifier<bool>(false);

  // notificadores para guardar los calculos matematicos
  final ValueNotifier<int> _parteEntera = ValueNotifier<int>(0);
  final ValueNotifier<int> _residuo = ValueNotifier<int>(0);
  final ValueNotifier<int> _numeroInvertido = ValueNotifier<int>(0);

  // validar campos usando solo sumas y restas e inversion matematica
  void _validarCampos() {
    final textoDividendo = _controladorDividendo.text.trim();
    final textoDivisor = _controladorDivisor.text.trim();
    final textoNumero = _controladorNumero.text.trim();

    final dividendo = int.tryParse(textoDividendo);
    final divisor = int.tryParse(textoDivisor);
    final numero = int.tryParse(textoNumero);

    // validar que todos sean mayores a cero
    if (dividendo != null && dividendo > 0 &&
        divisor != null && divisor > 0 &&
        numero != null && numero > 0) {
      
      // calcular parte entera y residuo usando solo restas y sumas
      int cociente = 0;
      int resto = dividendo;
      while (resto >= divisor) {
        resto = resto - divisor; // resta sucesiva
        cociente = cociente + 1; // suma de contador
      }
      final resultadoParteEntera = cociente;
      final resultadoResiduo = resto;

      // el resultado de la division debe ser mayor a cero
      if (resultadoParteEntera > 0) {
        // invertir el numero matematicamente
        int invertido = 0;
        int temporal = numero;
        while (temporal > 0) {
          int digito = temporal;
          int decenas = 0;
          while (digito >= 10) {
            digito = digito - 10;
            decenas = decenas + 1;
          }
          invertido = (invertido * 10) + digito;
          temporal = decenas;
        }

        _parteEntera.value = resultadoParteEntera;
        _residuo.value = resultadoResiduo;
        _numeroInvertido.value = invertido;
        _botonCerrarHabilitado.value = true;
        return;
      }
    }

    _botonCerrarHabilitado.value = false;
  }

  // retornar los datos a la segunda pantalla
  void _cerrarVentana(BuildContext context) {
    final dividendo = int.parse(_controladorDividendo.text.trim());
    final divisor = int.parse(_controladorDivisor.text.trim());
    final numero = int.parse(_controladorNumero.text.trim());

    Navigator.pop(context, {
      'nombres': nombres,
      'apellidos': apellidos,
      'dividendo': dividendo,
      'divisor': divisor,
      'numero': numero,
      'parteEntera': _parteEntera.value,
      'residuo': _residuo.value,
      'numeroInvertido': _numeroInvertido.value,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('VENTANA (TRES)'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: 360,
              padding: const EdgeInsets.fromLTRB(22, 24, 22, 28),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'PASAR Y MOSTRAR: Nombre y Apellido',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 12),

                  // Nombres
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: Text(
                            'Nombres:',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              controller: _controladorNombres,
                              readOnly: true,
                              showCursor: false,
                              enableInteractiveSelection: false,
                              style: const TextStyle(fontSize: 14),
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 10,
                                ),
                                filled: true,
                                fillColor: Color(0xFFBDBDBD),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.2,
                                  ),
                                  borderRadius: BorderRadius.zero,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Apellidos
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: Text(
                            'Apellidos:',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              controller: _controladorApellidos,
                              readOnly: true,
                              showCursor: false,
                              enableInteractiveSelection: false,
                              style: const TextStyle(fontSize: 14),
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 10,
                                ),
                                filled: true,
                                fillColor: Color(0xFFBDBDBD),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.2,
                                  ),
                                  borderRadius: BorderRadius.zero,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Dividendo
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: Text(
                            'Dividendo:',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              controller: _controladorDividendo,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                _SoloNumerosMayoresACeroFormatter(),
                              ],
                              onChanged: (_) => _validarCampos(),
                              style: const TextStyle(fontSize: 14),
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 10,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.2,
                                  ),
                                  borderRadius: BorderRadius.zero,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Divisor
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: Text(
                            'Divisor:',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              controller: _controladorDivisor,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                _SoloNumerosMayoresACeroFormatter(),
                              ],
                              onChanged: (_) => _validarCampos(),
                              style: const TextStyle(fontSize: 14),
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 10,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.2,
                                  ),
                                  borderRadius: BorderRadius.zero,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Numero
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: Text(
                            'Número:',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              controller: _controladorNumero,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                _SoloNumerosMayoresACeroFormatter(),
                              ],
                              onChanged: (_) => _validarCampos(),
                              style: const TextStyle(fontSize: 14),
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 10,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.2,
                                  ),
                                  borderRadius: BorderRadius.zero,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 90),

                  // boton cerrar usando valuelistenablebuilder en statelesswidget
                  ValueListenableBuilder<bool>(
                    valueListenable: _botonCerrarHabilitado,
                    builder: (context, habilitado, _) {
                      return SizedBox(
                        width: double.infinity,
                        height: 42,
                        child: ElevatedButton(
                          onPressed: habilitado
                              ? () => _cerrarVentana(context)
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF92D050),
                            foregroundColor: Colors.black,
                            disabledBackgroundColor: const Color(0xFF808080),
                            disabledForegroundColor: Colors.black,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                              side: BorderSide(
                                color: Colors.black,
                                width: 1.2,
                              ),
                            ),
                            elevation: 0,
                          ),
                          child: const Text('Cerrar'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
