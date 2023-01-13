// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CustomError extends Equatable {
  final String code;
  final String errorMsg;
  final String plugin;
  CustomError({
    this.code = '',
    this.errorMsg = '',
    this.plugin = '',
  });

  @override
  List<Object> get props => [code, errorMsg, plugin];

  @override
  bool get stringify => true;
}
