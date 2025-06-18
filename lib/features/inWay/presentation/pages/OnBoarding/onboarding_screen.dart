import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inway/cashe_helper.dart';
import 'package:inway/features/inWay/presentation/constants/color_manger.dart';
import 'package:inway/features/inWay/presentation/constants/image_manger.dart';
import 'package:inway/features/inWay/presentation/constants/navigation_manger.dart';
import 'package:inway/features/inWay/presentation/cubit/inway_cubit.dart';
import 'package:inway/features/inWay/presentation/pages/OnBoarding/onboarding_model.dart';
import 'package:inway/features/inWay/presentation/pages/singup/register.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../widgets/onboarding_widget.dart';

// ignore: must_be_immutable
class OnBoarding extends StatelessWidget {
  OnBoarding({super.key});
  LiquidController controller = LiquidController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final pages = [
      OnBoardingScreen(
          model: OnBoardingModel(
              AppImagesAssets.onboarding1,
              'Una App diseñada para facilitar tu proceso de paqueteria, y mudanza al alcance de tu mano.',
              size.height,
              ColorApp.green,
              'Bienvenidos a GoCargo')),
      OnBoardingScreen(
          model: OnBoardingModel(
              AppImagesAssets.onboarding2,
              'Conectate con conductores mediante nuestra app de manera rápida, sencilla, y fácil de usar.',
              size.height,
              ColorApp.sky,
              'Solicita Fletes de Forma Segura')),
      OnBoardingScreen(
          model: OnBoardingModel(
              AppImagesAssets.onboarding3,
              'Elige entre nuestras opciones disponibles para completar tu pago.',
              size.height,
              ColorApp.deepblue,
              'Elige tu Método de Pago'))
    ];
    return BlocProvider(
      create: (context) => InwayCubit(),
      child: BlocConsumer<InwayCubit, InwayState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = InwayCubit.get(context);
          return Scaffold(
            body: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                LiquidSwipe(
                  pages: pages,
                  slideIconWidget: cubit.curentpage == 2
                      ? const Column()
                      : const Icon(Icons.arrow_back_ios),
                  enableSideReveal: true,
                  liquidController: controller,
                  fullTransitionValue: 450,
                  onPageChangeCallback: (activePageIndex) =>
                      cubit.changeindactor(activePageIndex),
                  enableLoop: false,
                ),
                Positioned(
                    bottom: 25,
                    child: AnimatedSmoothIndicator(
                      activeIndex: controller.currentPage,
                      count: 3,
                      effect: const WormEffect(
                          dotHeight: 10, spacing: 8, radius: 15),
                    )),
                if (cubit.curentpage == 2)
                  Positioned(
                      bottom: 45,
                      right: 30,
                      child: FloatingActionButton(
                        onPressed: () {
                          cubit.onboarding = true;
                          CasheHelper.savedata('onboarding', cubit.onboarding)
                              .then((value) {
                            return slideRightNaviget(
                                const RegisterScreen(), context);
                          });
                        },
                        child: const Icon(Icons.arrow_forward_ios),
                      ))
              ],
            ),
          );
        },
      ),
    );
  }
}
