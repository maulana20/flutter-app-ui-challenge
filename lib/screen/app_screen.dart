import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'app/utils/screen_size.dart';
import '../model/menu.dart';

class AppScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			debugShowCheckedModeBanner: false,
			theme: ThemeData(
				fontFamily: "Varela",
			),
			home: DefaultTabController(
				length: 3,
				child: Scaffold(
					body: TabBarView(
						children: [
							HomePage(),
							TransactionPage(),
							LoginPage(),
						]
					),
					bottomNavigationBar: new TabBar(
						tabs: [
							Tab( icon: new Icon(Icons.home), ),
							Tab( icon: new Icon(Icons.event_note), ),
							Tab( icon: new Icon(Icons.perm_identity), ),
						],
						labelColor: Colors.green,
						unselectedLabelColor: Colors.blue,
						indicatorSize: TabBarIndicatorSize.label,
						indicatorPadding: EdgeInsets.all(5.0),
						indicatorColor: Colors.red,
					),
					backgroundColor: Colors.white,
				),
			),
		);
	}
}

class HomePage extends StatelessWidget {
	Menu menu;
	
	List<Menu> menus = <Menu> [
		Menu(title: 'pesawat', assets: 'assets/images/pesawat.png'),
		Menu(title: 'kereta', assets: 'assets/images/kereta.png'),
		Menu(title: 'pelni', assets: 'assets/images/perahu.png'),
		Menu(title: 'bis', assets: 'assets/images/bus.png'),
		Menu(title: 'hotel', assets: 'assets/images/hotel.png'),
		Menu(title: 'tour', assets: 'assets/images/tour.png'),
	];
	
	@override
	Widget build(BuildContext context) {
		final _media = MediaQuery.of(context).size;
		return ListView(
			padding: EdgeInsets.zero,
			physics: BouncingScrollPhysics(),
			children: <Widget>[
				Container(
					color: Colors.grey.shade50,
					height: _media.height / 2.2,
					child: Stack(
						children: <Widget>[
							Column(
								children: <Widget>[
									Expanded(
										flex: 5,
										child: Stack(
											children: <Widget>[
												Material(
													elevation: 4,
													child: CarouselSlider(
														autoPlay: true,
														height: 400.0,
														items: [AssetImage("assets/images/promo2.jpg"),AssetImage("assets/images/promo.jpg")].map((bgImg) {
															return Builder(
																builder: (BuildContext context) {
																	return Image(image: bgImg, fit: BoxFit.cover);
																},
															);
														}).toList(),
													),
												),
												Opacity( opacity: 0.3, child: Container( color: Colors.black87, ), )
											],
										),
									),
									Expanded( flex: 1, child: Container(), )
								],
							),
							Align(
								alignment: Alignment.bottomCenter,
								child: Container(
									margin: EdgeInsets.only( left: 10, right: 10),
									height: _media.longestSide <= 775 ? _media.height / 3.8 : _media.height / 4.2,
									width: _media.width,
									child: Material(
										elevation: 1,
										shadowColor: Colors.grey.shade300,
										color: Colors.white,
										shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10), ),
										child: GridView.count(
											crossAxisCount: 3,
											childAspectRatio: 2,
											children: List.generate(menus.length, (index) {
												return Column(
													mainAxisSize: MainAxisSize.min,
													crossAxisAlignment: CrossAxisAlignment.center,
													children: [
														GestureDetector(
															onTap: () => print('${menus[index].title}'),
															child: Center(
																	child: Column(
																		mainAxisSize: MainAxisSize.min,
																		crossAxisAlignment: CrossAxisAlignment.center,
																		children: <Widget>[
																			Image.asset(menus[index].assets, height: 30.0, width: 40.0),
																			SizedBox( height: 2.0 ),
																		],
																	),
																),
														),
														Text(menus[index].title, style: TextStyle( inherit: true, fontWeight: FontWeight.w500, fontSize: 11.0)),
														SizedBox( height: 3.0 ),
													],
												);
											}),
										),
									),
								),
							),
						],
					),
				),
				Container(
					color: Colors.grey.shade50,
					width: _media.width,
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: <Widget>[
							Padding(
								padding: const EdgeInsets.all(15.0),
								child: Row(
									mainAxisAlignment: MainAxisAlignment.spaceBetween,
									children: <Widget>[
										Text( "pilih hotel favorit mu", style: TextStyle( fontSize: 14, fontWeight: FontWeight.bold, ), ),
										Icon( Icons.arrow_forward_ios, color: Colors.grey, size: 10, ),
									],
								),
							),
							Container(
								margin: EdgeInsets.all(5.0),
								height: screenAwareSize( _media.longestSide <= 775 ? 200 : 300, context ),
								child: NotificationListener<OverscrollIndicatorNotification>(
									onNotification: (overscroll) {
										overscroll.disallowGlow();
									},
									child: ListView.builder(
										physics: BouncingScrollPhysics(),
										scrollDirection: Axis.horizontal,
										itemCount: 3,
										itemBuilder: (BuildContext context, int index) {
											return Padding(
												padding: EdgeInsets.only(right: 5),
												child: Container(
													width: 150,
													height: 180,
													padding: EdgeInsets.all(5.0),
													alignment: Alignment.bottomLeft,
													decoration: BoxDecoration(
														image: new DecorationImage(
															image: new AssetImage('assets/images/users/anna.jpeg'),
															fit: BoxFit.cover,
														)
													),
													child: Text('Hotel Haris', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white) ),
												),
											);
										},
									),
								),
							),
							Container(margin: EdgeInsets.all(10.0),),
						],
					),
				),
			],
		);
	}
}

