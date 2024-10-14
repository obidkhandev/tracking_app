import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_distance/core/utils/size_config.dart';
import 'package:track_distance/core/values/app_colors.dart';
import 'package:track_distance/presentation/cubit/tracking_cubit.dart';
import 'package:track_distance/presentation/screens/tracking/widget/animated_cicular_progress.dart';
import 'package:track_distance/presentation/screens/tracking/widget/tab_button.dart';

class TopSection extends StatelessWidget {
  const TopSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackingCubit, TrackingState>(
      builder: (context, state) {
        final bloc = context.read<TrackingCubit>();
        return Expanded(
          flex: 2,
          child: SizedBox(
            width: double.infinity,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: AppColors.white,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: he(10),
                  top: he(20),
                  left: wi(10),
                  right: wi(10),
                ),
                child: Column(
                  children: [
                    const TabButton(
                      text: "Today",
                    ),
                    SizedBox(height: he(40)),
                    Stack(
                      alignment: Alignment.center, // Ensure all children are centered
                      children: [
                        AnimatedCircularProgress(
                          currentStep: state.totalDistance,
                          totalSteps: 10000,
                          progressColor: AppColors.primaryColor, // Progress circle color
                          backgroundColor: Colors.grey.shade300, // Background circle color
                          strokeWidth: 20,
                        ),
                         Center(
                          child: Text(
                            state.totalDistance.toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center, // Center align the text itself
                          ),
                        ),
                      ],
                    ),
                   const Spacer(),
                    const Text(
                      'Sizning maqsadingiz: 10 000 qadam',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center, // Center align the text itself
                    ),
                    SizedBox(height: he(30)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
