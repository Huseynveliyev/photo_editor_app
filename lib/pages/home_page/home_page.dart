import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_editor_app/const/app_colors.dart';
import 'package:photo_editor_app/notifier/image_notifier.dart';
import 'package:photo_editor_app/pages/editing_page/image_editing_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ImageNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home Page'),
        actions: [
          IconButton(
              icon: Icon(
                Icons.delete,
                color: AppColors.red,
              ),
              onPressed: () {
                provider.clearList();
              }),
        ],
      ),
      body: const ImageGrid(),
      floatingActionButton: const AddImageButton(),
    );
  }
}

class ImageGrid extends StatelessWidget {
  const ImageGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ImageNotifier>(context);

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        childAspectRatio: 140 / 220,
      ),
      itemCount: provider.images.length,
      itemBuilder: (context, index) {
        final image = provider.images[index];

        return GestureDetector(
          onTap: () => _openImage(image, context, provider),
          child: Image.file(image),
        );
      },
    );
  }

  void _openImage(File image, BuildContext context, ImageNotifier provider) {
    provider.image = image;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ImageEditingPage()),
    );
  }
}

class AddImageButton extends StatelessWidget {
  const AddImageButton({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ImageNotifier>(context, listen: false);
    return FloatingActionButton(
      onPressed: provider.pickImage,
      child: const Icon(Icons.add),
    );
  }
}