class TransactionPage extends StatelessWidget {
	
	@override
	Widget build(BuildContext context) {
		return Scaffold( 
			appBar: AppBar(title: Text('Riwayat Transaksi')),
			body: Container(
				color: Colors.white,
				alignment: Alignment.bottomLeft,
				child: ListView(
					padding: EdgeInsets.only(top: 10.0),
					children: [
						_transCard('assets/images/keranjang.png', 'Riwayat Pembelian', '(Pulsa, Token PLN, Paket Data)'),
						_transCard('assets/images/dompet.png', 'Riwayat Pembayaran', '(Tagihan PLN, PDAN, Pascabayar)'),
						_transCard('assets/images/pesawat.png', 'Riwayat Reservasi Tiket', '(Lion Air, Sriwijaya, Citilink)'),
					],
				),
			),
		);
	}
	
	Widget _transCard(String image, String title, String desc) {
		return Card(
			margin: EdgeInsets.all(10.0),
			color: Colors.white,
			shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0), ),
			child: Padding(
				padding: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
				child: Column(
					children: <Widget>[
						SizedBox( height: 10.0 ),
						Row(
							children: [
								Image.asset(image, height: 50.0, width: 50.0),
								SizedBox( width: 15.0 ),
								Column(
									mainAxisSize: MainAxisSize.min,
									children: [
										Text(title, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
										SizedBox( height: 5.0 ),
										Text(desc, style: TextStyle(fontSize: 12.0, )),
									],
								),
							],
						),
					],
				),
			),
		);
	}
}

class LoginPage extends StatefulWidget {
	static String tag = 'login-page';
	@override
	_LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
	bool _obscureText = true;
	
	@override
	Widget build(BuildContext context) {
		return Container(
			color: Colors.white,
			child: ListView(
					shrinkWrap: true,
					padding: EdgeInsets.only(left: 24.0, right: 24.0),
					children: <Widget>[
						SizedBox(height: 40.0),
						Hero(
							tag: 'hero',
							child: CircleAvatar(
								backgroundColor: Colors.transparent,
								radius: 80.0,
								child: Image.asset('assets/images/bat.png'),
							),
						),
						SizedBox(height: 10.0),
						TextFormField(
							keyboardType: TextInputType.emailAddress,
							autofocus: false,
							initialValue: 'alucard@gmail.com',
							decoration: InputDecoration(
								hintText: 'Email',
								contentPadding: EdgeInsets.all(10.0),
								border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
								icon: Padding( padding: const EdgeInsets.only(top: 5.0), child: const Icon(Icons.person)),
							),
						),
						SizedBox(height: 8.0),
						Column(
							children: <Widget> [
								TextFormField(
									autofocus: false,
									initialValue: 'some password',
									obscureText: _obscureText,
									decoration: InputDecoration(
										hintText: 'Password',
										contentPadding: EdgeInsets.all(10.0),
										border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
										icon: Padding( padding: const EdgeInsets.only(top: 5.0), child: const Icon(Icons.lock)),
										suffixIcon: IconButton(
											icon: Icon(Icons.remove_red_eye),
											onPressed: () => setState(() { _obscureText = !_obscureText; }),
										),
									),
								),
							],
						),
						SizedBox(height: 24.0),
						Padding(
							padding: EdgeInsets.symmetric(vertical: 20.0),
							child: Material(
								borderRadius: BorderRadius.circular(30.0),
								shadowColor: Colors.lightBlueAccent.shade100,
								elevation: 0.0,
								child: MaterialButton(
									minWidth: 200.0,
									height: 42.0,
									onPressed: () {},
									color: Colors.lightBlueAccent,
									child: Text('Log In', style: TextStyle(color: Colors.white)),
								),
							),
						),
						FlatButton(
							child: Text(
								'Forgot password?',
								style: TextStyle(color: Colors.black54),
							),
							onPressed: () {},
						),
					],
				),
		);
	}
}
