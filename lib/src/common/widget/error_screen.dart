import 'package:flutter/material.dart';

/// ErrorScreen widget
class ErrorScreen extends StatelessWidget {
  const ErrorScreen({this.exception, super.key});

  final Exception? exception;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: Text(exception.toString()));
}
