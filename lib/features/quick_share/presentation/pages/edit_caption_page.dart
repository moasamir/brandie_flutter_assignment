import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class EditCaptionPage extends StatefulWidget {
  final String initialCaption;
  const EditCaptionPage({super.key, required this.initialCaption});

  @override
  State<EditCaptionPage> createState() => _EditCaptionPageState();
}

class _EditCaptionPageState extends State<EditCaptionPage> {
  late TextEditingController _controller;
  bool _isModified = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialCaption);
    _controller.addListener(() {
      setState(() {
        _isModified = _controller.text != widget.initialCaption;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Edit Caption', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _isModified ? () {
              // Save logic here
              Navigator.pop(context, _controller.text);
            } : null,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: _isModified ? AppColors.primary : Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text('Save', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _controller,
          maxLines: null,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          style: const TextStyle(fontSize: 16, height: 1.5),
          autofocus: true,
        ),
      ),
    );
  }
}
