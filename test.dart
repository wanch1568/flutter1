import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '/view_models/select_date.dart';
import '/provider/riverpod_provider.dart';
import 'package:table_calendar/table_calendar.dart';

class MyTableCalendar extends ConsumerWidget{
    bool isChanged=false;
    DateTime _focusedDay = DateTime.now();
    DateTime? _selectedDay;
    int num=0;
    @override 
    Widget build(BuildContext context,WidgetRef ref){
        _focusedDay=ref.watch(selectedDate);
        _selectedDay=ref.watch(selectedDate);
        //ref.watch(calenderChanged);
        num+=1;
        print(num);
        print("changed!");
        return TableCalendar(
            locale: 'ja_JP',
            shouldFillViewport:true,
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
                //print(day.toString()+isSameDay(_selectedDay, day).toString());
                return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
                _selectedDay=selectedDay;
                _focusedDay=focusedDay;
                print(selectedDay);
                ref.read(selectedDate.notifier).state=selectedDay;
                print(focusedDay);
            },
            
        );
    }
}

/*class InputCalender extends ConsumerWidget{
    bool isChanged=false;
    DateTime _focusedDay = DateTime.now();
    DateTime? _selectedDay=DateTime.now();
    @override
    Widget build(BuildContext context,WidgetRef ref){
        //ref.read(selectedDate.notifier).state=DateFormat('yyyy-MM-dd').format(now);
        String formatDate=DateFormat('yyyy/MM/dd').format(ref.watch(selectedDate));

        return ElevatedButton(
            child:Text(formatDate),
            onPressed:(){
                showDialog(
                    context:context,
                    builder:(BuildContext context){
                        //ここでchangedDayの変更を監視。changedDayは日付がクリックされた際に実行されるonDaySelectedのなかで変更
                        ref.watch(changedDay);
                        
                        return Dialog(
                            child:Expanded(
                                child:SizedBox(
                                    height:MediaQuery.of(context).size.height/2,
                                    width:MediaQuery.of(context).size.width/1.2,
                                    child:TableCalendar(
                                        locale: 'ja_JP',
                                        shouldFillViewport:true,
                                        firstDay: DateTime.utc(2010, 10, 16),
                                        lastDay: DateTime.utc(2030, 3, 14),
                                        focusedDay: _focusedDay,
                                        selectedDayPredicate: (day) {
                                            //print(day.toString()+isSameDay(_selectedDay, day).toString());
                                            return isSameDay(_selectedDay, day);
                                        },
                                        onDaySelected: (selectedDay, focusedDay) {
                                            _selectedDay=selectedDay;
                                            _focusedDay=selectedDay;
                                            if(isChanged){
                                                ref.read(changedDay.notifier).state = false;
                                                isChanged=false;
                                                print("true→"+ref.read(changedDay).toString());
                                            }else{
                                                ref.read(changedDay.notifier).state = true;
                                                isChanged=true;
                                                print("false→"+ref.read(changedDay).toString());
                                            }
                                        },
                                        
                                    ),
                                ),
                            ),
                        );
                    }
                );
            }
        );
        
    }
}*/
