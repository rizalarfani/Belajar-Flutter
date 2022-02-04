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
  TextEditingController? halaman = TextEditingController();
  int? _pageNumber = 0;
  int? _pageCount = 0;

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
            height: 45,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 45,
                  margin: EdgeInsets.all(5),
                  child: TextField(
                    controller: halaman!,
                    onChanged: (value) {
                      _pdfViewerController!
                          .jumpToPage(int.parse(value.toString()));
                      setState(() {
                        _pageNumber = int.parse(value.toString());
                      });
                    },
                    textInputAction: TextInputAction.search,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: new InputDecoration(
                      hintText: '$_pageNumber',
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 3.0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(6),
                        ),
                      ),
                      contentPadding: EdgeInsets.only(
                          bottom: 10.0, left: 10.0, right: 10.0),
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Text("Dari"),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Text("$_pageCount"),
                ),
                IconButton(
                  onPressed: () {
                    _pdfViewerController!.previousPage();
                    setState(() {
                      _pageNumber = _pdfViewerController!.pageNumber;
                    });
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_left,
                    color: Colors.grey,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _pdfViewerController!.nextPage();
                    setState(() {
                      _pageNumber = _pdfViewerController!.pageNumber;
                    });
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          preferredSize: Size.fromHeight(30),
        ),
      ),
      body: SfPdfViewer.asset('$pathPdf',
          controller: _pdfViewerController, enableDoubleTapZooming: true,
          onDocumentLoaded: (PdfDocumentLoadedDetails detail) {
        setState(() {
          _pageNumber = _pdfViewerController!.pageNumber;
          _pageCount = _pdfViewerController!.pageCount;
        });
      }),
    );
  }
}
