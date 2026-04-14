import 'package:flutter/material.dart';
import '../../models/sector_def.dart';

typedef AnalysisChangedCallback =
    void Function({
      required String sector,
      required String factorKey,
      required int lag,
      required AnalysisMode mode,
    });

class AnalysisControlPanel extends StatefulWidget {
  final AnalysisChangedCallback onChanged;

  const AnalysisControlPanel({super.key, required this.onChanged});

  @override
  State<AnalysisControlPanel> createState() => _AnalysisControlPanelState();
}

class _AnalysisControlPanelState extends State<AnalysisControlPanel> {
  int _selectedSectorIndex = 0;
  late String _selectedFactorKey;
  int _lag = 0;
  AnalysisMode _mode = AnalysisMode.tendencia;

  SectorDef get _sector => kSectors[_selectedSectorIndex];

  @override
  void initState() {
    super.initState();
    _selectedFactorKey = _sector.factors.first.apiKey;
    WidgetsBinding.instance.addPostFrameCallback((_) => _fireCallback());
  }

  void _fireCallback() {
    widget.onChanged(
      sector: _sector.apiKey,
      factorKey: _selectedFactorKey,
      lag: _lag,
      mode: _mode,
    );
  }

  void _onSectorChanged(int index) {
    setState(() {
      _selectedSectorIndex = index;
      _selectedFactorKey = _sector.factors.first.apiKey;
    });
    _fireCallback();
  }

  void _onFactorChanged(String? value) {
    if (value == null) return;
    setState(() => _selectedFactorKey = value);
    _fireCallback();
  }

  void _onLagChanged(double value) {
    setState(() => _lag = value.round());
    _fireCallback();
  }

  void _onModeChanged(Set<AnalysisMode> selection) {
    setState(() => _mode = selection.first);
    _fireCallback();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TITULO
            Row(
              children: [
                Icon(Icons.tune_rounded, color: cs.primary, size: 22),
                const SizedBox(width: 10),
                Text(
                  'Panel de Análisis',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // SECTOR SELECTOR
            _SectionLabel(
              label: 'Sector Económico',
              icon: Icons.business_rounded,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(kSectors.length, (i) {
                final s = kSectors[i];
                final selected = i == _selectedSectorIndex;
                return FilterChip(
                  label: Text(s.label),
                  selected: selected,
                  onSelected: (_) => _onSectorChanged(i),
                  selectedColor: s.color.withValues(
                    alpha: isDark ? 0.35 : 0.18,
                  ),
                  checkmarkColor: s.color,
                  labelStyle: TextStyle(
                    color: selected ? s.color : cs.onSurfaceVariant,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                    fontSize: 13,
                  ),
                  side: BorderSide(
                    color: selected
                        ? s.color.withValues(alpha: 0.6)
                        : cs.outlineVariant,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 2,
                  ),
                );
              }),
            ),
            const SizedBox(height: 22),

            // FACTOR SELECTOR
            _SectionLabel(
              label: 'Variable Económica',
              icon: Icons.show_chart_rounded,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              initialValue: _selectedFactorKey,
              onChanged: _onFactorChanged,
              isExpanded: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: cs.surfaceContainerHighest.withValues(alpha: 0.5),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: cs.outlineVariant),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: cs.outlineVariant.withValues(alpha: 0.5),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: _sector.color, width: 2),
                ),
              ),
              dropdownColor: cs.surfaceContainer,
              borderRadius: BorderRadius.circular(14),
              style: TextStyle(color: cs.onSurface, fontSize: 14),
              items: _sector.factors.map((f) {
                return DropdownMenuItem(value: f.apiKey, child: Text(f.label));
              }).toList(),
            ),
            const SizedBox(height: 22),

            // LAG CONTROL
            _SectionLabel(label: 'Retraso (Lag)', icon: Icons.schedule_rounded),
            const SizedBox(height: 4),
            Row(
              children: [
                _LagButton(
                  icon: Icons.remove_rounded,
                  onPressed: _lag > 0
                      ? () => _onLagChanged((_lag - 1).toDouble())
                      : null,
                  color: _sector.color,
                ),
                Expanded(
                  child: SliderTheme(
                    data: SliderThemeData(
                      activeTrackColor: _sector.color,
                      inactiveTrackColor: _sector.color.withValues(alpha: 0.15),
                      thumbColor: _sector.color,
                      overlayColor: _sector.color.withValues(alpha: 0.12),
                      valueIndicatorColor: _sector.color,
                      valueIndicatorTextStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                      trackHeight: 4,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 8,
                      ),
                    ),
                    child: Slider(
                      value: _lag.toDouble(),
                      min: 0,
                      max: 12,
                      divisions: 12,
                      label: '$_lag ${_lag == 1 ? "mes" : "meses"}',
                      onChanged: _onLagChanged,
                    ),
                  ),
                ),
                _LagButton(
                  icon: Icons.add_rounded,
                  onPressed: _lag < 12
                      ? () => _onLagChanged((_lag + 1).toDouble())
                      : null,
                  color: _sector.color,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '0',
                    style: TextStyle(fontSize: 11, color: cs.onSurfaceVariant),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      '$_lag ${_lag == 1 ? "mes" : "meses"} de retraso',
                      key: ValueKey(_lag),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _sector.color,
                      ),
                    ),
                  ),
                  Text(
                    '12',
                    style: TextStyle(fontSize: 11, color: cs.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),

            // ANALYSIS MODE TOGGLE
            _SectionLabel(
              label: 'Tipo de Análisis',
              icon: Icons.analytics_rounded,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: SegmentedButton<AnalysisMode>(
                segments: const [
                  ButtonSegment(
                    value: AnalysisMode.tendencia,
                    label: Text('Tendencia', style: TextStyle(fontSize: 12)),
                    icon: Icon(Icons.show_chart_rounded, size: 18),
                  ),
                  ButtonSegment(
                    value: AnalysisMode.correlacion,
                    label: Text('Correlación', style: TextStyle(fontSize: 12)),
                    icon: Icon(Icons.scatter_plot_rounded, size: 18),
                  ),
                ],
                selected: {_mode},
                onSelectionChanged: _onModeChanged,
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  side: WidgetStatePropertyAll(
                    BorderSide(color: cs.outlineVariant.withValues(alpha: 0.5)),
                  ),
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // CORRELATION SCORE BADGE
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _sector.color.withValues(alpha: isDark ? 0.2 : 0.08),
                    _sector.color.withValues(alpha: isDark ? 0.08 : 0.02),
                  ],
                ),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _sector.color.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 16,
                    color: _sector.color,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      '${_sector.label} · ${_sector.factors.firstWhere((f) => f.apiKey == _selectedFactorKey).label}',
                      style: TextStyle(
                        fontSize: 12,
                        color: cs.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  final IconData icon;

  const _SectionLabel({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(icon, size: 16, color: cs.onSurfaceVariant),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: cs.onSurfaceVariant,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

class _LagButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color color;

  const _LagButton({
    required this.icon,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 34,
      height: 34,
      child: IconButton.filled(
        onPressed: onPressed,
        icon: Icon(icon, size: 16),
        style: IconButton.styleFrom(
          backgroundColor: color.withValues(alpha: 0.12),
          foregroundColor: color,
          disabledBackgroundColor: Theme.of(
            context,
          ).colorScheme.surfaceContainerHighest,
          disabledForegroundColor: Theme.of(
            context,
          ).colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
