import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viadoc_app/env/theme/app_theme.dart';
import 'package:viadoc_app/modules/create_flow/models/create_flow_request.dart';
import 'package:viadoc_app/modules/create_flow/provider/create_flow_provider.dart';
import 'package:viadoc_app/modules/create_flow/widget/section_info_basica.dart';
import 'package:viadoc_app/modules/view_flows/models/view_flows_response.dart';
import 'package:viadoc_app/shared/widgets/section_card.dart';

class CreateFlowPage extends ConsumerStatefulWidget {
  final ViewFlowsResponse? template;

  const CreateFlowPage({super.key, this.template});

  @override
  ConsumerState<CreateFlowPage> createState() => _CreateFlowPageState();
}

class _CreateFlowPageState extends ConsumerState<CreateFlowPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  late TextEditingController _nameController;
  int? _selectedTypeId;
  DateTime? _expiration;
  bool _addCertificate = false;
  bool _includeDateTime = false;
  bool _notifyCreator = false;
  bool _notifyCreatorOnReject = false;

  @override
  void initState() {
    super.initState();
    final t = widget.template;
    _nameController = TextEditingController(text: t?.name ?? '');
    _selectedTypeId = t?.typeId;
    _expiration = t?.expiration;
    _addCertificate = t?.addCertificateAtComplete ?? false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final request = CreateFlowRequest(
      name: _nameController.text.trim(),
      typeId: _selectedTypeId,
      expiration: _expiration,
      addCertificateAtComplete: _addCertificate,
      includeDateTime: _includeDateTime,
      notifyCreator: _notifyCreator,
      notifyCreatorOnReject: _notifyCreatorOnReject,
    );

    final service = ref.read(createFlowServicesProvider);
    final response = await service.createFlow(context, request);

    setState(() => _isLoading = false);

    if (!mounted) return;

    if (response.result) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Flujo creado correctamente')),
      );
      Navigator.pop(context);
    }
  }

  Widget _submitButton({bool compact = false}) {
    return ElevatedButton.icon(
      onPressed: _isLoading ? null : _submit,
      icon: _isLoading
          ? const SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : const Icon(Icons.arrow_forward, size: 16),
      label: Text(compact ? 'Configurar' : 'Pasar a configurar elementos'),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 12 : 20,
          vertical: compact ? 8 : 16,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundTextForm,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundTextForm,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppTheme.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Crear un nuevo flujo',
          style: TextStyle(
            color: AppTheme.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        // ✅ Siempre visible al hacer scroll
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _submitButton(compact: true),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Con tan solo agregar archivos, involucrados y algunas configuraciones adicionales, podrá crear un flujo para su organización.',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),

              const SizedBox(height: 24),

              // ── Información básica ──
              SectionInfoBasica(
                nameController: _nameController,
                selectedTypeId: _selectedTypeId,
                expiration: _expiration,
                addCertificate: _addCertificate,
                includeDateTime: _includeDateTime,
                notifyCreator: _notifyCreator,
                notifyCreatorOnReject: _notifyCreatorOnReject,
                onTypeChanged: (v) => setState(() => _selectedTypeId = v),
                onExpirationChanged: (v) => setState(() => _expiration = v),
                onAddCertificateChanged: (v) =>
                    setState(() => _addCertificate = v),
                onIncludeDateTimeChanged: (v) =>
                    setState(() => _includeDateTime = v),
                onNotifyCreatorChanged: (v) =>
                    setState(() => _notifyCreator = v),
                onNotifyCreatorOnRejectChanged: (v) =>
                    setState(() => _notifyCreatorOnReject = v),
              ),

              const SizedBox(height: 24),

              // ── Placeholders — próximos pasos ──
              _SectionPlaceholder(title: 'Archivos'),
              const SizedBox(height: 16),
              _SectionPlaceholder(title: 'Involucrados'),
              const SizedBox(height: 16),
              _SectionPlaceholder(title: 'Recordatorios'),

              const SizedBox(height: 32),

              // ✅ Botón completo al final
              SizedBox(width: double.infinity, child: _submitButton()),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionPlaceholder extends StatelessWidget {
  final String title;

  const _SectionPlaceholder({required this.title});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: title,
      child: Row(
        children: [
          Icon(
            Icons.hourglass_top_outlined,
            size: 16,
            color: Colors.grey.shade400,
          ),
          const SizedBox(width: 8),
          Text(
            'Próximo paso',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }
}
