
void loadDataFiles() {

  databaseFiles = listFileNames(dataPath(databaseFilesLocation));

  if (databaseFiles == null) {
    println("Folder " + databaseFilesLocation + " does not exist or cannot be accessed.");
  } 
  else {
    println("Successfully loaded files.");
  }

  grammar = new RiGrammar(this, templateFile);

  for (int i=0; i<databaseFiles.length; i++) {
    String[] rows = loadStrings(databaseFilesLocation + "/" + databaseFiles[i]);
    String definitionName = databaseFiles[i].substring(0, databaseFiles[i].lastIndexOf('.'));
    grammar.setDefinition(definitionName, join(rows, " | "));
    //println(databaseFiles[i] + ": " + join(rows, " | "));
  }
}


void saveDataFile() {

  String[] output = {
  };

  Map m = grammar.getDefinitions();
  Iterator iterator = m.entrySet().iterator();
  while (iterator.hasNext ()) {
    Map.Entry mapEntry = (Map.Entry) iterator.next();
    output = append(output, "{\n" + mapEntry.getKey() + "\n" + mapEntry.getValue() + "\n}");
  }

  saveStrings(dataFile, output);
}

String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  }
  else {
    // If it’s not a directory
    return null;
  }
}

