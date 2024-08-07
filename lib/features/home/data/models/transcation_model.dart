

class TransactionModel
{
  late final String time;
  late final String date;
  late final String category;
  late final String amount;
 late  final String type;
 late final int id;

  TransactionModel({required this.time,required this.date,required this.category,required this.amount,required this.type});

  TransactionModel.fromJson(Map<String, dynamic> json)
  {
    time = json['time'];
    date = json['date'];
    category = json['category'];
    amount = json['amount'];
    type = json['type'];
    id = json['id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['time'] = time;
    data['date'] =date;
    data['category'] = category;
    data['amount'] = amount;
    data['type'] = type;
    return data;
  }
}