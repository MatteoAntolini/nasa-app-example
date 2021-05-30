import 'package:flutter/material.dart';

void showNetworkErrorDialog(BuildContext context) {
	   showDialog(
      builder: (BuildContext context) => SimpleDialog(
            title: Text(
              "Errore con la connessione",
            ),
            children: [
              Text(
                "non c'è connessione",
              )
            ],
          ),
      context: context);
}

void showGeneralErrorDialog(BuildContext context) {
	showDialog(
      builder: (BuildContext context) => SimpleDialog(
            title: Text(
              "Errore generale",
            ),
            children: [
              Text(
                "Riprova più tardi. Se l'errore dovesse persistere, contattaci a info@hoongry.com",
              )
            ],
          ),
      context: context);
}
