List<String> generateQuery(String text) {
  List<String> newListData = [text];
  List<String> listPossibleName = [];


  listPossibleName = listPossibleName + text.split(" ");
  for (int i = 0; i < listPossibleName.length; i++) {
    List<String> newListString = [];
    listPossibleName.asMap().forEach(
          (int index, String element) {
        if (i <= index) newListString.add("$element ");
      },
    );
    List<String> listData =  generateString(newListString.join().split(""), []);
    newListData = newListData + listData;
  }
  return newListData;
}

List<String> generateString(List<String> listElementExist, List<String> listNewElement,) {
    if(listElementExist.isEmpty){
      return listNewElement;
    }

    String text = listNewElement.isNotEmpty ? listNewElement[listNewElement.length -1] : '';
    String item = listElementExist[0];
    String newItem = "$text$item";
    listElementExist.removeAt(0);
    listNewElement.add(newItem);
    return generateString(listElementExist, listNewElement);
}