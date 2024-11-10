import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:lottie/lottie.dart';
import 'package:peakbit_blog/blocs/article/article_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:peakbit_blog/common/error_screen.dart';

class ArticleScreen extends StatefulWidget {
  final int id;
  const ArticleScreen({required this.id, super.key});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {

  @override
  void initState() {
    BlocProvider.of<ArticleCubit>(context).getArticle(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ArticleCubit, ArticleState>(
          builder: (context, state) {
            if(state is ArticleSuccess) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(28),
                              child: Image.network(
                                state.article.imageUrl,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                                errorBuilder: (context, object, stackTrace) => Center(child: SvgPicture.asset("assets/icons/magnifier.svg", height: 140,)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 13, right: 13, bottom: 20),
                            child: Text(
                              state.article.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 28,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 13, right: 13, bottom: 24),
                            child: HtmlWidget(
                              state.article.description,
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  backButton,
                ],
              );
            } else if(state is ArticleNetworkError) {
              return ErrorScreenWidget(
                details: Text(
                  AppLocalizations.of(context)?.network_error_message ?? "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                onRefresh: () => BlocProvider.of<ArticleCubit>(context).getArticle(id: widget.id),
                backButton: backButton,
              );
            } else if(state is ArticleFailure) {
              return ErrorScreenWidget(
                details: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)?.general_error_message ?? "",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: state.errorMessage != null ? 10 : 0,),
                    state.errorMessage != null ? Text(
                      "(${state.errorMessage!})",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ) : const SizedBox(),
                  ],
                ),
                onRefresh: () => BlocProvider.of<ArticleCubit>(context).getArticle(id: widget.id),
                backButton: backButton,
              );
            } else {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Lottie.asset("assets/loading.json", width: 82, height: 82),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget get backButton {
    return Positioned(
      top: 16,
      left: 13,
      child: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: SvgPicture.asset("assets/icons/back_btn.svg", width: 24, height: 24,),
      ),
    );
  }
}
