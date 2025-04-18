import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:screenshot/screenshot.dart';

void main() {
  runApp(MenuApp());
}

enum FileType { pdf, image }

class MenuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MenuCreationPage(),
    );
  }
}

class GradientScaffold extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;
  final List<Widget>? actions;

  const GradientScaffold({
    required this.child,
    this.appBar,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF9C4), Color(0xFFFFEB3B)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: child,
      ),
    );
  }
}

class MenuCreationPage extends StatefulWidget {
  @override
  _MenuCreationPageState createState() => _MenuCreationPageState();
}

class _MenuCreationPageState extends State<MenuCreationPage> {
  final TextEditingController _itemController = TextEditingController();
  final List<String> _menuItems = [];
  bool _showMenuButtons = false;

  void _addItem() {
    final text = _itemController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _menuItems.add(text);
        _itemController.clear();
      });
    }
  }

  void _removeItem(int index) {
    setState(() {
      _menuItems.removeAt(index);
    });
  }

  void _toggleMenuButtons() {
    setState(() {
      _showMenuButtons = !_showMenuButtons;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: AppBar(
        title: Text('Créer Menu'),
        backgroundColor: Color.fromARGB(255, 225, 255, 56),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _itemController,
              decoration: InputDecoration(
                hintText: 'Entrer un élément du menu',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addItem,
              child: Text('Ajouter'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(212, 243, 247, 50),
                foregroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _menuItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(_menuItems[index]),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Color.fromARGB(255, 209, 206, 11)),
                        onPressed: () => _removeItem(index),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _toggleMenuButtons,
              child: Text(_showMenuButtons ? 'Cacher menu' : 'OK'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            if (_showMenuButtons) ...[
              SizedBox(height: 20),
              ElevatedButton.icon(
                icon: Icon(Icons.picture_as_pdf, color: Colors.red),
                label: Text('menu.pdf'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailPage(fileType: FileType.pdf, menuItems: _menuItems),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  minimumSize: Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                icon: Icon(Icons.image, color: Colors.deepOrange),
                label: Text('menu.IMG'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => StyledMenuImagePage(
                        menuItems: _menuItems,
                        showDownloadIcon: true,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  minimumSize: Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final FileType fileType;
  final List<String> menuItems;

  const DetailPage({required this.fileType, required this.menuItems});

  Future<String> downloadFile(String url, String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/$fileName';

    if (!File(path).existsSync()) {
      try {
        await Dio().download(url, path);
      } catch (e) {
        throw Exception("Erreur téléchargement: $e");
      }
    }
    return path;
  }

  @override
  Widget build(BuildContext context) {
    String fileName = fileType == FileType.pdf ? "menu.pdf" : "menu.IMG";
    String url = fileType == FileType.pdf
        ? 'https://www.africau.edu/images/default/sample.pdf'
        : 'https://via.placeholder.com/300.png';

    return GradientScaffold(
      appBar: AppBar(
        title: Text(fileName),
        backgroundColor: Color.fromARGB(255, 227, 253, 77),
      ),
      child: Column(
        children: [
          SizedBox(height: 30),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Icon(
                fileType == FileType.pdf ? Icons.picture_as_pdf : Icons.image,
                size: 30,
              ),
              title: Text("Voir", style: TextStyle(fontSize: 18)),
              onTap: () async {
                if (fileType == FileType.pdf) {
                  String path = await downloadFile(url, fileName);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PDFViewerPage(pdfPath: path),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => StyledMenuImagePage(
                        menuItems: menuItems,
                        showDownloadIcon: false,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          SizedBox(height: 20),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Icon(Icons.download, size: 30, color: Colors.blue),
              title: Text("Télécharger", style: TextStyle(fontSize: 18, color: Colors.blue)),
              onTap: () async {
                await downloadFile(url, fileName);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$fileName téléchargé')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PDFViewerPage extends StatelessWidget {
  final String pdfPath;

  const PDFViewerPage({required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: AppBar(title: Text('PDF Viewer')),
      child: Center(
        child: Text('PDF Path: $pdfPath'),
      ),
    );
  }
}

class StyledMenuImagePage extends StatefulWidget {
  final List<String> menuItems;
  final bool showDownloadIcon;

  const StyledMenuImagePage({
    required this.menuItems,
    required this.showDownloadIcon,
  });

  @override
  State<StyledMenuImagePage> createState() => _StyledMenuImagePageState();
}

class _StyledMenuImagePageState extends State<StyledMenuImagePage> {
  final ScreenshotController _screenshotController = ScreenshotController();

  Future<void> _saveImage() async {
    final image = await _screenshotController.capture();
    if (image == null) return;

    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/menu_image.png';
    final file = File(path);
    await file.writeAsBytes(image);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Image téléchargée: menu_image.png')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: AppBar(
        title: Text("Menu du jour"),
        backgroundColor: Color.fromARGB(255, 251, 255, 0),
        actions: [
          if (widget.showDownloadIcon)
            IconButton(
              icon: Icon(Icons.download),
              onPressed: _saveImage,
            ),
        ],
      ),
      child: Screenshot(
        controller: _screenshotController,
        child: Center(
          child: Card(
            margin: EdgeInsets.all(20),
            elevation: 10,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("🍽️ Menu du jour",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                      )),
                  SizedBox(height: 20),
                  ...widget.menuItems.map(
                    (item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Row(
                        children: [
                          Icon(Icons.fastfood, color: Colors.deepOrange),
                          SizedBox(width: 10),
                          Text(item, style: TextStyle(fontSize: 18)),
                        ],
                      ),
                    ),
                  ).toList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
