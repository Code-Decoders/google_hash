import 'dart:io';

List getLikes(List list) {
  List lst = [];
  list.forEach((element) {
    lst.addAll([...element]);
  });
  return lst;
}

getToppings(File file) async {
  String rawData = await file.readAsStringSync();

  List<String> data = rawData.split('\n');
  // print(data.toString());

  Map<int, List> customers = {};

  List demoLikes = [];
  List likes = [];
  List demoDislikes = [];
  List dislikes = [];

  for (var i = 0; i < int.parse(data[0]) * 2; i++) {
    customers[i + 1] = data[i + 1].split(' ');
  }

  for (var i = 1; i <= customers.length; i++) {
    if (i.isEven) {
      customers[i] != null ? demoDislikes.add(customers[i]!.toList()) : null;
    }
  }
  for (var i = 1; i < customers.length; i++) {
    if (i.isOdd) {
      demoLikes.add(customers[i]!.toList());
    }
  }

  demoLikes.forEach((e) {
    e.removeAt(0);
  });

  demoDislikes.forEach((e) {
    e.removeAt(0);
  });

  demoDislikes.forEach((e) {
    dislikes.addAll([...e]);
  });

  demoLikes.forEach((element) {
    likes.addAll([...element]);
  });

  likes = likes.toSet().toList();
  dislikes = dislikes.toSet().toList();

  likes.removeWhere((element) {
    return dislikes.contains(element);
  });

  Map<String, dynamic> totalWords = {
    'likes': getLikes(demoLikes),
    'dislikes': getLikes(demoDislikes),
  };
  Map counts = {};
  totalWords['likes'].forEach((e) => counts[e] = (counts[e] ?? 0) + 1);
  totalWords['dislikes'].forEach((e) => counts[e] = (counts[e] ?? 0) - 1);
  List<String> output = [];
  counts.forEach((key, value) {
    if (value >= 0) output.add(key);
  });
  print(output.length);

  var length = likes.length;

  await File('elaborate_output.txt')
      .writeAsString("${output.length} ${output.join(" ")}");
}

main() async {
  File file = await new File('./e_elaborate.in.txt');
  getToppings(file);
}
