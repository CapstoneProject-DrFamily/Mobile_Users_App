import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class BaseView<T extends Model> extends StatelessWidget {
  final ScopedModelDescendantBuilder<T> _builder;

  BaseView({ScopedModelDescendantBuilder builder}) : _builder = builder;
  @override
  Widget build(BuildContext context) {
    return ScopedModel<T>(
      child: ScopedModelDescendant<T>(
        builder: _builder,
      ),
    );
  }
}
