import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_crud_bloc/locator.dart';
import 'package:simple_crud_bloc/ui/posts/bloc/posts_cubit.dart';
import 'package:simple_crud_bloc/ui/posts/widget/post_card_widget.dart';
import 'package:simple_crud_bloc/ui/widgets/scren_loading_wrapper.dart';
import 'package:simple_crud_bloc/utils/res_color.dart';
import 'package:simple_crud_bloc/utils/size_config.dart';


class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(MediaQuery.of(context).size);
    return BlocProvider(
      create: (context) => locator<PostsCubit>()..init(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ResColor.colorPrimary,
          title: const Text('JSONPlaceHolder Posts'),
        ),
        body: const _PostList(),
      ),
    );
  }
}

class _PostList extends StatelessWidget {
  const _PostList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<PostsCubit>().getPosts();
      },
      child: BlocBuilder<PostsCubit, PostsState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const ScreenLoadingWrapper();
          }

          if (state.status.isFailure) {
            return ListView(
              children:  [
                SizedBox(height: SizeConfig.screenWidth/3,),
                const Center(child: Text("Something went wrong")),
              ],
            );
          }

          if (state.posts.isEmpty) {
            return ListView(
              children:  [
                SizedBox(height: SizeConfig.screenWidth/3,),
                const Center(child: Text("Data not found")),
              ],
            );
          }
          if (state.status.isSuccess) {
            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return PostCardWidget(
                  data: state.posts[index],
                  onTap: () {

                  },
                );
              },
              itemCount: state.posts.length,
            );
          }
          return Container();
        },
      ),
    );
  }
}

