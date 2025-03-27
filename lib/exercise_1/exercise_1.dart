import 'package:flutter/material.dart';
import 'package:main_games_test/exercise_1/model/exercise_1_item_model.dart';

class Exercise1Widget extends StatefulWidget {
  const Exercise1Widget({super.key});

  @override
  State<Exercise1Widget> createState() => _Exercise1WidgetState();
}

class _Exercise1WidgetState extends State<Exercise1Widget> {
  final List<Exercise1ItemModel> items = List.generate(30, (index) {
    return Exercise1ItemModel(
      id: index.toString(),
      title: "item $index",
      url: index == 2
          ? 'error_link'
          : 'https://picsum.photos/id/$index/1000/300',
    );
  });

  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  bool isShowInsert = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercise 1"),
        automaticallyImplyLeading: true,
      ),
      // body: _buildListView(),
      body: _buildAnimatedList(),
      floatingActionButton: isShowInsert
          ? ElevatedButton(
              onPressed: () {
                _listKey.currentState?.insertAllItems(
                  0,
                  items.length,
                  duration: const Duration(
                    milliseconds: 500,
                  ),
                );
                setState(() {
                  isShowInsert = false;
                });
              },
              child: const Text("Insert"),
            )
          : null,
    );
  }

  Widget _buildAnimatedList() {
    return AnimatedList(
      key: _listKey,
      itemBuilder: (context, index, animation) {
        final item = items.elementAt(index);
        return _buildAnimatedItem(item, animation);
      },
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        var item = items.elementAt(index);
        return Container(
          child: _buildItem(item),
        );
      },
    );
  }

  Widget _buildAnimatedItem(
      Exercise1ItemModel item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: _buildItem(item),
    );
  }

  Widget _buildItem(Exercise1ItemModel item) {
    double imageWidth = 200;
    double imageHeight = 200 * 9 / 16;

    return Center(
      key: ValueKey(item.id),
      child: Container(
        width: imageWidth,
        decoration: BoxDecoration(
            border: Border.all(
          color: Colors.black.withOpacity(.5),
        )),
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              item.url,
              cacheWidth: imageWidth.toInt(),
              width: imageWidth,
              height: imageHeight,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;

                return const CircularProgressIndicator(
                  strokeWidth: 2,
                  backgroundColor: Colors.blue,
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return SizedBox(
                  width: imageWidth,
                  height: imageHeight,
                  child: const Icon(Icons.error, color: Colors.red),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(item.title),
            ),
            ...List.generate(10, (index) {
              return const Icon(Icons.abc);
            }),
          ],
        ),
      ),
    );
  }
}
