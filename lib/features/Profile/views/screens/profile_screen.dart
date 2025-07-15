import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t1/features/Profile/manager/cubit/profile_cubit.dart';
import '../../data/model/profile_model.dart';
import '../../manager/cubit/profile_state.dart';
import 'dart:ui'; // Required for BackdropFilter

class ProfileScreen extends StatelessWidget {
  static String id = "/ProfileScreen";
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => ProfileCubit()..getUserData(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA), // A light grey background
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileError) {
              return Center(child: Text("خطأ: ${state.message}"));
            } else if (state is ProfileSuccess) {
              final Data? user = state.profileData.data;
              if (user == null) {
                return const Center(child: Text("لم يتم العثور على بيانات."));
              }

              // --- ✨ New Elegant and Clear Design ✨ ---
              return CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    expandedHeight: 250.0,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    pinned: true,
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          // Background Image
                          Image.network(
                            'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=800&q=80',
                            fit: BoxFit.cover,
                          ),
                          // Gradient Overlay
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                          // User Info in the Header
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.white,
                                  backgroundImage: AssetImage("assets/Frame 21 (1).png"),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  user.fullname ?? "اسم المستخدم",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                    shadows: [Shadow(blurRadius: 2, color: Colors.black45)],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  user.username ?? "Username",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // --- Main content area with user details ---
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildSectionTitle("المعلومات الشخصية"),
                          UserInfoCard(
                            icon: Icons.email_outlined,
                            label: "البريد الإلكتروني",
                            value: user.email ?? 'غير متوفر',
                            iconColor: Colors.red,
                          ),
                          UserInfoCard(
                            icon: Icons.phone_outlined,
                            label: "رقم الهاتف",
                            value: user.phoneNo ?? 'غير متوفر',
                            iconColor: Colors.green,
                          ),
                          const SizedBox(height: 24),
                          buildSectionTitle("المعلومات الأكاديمية"),
                          // Academic info in grid layout like the image
                          Row(
                            children: [
                              Expanded(
                                child: AcademicInfoCard(
                                  icon: Icons.school,
                                  label: "الجامعة",
                                  value: user.universityCode ?? 'غير متوفر',
                                  iconColor: Colors.blue,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: AcademicInfoCard(
                                  icon: Icons.layers,
                                  label: "الفرقة",
                                  value: user.level?.toString() ?? 'غير متوفر',
                                  iconColor: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }
            return const Center(child: Text("جاري تحميل البيانات..."));
          },
        ),
      ),
    );
  }

  // Helper widget to build section titles
  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF343A40),
        ),
      ),
    );
  }
}

// --- ✨ A clearer and more functional UserInfoCard ✨ ---
class UserInfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color iconColor;

  const UserInfoCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.iconColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF495057),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- ✨ New Academic Info Card for Grid Layout ✨ ---
class AcademicInfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color iconColor;

  const AcademicInfoCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.iconColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 32),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF343A40),
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}