import 'package:flutter/material.dart';
import 'package:messenger/data/repositories/contact_repository.dart';
import 'package:messenger/data/services/service_locator.dart';
import 'package:messenger/logic/cubits/auth/auth_cubit.dart';
import 'package:messenger/presentation/screens/auth/login_screen.dart';
import 'package:messenger/router/app_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ContactRepository _contactRepository;
  @override
  void initState() {
    _contactRepository = getIt<ContactRepository>();
    super.initState();
  }

  void _showContactsList(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  "Contacts",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: _contactRepository.getRegisteredContacts(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Error: ${snapshot.error}"),
                          );
                        }
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        final contacts = snapshot.data!;
                        if (contacts.isEmpty) {
                          return const Center(child: Text("No contacts found"));
                        }
                        return ListView.builder(
                            itemCount: contacts.length,
                            itemBuilder: (context, index) {
                              final contact = contacts[index];
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.1),
                                  child: Text(contact["name"][0].toUpperCase()),
                                ),
                                title: Text(contact["name"]),
                                onTap: () {},
                              );
                            });
                      }),
                )
              ],
            ),
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chats",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        actions: [
          InkWell(
            onTap: () async {
              await getIt<AuthCubit>().signOut();
              getIt<AppRouter>().pushAndRemoveUntil(const LoginScreen());
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: const Center(child: Text("Welcome to the Home Screen!")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showContactsList(context),
        child: Icon(Icons.chat, color: Colors.white),
      ),
    );
  }
}
