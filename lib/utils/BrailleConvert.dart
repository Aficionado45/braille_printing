// Given String, page width, character length
// Only complete words in each line rest filled with spaces
// Forward in odd lines, reverse in even lines
// In Odd lines no need of extra spaces if string ends
// In Even lines add extra spaces since it's reversed

import 'package:flutter/material.dart';
import 'package:basic_utils/basic_utils.dart';

String convert2(String text, int width, int ch_length) {
  int characters = (width / ch_length).floor();
  int len = text.length;
  String converted = "";
  String line = "";
  String word = "";
  int lineNumber = 1;
  int j;

  return converted;
}

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
    converted = converted + table[text[i]];
  }
  converted += "98";
  return converted;
}

void fnc() {
  String s = "hello world lets print you";
  int val = 6;
  int cnt = 0;
  String fin_string = "";
  String str = "";

  List<Pair<String, int>> len;
  s += " ";
  for (int i = 0; i < s.length; i++) {
    if (s[i] == ' ') {
      len.add(Pair(str, cnt));
      cnt = 0;
      str = "";
    } else {
      cnt++;
      str += s[i];
    }
  }
  cnt = 0;
  List<String> vec;
  int sp = 0;
  int lines = 0;
  for (int i = 0; i < len.length; i++) {
    if (cnt + len[i].cnt + sp > val) {
      vec = vec.reversed;
      String ss = "";
      while (vec.length > 1) {
        ss += vec.last + " ";
        vec.removeLast();
      }
      ss += vec.last;
      vec.removeLast();
      while (ss.length % val != 0) {
        ss += '_';
      }
      lines++;
      if (lines % 2 == 0) ss = StringUtils.reverse(ss);
      ss += '#';
      fin_string += ss;
      cnt = 0;
      sp = 0;
      vec.clear();
    }
    cnt += len[i].cnt;
    vec.add(len[i].str);
    sp++;
  }
  String ss;
  vec = vec.reversed;
  while (vec.length > 1) {
    ss += vec.last + " ";
    vec.removeLast();
  }
  ss += vec.last;
  vec.removeLast();
  lines++;
  if (lines % 2 == 0) {
    while (ss.length % val != 0) {
      ss += '_';
    }
  }
  if (lines % 2 == 0) ss = StringUtils.reverse(ss);
  print(fin_string += ss);
  // return fin_string += ss;
}
