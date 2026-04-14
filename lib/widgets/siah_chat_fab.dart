import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_siah/core/theme/app_theme.dart';
import 'package:proyecto_siah/widgets/cactus_icon.dart';

class SiahChatFab extends StatelessWidget {
  const SiahChatFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _abrirChat(context),
      backgroundColor: SiahColors.terracota,
      elevation: 4,
      child: const CactusIcon(
  size: 30,
  color: Colors.white,
),
    );
  }

  void _abrirChat(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _ChatModal(),
    );
  }
}

class _ChatModal extends StatefulWidget {
  const _ChatModal();

  @override
  State<_ChatModal> createState() => _ChatModalState();
}

class _ChatModalState extends State<_ChatModal> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _mensajes = [
    {
      'texto': '¡Hola! Soy SIAH IA\n\nPuedo ayudarte a entender el impacto de la sequía en el empleo agrícola de Sonora. ¿Qué deseas consultar?',
      'esIA': true,
    }
  ];
  bool _escribiendo = false;

  final List<String> _respuestasSimuladas = [
    'Según los datos del DRRY, el nivel actual de la Presa Mocúzari se encuentra al 34% de su capacidad, lo que representa un riesgo alto para el ciclo agrícola 2024-2025.',
    'En el Valle del Yaqui se estima una reducción del 63.87% en la contratación de jornaleros debido a la sequía prolongada. Se recomienda explorar oportunidades en el sector manufactura.',
    'Los parques industriales del sur de Sonora tienen actualmente más de 3,200 vacantes disponibles que no requieren capacitación especializada previa.',
    'La correlación entre el nivel de la Presa Mocúzari y la superficie sembrada es de r = +0.92, lo que indica que el agua disponible es el principal predictor de actividad agrícola.',
    'El Valle del Mayo tiene una superficie total de 98,000 hectáreas. Durante sequías severas, hasta el 52% de esta superficie queda sin sembrar.',
    'Los sectores con mayor capacidad de absorción laboral son: Manufactura (+12% crecimiento), Construcción (alta demanda) y Servicios (logística y comercio regional).',
  ];

  int _respuestaIndex = 0;

  Future<void> _enviarMensaje() async {
    final texto = _controller.text.trim();
    if (texto.isEmpty) return;

    setState(() {
      _mensajes.add({'texto': texto, 'esIA': false});
      _escribiendo = true;
    });
    _controller.clear();
    _scrollAbajo();

    await Future.delayed(const Duration(milliseconds: 1400));

    setState(() {
      _mensajes.add({
        'texto': _respuestasSimuladas[_respuestaIndex % _respuestasSimuladas.length],
        'esIA': true,
      });
      _respuestaIndex++;
      _escribiendo = false;
    });
    _scrollAbajo();
  }

  void _scrollAbajo() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.80,
      decoration: const BoxDecoration(
        color: SiahColors.crema,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          _buildHandle(),
          _buildChatHeader(),
          Expanded(child: _buildMensajes()),
          if (_escribiendo) _buildEscribiendo(),
          _buildInputBar(),
        ],
      ),
    );
  }

  Widget _buildHandle() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: SiahColors.cardBorde,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildChatHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        color: SiahColors.crema,
        border: Border(
          bottom: BorderSide(color: SiahColors.cardBorde),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: SiahColors.terracota,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const CactusIcon(
  size: 18,
  color: Colors.white,
),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SIAH IA',
                style: GoogleFonts.barlow(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: SiahColors.textoPrincipal,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: SiahColors.verdeCactus,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Asistente de análisis hídrico',
                    style: GoogleFonts.nunito(
                      fontSize: 11,
                      color: SiahColors.textoSecundario,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: SiahColors.cremaOscura,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.close_rounded,
                  size: 18, color: SiahColors.textoSecundario),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMensajes() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: _mensajes.length,
      itemBuilder: (context, index) {
        final mensaje = _mensajes[index];
        final esIA = mensaje['esIA'] as bool;
        return _buildBurbuja(
          texto: mensaje['texto'] as String,
          esIA: esIA,
        );
      },
    );
  }

  Widget _buildBurbuja({required String texto, required bool esIA}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment:
            esIA ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (esIA) ...[
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: SiahColors.terracota,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: CactusIcon(
  size: 24,
  color: Colors.white,
),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: esIA ? SiahColors.blanco : SiahColors.terracota,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(esIA ? 4 : 16),
                  bottomRight: Radius.circular(esIA ? 16 : 4),
                ),
                border: esIA
                    ? Border.all(color: SiahColors.cardBorde)
                    : null,
              ),
              child: Text(
                texto,
                style: GoogleFonts.nunito(
                  fontSize: 13,
                  color: esIA
                      ? SiahColors.textoPrincipal
                      : SiahColors.blanco,
                  height: 1.5,
                ),
              ),
            ),
          ),
          if (!esIA) const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildEscribiendo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: SiahColors.terracota,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: CactusIcon(
    size: 18,
  color: Colors.white,
),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: SiahColors.blanco,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: SiahColors.cardBorde),
            ),
            child: Row(
              children: [
                _buildPunto(0),
                const SizedBox(width: 4),
                _buildPunto(1),
                const SizedBox(width: 4),
                _buildPunto(2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPunto(int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.4, end: 1.0),
      duration: Duration(milliseconds: 400 + (index * 150)),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: SiahColors.textoSecundario,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(
          16, 12, 16, MediaQuery.of(context).viewInsets.bottom + 16),
      decoration: BoxDecoration(
        color: SiahColors.crema,
        border: Border(top: BorderSide(color: SiahColors.cardBorde)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: SiahColors.blanco,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: SiahColors.cardBorde),
              ),
              child: TextField(
                controller: _controller,
                style: GoogleFonts.nunito(
                  fontSize: 13,
                  color: SiahColors.textoPrincipal,
                ),
                decoration: InputDecoration(
                  hintText: 'Pregunta sobre sequía, empleo...',
                  hintStyle: GoogleFonts.nunito(
                    fontSize: 13,
                    color: SiahColors.textoSecundario.withOpacity(0.6),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 12),
                ),
                onSubmitted: (_) => _enviarMensaje(),
                textInputAction: TextInputAction.send,
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: _enviarMensaje,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: SiahColors.terracota,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.send_rounded,
                color: SiahColors.blanco,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}