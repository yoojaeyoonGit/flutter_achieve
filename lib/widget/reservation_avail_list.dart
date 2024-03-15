import 'package:flutter/material.dart';

class ReservationAvailListView extends StatefulWidget {
  final List<String> reservedAvailList;
  final int cursorDateNum;

  const ReservationAvailListView({
    Key? key,
    required this.reservedAvailList,
    required this.cursorDateNum,
  }) : super(key: key);

  @override
  State<ReservationAvailListView> createState() =>
      _ReservationAvailListViewState();
}

class _ReservationAvailListViewState extends State<ReservationAvailListView>
    with TickerProviderStateMixin {
  late final ScrollController _scrollController = ScrollController();
  bool isTop = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    setState(() {
      if (_scrollController.offset > 0) {
        isTop = false;
      } else {
        isTop = true;
      }
    });
  }

  void scrollToEnd() {
    if (_scrollController.hasClients) {
      final double maxScrollExtent = _scrollController.position.maxScrollExtent;
      _scrollController.animateTo(maxScrollExtent,
          duration: const Duration(milliseconds: 100), curve: Curves.linear);
    }
  }

  void scrollToStart() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 100), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    DateTime dateTime = DateTime.now();
    dateTime = DateTime.now().add(Duration(days: widget.cursorDateNum));
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Container(
              height: height * 0.035,
              width: width * 0.23,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black,
              ),
              child: Center(
                child: Text(
                  "${dateTime.month}월 ${dateTime.day}일",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemBuilder: (context, index) {
                String time = widget.reservedAvailList[index];

                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Text(
                      time.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
              itemCount: widget.reservedAvailList.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: IconButton(
              onPressed: () {
                isTop ? scrollToEnd() : scrollToStart();
              },
              icon: isTop
                  ? const Icon(Icons.arrow_drop_down_circle)
                  : const Icon(Icons.arrow_drop_up_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
