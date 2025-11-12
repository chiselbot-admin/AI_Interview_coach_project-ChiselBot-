import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/storage_providers.dart';
import 'user_avatar.dart';

class MainAppbar extends ConsumerWidget implements PreferredSizeWidget {
  const MainAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () async {
                await ref.read(storageListProvider.notifier).refresh();
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu)),
          Text(
            "ChiselBot",
            style: GoogleFonts.poppins(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          UserAvatar(radius: 15)
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
