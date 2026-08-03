import 'package:flutter/material.dart';

class LeaveRequests extends StatelessWidget {
  final List<Map<String, dynamic>> requests = [
    {
      'title': 'Tour',
      'status': 'Approved',
      'statusColor': Colors.green,
      'leaveFrom': '29 Jan',
      'leaveTo': '05 Feb',
      'requestedDate': '18 Apr, 5:30pm',
    },
    {
      'title': 'Suffering from cold',
      'status': 'Pending',
      'statusColor': Colors.orange,
      'leaveFrom': '29 Jan',
      'leaveTo': '05 Feb',
      'requestedDate': '18 Apr, 5:30pm',
    },
    {
      'title': 'Going for trip',
      'status': 'Rejected',
      'statusColor': Colors.red,
      'leaveFrom': '29 Jan',
      'leaveTo': '05 Feb',
      'requestedDate': '18 Apr, 5:30pm',
    },
  ];

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

  @override
  Widget build(BuildContext context) {
    // Get screen width
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code, color: Colors.black),
            onPressed: () {
              // Add functionality here
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {
              // Add functionality here
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.grey[300],
              backgroundImage: NetworkImage(
                'https://via.placeholder.com/150',
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            children: [
              DropdownButton<String>(
                value: "My requests",
                icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                underline: SizedBox(),
                items: <String>['My requests', 'My approvals']
                    .map((String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(color: Colors.black)),
                ))
                    .toList(),
                onChanged: (String? newValue) {
                },
              ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: requests.length,
                itemBuilder: (context, index) {
                  final request = requests[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                request['title'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(width: 4.0),
                                  Text(
                                    '${request['leaveFrom']} - ${request['leaveTo']}',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 8.0),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4.0,
                                ),
                                decoration: BoxDecoration(
                                  color: request['statusColor'],
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  request['status'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Requested on: ${request['requestedDate']}',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {},
              child: Text("+ Add Leave Request", style: TextStyle(fontSize: screenWidth * 0.045)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(
                  vertical: screenWidth * 0.04,
                  horizontal: screenWidth * 0.23,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
