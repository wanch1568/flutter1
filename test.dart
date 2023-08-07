class InputCalender extends ConsumerWidget{
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
}
