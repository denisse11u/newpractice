import 'package:flutter/material.dart';

class SectionInfoBasica extends StatelessWidget {
  final TextEditingController nameController;
  final int? selectedTypeId;
  final DateTime? expiration;
  final bool addCertificate;
  final bool includeDateTime;
  final bool notifyCreator;
  final bool notifyCreatorOnReject;

  final ValueChanged<int?> onTypeChanged;
  final ValueChanged<DateTime?> onExpirationChanged;
  final ValueChanged<bool> onAddCertificateChanged;
  final ValueChanged<bool> onIncludeDateTimeChanged;
  final ValueChanged<bool> onNotifyCreatorChanged;
  final ValueChanged<bool> onNotifyCreatorOnRejectChanged;

  // TODO: traer desde AppInfoResponse provider
  static const _tipos = [
    _Tipo(id: 1, label: 'Certificados'),
    _Tipo(id: 2, label: 'Simple'),
    _Tipo(id: 3, label: 'Electrónico'),
  ];

  const SectionInfoBasica({
    super.key,
    required this.nameController,
    required this.selectedTypeId,
    required this.expiration,
    required this.addCertificate,
    required this.includeDateTime,
    required this.notifyCreator,
    required this.notifyCreatorOnReject,
    required this.onTypeChanged,
    required this.onExpirationChanged,
    required this.onAddCertificateChanged,
    required this.onIncludeDateTimeChanged,
    required this.onNotifyCreatorChanged,
    required this.onNotifyCreatorOnRejectChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Información básica',
      subtitle: 'Define la información básica de tu flujo',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Nombre ──
          const _Label('Nombre'),
          const SizedBox(height: 6),
          TextFormFieldWidget(
            controller: nameController,
            hintText: 'Tj. Contrato de servicios',
            validator: (v) => (v == null || v.trim().isEmpty)
                ? 'El nombre es requerido'
                : null,
          ),

          const SizedBox(height: 16),

          // ── Tipo ──
          const _Label('Tipo'),
          const SizedBox(height: 6),
          DropdownFormFieldWidget<int>(
            value: selectedTypeId,
            hintText: 'Selecciona un tipo',
            validator: (v) => v == null ? 'Selecciona un tipo' : null,
            items: _tipos
                .map((t) => DropdownMenuItem(value: t.id, child: Text(t.label)))
                .toList(),
            onChanged: onTypeChanged,
          ),

          const SizedBox(height: 16),

          // ── Válido hasta ──
          const _Label('Válido hasta'),
          const SizedBox(height: 6),
          TextFormFieldWidget(
            readOnly: true,
            hintText: 'mm/dd/yyyy',
            controller: TextEditingController(
              text: expiration != null
                  ? '${expiration!.month.toString().padLeft(2, '0')}/'
                        '${expiration!.day.toString().padLeft(2, '0')}/'
                        '${expiration!.year}'
                  : '',
            ),
            suffixIcon: const Icon(
              Icons.calendar_today_outlined,
              size: 18,
              color: Colors.grey,
            ),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate:
                    expiration ?? DateTime.now().add(const Duration(days: 30)),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
              );
              if (picked != null) onExpirationChanged(picked);
            },
          ),

          const SizedBox(height: 16),

          // ── Checkboxes ──
          CheckboxWidget(
            value: addCertificate,
            onChanged: onAddCertificateChanged,
            label: 'No incluir un certificado de evidencias en este flujo',
          ),
          CheckboxWidget(
            value: includeDateTime,
            onChanged: onIncludeDateTimeChanged,
            label: 'Incluir fecha y hora del sistema en las firmas',
          ),
          CheckboxWidget(
            value: notifyCreator,
            onChanged: onNotifyCreatorChanged,
            label:
                'Notificar únicamente al creador cuando este flujo se apruebe',
          ),
          CheckboxWidget(
            value: notifyCreatorOnReject,
            onChanged: onNotifyCreatorOnRejectChanged,
            label:
                'Notificar únicamente al creador cuando este flujo se rechace',
          ),

          const SizedBox(height: 12),

          // ── Info certificado ──
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color: Colors.green.shade700,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'El certificado de evidencias es un documento legal que respalda la integridad y autenticidad del proceso de firma.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.green.shade800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
  );
}

class _Tipo {
  final int id;
  final String label;
  const _Tipo({required this.id, required this.label});
}
