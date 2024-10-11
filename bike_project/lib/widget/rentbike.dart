import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// import '../data/rentbikeModel.dart';
import 'components/imagesliderWidget.dart';
class Bikecontainer extends StatelessWidget {
  const Bikecontainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageSlider(),
          SizedBox(height: 10),
          Text(
            'Bikes For Rent',
            style: Theme.of(context)
                .textTheme
                .bodyText1, // Update to appropriate text style
          ),
          SizedBox(height: 10),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Bikes').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                final partsList = snapshot.data!.docs;

                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 2 / 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: partsList.length,
                  itemBuilder: (BuildContext ctx, index) {
                    final part = partsList[index];
                    final partData = part.data() as Map<String, dynamic>;

                    final imageUrl = partData['imageUrl'];
                    final itemName = partData['itemName'];
                    final price = partData['price'];

                    return GridTile(
                      footer: GridTileBar(
                        backgroundColor: Colors.black54,
                        title: Text(
                          itemName,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle:
                            Text(price.toString()), // Convert price to a string
                        trailing: Icon(Icons.favorite_border_sharp),
                      ),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
