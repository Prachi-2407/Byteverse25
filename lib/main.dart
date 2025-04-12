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
  _SchoolMealsScreenSchool createState() => _SchoolMealsScreenSchool();
}

class _SchoolMealsScreenSchool extends State<SchoolMealsScreen> {
  String selectedSchool = 'ABC School';

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
                    child: Image.asset('assets/images/image1.jpeg',
                        fit: BoxFit.cover),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset('assets/images/image2.jpeg',
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
            _buildStateScore('ABC School', '9.5 / 10'),
            SizedBox(height: 10,),
            _buildStateScore('XYZ School', '9.3 / 10'),
            SizedBox(height: 10,),
            _buildStateScore('DEF School', '9.1 / 10'),
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

            DropdownButton<String>(
              value: selectedSchool,
              isExpanded: true,
              items: ['ABC School', 'DEF School', 'XYZ School', 'GHI School']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedSchool = newValue!;
                });
              },
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {


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