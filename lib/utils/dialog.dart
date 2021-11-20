import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'comfun.dart';

class DialogWidget extends Dialog {
  const DialogWidget({
    Key? key,
    required this.title,
    required this.content,
    this.contentExtend,
    this.cancelText,
    this.confirmText = '确定',
    this.outTapDismiss = false,
    this.slideMargin = 26,
    this.showBottomDo = true,
    this.dialogBg,
    this.borderRadius = 10,
    this.showTitle = true,
    this.cancelTextColor,
    this.confirmTextColor,
    this.timeDownForConfirm = 0,
    this.cancelFun,
    this.confirmFun,
    this.confirmCloseAfter,
    this.showLoading = false,
  }) : super(key: key);

  final String title;
  final String content;
  final Widget? contentExtend;
  final String? cancelText;
  final String confirmText;
  final bool outTapDismiss;
  final double slideMargin;
  final bool showBottomDo;
  final Color? dialogBg;
  final double borderRadius;
  final bool showTitle;
  final Color? cancelTextColor;
  final Color? confirmTextColor;
  final int timeDownForConfirm; // 确定按钮可点击操作的倒计时，为 0 则不开启
  final ConfirmFun? cancelFun; // 取消回调
  final ConfirmFun? confirmFun; // 确定回调
  final Function? confirmCloseAfter; // 确定回调关闭页面后

  final bool showLoading; // 显示dialog中的loading态

  @override
  Widget build(BuildContext context) {
    Widget _main() {
      return GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: Container(
                  decoration: ShapeDecoration(
                    color: dialogBg ?? const Color(0xffffffff),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(borderRadius),
                      ),
                    ),
                  ),
                  margin: EdgeInsets.all(slideMargin).copyWith(bottom: 160 + MediaQuery.of(context).viewInsets.bottom / 2,),
                  child: Column(
                    children: <Widget>[
                      if (showTitle) Padding(
                        padding: const EdgeInsets.all(18),
                        child: Center(
                          child: Text(title, style: const TextStyle(fontSize: 18, color: Color(0xED2B2B2B), fontWeight: FontWeight.bold)),
                        ),
                      ),
                      if (showTitle) Container(
                        color: dialogBg ?? const Color(0xffffffff),
                        height: 1.0,
                      ),
                      if (content.trim().isNotEmpty) Container(
                        constraints: BoxConstraints(minHeight: contentExtend != null ? 0 : 60),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                          child: IntrinsicHeight(
                            child: Text(content, style: const TextStyle(fontSize: 15, color: Color(0xED424242))),
                          ),
                        ),
                      ),
                      contentExtend ?? Container(),
                      if (showBottomDo) Container(
                        color: dialogBg != null ? dialogBg! : const Color(0xfff6f6f6),
                        height: 1.0,
                      ),
                      if (showBottomDo) _buildBottomButtonGroup(context)
                    ],
                  ),
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
              ),
            ],
          ),
        ),
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          if (outTapDismiss) Navigator.of(context).pop();
        },
      );
    }
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: ComFun.getTextScaleFactor(),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: IgnorePointer(
          ignoring: showLoading,
          child: Opacity(
            opacity: showLoading ? 0 : 1,
            child: _main(),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButtonGroup(BuildContext context) {
    var widgets = <Widget>[];
    if (cancelText != null && cancelText!.isNotEmpty) widgets.add(_buildBottomCancelButton(context));
    if (cancelText != null && cancelText!.isNotEmpty && confirmText.isNotEmpty) widgets.add(_buildBottomOnline());
    if (confirmText.isNotEmpty) widgets.add(_buildBottomPositiveButton(context));

    return Flex(
      direction: Axis.horizontal,
      children: widgets,
    );
  }

  Widget _buildBottomOnline() {
    return Container(
      color: dialogBg != null ? dialogBg! : const Color(0xfff6f6f6),
      height: 36,
      width: 1,
    );
  }

  Widget _buildBottomCancelButton(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: TextButton(
        onPressed: () {
          bool canPop = cancelFun?.call() ?? true;
          if (canPop) Navigator.pop(context);
        },
        child: Text(cancelText ?? '取消', style: TextStyle(fontSize: 15, color: cancelTextColor ?? (cancelFun != null ? const Color(0xFF525252) : const Color(0xFF9A9A9A)), fontWeight: FontWeight.bold)),
        style: ButtonStyle(
          // 设置水波纹颜色
          overlayColor: MaterialStateProperty.all(const Color(0x00CBCBCB)),
        ),
      ),
    );
  }

  Widget _buildBottomPositiveButton(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: TextButton(
        onPressed: () {
          if (timeDownForConfirm <= 0) {
            bool canPop = confirmFun?.call() ?? true;
            if (canPop) {
              Navigator.pop(context);
              confirmCloseAfter?.call();
            }
          }
        },
        child: Text(timeDownForConfirm > 0 ? '$confirmText（${timeDownForConfirm}s）' : confirmText, style: TextStyle(fontSize: 15, color: confirmTextColor ?? const Color(0xFF525252), fontWeight: FontWeight.bold)),
        style: ButtonStyle(
          // 设置水波纹颜色
          overlayColor: MaterialStateProperty.all(const Color(0x00CBCBCB)),
        ),
      ),
    );
  }
}

typedef ConfirmFun = bool Function();
