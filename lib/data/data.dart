import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<Map<String, dynamic>> transactionData = [
  {
    'icon': const FaIcon(
      FontAwesomeIcons.burger,
      color: Colors.white,
    ),
    'color': Colors.pink,
    'name': 'Food',
    'totalAmount': '-28.67/-',
    'date': 'Today',
  },
  {
    'icon': const FaIcon(
      FontAwesomeIcons.bagShopping,
      color: Colors.white,
    ),
    'color': Colors.purple,
    'name': 'Shopping',
    'totalAmount': '-489.99/-',
    'date': 'Today',
  },
  {
    'icon': const FaIcon(
      FontAwesomeIcons.heartCircleCheck,
      color: Colors.white,
    ),
    'color': Colors.green,
    'name': 'Health',
    'totalAmount': '-100.00/-',
    'date': 'Yesterday',
  },
  {
    'icon': const FaIcon(
      FontAwesomeIcons.bus,
      color: Colors.white,
    ),
    'color': Colors.orange[400],
    'name': 'Travel',
    'totalAmount': '-40.00/-',
    'date': 'Yesterday',
  },
];
