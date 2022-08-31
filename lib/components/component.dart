import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linker/cubit/cubit.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

Widget BuildLinkItem(Map model, context) => Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        AppCubit.get(context).DeleteDatabase(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Center(
              child: Link(
                uri: Uri.parse('${model['link']}'),
                target: LinkTarget.self,
                builder: (context,followLink) => ElevatedButton(
                  child: Text(
                    '${model['title']}',
                    style: GoogleFonts.acme(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: followLink,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                  ),
                ),
              ),
            )
          ),
        ),
      ),
    );
