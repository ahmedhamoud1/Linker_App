import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linker/cubit/states.dart';
import 'package:sqflite/sqflite.dart';


class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(InitialState());
  static AppCubit get(context) => BlocProvider.of(context);



  // database
  Database? database;
  List<Map> linker =[];

  // create database
  void CreateDatabase() {
    openDatabase( 'linker.db', version: 1,
        onCreate: (database,version)
        {
          print('database created');
          database.execute('CREATE TABLE linker (id INTEGER PRIMARY KEY, title TEXT, link TEXT)').
          then((value)
          {
            print('table created');
          }).catchError((error) {
            print('error while creating table ${error.toString()}');
          });
        },
        onOpen: (database)
        {
          getFromDatabase(database).then((value)
          {
            linker = value;
            print(linker);
            emit(GetFromDatabaseState());
          });
          print('database opened');
        }
    ).then((value)
    {
      database = value;
      emit(CreateDatabaseState());
    });
  }

// insert to database
   InsertToDatabase({
    required String title,
    required String link,
  }) async {
     await database!.transaction((txn)
    async
    {
      txn.rawInsert('INSERT INTO linker (title, link) VALUES("$title", "$link")');
    }).then((value)
    {
      print('$value inserted successfully');
      emit(InsertToDatabaseState());

      getFromDatabase(database).then((value)
      {
        linker = value;
        print(linker);
        emit(GetFromDatabaseState());
      });
    }).catchError((onError)
    {
      print('error while inserting data');
    });
  }

  // get from database
  Future<List<Map>> getFromDatabase(database) async
  {
    return await database!.rawQuery('SELECT * FROM linker');
  }

  // delete from database

  void DeleteDatabase({
    required int id,
  }) async
  {
    database!.rawDelete
      (
      'DELETE FROM linker WHERE id = ?', [id],
    ).then((value)
    {
      getFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });



  }





  }

