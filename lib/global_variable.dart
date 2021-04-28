import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

StreamSubscription<Event> updateDoctorLocation;

StreamSubscription<Event> transactionStatusUpdate;

StreamSubscription<Event> updateDoctorTransaction;

StreamSubscription<Event> transactionMapStreamSubscription;

StreamSubscription<Event> updateDoctorTransactionChecking;

StreamSubscription<Event> updateDoctorTransactionSample;
