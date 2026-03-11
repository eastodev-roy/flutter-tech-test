import 'package:assignment_app/core/services/theme_service.dart';
import 'package:assignment_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Get.find<ThemeService>();
    final authController = Get.find<AuthController>();

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20.h),
          // Profile Section
          Obx(() => _buildProfileHeader(authController)),
          SizedBox(height: 32.h),

          // Preferences Section
          _buildSectionTitle('PREFERENCES'),
          _buildSettingsCard(
            children: [
              _buildSwitchTile(
                icon: Icons.dark_mode_outlined,
                title: 'Dark Mode',
                value: Get.isDarkMode,
                onChanged: (_) => themeService.switchTheme(),
              ),
              const Divider(height: 1),
              _buildSwitchTile(
                icon: Icons.notifications_none_outlined,
                title: 'Push Notifications',
                value: true,
                onChanged: (val) {},
              ),
            ],
          ),

          SizedBox(height: 24.h),

          // Account Section
          _buildSectionTitle('ACCOUNT'),
          _buildSettingsCard(
            children: [
              _buildNavigationTile(
                icon: Icons.shield_outlined,
                title: 'Privacy & Security',
                onTap: () {},
              ),
              const Divider(height: 1),
              _buildNavigationTile(
                icon: Icons.help_outline,
                title: 'Support',
                onTap: () {},
              ),
            ],
          ),

          SizedBox(height: 32.h),

          // Logout Button
          _buildLogoutButton(authController),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(AuthController controller) {
    final user = controller.user.value;
    return Column(
      children: [
        CircleAvatar(
          radius: 50.r,
          backgroundColor: Colors.blue[50],
          backgroundImage: user?.image != null && user!.image.isNotEmpty
              ? NetworkImage(user.image)
              : const NetworkImage('https://i.pravatar.cc/150?u=alex'),
        ),
        SizedBox(height: 16.h),
        Text(
          user?.fullName ?? 'Guest User',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4.h),
        Text(
          user?.email ?? 'guest@example.com',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
        SizedBox(height: 16.h),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple[50],
            foregroundColor: Colors.deepPurple,
            elevation: 0,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
          child: Text(
            'Edit Profile',
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, bottom: 8.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey[300],
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsCard({required List<Widget> children}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: Colors.deepPurple[50],
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(icon, color: Colors.deepPurple, size: 20.sp),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.deepPurple,
      ),
    );
  }

  Widget _buildNavigationTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: Colors.deepPurple[50],
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(icon, color: Colors.deepPurple, size: 20.sp),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.grey, size: 20.sp),
    );
  }

  Widget _buildLogoutButton(AuthController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {
          controller.logout();
        },
        icon: const Icon(Icons.logout, color: Colors.redAccent),
        label: const Text('Logout'),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.redAccent,
          side: const BorderSide(color: Colors.redAccent, width: 0.5),
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
    );
  }
}
