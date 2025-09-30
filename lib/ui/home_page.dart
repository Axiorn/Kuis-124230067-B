import 'package:flutter/material.dart';
import 'package:kuis_ppam_067/ui/login_page.dart';
import 'package:kuis_ppam_067/ui/detail_page.dart';
import 'package:kuis_ppam_067/models/game_model.dart';

class HomePage extends StatelessWidget {
  final String username;
  const HomePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halo, $username Welcome Back!'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 14),
            SearchBar(
              hintText: "Search Game",
            ),
            const SizedBox(height: 26),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: gameList.length,

                  itemBuilder: (BuildContext context, int index) {
                    return _menuItem(context, index);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(context, index) {
  return InkWell(
    onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DetailPage(game: index);
        }));
      },
    child: Container(
        decoration:BoxDecoration(
          color: const Color.fromARGB(255, 209, 231, 241),
          // border: Border.all(width: 1),
          borderRadius:BorderRadius.circular(20)
        ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          child: SizedBox(
            height: 120,
            width: double.infinity,
            child: Image.asset(
              gameList[index].gameImg,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                gameList[index].gameName, style: const TextStyle( fontWeight: FontWeight.bold, fontSize: 15, ),
              ),
              const SizedBox(height: 4),
              Text(
                gameList[index].gameDesc, style: TextStyle(fontSize: 12, color: Colors.grey[500]), maxLines: 3, overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.thumb_up_alt),
                  Text(
                    " ${gameList[index].totalLike}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
    ),
  );
}
}