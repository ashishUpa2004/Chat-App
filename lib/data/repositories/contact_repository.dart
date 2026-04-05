import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:messenger/data/models/user_model.dart';
import 'package:messenger/data/services/base_repository.dart';

class ContactRepository extends BaseRepository {
  String get currentUserId => FirebaseAuth.instance.currentUser?.uid ?? '';

  Future<bool> requestContactsPermission() async {
    bool permissionGranted = await FlutterContacts.requestPermission();
    return permissionGranted;
  }

  /// Normalize phone number to a consistent format (10 digits without country code)
  String _normalizePhoneNumber(String phoneNumber) {
    // Remove all non-digit characters except leading +
    String normalized = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    
    // Remove leading +
    if (normalized.startsWith('+')) {
      normalized = normalized.substring(1);
    }
    
    // Remove country code (91 for India) if present
    if (normalized.startsWith('91') && normalized.length == 12) {
      normalized = normalized.substring(2);
    }
    
    // Return only the last 10 digits
    if (normalized.length > 10) {
      normalized = normalized.substring(normalized.length - 10);
    }
    
    return normalized;
  }

  Future<List<Map<String, dynamic>>> getRegisteredContacts() async {
    try {
      bool hasPermission = await requestContactsPermission();
      if (!hasPermission) {
        return [];
      }

      // Get device contacts with phone numbers
      final contacts = await FlutterContacts.getContacts(withProperties: true);

      // Extract phone numbers and normalize them
      final phoneNumbers = <Map<String, dynamic>>[];
      
      for (int i = 0; i < contacts.length; i++) {
        var contact = contacts[i];
        if (contact.phones.isNotEmpty) {
          for (int j = 0; j < contact.phones.length; j++) {
            final phone = contact.phones[j];
            final phoneNumber = phone.number ?? '';
           
            
            if (phoneNumber.isNotEmpty) {
              phoneNumbers.add({
                'name': contact.displayName,
                'phoneNumber': phoneNumber,
                'normalized': _normalizePhoneNumber(phoneNumber),
              });
              
            }
          }
        }
      }
      // Get all users from Firestore
      final usersSnapshot = await firestore.collection('users').get();
      print('DEBUG: Found ${usersSnapshot.docs.length} users in Firestore');

      final registeredUsers = usersSnapshot.docs
          .map((doc) => UserModel.fromFirestore(doc))
          .toList();

      // Match contacts with registered users
      final matchedContacts = <Map<String, dynamic>>[];
      
      for (var contact in phoneNumbers) {
        String normalizedDeviceNumber = contact["normalized"].toString();
        
        for (var user in registeredUsers) {
          if (user.uid == currentUserId) continue;
          
          String normalizedStoredNumber = _normalizePhoneNumber(user.phoneNumber);
          
          if (normalizedDeviceNumber == normalizedStoredNumber) {
            matchedContacts.add({
              'id': user.uid,
              'name': contact['name'],
              'phoneNumber': contact['phoneNumber'],
            });
            break;
          }
        }
      }
      return matchedContacts;
    } catch (e, stackTrace) {
      return [];
    }
  }
}