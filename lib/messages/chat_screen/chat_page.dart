import 'package:collarchek/messages/chat_screen/chat_controllers.dart';
import 'package:collarchek/utills/app_colors.dart';
import 'package:collarchek/utills/app_strings.dart';
import 'package:collarchek/utills/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../utills/common_widget/common_appbar.dart';
import '../../utills/common_widget/progress.dart';
import '../../utills/image_path.dart';
import '../pdf_viewer/pdf_viwer_page.dart';
import '../video_player/video_player.dart';

class ChatPage extends GetView<ChatControllers>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appPrimaryBackgroundColor,
      body: PopScope(
        canPop: false, // Prevents default back behavior
        onPopInvoked: (didPop) {
          if (!didPop) {
            onWillPop();
          }
        },
        child: SafeArea(
          child: Column(
            children: <Widget>[
              commonActiveSearchBar(
                  backGroundColor:appPrimaryBackgroundColor ,
                  onClick: (){
                    controller.backButtonClick(context);
                  },
                  leadingIcon: appBackSvgIcon,
                  screenName: controller.appBarName.value??"",
                  onShareClick: (){},
                  onFilterClick: (){},
                  actionButton: '',
                  isProfileImageShow: true,
                  profileImageData:controller.profileImage.value??"",
                  initialName: getInitialsWithSpace(input: controller.appBarName.value??"")
              ),
              // SizedBox(height: 20,),
              Expanded(
                child: Obx(() {
                  var messageData=controller.messageDatum.value.message??[];
                  messageData = List.from(messageData.reversed); // Reverse the list
                  return Container(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child: ListView.builder(
                      reverse: true, // New messages appear at the bottom
                      padding: EdgeInsets.all(10),
                      itemCount: messageData.length??0,
                      itemBuilder: (context, index) {
                        final message = messageData[index];
                        bool isMe = message.receiver == controller.receiverIdData.value;
                        String? documentUrl = (message.document?.isNotEmpty ?? false) ? message.document!.first : null;
                        return Align(
                          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: isMe?appPrimaryColor:appWhiteColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  messageData[index].message.toString(),
                                  style: AppTextStyles.font14W500.copyWith(color: isMe?appWhiteColor:appBlackColor),
                                ),
                              ),
                              // Display Document (PDF, Image, or Video)
                              if (documentUrl != null) displayDocument(documentUrl),
                              SizedBox(height: 3,),
                              Text(formatTimestampInAmPm(timestamp: messageData[index].datetime.toString()),style: AppTextStyles.font12w500.copyWith(color: appGreyBlackColor),)

                            ],
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          controller: controller.messageController,
                          decoration: InputDecoration(
                            suffixIcon:GestureDetector(
                              onTap: (){
                                getFileFromGallery(context,onFilePickedData: (String data) {
                                  controller.selectedDocumentData.value=data;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: SvgPicture.asset(appUploadDocument,height: 20,width: 20,),
                              ),
                            ),

                            hintText: appTypeAMessage,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        controller.sendMessage(controller.messageController.text);
                        controller.messageController.clear();
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: appPrimaryColor
                        ),
                        child: Padding(
                            padding: EdgeInsets.all(8),
                            child: SvgPicture.asset(appChatSvg,height: 24,width: 24,)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget displayDocument(String url) {
    String fileType = getFileType(url);

    switch (fileType) {
      case 'pdf':
        return GestureDetector(
          onTap: () => Get.to(() => PdfViewerScreen(pdfUrl: url)),
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.picture_as_pdf, color: Colors.red),
                SizedBox(width: 5),
                Text("Open PDF", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        );

      case 'image':
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(url, height: 150, width: 150, fit: BoxFit.cover),
        );

      case 'video':
        return VideoPlayerWidget(videoUrl: url);

      default:
        return Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text("Unsupported file type", style: TextStyle(color: Colors.red)),
        );
    }
  }

  String getFileType(String url) {
    if (url.endsWith('.pdf')) return 'pdf';
    if (url.endsWith('.png') || url.endsWith('.jpg') || url.endsWith('.jpeg')) return 'image';
    if (url.endsWith('.mp4') || url.endsWith('.mov') || url.endsWith('.avi')) return 'video';
    return 'unknown';
  }


}