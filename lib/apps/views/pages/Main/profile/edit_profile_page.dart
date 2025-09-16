import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // Controllers to manage the text in TextFormFields
  final _nameController = TextEditingController(text: 'Kiplinyu');
  final _usernameController = TextEditingController(text: 'Kiplinyu');
  final _emailController = TextEditingController(text: 'Kiplinyu@gmail.com');
  final _phoneController = TextEditingController(text: '62+ 853 - 1234 - 5678');

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            PhosphorIconsRegular.caretLeft,
            color: AppColors.text,
          ),
          onPressed: () => {context.pop()},
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: AppColors.text,
            fontFamily: "SFUI",
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildProfilePicture(),
              const SizedBox(height: 32),
              _buildTextField(label: 'Name', controller: _nameController),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Username',
                controller: _usernameController,
              ),
              const SizedBox(height: 16),
              _buildTextField(label: 'Email', controller: _emailController),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Phone Number',
                controller: _phoneController,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement save logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.whiteText,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SFUI',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Widget for the circular profile picture with an edit button.
  Widget _buildProfilePicture() {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('assets/images/profile.jpg'),
            backgroundColor: AppColors.placeholder,
          ),
          Positioned(
            bottom: 0,
            right: -5,
            child: GestureDetector(
              onTap: () {
                // TODO: Implement image picker logic
              },
              child: const CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.primary,
                child: Icon(
                  PhosphorIconsRegular.pencilSimple,
                  color: AppColors.whiteText,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper widget to create a labeled text field.
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.text,
            fontFamily: 'SFUI',
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintStyle: TextStyle(
              color: AppColors.placeholder,
              fontFamily: 'SFUI',
            ),
            filled: true,
            fillColor: AppColors.card,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }
}
