import 'package:flutter/material.dart';
import 'package:pdf_read/pdfView.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Read'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () => {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PdfView(
                            pathPdf: 'assets/edaran.pdf',
                          ),
                        ),
                      ),
                    },
                child: Text("Load Pdf Asset")),
          ],
        ),
      ),
    );
  }
}
