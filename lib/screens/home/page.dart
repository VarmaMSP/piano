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
    'Animation Addicts Podcast - Animated Movie Reviews & Interviews for Disney, DreamWorks, Pixar & everything in',
    'I Like Your Work: Conversations with Artists, Curators & Collectors',
    'Dying For Sex',
    'Even the Rich',
    'This Is Actually Happening',
    'Dan Carlins Hardcore History',
    'RISK!',
    'The Film Reroll',
    'Invisibilia',
    'The Flop House',
    'Song Exploder',
    '99% Invisible',
    'Command Line Heroes',
    'Unspooled',
    'The Ezra Klein Show',
    'Making Sense with Sam Harris',
    'Sean Carrolls Mindscape: Science, Society, Philosophy, Culture, Arts, and Ideas',
    'The Dollop with Dave Anthony and Gareth Reynolds',
    'The Catch and Kill Podcast with Ronan Farrow',
    'Crypto Basic Podcast: Teaching You The Basics of Bitcoin and the World of Cryptocurrency. CryptoBasic',
    'Grubstakers',
    'Science Vs',
    'The Portal',
    'Sugar Calling',
    'Rabbit Hole',
    'Pivot',
    'Stephen Frys 7 Deadly Sins'
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
    'Animation Addicts Podcast - Animated Movie Reviews & Interviews for Disney, DreamWorks, Pixar & everything in':
        'animation-addicts-podcast-animated-movie-reviews-interviews-for-disney-dreamworks-aQAPYa',
    'Life is Short with Justin Long': 'life-is-short-with-justin-long-bmZXEd',
    'I Like Your Work: Conversations with Artists, Curators & Collectors':
        'i-like-your-work-conversations-with-artists-curators-collectors-1aKQzd',
    'Dying For Sex': 'dying-for-sex-bk7Okv',
    'Even the Rich': 'even-the-rich-avjzmr',
    'This Is Actually Happening': 'this-is-actually-happening-epQkmV',
    'Dan Carlins Hardcore History': 'dan-carlins-hardcore-history-aKZoze',
    'RISK!': 'risk-PdyA6d',
    'The Film Reroll': 'the-film-reroll-dwkyNr',
    'Invisibilia': 'invisibilia-dGRLrb',
    'The Flop House': 'the-flop-house-b4xKgb',
    'Song Exploder': 'song-exploder-dGv4rb',
    '99% Invisible': '99-invisible-qaQAMa',
    'Command Line Heroes': 'command-line-heroes-bqj0K7',
    'Unspooled': 'unspooled-dPjBza',
    'The Ezra Klein Show': 'the-ezra-klein-show-e7p3Ba',
    'Making Sense with Sam Harris': 'making-sense-with-sam-harris-b27gNd',
    'Sean Carrolls Mindscape: Science, Society, Philosophy, Culture, Arts, and Ideas':
        'sean-carrolls-mindscape-science-society-philosophy-culture-arts-and-ideas-ejYpWd',
    'The Dollop with Dave Anthony and Gareth Reynolds':
        'the-dollop-with-dave-anthony-and-gareth-reynolds-dwpkwe',
    'The Catch and Kill Podcast with Ronan Farrow':
        'the-catch-and-kill-podcast-with-ronan-farrow-dG99ra',
    'Crypto Basic Podcast: Teaching You The Basics of Bitcoin and the World of Cryptocurrency. CryptoBasic':
        'crypto-basic-podcast-teaching-you-the-basics-of-bitcoin-and-e05Ava',
    'Grubstakers': 'grubstakers-bmPEAa',
    'Science Vs': 'science-vs-aOPrYb',
    'The Portal': 'the-portal-b81BlL',
    'Sugar Calling': 'sugar-calling-azBzy7',
    'Rabbit Hole': 'rabbit-hole-bYQ3L2',
    'Pivot': 'pivot-dRllqa',
    'Stephen Frys 7 Deadly Sins': 'stephen-frys-7-deadly-sins-b663Nl',
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
