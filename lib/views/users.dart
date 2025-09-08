import 'package:flutter/material.dart';
import 'package:lazyloading/api_service.dart';
import 'package:lazyloading/models/user_model.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  final ApiService _apiService = ApiService();
  final ScrollController _scrollController = ScrollController();
  List<UserModel> _users = [];
  bool isLoading = false;
  int start = 0;
  int limit = 4;
  @override
  void initState() {
    super.initState();
    fethcMoreUsers();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fethcMoreUsers();
      }
    });
  }

  Future<void> fethcMoreUsers() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });
    List<UserModel> newUsers = await _apiService.fetchUsers(start, limit);
    setState(() {
      _users.addAll(newUsers);
      start += limit;
      isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fetch Users on scroll"),
        actions: [Text('${_users.length}')],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        controller: _scrollController,
        physics: BouncingScrollPhysics(
          decelerationRate: ScrollDecelerationRate.fast,
        ),
        itemCount: _users.length + 1,
        itemBuilder: (context, index) {
          if (index < _users.length) {
            final user = _users[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 25.0),
              child: Card(
                child: Column(
                  children: [
                    const SizedBox(height: 25),
                    Text(
                      'ID: ${user.id.toString()}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 25),
                    Text(
                      'Name: ${user.name}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 25),

                    Text(
                      'Name: ${user.email}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 25),
                  ],
                ),
              ),
            );
          } else {
            return isLoading
                ? const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : const SizedBox();
          }
        },
      ),
    );
  }
}
