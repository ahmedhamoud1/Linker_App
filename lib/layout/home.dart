import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linker/cubit/cubit.dart';
import 'package:linker/cubit/states.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/link.dart';
import '../components/component.dart';

class Home extends StatelessWidget {

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var linkController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) =>AppCubit()..CreateDatabase(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context, state)
        {
          if(state is InsertToDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context , state)
        {
          var link = AppCubit.get(context).linker;
          AppCubit cubit = AppCubit.get(context);
          return  Scaffold(
              key: scaffoldKey,
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                leading: IconButton(
                  onPressed: ()
                  {
                    scaffoldKey.currentState!.openDrawer();
                  },
                  icon: Icon(Icons.scatter_plot,
                    color: Colors.black,
                  ),
                ),
                title: Text('Linker App',
                  style: GoogleFonts.acme(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
              ),
              drawer: Drawer(
                backgroundColor: Colors.white,
                width: 250,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50),
                        child: Image(
                          image: AssetImage('images/2.png'),
                        )
                      ),
                      Text(
                        'For technical support contact us',
                        style: GoogleFonts.acme(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children:
                        [
                          Icon(
                              Icons.link),
                          SizedBox(
                            width: 40,
                          ),
                          Link(
                            uri: Uri.parse('https://www.linkedin.com/in/ahmed-hamoud-8b0041217/'),
                            target: LinkTarget.self,
                            builder: (context,followLink) => ElevatedButton(
                              child: Text(
                                'Linked In',
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
                        ],
                      )
                    ],
                  ),
                ),
              ),
              body: ConditionalBuilder(
                  condition: link.length > 0,
                  builder: (context) => ListView.separated(
                    itemCount: link.length,
                    itemBuilder: (context, index) => BuildLinkItem(link[index], context),
                    separatorBuilder: (context, index) => SizedBox(),
                  ),
                  fallback: (BuildContext context) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('images/0.png')),
                    ),
                  )),
              floatingActionButton: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 40,
                ),
                child: FloatingActionButton(
                  backgroundColor: Colors.black,
                  onPressed: ()
                  {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('link Shortener'),
                          titleTextStyle: GoogleFonts.acme(
                              color: Colors.black,
                              fontSize: 20
                          ),
                          content: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children:
                              [
                                TextFormField(
                                  onTap: () {},
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'INVALID DATA';
                                    }
                                  },
                                  controller: titleController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              16),
                                          borderSide: BorderSide(
                                              color: Colors.black
                                          )
                                      ),
                                      prefixIcon: Icon(Icons.title,
                                        color: Colors.black,),
                                      labelText: 'Link Title',
                                      labelStyle: GoogleFonts.acme(
                                          fontSize: 15,
                                          color: Colors.black
                                      )
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  onTap: () {},
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'INVALID DATA';
                                    }
                                  },
                                  cursorColor: Colors.black,
                                  controller: linkController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      fillColor: Colors.black,
                                      focusColor: Colors.black,
                                      hoverColor: Colors.black,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              16),
                                          borderSide: BorderSide(
                                              color: Colors.black
                                          )
                                      ),
                                      prefixIcon: Icon(Icons.title,
                                        color: Colors.black,),
                                      labelText: 'Link',
                                      labelStyle: GoogleFonts.acme(
                                          fontSize: 15,
                                          color: Colors.black
                                      )),
                                ),
                              ],
                            ),
                          ),
                          actions:
                          [
                            TextButton(
                              onPressed: ()
                              {
                                if(formKey.currentState!.validate())
                                {
                                  cubit.InsertToDatabase(
                                    title: titleController.text,
                                    link: linkController.text,
                                  );
                                }
                              },
                              child: Text("Add",
                                style: GoogleFonts.acme(
                                    color: Colors.black,
                                    fontSize: 19
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: ()
                              {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel",
                                style: GoogleFonts.acme(
                                    color: Colors.black,
                                    fontSize: 19
                                ),
                              ),
                            ),
                          ],
                        )
                    );
                  },
                  child: Icon(Icons.edit),
                ),
              )
          );
        },
      ),
    );
  }
}




