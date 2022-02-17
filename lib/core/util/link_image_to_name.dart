String linkImageToName(String path){
  List<String> listElement = path.split("/");
  path = listElement[listElement.length -1];
  path = path.split("?")[0];
  path = path.replaceAll("%2F", "/");
  return path;
}