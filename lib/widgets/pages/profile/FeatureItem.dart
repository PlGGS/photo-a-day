import 'package:flutter/material.dart';
import 'package:photoaday/services/models.dart';
import 'package:photoaday/widgets/shared/CircleImage.dart';

class FeatureItem extends StatelessWidget {
  final double height;
  final Feature feature;

  const FeatureItem({
    Key? key,
    this.height = 100,
    required this.feature,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: feature.imageUri,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 20,
        shadowColor: Colors.transparent,
        color: Theme.of(context).backgroundColor,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    FeaturePage(feature: feature),
              ),
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Flexible(
                flex: 3,
                child: Container(
                  width: 100,
                  height: 150,
                  child: CircleImage(
                    radius: 45,
                    borderRatio: 0.93,
                    borderColor: Theme.of(context).buttonColor,
                    imagePath: feature.imageUri,
                    onPressed: () {},
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    feature.title,
                    style: const TextStyle(
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeaturePage extends StatelessWidget {
  final Feature feature;

  const FeaturePage({super.key, required this.feature});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          Hero(
            tag: feature.imageUri,
            child: Image.network(feature.imageUri,
                width: MediaQuery.of(context).size.width),
          ),
          Text(
            feature.title,
            style: const TextStyle(
                height: 2, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
