# adminpanel
<p>  Simple Application in Flutter-Firebase.

App has the following functionalities:
A user(admin) needs to sign up for using this app(User Authentication)
Once he signed in, He can manage everything in the app:

a: Add Teachers, Edit Teachers, Delete Teachers
b: Add Students, Edit Students, Delete Students
c: Add fee, Edit fee, Delete fee
d: Search student details on his registration number
e: Upload and View multiple images
f: Create Events

State management( provider )
backend (Firebase)

Sources:
Net ninja
Angela yu
MTechViral </p>

</h1> Provider </h1>
<p><strong> Some of the concepts about provider, I learnt from different sources: </strong></p>
<h5>Managing Flutter State using Provider</h5>
<p><strong>What is State Management? </strong></p>
<p>State is the data your application needs to display or do something with. Data which may change.
For relatively simple scenarios, where the application consists of a single screen, we could use Flutter’s Stateful widgets and call setState()to rebuild the widget after we’ve modified some data or state. Remember, Flutter adopts a reactive model, rendering the user interface in response to state changes.
But consider the following scenario — a home screen which displays the currently signed-in user. That’s a two-screen application at a minimum and the home screen must somehow react to the action outcomes on another screen i.e. someone has logged in.
So What Is Provider Exactly?
If you browse to the provider pub.dev package page you’ll see no mention of state management. Instead, it’s described as a wrapper around InheritedWidget and a quick search later you’ll see that InheritedWidget has something to do with propagating information down the widget tree. We’re getting closer.
In the context of state management, Provider is a widget that makes some value — like our user sign-in details— available to the widgets below it. Think of it as a convenient tool for passing state down the widget tree and rebuilding the UI when there are changes.
Concepts and Terminology
You need to become familiar with 4 concepts when working with provider.
1.Model — a class you create to encapsulate your application data and optional methods for modifying that data. This is what is made available to other widgets. Think of it as our message to broadcast.
2.ChangeNotifier — provides model change notifications to listeners. Your model above extends this class and it’s how we publish or broadcast messages.
3.Consumer — a provider package widget which reacts to ChangeNotifier changes and calls build method to apply model updates. This is our subscriber.
4.ChangeNotifierProvider — a provider package widget that provides an instance of a ChangeNotifier to its descendant widgets. Consumer widgets need to know the ChangeNotifier instance they need to observe. That’s the role of ChangeNotifierProvider.



import 'package:flutter/material.dart';
	import 'package:provider/provider.dart';
	
	void main() {
	runApp(
	/// Providers are above [MyApp] instead of inside it, so that tests
	/// can use [MyApp] while mocking the providers
	ChangeNotifierProvider(
	create: (_) => SignInDetailsModel(),
	child: MyApp(),
	),
	);
	}
	
	class MyApp extends StatelessWidget {
	static const String _title = 'Provider Sign-In Example';
	
	@override
	Widget build(BuildContext context) {
	return MaterialApp(
	title: _title, home: HomePage(), debugShowCheckedModeBanner: false);
	}
	}
	
	class HomePage extends StatelessWidget {
	Widget build(BuildContext context) {
	return Scaffold(
	appBar: AppBar(
	title: const Text('Provider Login Example'),
	actions: <Widget>[
	IconButton(
	icon: Icon(Icons.person),
	onPressed: () {
	Navigator.push(
	context,
	MaterialPageRoute(builder: (context) => LoginRoute()),
	);
	},
	),
	]),
	body: Center(child: Consumer<SignInDetailsModel>(
	builder: (context, userModel, child) {
	String message = (userModel.user == ""
	? "Please sign-in"
	: "Welcome ${userModel.user}");
	return Text(message, style: Theme.of(context).textTheme.headline4);
	},
	)));
	}
	}
	
	class LoginRoute extends StatelessWidget {
	TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
	
	final userNameTextController = TextEditingController();
	
	@override
	Widget build(BuildContext context) {
	final userField = TextField(
	style: style,
	controller: userNameTextController,
	decoration: InputDecoration(
	contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
	hintText: "User Name",
	border: OutlineInputBorder(borderRadius: BorderRadius.horizontal())),
	);
	final passwordField = TextField(
	obscureText: true,
	style: style,
	decoration: InputDecoration(
	contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
	hintText: "Password",
	border: OutlineInputBorder(borderRadius: BorderRadius.horizontal())),
	);
	final loginButon = Material(
	elevation: 5.0,
	color: Colors.blueAccent[400],
	child: MaterialButton(
	minWidth: MediaQuery.of(context).size.width,
	padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
	onPressed: () {
	Provider.of<SignInDetailsModel>(context, listen: false)
	.signIn(userNameTextController.text);
	
	// Navigate back to first route when tapped.
	Navigator.pop(context);
	},
	child: Text("Sign-In",
	textAlign: TextAlign.center,
	style: style.copyWith(
	color: Colors.white, fontWeight: FontWeight.bold)),
	),
	);
	
	return Scaffold(
	body: Center(
	child: Container(
	color: Colors.white,
	child: Padding(
	padding: const EdgeInsets.all(20.0),
	child: Column(
	crossAxisAlignment: CrossAxisAlignment.center,
	mainAxisAlignment: MainAxisAlignment.center,
	children: <Widget>[
	SizedBox(height: 25.0),
	userField,
	SizedBox(height: 25.0),
	passwordField,
	SizedBox(
	height: 25.0,
	),
	loginButon,
	SizedBox(
	height: 25.0,
	),
	],
	),
	),
	),
	),
	);
	}
	}
	
	class SignInDetailsModel with ChangeNotifier {
	String _user = "";
	DateTime _signInOn;
	String get user => _user;
	DateTime get signInOn => _signInOn;
	
	void signIn(String userName) {
	_user = userName;
	_signInOn = DateTime.now();
	notifyListeners();
	}
	}
Points to Note:
1.Line 8: ChangeNotifierProvider is the widget that provides an instance of a ChangeNotifier to its descendant widgets. Here it builds an instance of our model class SignInDetailsModel .
2.Line 41: Our HomePage consists of a Text widget which is wrapped inside a Consumer widget. The text displayed changes when a user is signed-in, the Consumer widget forces a rebuild when a notification is broadcast by our model class.
3.Line 51: We define our Sign-In screen, consisting of a user name field, password field and a button.
4.Line 84: Here we are using the Provider.of method to access the model instance. Provider.of obtains the nearest Provider<T> up its widget tree and returns its value. We then call signIn to crudely sign in the user and fire our notification, before finally transitioning back to the home screen.
5.Line 127: This is our model class, where we encapsulate our user name and sign-in date. Notice how we extend ChangeNotifier and then call notifiyListeners() when broadcasting to any Consumer widgets that a sign-in has occurred.</p>
  
<h4>Summary</h4>
<p>
  State Management in Flutter is a complex topic, not least because of the number of possible approaches and packages available.
Here, we have attempted to introduce the reader to Provider and its concepts and also demonstrated how to incorporate it into an application in order to share state between screens.
Whilst briefly mentioned in this post, the techniques demonstrated here also promote lose decoupling - whereby the home screen and the sign-in screens are unaware of each other’s inner workings. They share a common model and utilise Provider to propagate and consume changes in this model.


  </p>

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
