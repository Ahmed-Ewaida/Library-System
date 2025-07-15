import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:t1/features/Projects/manager/cubit/project_details_cubit.dart';
import 'package:t1/features/Projects/views/screens/pdf_viewer_screen.dart';
import '../../../../Core/custom_appBar.dart';
import '../../data/model/projects_model.dart';
import '../../manager/cubit/progect_state.dart';

class ProjectDetails extends StatelessWidget {
  final int projectId; // ✅ أصبحت الشاشة تستقبل الـ ID فقط

  const ProjectDetails({super.key, required this.projectId});

  static String id = "/ProjectDetails";

  @override
  Widget build(BuildContext context) {
    const String projectPdfUrl = "https://ebel-kliniken.com/fileadmin/user_upload/demo/dokument-2.pdf";

    return BlocProvider(
      create: (context) => ProjectDetailsCubit()..fetchProjectDetails(projectId),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(),
        body: BlocBuilder<ProjectDetailsCubit, ProjectDetailsState>(
          builder: (context, state) {
            // حالة التحميل
            if (state is ProjectDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            // حالة النجاح في جلب البيانات
            if (state is ProjectDetailsSuccess) {
              final project = state.project; // ✅ البيانات الكاملة للمشروع
              return buildProjectDetailsView(context, project, projectPdfUrl);
            }

            // حالة الخطأ
            if (state is ProjectDetailsError) {
              return Center(child: Text('حدث خطأ: ${state.message}'));
            }

            // الحالة الأولية
            return const Center(child: Text("جاري تحميل تفاصيل المشروع..."));
          },
        ),
      ),
    );
  }

  // ويدجت لعرض التفاصيل بعد تحميلها
  Widget buildProjectDetailsView(BuildContext context, Projects project, String defaultPdfUrl) {
    return SingleChildScrollView( // لتجنب أي مشاكل في حجم الشاشة
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          Center(
            child: Column(
              children: [
                Image.asset(
                  "assets/Gemini_Generated_Image_bwtuzibwtuzibwtu.png",
                  width: 150,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10),
                Text('اسم المشروع: ${project.projectName ?? "غير محدد"}'),
                Text('اسم المشرف: ${project.supervisor ?? "غير محدد"}'),
                Text('القسم: ${project.department ?? "غير محدد"}'),
                // ✅ البيانات الآن ستظهر بشكل صحيح
                Text('المكان: ${project.place ?? "غير محدد"}'),
                Text('رقم الرف: ${project.shelfNo ?? "غير محدد"}'),
                Text('تاريخ المشروع: ${project.projectDate ?? "غير محدد"}'),
                Text(
                  'حالة المشروع: ${project.status == "available" ? "متوفر" : "غير متوفر"}',
                  style: TextStyle(
                    color: project.status == "available" ? Colors.green : Colors.red,
                  ),
                ),
                const Text(' ⭐⭐⭐⭐⭐'),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Center(
            child: Container(
              width: 250,
              child: ElevatedButton(
                onPressed: () {
                  context.push(PdfViewerScreen.id, extra: project.pdfUrl ?? defaultPdfUrl);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(7),
                  backgroundColor: const Color(0XFF0C8CE9),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('قراءة المشروع', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}