import 'package:flutter/material.dart';
import 'package:fusion_app/themes/light_theme.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Column(
          children: [
            Center(
                child: Container(
                  margin: EdgeInsets.only(
                      top: 40,
                      left: 20,
                      right: 20
                  ),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: lightMode.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  width: double.infinity*2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Мой QR',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                              color: lightMode.colorScheme.background,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          width: constraints.maxWidth/1.4,
                          child: QrImageView(
                            dataModuleStyle: QrDataModuleStyle(
                                dataModuleShape: QrDataModuleShape.square,
                                color: lightMode.colorScheme.secondary
                            ),
                            eyeStyle: QrEyeStyle(
                                eyeShape: QrEyeShape.square,
                                color: lightMode.colorScheme.secondary
                            ),
                            data: '+79216108710',
                          )
                      ),
                    ],
                  ),
                )
            ),
          ],
        );
      }
    );
  }

}