import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_heart_junior/core/constants/app_colors.dart';
import 'package:healthy_heart_junior/core/constants/app_styles.dart';
import 'package:healthy_heart_junior/data/models/doctor_model.dart';
import 'package:healthy_heart_junior/presentation/controllers/doctors_controller.dart';

class DoctorsView extends GetView<DoctorsController> {
  const DoctorsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildFilters(),
              const SizedBox(height: 20),
              Expanded(child: _buildDoctorsList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
        ),
        const SizedBox(width: 8),
        Text(
          'الأطباء المقترحين',
          style: AppStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () => controller.refreshDoctors(),
          icon: Icon(Icons.refresh, color: AppColors.primary),
        ),
      ],
    );
  }

  Widget _buildFilters() {
    return Row(
      children: [
        // Expanded(
        //   child: Obx(() =>Container(
        //     padding: const EdgeInsets.symmetric(horizontal: 16),
        //     decoration: BoxDecoration(
        //       color: AppColors.surface,
        //       borderRadius: BorderRadius.circular(12),
        //       border: Border.all(color: AppColors.textSecondary.withOpacity(0.3)),
        //     ),
        //     child: DropdownButtonHideUnderline(
        //       child: DropdownButton<String>(
        //         value: controller.selectedSpecialty.value,
        //         onChanged: (value) => controller.filterBySpecialty(value!),
        //         items: ['جميع التخصصات', 'أمراض القلب', 'جراحة القلب', 'طب الأسرة']
        //             .map((specialty) => DropdownMenuItem(
        //                   value: specialty,
        //                   child: Text(specialty),
        //                 ))
        //             .toList(),
        //       ),
        //     ),
        //   ),
        // ),
        // ),
        // const SizedBox(width: 12),
         Obx(() =>Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.textSecondary.withOpacity(0.3)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: controller.sortBy.value,
              onChanged: (value) => controller.sortDoctors(value!),
              items: ['الأقرب', 'الأعلى تقييماً']
                  .map((sort) => DropdownMenuItem(
                        value: sort,
                        child: Text(sort),
                      ))
                  .toList(),
            ),
          ),
        ),
         ),
      ],
    );
  }

  Widget _buildDoctorsList() {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: AppColors.primary),
              const SizedBox(height: 16),
              Text('جاري البحث عن الأطباء...', style: AppStyles.bodyMedium),
            ],
          ),
        );
      }

      if (controller.doctors.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.medical_services, size: 60, color: AppColors.textSecondary),
              const SizedBox(height: 16),
              Text('لا توجد أطباء متاحين', style: AppStyles.bodyMedium),
            ],
          ),
        );
      }

      return ListView.builder(
        itemCount: controller.doctors.length,
        itemBuilder: (context, index) {
          final doctor = controller.doctors[index];
          return _buildDoctorCard(doctor);
        },
      );
    });
  }

  Widget _buildDoctorCard(DoctorModel doctor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // صورة الطبيب
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(doctor.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.name,
                  style: AppStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  doctor.specialty,
                  style: AppStyles.bodyMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  doctor.hospital,
                  style: AppStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(
                      '${doctor.distance.toStringAsFixed(1)} كم',
                      style: AppStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.star, size: 16, color: AppColors.warning),
                    const SizedBox(width: 4),
                    Text(
                      doctor.rating.toStringAsFixed(1),
                      style: AppStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => controller.contactDoctor(doctor),
            icon: Icon(Icons.phone, color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}