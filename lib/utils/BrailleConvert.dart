// Given String, page width, character length
// Only complete words in each line rest filled with spaces
// Forward in odd lines, reverse in even lines
// In Odd lines no need of extra spaces if string ends
// In Even lines add extra spaces since it's reversed

import 'package:flutter/material.dart';
import 'package:basic_utils/basic_utils.dart';

String convert(String text) {
  text.toLowerCase();
  String converted = "";
  Map table = {
    'a': '100000',
    'b': '110000',
    'c': '100100',
    'd': '100110',
    'e': '100010',
    'f': '110100',
    'g': '110110',
    'h': '110010',
    'i': '010100',
    'j': '010110',
    'k': '101000',
    'l': '111000',
    'm': '101100',
    'n': '101110',
    'o': '101010',
    'p': '111100',
    'q': '111110',
    'r': '111010',
    's': '011100',
    't': '011110',
    'u': '101001',
    'v': '111001',
    'w': '010111',
    'x': '101101',
    'y': '101111',
    'z': '101011',
    '#': '001111',
    '1': '100000',
    '2': '110000',
    '3': '100100',
    '4': '100110',
    '5': '100010',
    '6': '110100',
    '7': '110110',
    '8': '110010',
    '9': '010100',
    '0': '010110',
    ' ': '000000'
  };
  for (int i = 0; i < text.length; i++) {
    /*if (text[i] == '#') {
      converted += '#';
    }*/
    converted += table[text[i]];
  }
  return converted;
}

/*String convert(String s, double width, int ch_length) {
  int val = (width / ch_length).floor();
  int cnt = 0;
  String fin_string = "";
  String str = "";
  var len_str = new List();
  var len_int = new List();

  s += ' ';
  for (int i = 0; i < s.length; i++) {
    if (s[i] == ' ') {
      len_str.add(str);
      len_int.add(cnt);
      cnt = 0;
      str = "";
    } else {
      cnt++;
      str += s[i];
    }
  }
  cnt = 0;
  var vec = new List();

  int sp = 0;
  int lines = 0;
  for (int i = 0; i < len_str.length; i++) {
    if (cnt + len_int[i] + sp > val) {
      vec = List.from(vec.reversed);
      String ss = "";
      while (vec.length > 1) {
        ss += vec.last + " ";
        vec.removeLast();
      }
      ss += vec.last;
      vec.removeLast();
      while (ss.length % val != 0) {
        ss += ' ';
      }
      lines++;
      if (lines % 2 == 0) ss = StringUtils.reverse(ss);
      ss += '#';
      fin_string += ss;
      cnt = 0;
      sp = 0;
      vec.clear();
    }
    cnt += len_int[i];
    vec.add(len_str[i]);
    sp++;
  }
  String ss = "";
  vec = List.from(vec.reversed);
  while (vec.length > 1) {
    ss += vec.last + " ";
    vec.removeLast();
  }
  ss += vec.last;
  vec.removeLast();
  lines++;
  if (lines % 2 == 0) {
    while (ss.length % val != 0) {
      ss += ' ';
    }
  }
  if (lines % 2 == 0) ss = StringUtils.reverse(ss);
  return convert2(fin_string += ss);
}
*/