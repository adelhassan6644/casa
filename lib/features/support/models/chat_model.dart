
import 'package:firebase_database/firebase_database.dart';



class ChatModel {
  ChatModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.studentId,
    required this.userId,
    required this.readCount,
    required this.message,
    required this.studentRead
  });
  late final int id;
  late final DateTime createdAt;
  late final DateTime updatedAt;
  late final int studentId;
  late final int userId;
  late final int readCount;
  late  int studentRead;
  late final String message;


  ChatModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);

    userId = json['user_id'];
    readCount = json['read_count'];
    studentRead = json['student_read'];
    message = json['message']??"";

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['student_id'] = studentId;
    _data['user_id'] = userId;
    _data['read_count'] = readCount;
    _data['message'] = message;

    return _data;
  }
}
class Message {
  late final String massage;
  late final DateTime date; late final String senderId;

  Message({required this.massage, required this.date, required this.senderId});
  Message.fromJson( json){
    massage = json['message']??"";
    senderId = json['sender_id'].toString();
    date = DateTime.parse(json['created_at']??DateTime.now().toString());

  }

}



