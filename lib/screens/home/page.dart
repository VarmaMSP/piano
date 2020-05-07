import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static final List<String> podcasts = [
    'Planet Money',
    'Heavyweight',
    'Past Gas by Donut Media',
    'This Podcast Will Kill You',
    'Ridiculous History',
    'Sawbones: A Marital Tour of Misguided Medicine',
    'The Bike Shed',
    'Darknet Diaries',
    'American Scandal',
    'Developer Tea',
    'Full Stack Radio',
    'Reply All',
  ];

  static final Map<String, String> urlParams = {
    'Planet Money': 'planet-money-mbk0Ed',
    'Heavyweight': 'heavyweight-e79vOb',
    'Past Gas by Donut Media': 'past-gas-by-donut-media-boVZNa',
    'This Podcast Will Kill You': 'this-podcast-will-kill-you-dBrx2d',
    'Ridiculous History': 'ridiculous-history-enrADe',
    'Sawbones: A Marital Tour of Misguided Medicine':
        'sawbones-a-marital-tour-of-misguided-medicine-bmZNAd',
    'The Bike Shed': 'the-bike-shed-eVNNMX',
    'Darknet Diaries': 'darknet-diaries-b8XXmb',
    'American Scandal': 'american-scandal-dRoy0e',
    'Developer Tea': 'developer-tea-eERMBl',
    'Full Stack Radio': 'full-stack-radio-el5EO5',
    'Reply All': 'reply-all-epZEXb',
  };

  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(0, 0),
        child: Container(),
      ),
      body: ListView.separated(
        itemCount: podcasts.length,
        separatorBuilder: (_, __) => Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(podcasts[index]),
            onTap: () {
              Navigator.of(context).pushNamed(
                '/podcast',
                arguments: {'urlParam': urlParams[podcasts[index]]},
              );
            },
          );
        },
      ),
    );
  }
}
