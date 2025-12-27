import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ticktokclone/repos/autentication_repo.dart';
import 'package:ticktokclone/viewmodel/avartar_view_model.dart';

class Avartar extends ConsumerStatefulWidget {
  Avartar({
    super.key,
    required this.name,
    required this.hasAvatar,
    required this.uid,
  });

  String name;
  bool hasAvatar;
  String uid;

  @override
  ConsumerState<Avartar> createState() => _AvartarState(); //add for statefulwidget
}

class _AvartarState extends ConsumerState<Avartar> {
  Future<void> _onAvartarTap() async {
    final xfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
      maxHeight: 150,
      maxWidth: 150,
    );

    if (xfile != null) {
      final file = File(xfile.path);
      ref.read(avatarProvider.notifier).upLoadAvatar(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(avatarProvider).isLoading;

    return GestureDetector(
      onTap: isLoading ? null : _onAvartarTap,
      child: isLoading
          ? Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(shape: BoxShape.circle),
              width: 50,
              height: 50,
              child: CircularProgressIndicator.adaptive(),
            )
          : CircleAvatar(
              radius: 50,
              backgroundColor: Colors.lightBlue[900],
              foregroundImage: widget.hasAvatar
                  ? NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/newworld-e5f58.firebasestorage.app/o/avartars%2F${widget.uid}?alt=media",
                    )
                  : null,

              child: Text(widget.name),
            ),
    );
  }
}
