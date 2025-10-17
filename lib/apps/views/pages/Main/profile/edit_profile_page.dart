import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:healing_apps/apps/models/user_model.dart';
import 'package:healing_apps/apps/providers/user_provider.dart';
import 'package:healing_apps/apps/services/backend_controller_service.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EditProfilePage extends ConsumerStatefulWidget
{
    const EditProfilePage({super.key});

    @override
    ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage>
{

    UserModel? userModel;

    // Controllers to manage the text in TextFormFields
    final _nameController = TextEditingController(text: 'null');
    final _usernameController = TextEditingController(text: 'null');
    final _emailController = TextEditingController(text: 'null@null.com');
    final _phoneController = TextEditingController(text: 'XXXXXXXXXXX');

    @override
    void dispose()
    {
        _nameController.dispose();
        _usernameController.dispose();
        _emailController.dispose();
        _phoneController.dispose();
        super.dispose();
    }

    @override
    void initState()
    {
        super.initState();
        userModel = ref.read(getUserProvider).value;
        _nameController.text = userModel?.name ?? 'X';
        _usernameController.text = userModel?.username ?? 'X';
        _emailController.text = userModel?.email ?? 'X';
        _phoneController.text = userModel?.phone ?? 'X';
        _phoneController.text = userModel?.phone ?? 'X';
    }

    void _saveProfile() async 
    {
        final updatedUser = UserModel(
            id: userModel?.id ?? '',
            username: _usernameController.text,
            name: _nameController.text,
            email: _emailController.text,
            phone: _phoneController.text,
            location: userModel?.location ?? '',
            token: userModel?.token ?? '',
        );

        final backendService = BackendControllerService();
        void onSuccess()
        {
            if (mounted) 
            {
                ScaffoldMessenger.of(context,).showSnackBar(const SnackBar(content: Text('Profile updated successfully!')));
                context.pop();
            }
            ref.watch(getUserProvider).value;
        }
        
        void onError(String message)
        {
            if (mounted) 
            {
                ScaffoldMessenger.of(
                    context,
                ).showSnackBar(SnackBar(content: Text(message)));
            }
        }
        final result = await backendService.updateUserProfile(updatedUser);
        if (result != null && result.statusCode == 200) 
        {
            Future.delayed(const Duration(seconds: 2), onSuccess);
        } 
        else 
        {
            final message = result?.data['message'] ?? 'Profile update failed. Please try again.';
            onError(message);
        }
    }

    @override
    Widget build(BuildContext context)
    {
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
                            _buildTextField(label: 'Username', controller: _usernameController,),
                            const SizedBox(height: 16),
                            _buildTextField(label: 'Email', controller: _emailController),
                            const SizedBox(height: 16),
                            _buildTextField(
                                label: 'Phone Number',
                                controller: _phoneController,
                            ),
                            const SizedBox(height: 40),
                            ElevatedButton(
                                onPressed: () async{
                                    await showDialog<void>(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                            title: const Text('Confirm Save'),
                                            content: const Text('Are you sure you want to save the changes?'),
                                            actions: [
                                                TextButton(
                                                    onPressed: () => Navigator.of(context).pop(false),
                                                    child: const Text('Cancel'),
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {
                                                        Navigator.of(context).pop(true);
                                                        _saveProfile();
                                                    },
                                                    child: const Text('Save'),
                                                ),
                                            ],
                                        ),
                                    );
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
    Widget _buildProfilePicture()
    {
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
                            onTap: ()
                            {
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
    })
    {
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
