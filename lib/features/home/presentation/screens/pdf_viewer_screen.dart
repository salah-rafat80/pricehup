import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../../core/utils/size_config.dart';

/// PDF viewer screen to display price list PDFs from URL or assets
class PdfViewerScreen extends StatefulWidget {
  final String title;
  final String pdfAssetPath;

  const PdfViewerScreen({
    super.key,
    required this.title,
    required this.pdfAssetPath,
  });

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  bool _hasError = false;
  bool _isLoading = true;
  bool _snackShown = false;
  String? _errorMessage;
  final PdfViewerController _pdfViewerController = PdfViewerController();

  late final bool _isNetworkUrl;
  late final Widget _viewer; // ثبّت الويدجت لتجنب إعادة الإنشاء مع كل build

  @override
  void initState() {
    super.initState();
    _isNetworkUrl = widget.pdfAssetPath.startsWith('http://') ||
        widget.pdfAssetPath.startsWith('https://');

    final viewerKey = ValueKey(widget.pdfAssetPath);

    if (_isNetworkUrl) {
      _viewer = SfPdfViewer.network(
        widget.pdfAssetPath,
        key: viewerKey,
        controller: _pdfViewerController,
        pageLayoutMode: PdfPageLayoutMode.continuous,
        scrollDirection: PdfScrollDirection.vertical,
        enableDoubleTapZooming: true,
        enableTextSelection: false,
        canShowScrollHead: true,
        canShowScrollStatus: true,
        canShowPaginationDialog: true,
        interactionMode: PdfInteractionMode.pan,
        onDocumentLoaded: (details) {
          if (!mounted) return;
          if (_isLoading) {
            setState(() => _isLoading = false);
          }
          if (!_snackShown) {
            _snackShown = true;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('تم تحميل ${details.document.pages.count} صفحة'),
                duration: const Duration(seconds: 2),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        onDocumentLoadFailed: (details) {
          if (!mounted) return;
          setState(() {
            _hasError = true;
            _isLoading = false;
            _errorMessage = details.description;
          });
        },
      );
    } else {
      _viewer = SfPdfViewer.asset(
        widget.pdfAssetPath,
        key: viewerKey,
        controller: _pdfViewerController,
        pageLayoutMode: PdfPageLayoutMode.continuous,
        scrollDirection: PdfScrollDirection.vertical,
        enableDoubleTapZooming: true,
        enableTextSelection: false,
        canShowScrollHead: true,
        canShowScrollStatus: true,
        canShowPaginationDialog: true,
        interactionMode: PdfInteractionMode.pan,
        onDocumentLoaded: (_) {
          if (!mounted) return;
          if (_isLoading) {
            setState(() => _isLoading = false);
          }
        },
        onDocumentLoadFailed: (details) {
          if (!mounted) return;
          setState(() {
            _hasError = true;
            _isLoading = false;
            _errorMessage = details.description;
          });
        },
      );
    }
  }

  @override
  void dispose() {
    _pdfViewerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            if (!_hasError && !_isLoading)
              IconButton(
                icon: const Icon(Icons.zoom_in),
                onPressed: () {
                  _pdfViewerController.zoomLevel = _pdfViewerController.zoomLevel + 0.25;
                },
              ),
            if (!_hasError && !_isLoading)
              IconButton(
                icon: const Icon(Icons.zoom_out),
                onPressed: () {
                  _pdfViewerController.zoomLevel = _pdfViewerController.zoomLevel - 0.25;
                },
              ),
          ],
        ),
        body: SafeArea(
          child: _hasError
              ? _buildErrorView(isLandscape)
              : Stack(
                  children: [
                    Positioned.fill(child: _viewer),
                    if (_isLoading)
                      IgnorePointer(
                        child: Container(
                          color: Colors.white,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CircularProgressIndicator(),
                                SizedBox(height: SizeConfig.h(2)),
                                Text(
                                  'جاري تحميل الملف...',
                                  style: TextStyle(fontSize: SizeConfig.sp(4.5)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildErrorView(bool isLandscape) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.all(SizeConfig.w(6)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: isLandscape ? SizeConfig.w(12) : SizeConfig.w(18),
                      color: Colors.red,
                    ),
                    SizedBox(height: SizeConfig.h(2)),
                    Text(
                      'فشل تحميل الملف',
                      style: TextStyle(
                        fontSize: SizeConfig.sp(6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: SizeConfig.h(1)),
                    Text(
                      _errorMessage ?? 'تأكد من اتصالك بالإنترنت',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: SizeConfig.sp(4.5),
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: SizeConfig.h(1)),
                    Text(
                      'الرابط: ${widget.pdfAssetPath}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: SizeConfig.sp(3.5),
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: SizeConfig.h(3)),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.h(2),
                          horizontal: SizeConfig.w(6),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _hasError = false;
                          _isLoading = true;
                          _snackShown = false;
                        });
                      },
                      icon: Icon(Icons.refresh, size: SizeConfig.w(6)),
                      label: Text(
                        'إعادة المحاولة',
                        style: TextStyle(fontSize: SizeConfig.sp(4.5)),
                      ),
                    ),
                    SizedBox(height: SizeConfig.h(1.5)),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.h(1.5),
                          horizontal: SizeConfig.w(6),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'العودة للقائمة',
                        style: TextStyle(fontSize: SizeConfig.sp(6)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
