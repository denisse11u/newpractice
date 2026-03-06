import 'package:aplicacionflutter/model/view_flows_response.dart';
import 'package:aplicacionflutter/modulo/widget/modalsheet.dart';
import 'package:flutter/material.dart';

class ViewPdf extends StatelessWidget {
  final List<FileElement>? files;

  const ViewPdf({super.key, this.files});

  @override
  Widget build(BuildContext context) {
    return BaseModalSheet(
      title: 'Ver archivos',
      subtitle:
          'Descargue o visualice los archivos que forman parte de este flujo',
      body: _PdfContent(files: files),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Contenido específico del modal de archivos
// ─────────────────────────────────────────────────────────────────────────────

class _PdfContent extends StatelessWidget {
  final List<FileElement>? files;

  const _PdfContent({this.files});

  @override
  Widget build(BuildContext context) {
    if (files == null || files!.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(child: Text('No hay archivos disponibles')),
      );
    }

    final processFiles = files!.where((f) => f.appFileId != null).toList();
    final originalFiles = files!
        .where((f) => f.originalFileId != null)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (processFiles.isNotEmpty) ...[
          _PdfSection(
            title: 'Versión de procesos',
            subtitle:
                'Una copia del archivo que incluye una o más modificaciones',
            files: processFiles,
            isProcess: true,
          ),
          const SizedBox(height: 20),
        ],
        if (originalFiles.isNotEmpty)
          _PdfSection(
            title: 'Versión original',
            subtitle:
                'Una copia original del archivo que se conserva sin modificaciones',
            files: originalFiles,
            isProcess: false,
          ),
      ],
    );
  }
}

// ── Sección con título y lista de archivos ────────────────────────────────────

class _PdfSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<FileElement> files;
  final bool isProcess;

  const _PdfSection({
    required this.title,
    required this.subtitle,
    required this.files,
    required this.isProcess,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 12),
        ...files.map((file) => _PdfFileItem(file: file, isProcess: isProcess)),
      ],
    );
  }
}

// ── Item individual de archivo ────────────────────────────────────────────────

class _PdfFileItem extends StatelessWidget {
  final FileElement file;
  final bool isProcess;

  const _PdfFileItem({required this.file, required this.isProcess});

  String get _fileName => isProcess
      ? (file.appFileTrace ?? 'Documento PDF')
      : (file.originalFileTrace ?? 'Documento PDF');

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isProcess ? Colors.red.shade50 : Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  isProcess ? Icons.picture_as_pdf : Icons.description,
                  color: isProcess ? Colors.red : Colors.blue,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _fileName.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'PDF Document',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: implementar descarga
                  },
                  icon: const Icon(Icons.download, size: 16),
                  label: const Text('Download'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // TODO: implementar visualización
                  },
                  icon: const Icon(Icons.remove_red_eye_outlined, size: 16),
                  label: const Text('View'),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
