import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'leave_requests.dart'; // Import the new LeaveRequests.dart file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LeaveRequestsPage(),
    );
  }
}

class LeaveRequestsPage extends StatefulWidget {
  @override
  _LeaveRequestsPageState createState() => _LeaveRequestsPageState();
}

class _LeaveRequestsPageState extends State<LeaveRequestsPage> {
  List<Map<String, String>> leaveRequests = [];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(icon: Icon(Icons.notifications_none, color: Colors.black), onPressed: () {}),
          CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: Icon(Icons.person, color: Colors.black),
          ),
          SizedBox(width: 10),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "My Requests",
                  style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: leaveRequests.isEmpty ? _buildNoRequestsUI(screenWidth) : _buildRequestsList(screenWidth),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) => LeaveRequestScreen(),
              );
            },
            child: Text("+ Add Leave Request", style: TextStyle(fontSize: screenWidth * 0.045)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: EdgeInsets.symmetric(vertical: screenWidth * 0.04),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildNoRequestsUI(double screenWidth) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/no_requests_image.png", width: screenWidth * 0.3),
          SizedBox(height: 10),
          Text(
            "No requests to display",
            style: TextStyle(fontSize: screenWidth * 0.045, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestsList(double screenWidth) {
    return ListView.builder(
      itemCount: leaveRequests.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(
              leaveRequests[index]["title"]!,
              style: TextStyle(fontSize: screenWidth * 0.045),
            ),
            subtitle: Text(
              "Leave from: ${leaveRequests[index]["dates"]}",
              style: TextStyle(fontSize: screenWidth * 0.04),
            ),
            trailing: Text(
              leaveRequests[index]["status"]!,
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                color: leaveRequests[index]["status"] == "Approved"
                    ? Colors.green
                    : leaveRequests[index]["status"] == "Pending"
                    ? Colors.orange
                    : Colors.red,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 1,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "My Request"),
        BottomNavigationBarItem(icon: Icon(Icons.group), label: "Team"),
        BottomNavigationBarItem(icon: Icon(Icons.description), label: "Documents"),
      ],
    );
  }
}

class LeaveRequestScreen extends StatefulWidget {
  @override
  _LeaveRequestScreenState createState() => _LeaveRequestScreenState();
}

class _LeaveRequestScreenState extends State<LeaveRequestScreen> {
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();

  Future<void> _selectDate(BuildContext context, bool isFrom) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isFrom ? fromDate : toDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        if (isFrom) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });

      // Auto adjust bottom sheet height
      await Future.delayed(Duration(milliseconds: 200));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom, // Auto-adjust for keyboard
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Auto-adjust height
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "New Leave",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: 10),
            _buildDateSelector(context, "From", true),
            SizedBox(height: 10),
            _buildDateSelector(context, "To", false),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: "Reason for apply",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.grey[300],
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to the LeaveRequests page when the button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LeaveRequests()),
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: Text("Send for approval"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector(BuildContext context, String label, bool isFrom) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        GestureDetector(
          onTap: () => _selectDate(context, isFrom),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(DateFormat('dd MMM yyyy').format(isFrom ? fromDate : toDate)),
                Icon(Icons.calendar_today, color: Colors.purple),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
