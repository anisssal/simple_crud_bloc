import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_crud_bloc/data/models/post_model.dart';
import 'package:simple_crud_bloc/ui/post_input/bloc/post_input_cubit.dart';
import 'package:simple_crud_bloc/ui/widgets/scren_loading_wrapper.dart';

import '../../locator.dart';
import '../../utils/message_util.dart';
import '../../utils/res_color.dart';
import '../widgets/input_text.dart';
import '../widgets/submit_button.dart';

class PostInputScreen extends StatelessWidget {
  final PostModel? existingPost;

  static route({PostModel? model}) {
    return MaterialPageRoute(
        builder: (ctx) => BlocProvider(
              create: (context) =>
                  locator<PostsInputCubit>()..init(post: model),
              child: PostInputScreen(
                existingPost: model,
              ),
            ));
  }

  const PostInputScreen({Key? key, this.existingPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<PostsInputCubit>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ResColor.colorPrimary,
        title: Text(title),
        actions: [
          if(existingPost!=null)
          IconButton(
              onPressed: () async{
                final result = await _showAlertDelete(context);
                if(result !=null&& result as bool) {
                  cubit.deletePost();
                }
              },
              icon: const Icon(
                Icons.close,
                color: Colors.white,
                semanticLabel: 'Delete',
              ))
        ],
      ),
      body: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: _PostForm(),
          ),
          BlocConsumer<PostsInputCubit, PostsInputState>(
            listener: (context, state) {
              if (state.status.isSuccess || state.deleteStatus.isSuccess) {
                Navigator.of(context).pop(true);
              }
              if (state.status.isSuccess && state.isEditMode) {
                MessageUtil.showSuccessOverlay(context,
                    message: 'Berhasil mengupdate post');
              }
              if (state.status.isSuccess && !state.isEditMode) {
                MessageUtil.showSuccessOverlay(context,
                    message: 'Berhasil menyimpan post');
              }
              if (state.deleteStatus.isSuccess) {
                MessageUtil.showSuccessOverlay(context,
                    message: 'Berhasil delete post');
              }

              if((state.status.isFailure || state.deleteStatus.isFailure) && state.errorMessage!=null) {
                MessageUtil.showErrorOverlay(context, message: state.errorMessage!);
              }
            },
            builder: (context, state) {
              if (state.status.isLoading || state.deleteStatus.isLoading) return const ScreenLoadingWrapper();
              return const SizedBox();

            },
          )
        ],
      ),
    );
  }

   _showAlertDelete(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hapus Post'),
          content: const Text('Apakah anda yakin ingin menghapus post ini ? '),
          actions: <Widget>[
            TextButton(
              child: const Text('Tidak'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('OKE'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }


  String get title {
    return existingPost != null ? 'Edit Post' : 'Input Post';
  }
}

class _PostForm extends StatefulWidget {
  const _PostForm({Key? key}) : super(key: key);

  @override
  State<_PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<_PostForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PostsInputCubit>();

    return Form(
        key: _formKey,
        child: BlocBuilder<PostsInputCubit, PostsInputState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 12,
                ),
                InputText(
                  "Title",
                  hint: "Masukkan post title",
                  required: true,
                  textInputAction: TextInputAction.next,
                  initialValue: state.post?.title,
                  onSaved: (value) {
                    cubit.setPostTitle(value ?? '');
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                InputText(
                  "Body",
                  hint: "Masukkan post body",
                  required: true,
                  textInputAction: TextInputAction.done,
                  minLines: 3,
                  maxLines: 6,
                  initialValue: state.post?.body,
                  onSaved: (value) {
                    cubit.setPostBody(value ?? '');
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SubmitButton.primaryGradient(
                  title: state.isEditMode ? 'Update' : 'Simpan',
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    _formKey.currentState!.save();
                    if (!_formKey.currentState!.validate()) {
                      MessageUtil.showErrorOverlay(context,
                          message: "Periksa kembali form isian Anda");
                      return;
                    }
                    context.read<PostsInputCubit>().submitPostInput();
                  },
                  borderRadius: 16,
                  fontSize: 16,
                  fontColor: Colors.white,
                ),
              ],
            );
          },
        ));
  }
}
