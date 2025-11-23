import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/route_manager.dart';
import 'package:healthy_heart_junior/core/constants/app_colors.dart';
import 'package:healthy_heart_junior/core/constants/app_styles.dart';
import 'package:healthy_heart_junior/data/models/news_model.dart';
import 'package:healthy_heart_junior/presentation/controllers/main_controller.dart';
import 'package:healthy_heart_junior/presentation/views/doctors/doctors_view.dart';
import 'package:healthy_heart_junior/presentation/views/expert_system/expert_system_view.dart';
import 'package:healthy_heart_junior/presentation/views/lab_analysis/lab_analysis_view.dart';
import 'package:healthy_heart_junior/presentation/views/news/web_view_page.dart';

class HomeView extends GetView<MainController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // الهيدر
              _buildHeader(),
              const SizedBox(height: 24),

              // شريط الأخبار
              _buildNewsSection(),
              const SizedBox(height: 24),

              // الإحصائيات الصحية
              _buildHealthStats(),
              const SizedBox(height: 24),

              // النصائح الصحية
              _buildHealthTips(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Obx(() {
      final user = controller.currentUser.value;
      return Row(
        children: [
          // صورة المستخدم
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.person, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ' ${user.name ?? "User"}',
                style: AppStyles.headlineMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                // 'Keep your heart healthy',
                'Hello',
                style: AppStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const Spacer(),
          // زر الإشعارات
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(Icons.notifications_none, color: AppColors.primary),
          ),
        ],
      );
    });
  }

  Widget _buildNewsSection() {
    final List<NewsItem> newsItems = [
    NewsItem(
      title: 'تطورات جديدة في علاج أمراض القلب',
      url: 'https://www.who.int/news-room/fact-sheets/detail/cardiovascular-diseases-(cvds)',
    ),
    NewsItem(
      title: 'أحدث أبحاث ضغط الدم المرتفع',
      url: 'https://www.heart.org/en/health-topics/high-blood-pressure',
    ),
    NewsItem(
      title: 'نصائح للحفاظ على صحة القلب',
      url: 'https://www.mayoclinic.org/healthy-lifestyle/fitness/in-depth/exercise/art-20048389',
    ),
  ];
  return SizedBox(
    height: 230,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Latest medical news',
          style: AppStyles.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: newsItems.length,
            itemBuilder: (context, index) {
              final news = newsItems[index];
              return _buildNewsCard(news);
            },
          ),
        ),
      ],
    ),
  );
}
    // return Container(
    //   height: 230,
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text(
    //         'Latest medical news',
    //         style: AppStyles.titleMedium.copyWith(
    //           fontWeight: FontWeight.bold,
    //           color: AppColors.textPrimary,
    //         ),
    //       ),
    //       const SizedBox(height: 8),
    //       Expanded(
    //         child: ListView.builder(
              // scrollDirection: Axis.horizontal,
              // itemCount: 3, // مؤقت
              // itemBuilder: (context, index) {
              //   return Container(
              //     width: 280,
              //     margin: const EdgeInsets.only(right: 12),
              //     decoration: BoxDecoration(
              //       gradient: AppColors.primaryGradient,
              //       borderRadius: BorderRadius.circular(16),
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.all(16.0),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             'New developments in heart treatment',
              //             style: AppStyles.bodyMedium.copyWith(
              //               color: Colors.white,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //           const Spacer(),
              //           Text(
              //             'Read more →',
              //             style: AppStyles.bodySmall.copyWith(
              //               color: Colors.white.withOpacity(0.8),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   );
              // },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  Widget _buildNewsCard(NewsItem news) {
  return Container(
    width: 280,
    margin: const EdgeInsets.only(right: 12),
    decoration: BoxDecoration(
      gradient: AppColors.primaryGradient,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            news.title,
            style: AppStyles.bodyMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => WebViewPage(
                url: news.url,
                title: 'الخبر الطبي',
              ));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'اقرأ المزيد →',
                  style: AppStyles.bodySmall.copyWith(
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildHealthStats() {
    return
    Column(
      children: [
        Row(
          children: [
            const SizedBox(height: 8),
            Text(
              "Services",
              style: AppStyles.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem(
              'Doctors',
              Icons.person,
              AppColors.primary,
               () => Get.to(() => const DoctorsView()),
            ),
            _buildStatItem(
              'Laboratory',
              Icons.science,
              AppColors.warning,
              () => Get.to(() => const LabAnalysisView()),
            ),
            _buildStatItem(
              'Assistant',
              Icons.medical_services,
              AppColors.success,
              () => Get.to(() => const ExpertSystemView()),
            ),
          ],
        ),
      ],
    );
    //  );
  }

  Widget _buildStatItem(
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            // shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            icon: Icon(icon),
            color: color,
            iconSize: 30,
            onPressed: onTap,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppStyles.bodySmall.copyWith(color: AppColors.textPrimary),
        ),
      ],
    );
  }

  Widget _buildHealthTips() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Health tips for you',
            style: AppStyles.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.accent.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.medical_services,
                          color: AppColors.accent,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Make sure to exercise for 30 minutes daily.',
                          style: AppStyles.bodyMedium.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
