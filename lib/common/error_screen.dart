import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

class ErrorScreenWidget extends StatelessWidget {
  final Widget details;
  final Function() onRefresh;
  final Widget? backButton;
  const ErrorScreenWidget({required this.details, required this.onRefresh, this.backButton, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(23),
          child: Column(
            children: [
              SizedBox(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 60),
                    child: SvgPicture.asset("assets/icons/magnifier.svg", height: 140),
                  ),
                ),
              ),
              Text(
                AppLocalizations.of(context)?.general_error ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 16,),
              details,
              const SizedBox(height: 41,),
              InkWell(
                onTap: () => onRefresh.call(),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFE9291B),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset("assets/icons/reload.svg", width: 21.6,),
                      const SizedBox(width: 9.15,),
                      Text(
                        AppLocalizations.of(context)?.reload ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        backButton ?? const SizedBox(),
      ],
    );
  }
}
