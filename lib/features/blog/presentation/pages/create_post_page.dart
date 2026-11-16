import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_pallete.dart';
import '../../data/models/blog_post.dart';
import '../bloc/blog_cubit.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _excerptController = TextEditingController();
  final _categoryController = TextEditingController(text: 'Lifestyle');

  @override
  void dispose() {
    _titleController.dispose();
    _excerptController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final post = BlogPost(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      excerpt: _excerptController.text.trim(),
      category: _categoryController.text.trim().isEmpty
          ? 'Lifestyle'
          : _categoryController.text.trim(),
      author: 'You',
      imageUrl: 'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?auto=format&fit=crop&w=800&q=80',
      readTime: '3 min read',
      likes: 0,
      featured: false,
    );

    context.read<BlogCubit>().addPost(post);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.background,
      appBar: AppBar(
        backgroundColor: AppPalette.background,
        title: const Text('Write a story'),
        foregroundColor: AppPalette.textPrimary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tell the world your latest idea',
                  style: TextStyle(
                    color: AppPalette.textPrimary,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 24),
                _buildField(
                  label: 'Title',
                  controller: _titleController,
                  maxLines: 1,
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Add a title'
                      : null,
                ),
                const SizedBox(height: 18),
                _buildField(
                  label: 'Category',
                  controller: _categoryController,
                  maxLines: 1,
                ),
                const SizedBox(height: 18),
                _buildField(
                  label: 'Excerpt',
                  controller: _excerptController,
                  maxLines: 5,
                  validator: (value) =>
                      value == null || value.trim().length < 10
                      ? 'Write a bit more'
                      : null,
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppPalette.accent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Publish story',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      style: const TextStyle(color: AppPalette.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppPalette.textSecondary),
        filled: true,
        fillColor: AppPalette.panel,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppPalette.accentSecondary,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
