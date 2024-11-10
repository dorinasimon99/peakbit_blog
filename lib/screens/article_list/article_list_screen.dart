import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:peakbit_blog/blocs/article/article_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:peakbit_blog/blocs/article_list/article_list_cubit.dart';
import 'package:peakbit_blog/common/error_screen.dart';
import 'package:peakbit_blog/models/article_list/article_item/article_item_model.dart';
import 'package:peakbit_blog/screens/article_list/article_item.dart';

import '../article/article_screen.dart';

class ArticleListScreen extends StatefulWidget {
  const ArticleListScreen({super.key});

  @override
  State<ArticleListScreen> createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<ArticleListScreen> {
  int _page = 1;
  int _maxPageCount = 0;
  final ScrollController _controller = ScrollController();
  final List<ArticleItemModel> _articles = [];

  @override
  void initState() {
    BlocProvider.of<ArticleListCubit>(context).getArticleList(page: _page);
    _controller.addListener((){
      if(_controller.hasClients) {
        if(_controller.position.atEdge && _controller.position.pixels > 0 && _maxPageCount > _page) {
          setState(() {
            _page++;
          });
          BlocProvider.of<ArticleListCubit>(context).getArticleList(page: _page);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.8),
          child: SvgPicture.asset("assets/p_logo.svg"),
        ),
        leadingWidth: 48.4,
        title: Text(
          AppLocalizations.of(context)?.blog ?? "Blog",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: SvgPicture.asset("assets/icons/menu.svg", width: 15,),
          ),
        ],
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 5,
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocConsumer<ArticleListCubit, ArticleListState>(
          listener: (context, state) {
            if(state is ArticleListSuccess) {
              setState(() {
                if(_maxPageCount == 0) {
                  _maxPageCount = state.articleList.meta.pageCount;
                }
                _articles.addAll(state.articleList.list);
              });
            }
          },
          builder: (context, state) {
            if(state is ArticleListNetworkError) {
              return ErrorScreenWidget(
                details: Text(
                  AppLocalizations.of(context)?.network_error_message ?? "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                onRefresh: () => BlocProvider.of<ArticleListCubit>(context).getArticleList(page: _page),
              );
            } else if(state is ArticleListFailure) {
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
                onRefresh: () => BlocProvider.of<ArticleListCubit>(context).getArticleList(page: _page),
              );
            } else if(state is ArticleListLoading && _articles.isEmpty) {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Lottie.asset("assets/loading.json", width: 82, height: 82),
                ),
              );
            } else {
              return OrientationBuilder(
                builder: (context, orientation) {
                  if(orientation == Orientation.portrait) {
                    return ListView.builder(
                      controller: _controller,
                      itemCount: _articles.length,
                      padding: const EdgeInsets.symmetric(horizontal: 23),
                      itemBuilder: (BuildContext context, int index) {
                        if(index == 0) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 33,),
                              Text(
                                AppLocalizations.of(context)?.newest ?? "Legfrissebb",
                                style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 19,),
                              ArticleItemWidget(
                                article: _articles[index],
                                articleContext: context,
                              ),
                            ],
                          );
                        }
                        return ArticleItemWidget(
                          article: _articles[index],
                          articleContext: context,
                        );
                      },
                    );
                  } else {
                    return SingleChildScrollView(
                      controller: _controller,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 23),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 33,),
                            Text(
                              AppLocalizations.of(context)?.newest ?? "Legfrissebb",
                              style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 19,),
                            GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _articles.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 37),
                              itemBuilder: (BuildContext context, int index) {
                                return ArticleItemWidget(
                                  article: _articles[index],
                                  articleContext: context,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                }
              );
            }
          },
        ),
      ),
    );
  }
}
