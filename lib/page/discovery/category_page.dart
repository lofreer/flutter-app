import 'package:flutter/material.dart';
import 'package:demo/provider/category_page_model.dart';
import 'package:demo/widget/category_widget_item.dart';
import 'package:demo/widget/loading_container.dart';
import 'package:demo/widget/provider_widget.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<CategoryPageModel>(
      model: CategoryPageModel(),
      onModelInit: (model) {
        model.loadData();
      },
      builder: (context, model, child) {
        return LoadingContainer(
          loading: model.loading,
          error: model.error,
          retry: model.retry,
          child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(color: Color(0xfff2f2f2)),
              child: GridView.builder(
                  itemCount: model.list.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5),
                  itemBuilder: (context, index) {
                    return CategoryWidgetItem(categoryModel: model.list[index]);
                  })),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
