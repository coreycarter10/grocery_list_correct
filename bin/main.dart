/*
 * Create a program that allows the user to add or remove items in a grocery list. The user
 * should also be able to view the list or quit the program. The list should be saved between
 * program executions.
 */

import 'dart:convert';
import 'dart:io';

import 'package:console/console.dart';
import 'package:grocery_list_correct/console_utils.dart';

const dataFile = "grocery_list.json";

List<String> groceryList;

void main() {
  Console.init();

  Console.setTextColor(ConsoleColor.blue.index);
  Console.write("\n************");
  Console.write("\nGROCERY LIST");
  Console.write("\n************\n");

  groceryList = load();

  printList();

  // Print menu of user options
  printMenu();
}

void printList({bool showHighlights = false}) {
  Console.setTextColor(ConsoleColor.blue.index);
  Console.write("\nLIST (Items: ${groceryList.length})\n");

  for (var i = 0; i < groceryList.length; i++) {
    if (showHighlights) {
      printMenuItem(phrase: "${i + 1} - ${groceryList[i]}");
    }
    else {
      Console.setTextColor(ConsoleColor.white.index);
      Console.write(groceryList[i]);
      consoleNewLine();
    }
  }
}

void printMenu() {
  consoleNewLine();

  printMenuItem(phrase: "Add an item to the list");
  printMenuItem(phrase: "Remove an item from the list");
  printMenuItem(phrase: "Show the list");
  printMenuItem(phrase: "Quit");

  final input = promptForString("Selection: ").toLowerCase();

  switch (input) {
    case 'a' : add(); break;
    case 'r' : remove(); break;
    case 's' : printList(); printMenu(); break;
    case 'q' : quit(); break;
    case 'j' : save(); break;
    default:
      printError("What the hell are you talking about? Try again, pal!");
      printMenu();
      break;
  }
}

void add() {
  final input = promptForString("Enter a grocery item: ");

  groceryList.add(input);

  printSuccess("Item added: $input");

  printMenu();
}

void remove() {
  printList(showHighlights: true);

  final input = promptForNumber("Enter the number for the item you wish to remove (<ENTER> = cancel): ");

  if (input != null) {
    final index = input - 1;

    if (index >= 0 && index < groceryList.length) {
      printSuccess("*${groceryList.removeAt(index)}* has been removed from the list.");
    }
    else {
      printError("Invalid item number: $input");
    }
  }

  printMenu();
}

void quit() {
  printMessage("Goodbye! Your grocery list will be saved in the file: $dataFile");

  save();
}

List<String> load() {
  final file = File(dataFile);

  if (file.existsSync()) {
    final String fileContent = file.readAsStringSync();
    final List<dynamic> list = jsonDecode(fileContent);
    final List<String> groceryList = list.cast<String>();
    return groceryList;
  }

  return [];
}

void save() {
  File(dataFile).writeAsStringSync(jsonEncode(groceryList));
}

