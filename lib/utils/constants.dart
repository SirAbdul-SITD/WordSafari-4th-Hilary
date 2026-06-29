// lib/utils/constants.dart
import 'package:flutter/material.dart';

// ── Linkoro palette: deep slate + bright connection colors ─────────────
const Color kBg          = Color(0xFF0D1017);
const Color kSurface     = Color(0xFF161B26);
const Color kBorder      = Color(0xFF273140);
const Color kAccent      = Color(0xFF5AD1FF);
const Color kCell        = Color(0xFF121722);
const Color kCellEdge    = Color(0xFF222B3A);
const Color kTextPrimary = Color(0xFFEAF2FB);
const Color kTextDim     = Color(0xFF8090A6);

const Color kStarOn  = Color(0xFFFFD54F);
const Color kStarOff = Color(0xFF1E2735);

const Color kEasyColor   = Color(0xFF5AD1FF);
const Color kMediumColor = Color(0xFFB58CFF);
const Color kHardColor   = Color(0xFFFF7043);

// pair colors (endpoint id -> color)
const List<Color> kPairColors = [
  Color(0xFFFF5D5D), Color(0xFF4FC3F7), Color(0xFFFFD54F),
  Color(0xFF66E08A), Color(0xFFB07BFF), Color(0xFFFF9F68),
  Color(0xFFEE6AA7), Color(0xFF4DD0C4), Color(0xFFFFFFFF),
  Color(0xFFA0E060),
];

const int kTotalLevels = 150;

TextStyle techno(double size,
        {Color color = kTextPrimary,
        FontWeight weight = FontWeight.bold,
        double letterSpacing = 1.5}) =>
    TextStyle(
        fontSize: size, color: color, fontWeight: weight,
        letterSpacing: letterSpacing);
