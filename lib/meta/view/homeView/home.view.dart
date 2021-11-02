import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:textscanner/core/notifier/homeNotifier/home.notifer.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightBlue,
          onPressed: () {
            Provider.of<HomeNotifer>(context, listen: false)
                .getImageFromText(context: context);
          },
          child: const Icon(
            Icons.done,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black54,
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              RichText(
                text: const TextSpan(
                  text: "Text",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: ' It',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: ' Out !!',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 100,
                child: Image.asset('assets/images/logo.png'),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.lightBlue),
                    ),
                    child: const Text(
                      'Gallery',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    onPressed: () {
                      Provider.of<HomeNotifer>(context, listen: false)
                          .pickUserImage(
                              context: context, source: ImageSource.gallery);
                    },
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.lightBlue),
                    ),
                    child: const Text(
                      'Camera',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    onPressed: () {
                      Provider.of<HomeNotifer>(context, listen: false)
                          .pickUserImage(
                              context: context, source: ImageSource.camera);
                    },
                  )
                ],
              ),
              Provider.of<HomeNotifer>(context, listen: true).getLoading == true
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: Image.file(
                                Provider.of<HomeNotifer>(context, listen: false)
                                    .getUserImage!),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            Provider.of<HomeNotifer>(context, listen: true)
                                .finalText!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20.0,
                              color: Colors.white60,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.lightBlue),
                            ),
                            child: const Text(
                              'Copy It !!',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            onPressed: () async {
                              Provider.of<HomeNotifer>(context, listen: false)
                                  .copyTextToClipBoard(context: context);
                            },
                          )
                        ],
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
