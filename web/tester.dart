import "dart:io";
import "dart:json" as JSON;
import 'package:mongo_dart/mongo_dart.dart';

main() {
  /*Options options = new Options();
  print(options.executable);
  print(options.script);
  List<String> args = options.arguments;
  print(args.length);
  print(args);
  */
  /*
  Options options = new Options();
  if (options.arguments.length != 2) {
    printHelp();
  }
  else if (options.arguments[0] == '--list') {
    listDir(options.arguments[1]);
  }
  else if (options.arguments[0] == '--out') {
    outputFile(options.arguments[1]);
  }*/
    
  
  HttpServer server = new HttpServer();
  print(server.toString());
  Map savedBlogPost = {'first'  : 'partridge',
                       'second' : 'turtledoves',
                       'fifth'  : 'golden rings'};
 // JSON.objectToJason(savedBlogPost);
  
  var db = new Db('mongodb://127.0.0.1/test'); 
  /*db.open().then((bool exists){
    if(exists){
      var _posts = db.collection("posts");
      _posts.remove();
      _posts.insert(savedBlogPost);
    };
  }    
  );*/
  print(db.databaseName);
  
  /*server.addRequestHandler(
  (HttpRequest req) => req.path.startsWith("/echo/"),
    (HttpRequest req,HttpResponse res) {
      var method = req.method;
      var path = req.path;
      res.outputStream.writeString("Echo: $method $path");
      res.outputStream.close();
    }
  );
  server.defaultRequestHandler = (HttpRequest req, HttpResponse res) {
    res.outputStream.writeString("Hello World");
    res.outputStream.close();
  };*/
  var staticFiles = new StaticFileHandler();
  var folderList = new FolderListHandler();
  var fileContent = new FileContentHandler();
  
  server.addRequestHandler(staticFiles.matcher, staticFiles.handler);
  server.addRequestHandler(folderList.matcher, folderList.handler);
  server.addRequestHandler(fileContent.matcher, fileContent.handler);
  
  server.listen("127.0.0.1", 8080);
  print("Listening...");
}

printHelp() {
  print("""
      Dart Directory Lister. Usage:
      List files and directories: --list DIR
  Output file to console : --out FILE""");
}
listDir(String folderPath) {
  
  var directory = new Directory(folderPath);
  
  directory.exists().then((bool exists) {
    if (exists) {
      DirectoryLister lister = directory.list();
      
      lister.onFile = (String filePath) {
        print("<FILE>  $filePath");
      };
      lister.onDir = (String dirPath) {
        print("<DIR>  $dirPath");
      };
      lister.onDone = (bool isCompleted) {
        print("Finished");
      };
    }
  });
}
outputFile(String filePath) {
  File file = new File(filePath);
  file.exists().then((exists){
    if(exists){
      InputStream inputStream = file.openInputStream();
      StringBuffer sb = new StringBuffer();
      
      inputStream.onData = (){
        List<int> data = inputStream.read();
        if(data != null){
          sb.add(new String.fromCharCodes(data));
        }
      };
      
      inputStream.onClosed = (){
        print(sb.toString());
      };
    }
  });
  /*file.readAsString().then((content) {
    print(content);
  });*/
}


class StaticFileHandler {
  bool matcher(HttpRequest req){
    return req.path.endsWith(".html")||req.path.endsWith(".dart")||req.path.endsWith(".css")||req.path.endsWith(".js");
  }
  
  void handler(HttpRequest req, HttpResponse res){
    var requestedFile = "./clients${req.path}";
    File file = new File(requestedFile);
    file.exists().then((bool exists){
        if(exists){
          file.openInputStream().pipe(res.outputStream);
        }
        else{
          print("The requested file not found.${file.name}");
        }
      }
      
    );
    
    
  }
}


class FolderListHandler{
  bool matcher(HttpRequest req){
    return req.path.startsWith("/folderList") && req.method =="GET";
  }
  
  void handler(HttpRequest req, HttpResponse res){
    addHeaders(res);
    var folder = req.path.substring('/folderList'.length);
    DirectoryLister lister = new Directory(folder).list();
    
    List<String> dirList = new List<String>();
    List<String> fileList = new List<String>();
    
    lister.onDir = (dirName){
      dirList.add(dirName);
    };
    lister.onFile = (fileName){
      if(fileName.endsWith(".dart")){
        fileList.add(fileName);
      }
    };
    
    lister.onDone = (done){
      var resultMap = new Map<String,List>();
      resultMap["files"] = fileList;
      resultMap["dirs"] = dirList;
      var jsonString = JSON.stringify(resultMap);
      res.outputStream.writeString(jsonString);
      res.outputStream.close();
    };
  }
  
  addHeaders(HttpResponse res){
    res.headers.add("Access-Control-Allow-Origin","http://localhost/*" );
    res.headers.add("Access-Control-Allow-Credentials", true);
  }
}

class FileContentHandler{
  bool matcher(HttpRequest req){
    return req.path.startsWith("/fileContent") && req.method =="GET";
  }
  
  void handler(HttpRequest req, HttpResponse res){
    addHeaders(res);
    var fileName = req.path.substring('/fileContent'.length);
    File file = new File(fileName);
    file.exists().then((bool exists){
      if(exists){
        file.readAsString().then((String fileContent) {      
          var result = new Map<String,String>();
          result["content"] = fileContent;
          res.outputStream.writeString(JSON.stringify(result));
          res.outputStream.close();
        });
      }
      else{
          res.outputStream.writeString("Requested File Not Found");
          res.outputStream.close();
      }
    });
  }
  
  addHeaders(HttpResponse res){
    res.headers.add("Access-Control-Allow-Origin","http://localhost/*" );
    res.headers.add("Access-Control-Allow-Credentials", true);
  }
}

