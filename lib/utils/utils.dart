
import 'package:intl/intl.dart';

String formatDatetime(int epoch)=> new DateFormat("dd-MM-yyyy").format(DateTime.fromMillisecondsSinceEpoch(epoch));