import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfView extends StatefulWidget implements PreferredSizeWidget {
  final String? pathPdf;

  const PdfView({Key? key, this.pathPdf}) : super(key: key);
  @override
  _PdfViewState createState() => _PdfViewState(this.pathPdf);

  @override
  Size get preferredSize => throw UnimplementedError();
}

class _PdfViewState extends State<PdfView> {
  String? pathPdf;
  PdfViewerController? _pdfViewerController;
  _PdfViewState(this.pathPdf);

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View PDF'),
        bottom: PreferredSize(
          child: Container(
            height: 30,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Text('asd'), Text('asd')],
            ),
          ),
          preferredSize: Size.fromHeight(30),
        ),
        actions: [
          IconButton(
            onPressed: () => {
              _pdfViewerController!.previousPage(),
            },
            icon: Icon(
              Icons.keyboard_arrow_up,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () => {
              _pdfViewerController!.nextPage(),
            },
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SfPdfViewer.asset(
        '$pathPdf',
        controller: _pdfViewerController,
        enableDoubleTapZooming: true,
      ),
    );
  }
}
