import 'package:flutter/material.dart';
import 'package:internet_file/internet_file.dart';
import 'package:pdfx/pdfx.dart';

class PdfViewerPage extends StatelessWidget {
  final pdfUrl = 'https://cdn.filestackcontent.com/wcrjf9qPTCKXV3hMXDwK';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchase Order'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            OrderInformation(),
            const SizedBox(height: 20),
            SizedBox(
              height: 400,
              child: PdfView(
                controller: PdfController(
                  document: PdfDocument.openData(InternetFile.get(pdfUrl)),
                ),
              ),
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}

class StatusIndicator extends StatelessWidget {
  final String label;
  final bool isActive;

  // ignore: use_key_in_widget_constructors
  const StatusIndicator({required this.label, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: isActive ? Colors.green : Colors.grey,
          child: isActive
              ? const Icon(Icons.check, color: Colors.white)
              : const Icon(Icons.close, color: Colors.white),
        ),
        const SizedBox(height: 5),
        Text(label),
      ],
    );
  }
}

// ignore: use_key_in_widget_constructors
class OrderInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Order Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('PO Number: PO#Lowe/Dec-2'),
            Text('Amount: ₹50,000'),
          ],
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Invoice Date: 12th May 24'),
            Text('Status: Bill Created'),
          ],
        ),
      ],
    );
  }
}

// ignore: use_key_in_widget_constructors
class AdditionalDocumentsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Additional Documents',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Table(
          border: TableBorder.all(color: Colors.black),
          children: [
            const TableRow(
              children: [
                Padding(
                    padding: EdgeInsets.all(8.0), child: Text('Document Name')),
                Padding(
                    padding: EdgeInsets.all(8.0), child: Text('Document No.')),
                Padding(
                    padding: EdgeInsets.all(8.0), child: Text('Date Created')),
                Padding(
                    padding: EdgeInsets.all(8.0), child: Text('Date Accepted')),
                Padding(padding: EdgeInsets.all(8.0), child: Text('Actions')),
              ],
            ),
            TableRow(
              children: [
                const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Purchase Order')),
                const Padding(
                    padding: EdgeInsets.all(8.0), child: Text('PO#Lowe/Dec-2')),
                const Padding(
                    padding: EdgeInsets.all(8.0), child: Text('12th Feb 24')),
                const Padding(
                    padding: EdgeInsets.all(8.0), child: Text('18th Feb 24')),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      TextButton(onPressed: () {}, child: const Text('View')),
                      TextButton(
                          onPressed: () {}, child: const Text('Download')),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
