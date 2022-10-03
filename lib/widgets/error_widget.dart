import 'package:gym_in/services/orders_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

class ErrorBody extends ConsumerWidget {
  const ErrorBody({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: const TextStyle(fontSize: 25),
          ),
          ElevatedButton(
            onPressed: () => ref.refresh(ordersServiceProvider),
            child: const Text("Try again"),
          ),
        ],
      ),
    );
  }
}
