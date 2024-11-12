import 'package:flu_editor/flu_editor.dart';
import 'package:flutter/material.dart';

class SaveTipPopWidget extends StatelessWidget {
  Function(bool saveEffect, String name) onSave;
  Function() onCancel;

  final TextureSource textureSource;
  final ShaderConfiguration configuration;

  SaveTipPopWidget(
      {super.key,
      required this.textureSource,
      required this.configuration,
      required this.onSave,
      required this.onCancel});

  final TextEditingController _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var textureWhRatio = (textureSource.width / textureSource.height);

    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width - 30,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.only(right: 5, top: 5),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Image.asset(
                      'icon_close@3x'.imagePng,
                      width: 18,
                    )),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                '应用调色效果前是否要保存配方下次一键调用？',
                style: TextStyle(
                    color: Color(0xff19191A),
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 33, bottom: 47),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        width: 96,
                        height: 96 / textureWhRatio,
                        child: ImageShaderPreview(
                          texture: textureSource,
                          configuration: configuration,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '配方名称：',
                        style: TextStyle(
                            color: Color(0xff656566),
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      Container(
                        width: 174,
                        height: 44,
                        padding:
                            EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                        margin: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: const Color(0xffF5F5F6),
                            border: Border.all(
                                color: const Color(0xff1E1925), width: 1)),
                        child: TextField(
                          controller: _mobileController,
                          cursorColor: const Color(0xff19191A),
                          style: const TextStyle(
                              color: Color(0xff19191A),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                          decoration: const InputDecoration(
                              hintText: '配方名称',
                              hintStyle: TextStyle(
                                  color: Color(0xffAEAEAE),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                              border: InputBorder.none,
                              counterText: ''),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 29),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(Colors.transparent),
                        padding: WidgetStateProperty.all(
                            const EdgeInsets.symmetric(
                                vertical: 9, horizontal: 30)),
                        side: WidgetStateProperty.all(
                          const BorderSide(
                              color: Color(0xff979797), width: 1), // 设置边框颜色和宽度
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        onSave.call(false, _mobileController.text);
                      },
                      child: const Text(
                        '不保存配方',
                        style: TextStyle(
                            color: Color(0xff19191A),
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  FilledButton(
                      onPressed: () async {
                        if (_mobileController.text.isEmpty) {
                          EditorUtil.toastActionCallback?.call('请输入配方名称');
                          return;
                        }

                        Navigator.pop(context);
                        onSave.call(true, _mobileController.text);
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(const Color(0xffFF799E)),
                          padding: WidgetStateProperty.all(
                              const EdgeInsets.symmetric(
                                  vertical: 9, horizontal: 30))),
                      child: const Text(
                        '保存配方',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
