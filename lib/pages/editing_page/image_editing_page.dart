import 'package:flutter/material.dart';
import 'package:photo_editor_app/notifier/image_notifier.dart';
import 'package:provider/provider.dart';

class ImageEditingPage extends StatelessWidget {
  const ImageEditingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit Image'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {},
          ),
        ],
      ),
      body: const ImageEditingBody(),
    );
  }
}

class ImageEditingBody extends StatelessWidget {
  const ImageEditingBody({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ImageNotifier>(context);
    final image = provider.image;

    if (image == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.7,
            child: Image.file(image),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: provider.cropImage,
                child: const Text('Edit image'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
