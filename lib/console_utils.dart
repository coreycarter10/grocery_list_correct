import 'package:console/console.dart' show Console, Prompter;
import 'package:meta/meta.dart' show required;

enum ConsoleColor {
  black,
  red,
  green,
  yellow,
  blue,
  magenta,
  cyan,
  white,
}

void highlight(String value, [int colorID = 3]) {
  Console.setTextColor(colorID);
  Console.write(value);
  Console.setTextColor(7);
}

int promptForNumber(String prompt) {
  Console.setTextColor(ConsoleColor.green.index);
  final input = Prompter("\n$prompt").promptSync();
  return int.tryParse(input);
}

void printMenuItem({
  @required String phrase,
  int highlightIndex = 0,
  ConsoleColor highlightColor = ConsoleColor.yellow,
  ConsoleColor defaultColor = ConsoleColor.white
}) {
  assert(phrase != null && phrase.isNotEmpty && highlightIndex < phrase.length && highlightIndex >= 0);

  // pre highlight text
  if (highlightIndex > 0) {
    Console.setTextColor(defaultColor.index);
    Console.write(phrase.substring(0, highlightIndex));
  }

  // highlight letter
  Console.setTextColor(highlightColor.index);
  Console.write(phrase[highlightIndex]);

  // post highlight text
  if (highlightIndex < phrase.length - 1) {
    Console.setTextColor(defaultColor.index);
    Console.write("${phrase.substring(highlightIndex + 1)}");
  }

  consoleNewLine();
}

void consoleNewLine() => Console.write("\n");

void printError(String msg) {
  Console.setTextColor(ConsoleColor.red.index);
  Console.write("\n$msg\n");
}

void printSuccess(String msg) {
  Console.setTextColor(ConsoleColor.yellow.index);
  Console.write("\n$msg\n");
}

String promptForString(String prompt) {
  Console.setTextColor(ConsoleColor.green.index);
  return Prompter("\n$prompt").promptSync();
}

void printMessage(String msg) {
  Console.setTextColor(ConsoleColor.white.index);
  Console.write("\n$msg\n");
}