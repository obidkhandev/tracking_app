import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_distance/core/utils/size_config.dart';
import 'package:track_distance/core/values/app_colors.dart';
import 'package:track_distance/core/widgets/custom_button.dart';
import 'package:track_distance/presentation/cubit/tracking_cubit.dart';
// import 'package:track_distance/presentation/screens/tracking/widget/bar_chart.dart';
import 'package:track_distance/presentation/screens/tracking/widget/tab_button.dart';
import 'package:track_distance/presentation/screens/tracking/widget/top_section.dart';



// Main Screen
class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrackingCubit(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          scrolledUnderElevation: 0,
          backgroundColor: AppColors.white,
          title: const Text(
            "Masofa Kuzatish",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: BlocBuilder<TrackingCubit, TrackingState>(
          builder: (context, state) {
        final bloc = context.read<TrackingCubit>();
            return Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: wi(12), vertical: he(20)),
              child: Column(
                children: [
                  const TopSection(),
                  SizedBox(height: he(20)),
                  CustomButton(
                    text: "${state.totalDistance.toStringAsFixed(1)} qadam",
                    fontSize: 20,
                    fontW: FontWeight.w600,
                    radius: BorderRadius.circular(10),
                    onTap: () {},
                  ),
                  SizedBox(height: he(20)),
                  Expanded(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: wi(10),
                          vertical: he(20),
                        ),
                        child: Column(
                          children: [
                            const Spacer(),
                            CustomButton(
                              text: "Boshlash",
                              onTap: () async {
                                await bloc.startTracking();
                              },

                            ),
                            SizedBox(height: he(10)),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomButton(
                                    text: "Kutish",
                                    onTap: () {},
                                  ),
                                ),
                                SizedBox(width: wi(10)),
                                Expanded(
                                  child: CustomButton(
                                    text: "Kutishni to‘xtatish",
                                    onTap: () {},
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
