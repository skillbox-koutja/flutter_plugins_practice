import 'package:flutter/material.dart';

class StatusView extends StatelessWidget {
  final List<Widget> children;

  const StatusView({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }
}

class LoadingStatusView extends StatelessWidget {
  const LoadingStatusView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const StatusView(
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: CircularProgressIndicator(),
        ),
        Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text('Awaiting result...'),
        ),
      ],
    );
  }
}

class ErrorStatusView extends StatelessWidget {
  final String errorMessage;

  const ErrorStatusView({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return StatusView(
      children: [
        const Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 60,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text('Error: $errorMessage'),
        ),
      ],
    );
  }
}
