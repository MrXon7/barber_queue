import 'package:barber_queue/companents/user_companents/aboutBarberItem.dart';
import 'package:barber_queue/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // sartaroshlarni yuklash
   // Web uchun kontekst muammolarini oldini olish
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).fetchBarbers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              userProvider.clearfilter();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.amber,
            )),
        title: Text(
          "QIDIRUV",
          style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 2),
        ),
      ),
      body: Column(
        children: [
          // Qidiruv maydoni
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchController,
              style: TextStyle(color: Colors.amber),
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey.shade600),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.amber),
                  ),
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  hintText: "Sartaosh ismini kiriting",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.amber,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey.shade700),
                  )),
              onChanged: (value) {
                setState(() {
                  userProvider.searchBarbers(value);
                });
              },
            ),
          ),
          SizedBox(height: 10),
          // Sartaroshlar ro'yxati
          Expanded(
              child: userProvider.filteredBarbers.isEmpty
                  ? Center(
                      child: Text(
                        "Sartaroshlar yo'q",
                        style: TextStyle(color: Colors.grey.shade400),
                      ),
                    )
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 300,
                          mainAxisExtent: 267,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: userProvider.filteredBarbers.length,
                      itemBuilder: (contex, index) {
                        final barber = userProvider.filteredBarbers[index];
                        String barberId = barber.id;
                        return BarberItem(
                          barber: barber.toMap(),
                          barberId: barberId,
                        );
                      }))
        ],
      ),
    );
  }
}
