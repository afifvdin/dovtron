import 'dart:math';

import 'package:flutter/material.dart';

double _defaultTextHeight = 14;
double _defaultTextPadding = 5;
double _defaultAppBarHeight = 60;
double _defaultMinAppBarHeight = 40;
double _unknownTextValue = 1;

class AppBarSliverHeader extends SliverPersistentHeaderDelegate {
  final String? title;
  final double expandedHeight;
  final double safeAreaPadding;
  final Widget? flexibleImage;
  final double flexibleSize;
  final String flexibleTitle;
  final double flexiblePadding;
  final bool flexToTop;
  final Function? onTap;
  final Widget? rightButton;
  final Widget? leftButton;

  AppBarSliverHeader(
      {this.title,
      this.onTap,
      this.flexibleImage,
      required this.expandedHeight,
      required this.safeAreaPadding,
      this.flexibleTitle = '',
      this.flexToTop = false,
      this.leftButton,
      this.rightButton,
      this.flexibleSize = 30,
      this.flexiblePadding = 4});

  double _textPadding(double shrinkOffset) {
    return _defaultTextPadding * _scaleFactor(shrinkOffset);
  }

  double _widgetPadding(double shrinkOffset) {
    double offset;
    if (title == null) {
      offset = _defaultMinAppBarHeight * _scaleFactor(shrinkOffset);
    } else {
      if (flexToTop) {
        offset = _defaultAppBarHeight * _scaleFactor(shrinkOffset);
      } else {
        offset = (_defaultAppBarHeight - _defaultMinAppBarHeight) *
                _scaleFactor(shrinkOffset) +
            _defaultMinAppBarHeight;
      }
    }
    return offset;
  }

  double _topOffset(double shrinkOffset) {
    double offset;
    if (title == null) {
      offset = safeAreaPadding +
          (_defaultMinAppBarHeight * _scaleFactor(shrinkOffset));
    } else {
      if (flexToTop) {
        offset = safeAreaPadding +
            (_defaultAppBarHeight * _scaleFactor(shrinkOffset));
      } else {
        offset = safeAreaPadding +
            ((_defaultAppBarHeight - _defaultMinAppBarHeight) *
                _scaleFactor(shrinkOffset)) +
            _defaultMinAppBarHeight;
      }
    }

    return offset;
  }

  double _calculateWidgetHeight(double shrinkOffset) {
    double actualTextHeight = _scaleFactor(shrinkOffset) * _defaultTextHeight +
        _textPadding(shrinkOffset) +
        _unknownTextValue;

    final padding = title == null
        ? (2 * flexiblePadding)
        : flexToTop
            ? (2 * flexiblePadding)
            : flexiblePadding;

    final trueMinExtent = minExtent - _topOffset(shrinkOffset);

    final trueMaxExtent = maxExtent - _topOffset(shrinkOffset);

    double minWidgetSize = trueMinExtent - padding;

    double widgetHeight =
        ((trueMaxExtent - actualTextHeight) - shrinkOffset) - padding;

    return widgetHeight >= minWidgetSize ? widgetHeight : minWidgetSize;
  }

  double _scaleFactor(double shrinkOffset) {
    final ratio = (maxExtent - minExtent) / 100;
    double percentageHeight = shrinkOffset / ratio;
    double limitedPercentageHeight =
        percentageHeight >= 100 ? 100 : percentageHeight;
    return 1 - (limitedPercentageHeight / 100);
  }

  Widget _builtContent(BuildContext context, double shrinkOffset) {
    _topOffset(shrinkOffset);
    return SafeArea(
      bottom: false,
      child: Semantics(
        button: true,
        child: Padding(
          padding: title == null
              ? EdgeInsets.symmetric(vertical: flexiblePadding)
              : flexToTop
                  ? EdgeInsets.symmetric(vertical: flexiblePadding)
                  : EdgeInsets.only(bottom: flexiblePadding),
          child: GestureDetector(
            onTap: () {
              onTap;
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                LimitedBox(
                    maxWidth: _calculateWidgetHeight(shrinkOffset),
                    maxHeight: _calculateWidgetHeight(shrinkOffset),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(
                              _calculateWidgetHeight(shrinkOffset))),
                          color: Colors.white),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            _calculateWidgetHeight(shrinkOffset)),
                        child: flexibleImage,
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(top: _textPadding(shrinkOffset)),
                  child: Text(
                    flexibleTitle,
                    textScaleFactor: _scaleFactor(shrinkOffset),
                    style: TextStyle(
                        fontSize: _defaultTextHeight,
                        color: Colors.white
                            .withOpacity(_scaleFactor(shrinkOffset)),
                        height: 1),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final Widget appBar = FlexibleSpaceBar.createSettings(
      minExtent: minExtent,
      maxExtent: maxExtent,
      currentExtent: max(minExtent, maxExtent - shrinkOffset),
      toolbarOpacity: 1,
      child: AppBar(
          actions: <Widget>[rightButton ?? Container()],
          leading: leftButton == null ? Container() : leftButton,
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
          title: title != null
              ? Text(
                  title!,
                  style: TextStyle(
                      color: flexToTop
                          ? Colors.white.withOpacity(_scaleFactor(shrinkOffset))
                          : Colors.white),
                )
              : null,
          flexibleSpace: Padding(
            padding: EdgeInsets.only(top: _widgetPadding(shrinkOffset)),
            child: _builtContent(context, shrinkOffset),
          ),
          centerTitle: true,
          toolbarOpacity: 1,
          bottomOpacity: 1.0),
    );
    return appBar;
  }

  @override
  double get maxExtent => expandedHeight + safeAreaPadding;

  @override
  double get minExtent => title == null
      ? _defaultAppBarHeight + safeAreaPadding
      : flexToTop
          ? _defaultAppBarHeight + safeAreaPadding
          : _defaultAppBarHeight + safeAreaPadding + flexibleSize;

  @override
  bool shouldRebuild(AppBarSliverHeader old) {
    if (old.flexibleImage != flexibleImage) {
      return true;
    }
    return false;
  }
}
