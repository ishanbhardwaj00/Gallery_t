import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_t/image_page.dart';
import 'package:image_picker/image_picker.dart';

class AlbumPage extends StatefulWidget {
  @override
  _AlbumPageState createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {

  List<File> imageList= [];
  File imageFile;
  dynamic picker= ImagePicker();
  fromGallery () async {
    var image= await picker.getImage(source: ImageSource.gallery);
    setState(() {
      imageFile=File(image.path);
      imageList.add(imageFile);
    });
  }
  fromCamera () async {
    var image= await picker.getImage(source: ImageSource.camera);
    setState(() {
      imageFile=File(image.path);
      imageList.add(imageFile);
    });
  }
  int currentIndex=0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(
            onPressed: fromGallery,
            icon: Icon(Icons.add, color: Color(0xff3D83F6),),
          ),
          IconButton(
            icon: Icon(Icons.camera_enhance),
            color: Colors.blue,
            iconSize: 22,
            onPressed: fromCamera,
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text("Photos", style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold, letterSpacing: 1.2),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(width: MediaQuery.of(context).size.width*0.95, height: 1, color: Color(0xff343437),),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("My Photos", style: TextStyle(fontSize: 24, color: Colors.white,fontWeight: FontWeight.w600),),
                Text("See all", style: TextStyle(color: Color(0xff3D83F6), fontSize: 20),),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 7,
                crossAxisSpacing: 7,
              ), itemCount: imageList.length,
                  itemBuilder: (BuildContext context, int index ) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xff343437),
                  ),

                  child: GestureDetector(
                    onTap: ()=> Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) {
                        return ImagePage(image1:imageList[index]);
                      }
                    )),
                      child: Hero(
                          tag: '${imageList[index].path}',
                          child: ClipRRect(
                          borderRadius: BorderRadius.circular(5)    ,
                          child: Image.file(
                          imageList[index], fit: BoxFit.cover,
                          width: 25,
                          height: 25,)))),
                );
                  },),
            )
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.transparent,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex=index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_library),
            title: Text("Photos"),
          )
          ,BottomNavigationBarItem(
            icon: Icon(Icons.photo_album),
            title: Text("Albums"),
          ),BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text("Search"),
          ),
        ],
      ) ,
    );
  }
}
