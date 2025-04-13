import 'dart:async';
import 'package:flutter/material.dart';


void main() {
  runApp(SchoolMealsApp());
}

class SchoolMealsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'School Meals',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SchoolMealsScreen(),
    );
  }
}

class SchoolMealsScreen extends StatefulWidget {
  @override
  _SchoolMealsScreenState createState() => _SchoolMealsScreenState();
}

class _SchoolMealsScreenState extends State<SchoolMealsScreen> {
  String selectedSchool = 'ABC School';
  List<Map<String, dynamic>> schools = [
    {'name': 'ABC School', 'rating': 5},
    {'name': 'DEF School', 'rating': 4},
    {'name': 'XYZ School', 'rating': 5},
    {'name': 'GHI School', 'rating': 4},
    {'name': 'JKL School', 'rating': 5},
    {'name': 'MNO School', 'rating': 4},
    {'name': 'PQR School', 'rating': 5},
    {'name': 'STU School', 'rating': 4},
    {'name': 'VWX School', 'rating': 5},
    {'name': 'YZA School', 'rating': 4},
  ];

  PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff9acfd8) ,
        currentIndex: 0,
        onTap: (index) {

        },
        items:
        const [

          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black,), label: 'Home'  ),
          BottomNavigationBarItem(
              icon: Icon(Icons.dinner_dining, color: Colors.black,), label: 'MENU'),
        ],
      ),
      appBar: PreferredSize(preferredSize: Size.fromHeight(40), child: AppBar(
        flexibleSpace:
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          decoration: BoxDecoration(
            color: Color(0xff2b6f7c),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Icon(Icons.nightlight_outlined, size: 26,),
              Text(
                "Home",
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w600),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
                child: Icon(Icons.account_circle, size: 28,),
              ),
            ],
          ),
        ),
      ),),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SizedBox(height: 25,),
            Container(
              height: 240,
              child: PageView(
                controller: _pageController,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset('assets/images/middaymeal1.jpg',
                        fit: BoxFit.cover),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset('assets/images/middaymeal2.jpeg',
                        fit: BoxFit.cover),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset('assets/images/middaymeal3.jpeg',
                        fit: BoxFit.cover),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Top Schools serving best meals',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            ...schools
                .where((school) => school['rating'] == 5)
                .take(3)
                .map((school) => _buildStateScore(school['name'], '${school['rating']} / 5'))
                .toList(),
            const SizedBox(height: 20),
            Divider(
              color:Colors.black,
            ),
            const SizedBox(height:20),
            const Text(
              'Select a School:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView.builder(
                itemCount: schools.length,
                itemBuilder: (context, index) {
                  final school = schools[index];
                  return ListTile(
                    title: Text(
                      school['name'],
                      style: TextStyle(
                        fontWeight: selectedSchool == school['name']
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    trailing: Text(
                      '${school['rating']} ★',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    selected: selectedSchool == school['name'],
                    selectedTileColor: Color(0xff9acfd8).withOpacity(0.3),
                    onTap: () {
                      setState(() {
                        selectedSchool = school['name'];
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KeralaNutritionCard(
                      schoolName: selectedSchool,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff9acfd8),

                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Find School',
                style: TextStyle(fontSize: 20 , color:Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStateScore(String state, String score, {bool highlight = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff2b6f7c),
              Color(0xff9acfd8),
            ]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            state,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: highlight ? Colors.black : Colors.black87,
            ),
          ),
          Text(
            score,
            style: TextStyle(
              fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff2b6f7c),
        leadingWidth: 40,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, size: 26),
        ),
        title: Text(
          "Profile",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        actions: [
          SizedBox(width: 26),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header
            SizedBox(height: 45),

            // Profile Image
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage(''),
            ),

            SizedBox(height: 30),

            // Name
            Text(
              "Rudraksha",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 30),

            // Details
            _buildInfo("Contact", "+91 7017296923", isGrey: true),
            _buildInfo("Email","rudrakshakr@gmail.com",isGrey: true),
            _buildInfo("Date of Birth", "April 11, 2004", isGrey: true),
            _buildInfo("Address", "123 Main Street", isGrey: true),
            _buildInfo("School Name", "ABC School", isGrey: true),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo(String title, String value, {bool isGrey = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Container(
        decoration: BoxDecoration(color:Color(0xff9acfd8), borderRadius: BorderRadius.circular(40)),
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$title:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(
                color: isGrey ? Colors.grey[600] : Colors.black,
                fontSize: 14,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class KeralaNutritionCard extends StatelessWidget {
  final String schoolName;
  final Map<String, int> nutrients = {
    'Protein': 85,
    'Carbohydrates': 90,
    'Fats': 70,
    'Vitamins': 75,
    'Minerals': 80,
  };

  KeralaNutritionCard({Key? key, required this.schoolName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff2b6f7c),
        leadingWidth: 40,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, size: 26),
        ),
        title: Text(
          "Nutrition",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        actions: [
          SizedBox(width: 26),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xff9acfd8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      schoolName,
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // Add your nutrition chart or other content here
              ],
            ),
          ),
        ),
      ),
    );
  }
}