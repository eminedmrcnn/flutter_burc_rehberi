import 'package:burc_rehberi/burc_liste.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

import 'models/burc.dart';
class BurcDetay extends StatefulWidget {

  int gelenIndex;

  BurcDetay(this.gelenIndex);

  @override
  _BurcDetayState createState() => _BurcDetayState();
}

class _BurcDetayState extends State<BurcDetay> {
  Burc secilenBurc;
  Color  baskinRenk;

  @override
  Widget build(BuildContext context) {

    secilenBurc = BurcListesi.tumBurclar[widget.gelenIndex];
    PaletteGenerator paletteGenerator;

    Future<PaletteGenerator> fPaletGenerator = PaletteGenerator.fromImageProvider(AssetImage("images/"+secilenBurc.burcBuyukResim));

    fPaletGenerator.then((value) {
      paletteGenerator = value;
      debugPrint("seçilen renk: " + paletteGenerator.dominantColor.color.toString());

      setState(() {
        baskinRenk = paletteGenerator.dominantColor.color;
      });

    });

    return Scaffold(
      body: CustomScrollView(
        primary: false,
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            primary: true,
            backgroundColor: baskinRenk != null ? baskinRenk : Colors.pink,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset("images/"+secilenBurc.burcBuyukResim, fit: BoxFit.cover,),
              centerTitle: true,
              title: Text(secilenBurc.burcAdi+" Burcu ve Özellikleri"),
            ),

          ),

          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(8),
              color: Colors.pink.shade50,
              child: SingleChildScrollView(
                  child: Text(secilenBurc.burcDetayi, style: TextStyle(fontSize: 18, color: Colors.black),),
                ),
              ),
            ),
        ],
      ),

    );
  }
}
