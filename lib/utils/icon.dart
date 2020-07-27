import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

IconData getCategoryIcon(String categoryId) {
  switch (categoryId) {

    ///Arts
    case 'lejRej':
      return Icons.brush_rounded;

    ///Business
    case 'zbq2dp':
      return Icons.business_center_rounded;

    ///Comedy
    case '9aAOdv':
      return MdiIcons.dramaMasks;

    ///Education
    case 'RdG7dD':
      return Icons.school_rounded;

    ///Fiction
    case '0dN6dL':
      return MdiIcons.bookOpen;

    ///Government
    case 'PdRqbG':
      return Icons.apartment_rounded;

    ///History
    case '5eVMdE':
      return MdiIcons.timerSand;

    ///Health & Fitness
    case 'NbWJay':
      return MdiIcons.dumbbell;

    ///Kids & Family
    case 'Rb41dB':
      return MdiIcons.humanFemaleBoy;

    ///Leisure
    case 'Pe9xdL':
      return MdiIcons.gamepadVariant;

    ///Music
    case 'mepY2a':
      return MdiIcons.musicNote;

    ///News
    case 'DdwpRe':
      return MdiIcons.earth;

    ///Religion & Spirituality
    case 'RdG67b':
      return Icons.spa_rounded;

    ///Science
    case 'qaQWld':
      return Icons.science_rounded;

    ///Society & Culture
    case 'Rb4x1b':
      return Icons.local_cafe_rounded;

    ///Sports
    case 'Xe0Rvb':
      return Icons.sports_handball_rounded;

    ///Technology
    case 'nelO6d':
      return Icons.devices_rounded;

    ///True Crime
    case 'vbmw0e':
      return MdiIcons.knife;

    ///TV & Film
    case 'penZle':
      return MdiIcons.movieOpen;

    default:
      return MdiIcons.emoticonOutline;
  }
}
