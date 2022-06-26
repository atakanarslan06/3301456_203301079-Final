import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AlinacakList extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('alinacaklist')
                      .snapshots(),
                  builder: (context, snapshot) {
                    final alinacaklist = snapshot.data?.docs;
                    if (alinacaklist == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (alinacaklist.isEmpty) {
                      return const Center(
                        child: Text('henüz alınacak yok'),
                      );
                    }
                    return ListView.builder(
                        itemCount: alinacaklist.length,
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          final alinacak = alinacaklist[index];
                          return Dismissible(
                            key: Key(alinacak.id),
                            background: Container(
                              color: Colors.red.shade300,
                              alignment: Alignment.centerRight,
                              child: const Icon(Icons.delete, color: Colors.white,),
                            ),
                            onDismissed: (direction){
                              FirebaseFirestore.instance.collection('alinacaklist').doc(alinacak.id).delete();
                            },
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: (){
                                FirebaseFirestore.instance.collection('alinacaklist').doc(alinacak.id).set({'alinacak' : alinacak['alinacak'] + ' gerekli', 'createdAt' : Timestamp.now()});
                              },
                              child: Card(
                                color: Colors.blueGrey.shade300,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        alinacak['alinacak'],
                                        style: TextStyle(color: Colors.black87),
                                      ),
                                      const Divider(color: Colors.blueGrey,),
                                      Text(
                                        DateFormat('dd/MM/yyyy      HH:mm:ss').format(alinacak['createdAt'].toDate(),),
                                      style: TextStyle(color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  },
                ),
              ),
              _inputFields(),
            ],
          ),
        ),
      ),
    );
  }

  Padding _inputFields() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Alınacak Listesi',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              FirebaseFirestore.instance.collection('alinacaklist').add({'alinacak': _controller.text, 'createdAt' : Timestamp.now()});
              _controller.clear();
            },
          ),
        ],
      ),
    );
  }
}
