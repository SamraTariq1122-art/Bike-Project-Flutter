import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class sparePartContainer extends StatelessWidget {
  const sparePartContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints.expand(
          height: height,
          width: width,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Most Popular',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                    // Adjust the height here
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Parts_Items')
                          .snapshots(),
                      builder: (context, snapshot) {
                        //

                        final partsList = snapshot.data!.docs;

                        //
                        return ListView.builder(
                          itemCount: partsList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final part = partsList[index];
                            final partData =
                                part.data() as Map<String, dynamic>;

                            final imageUrl = partData['imageUrl'];
                            final itemName = partData['itemName'];
                            final category = partData['category'];
                            final price = partData['price'];
                            // final partId = partData['partId'];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                        child: Image.network(
                                          imageUrl,
                                          fit: BoxFit.fill,
                                          height: 220,
                                          width: 250,
                                        )
                                        // Image.asset(
                                        //   ImageUrl,
                                        //   fit: BoxFit.fill,
                                        //   height: 120,
                                        //   width: 250,
                                        // ),
                                        ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Text(
                                        itemName,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w200),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Column(
                                        // mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Category: $category",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "PKR $price",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    )
                    //
                    ),
              ),

              //
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Spare Parts',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    'View All',
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Flexible(
                  child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('Spare').snapshots(),
                builder: (context, snapshot) {
                  final partsList = snapshot.data!.docs;
                  return  
                  ListView.builder(
                    itemCount: partsList.length,
                    itemBuilder: (ctx, index) {
                            final part = partsList[index];
                      final partData = part.data() as Map<String, dynamic>;

                      final imageUrl = partData['imageUrl'];
                      final itemName = partData['itemName'];
                      // final category = partData['category'];
                      final price = partData['price'];
                      return Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Image.network(imageUrl),
                            title: Text(
                              itemName,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            subtitle: Text(
                                price,
                                style: Theme.of(context).textTheme.bodyLarge),
                            trailing: Icon(Icons.favorite_border_sharp),
                          ),
                        ),
                      );
                    },
                  );
                  
                },
              )

                 
          )],
          ),
        ),
      ),
    );
  }
}
