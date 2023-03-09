import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:yb_flutter_quill/yb_flutter_quill.dart' hide Text;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late QuillController? _controller;
  final FocusNode _focusNode = FocusNode();
  late BuildContext _context;

  @override
  void initState() {
    super.initState();
    _controller = QuillController(
        document: Document(),
        selection: const TextSelection.collapsed(offset: 0));
  }

  /// 富文本
  Widget quillBuild() {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (event) {
        if (event.data.isControlPressed && event.character == 'b') {
          if (_controller!
              .getSelectionStyle()
              .attributes
              .keys
              .contains('bold')) {
            _controller!.formatSelection(Attribute.clone(Attribute.bold, null));
          } else {
            _controller!.formatSelection(Attribute.bold);
          }
        }
      },
      child: _buildWelcomeEditor(_context),
    );
  }

  Widget _buildWelcomeEditor(BuildContext context) {
    var quillEditor = QuillEditor(
      controller: _controller!,
      scrollController: ScrollController(),
      scrollable: true,
      focusNode: _focusNode,
      autoFocus: false,
      readOnly: false,
      placeholder: '请输入',
      expands: false,
      padding: EdgeInsets.zero,
      customStyles: DefaultStyles(
        placeHolder: DefaultTextBlockStyle(
            const TextStyle(
              fontSize: 14,
              color: Color(0x33999999),
            ),
            const Tuple2(16, 0),
            const Tuple2(0, 0),
            null),
        h1: DefaultTextBlockStyle(
            const TextStyle(
              fontSize: 14,
              color: Color(0x33333333),
            ),
            const Tuple2(16, 0),
            const Tuple2(0, 0),
            null),
        sizeSmall: const TextStyle(fontSize: 9),
      ),
    );

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: quillEditor,
            ),
          ),
          Container(child: SizedBox())
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: _buildWelcomeEditor(context));
  }
}
