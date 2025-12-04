import 'package:flutter/material.dart';

abstract class NotificationService {
  Future<void> initialize();
  Future<String> getToken();
}
