import 'package:adminpanel/api/fee_api.dart';
import 'package:adminpanel/api/teacher_api.dart';
import 'package:adminpanel/model/allmodels.dart';
import 'package:adminpanel/notifier/auth_notifier.dart';
import 'package:adminpanel/notifier/fee_notifier.dart';
import 'package:adminpanel/notifier/teacher_notifier.dart';
import 'package:adminpanel/screens/detail.dart';
import 'package:adminpanel/screens/fee_form.dart';
import 'package:adminpanel/screens/fees.dart';
import 'package:adminpanel/screens/FeeDetail.dart';
import 'package:flutter/material.dart';
import 'package:adminpanel/screens/professors.dart';
import 'package:provider/provider.dart';

class ViewFee extends StatefulWidget {
  @override
  _ViewFeeState createState() => _ViewFeeState();
}

class _ViewFeeState extends State<ViewFee> {
  @override
  void initState() {
    TeacherNotifier teacherNotifier =
        Provider.of<TeacherNotifier>(context, listen: false);
    getTeachers(teacherNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    FeeNotifier feeNotifier = Provider.of<FeeNotifier>(context);

    _onFeeDeleted(Fee fee) {
      Navigator.pop(context);
      feeNotifier.deleteFee(fee);
    }

    Future<void> _refreshList() async {
      getFee(feeNotifier);
    }

    print("building View fee");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: new Icon(Icons.arrow_back),
            color: Colors.white,
            iconSize: 40,
            highlightColor: Colors.pink,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Fees(),
                ),
              );
            }),
        title: Text("Fee List"),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      body: new RefreshIndicator(
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text('Class:   ' + feeNotifier.feeList[index].className),
              subtitle: Text('Fee:  ' + feeNotifier.feeList[index].fee),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  new IconButton(
                    icon: new Icon(Icons.edit),
                    highlightColor: Colors.pink,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return FeeForm(
                            isUpdating: true,
                          );
                        }),
                      );
                    },
                  ),
                  new IconButton(
                    icon: new Icon(Icons.delete),
                    highlightColor: Colors.pink,
                    onPressed: () {
                      deleteFee(feeNotifier.currentFee, _onFeeDeleted);
                    },
                  ),
                ],
              ),
            );
          },
          itemCount: feeNotifier.feeList.length,
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: Colors.black,
            );
          },
        ),
        onRefresh: _refreshList,
      ),
    );
  }
}
