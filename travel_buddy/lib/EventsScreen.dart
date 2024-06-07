import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class EventsScreen extends StatefulWidget {
  final String userId;

  const EventsScreen({required this.userId});

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final Color componentes = const Color(0xFF218EBA);
  final Color fondo = const Color(0xFFFFA500);
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  Map<DateTime, List<String>> _events = {};
  final TextEditingController _eventController = TextEditingController();
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: ios);
    flutterLocalNotificationsPlugin!.initialize(settings);

    _loadEvents();
  }

  Future<void> _loadEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? eventsData = prefs.getString('${widget.userId}_events');
    if (eventsData != null) {
      Map<String, dynamic> decodedData = json.decode(eventsData);
      Map<DateTime, List<String>> loadedEvents = {};
      decodedData.forEach((key, value) {
        DateTime date = DateTime.parse(key);
        List<String> events = List<String>.from(value);
        loadedEvents[date] = events;
      });
      setState(() {
        _events = loadedEvents;
      });
    }
  }

  Future<void> _saveEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> encodedData = _events.map((key, value) => MapEntry(key.toString(), value));
    await prefs.setString('${widget.userId}_events', json.encode(encodedData));
  }

  void _scheduleNotification(DateTime dateTime, String event) async {
    const androidDetails = AndroidNotificationDetails(
      'event_channel',
      'Event Notifications',
      channelDescription: 'Notifications for events',
      importance: Importance.max,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails();
    const notificationDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);

    await flutterLocalNotificationsPlugin!.schedule(
      event.hashCode,
      'Event Reminder',
      event,
      dateTime,
      notificationDetails,
      androidAllowWhileIdle: true,
    );
  }

  void _addEvent() {
    if (_eventController.text.isEmpty) return;

    setState(() {
      if (_events[_selectedDay] != null) {
        _events[_selectedDay]!.add(_eventController.text);
      } else {
        _events[_selectedDay] = [_eventController.text];
      }
    });

    _saveEvents();
    _scheduleNotification(_selectedDay, _eventController.text);
    _eventController.clear();
    Navigator.pop(context);
  }

  void _editEvent(int index) {
    if (_eventController.text.isEmpty) return;

    setState(() {
      _events[_selectedDay]![index] = _eventController.text;
    });

    _saveEvents();
    _eventController.clear();
    Navigator.pop(context);
  }

  void _deleteEvent(int index) {
    setState(() {
      _events[_selectedDay]!.removeAt(index);
      if (_events[_selectedDay]!.isEmpty) {
        _events.remove(_selectedDay);
      }
    });

    _saveEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: Key('appBarEventos'),  // Añade un Key aquí
        title: const Text(
          'Eventos',
          style: TextStyle(fontFamily: 'Pattaya', color: Colors.white),
        ),
        backgroundColor: componentes,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF218EBA), Color(0xFFFFA500)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                child: TableCalendar(
                  firstDay: DateTime.utc(2000, 1, 1),
                  lastDay: DateTime.utc(2100, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: componentes,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: fondo,
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: const TextStyle(color: Colors.white),
                    selectedTextStyle: const TextStyle(color: Colors.white),
                  ),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black),
                    rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black),
                  ),
                  calendarBuilders: CalendarBuilders(
                    dowBuilder: (context, day) {
                      if (day.weekday == DateTime.sunday || day.weekday == DateTime.saturday) {
                        return Center(
                          child: Text(
                            day.weekday == DateTime.sunday ? 'D' : 'S',
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: _events[_selectedDay] != null
                  ? ListView.builder(
                      itemCount: _events[_selectedDay]!.length,
                      itemBuilder: (context, index) {
                        final event = _events[_selectedDay]![index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 4,
                            color: componentes,
                            child: ListTile(
                              title: Text(
                                event,
                                style: GoogleFonts.lato(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit, color: Colors.white),
                                    onPressed: () {
                                      _eventController.text = event;
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text('Editar evento'),
                                          content: TextField(
                                            controller: _eventController,
                                            decoration: const InputDecoration(hintText: 'Editar evento'),
                                          ),
                                          actions: [
                                            TextButton(
                                              child: const Text('Cancelar'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            TextButton(
                                              child: const Text('Guardar'),
                                              onPressed: () {
                                                _editEvent(index);
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.white),
                                    onPressed: () {
                                      _deleteEvent(index);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        'No hay eventos para este día',
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: fondo,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Agregar evento'),
              content: TextField(
                controller: _eventController,
                decoration: const InputDecoration(hintText: 'Descripción del evento'),
              ),
              actions: [
                TextButton(
                  child: const Text('Cancelar'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: const Text('Agregar'),
                  onPressed: _addEvent,
                ),
              ],
            ),
          );
        },
        child: Icon(Icons.add, color: componentes),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: fondo,
        selectedItemColor: componentes,
        unselectedItemColor: Colors.black,
        currentIndex: 4,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/activities');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/routes');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/weather');
          } else if (index == 4) {
            Navigator.pushReplacementNamed(context, '/events');
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity),
            label: 'Actividades',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Rutas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'Tiempo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Eventos',
          ),
        ],
      ),
    );
  }
}
