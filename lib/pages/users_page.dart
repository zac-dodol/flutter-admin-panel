import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/user_service.dart';
import '../services/auth_service.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);
    final auth = Provider.of<AuthService>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Users", style: TextStyle(fontSize: 24)),
              ElevatedButton(
                onPressed:
                    auth.role != 'admin' ? null : () => userService.addUser(),
                child: const Text("Add User"),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              itemCount: userService.users.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final user = userService.users[index];
                final canEdit = auth.role == 'admin' || auth.role == 'editor';
                final canDelete = auth.role == 'admin';

                return ListTile(
                  title: TextField(
                    enabled: canEdit,
                    controller: TextEditingController(text: user['name']),
                    onChanged: (val) =>
                        userService.updateUser(index, 'name', val),
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                  subtitle: TextField(
                    enabled: canEdit,
                    controller: TextEditingController(text: user['email']),
                    onChanged: (val) =>
                        userService.updateUser(index, 'email', val),
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                  trailing: DropdownButton<String>(
                    value: user['role'],
                    items: const [
                      DropdownMenuItem(value: 'admin', child: Text('Admin')),
                      DropdownMenuItem(value: 'editor', child: Text('Editor')),
                      DropdownMenuItem(value: 'viewer', child: Text('Viewer')),
                    ],
                    onChanged: canEdit
                        ? (val) => userService.updateUser(index, 'role', val!)
                        : null,
                  ),
                  leading: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed:
                        canDelete ? () => userService.deleteUser(index) : null,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
