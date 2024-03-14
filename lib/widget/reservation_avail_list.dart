import 'package:flutter/material.dart';

class ReservationAvailListView extends StatefulWidget {
  final List<String> reservedAvailList;
  final ScrollController? scrollController;
  final int month;
  final int day;

  const ReservationAvailListView(
      {super.key,
      required this.reservedAvailList,
      required this.month,
      required this.day,
      required this.scrollController});

  @override
  State<ReservationAvailListView> createState() =>
      _ReservationAvailListViewState();
}

class _ReservationAvailListViewState extends State<ReservationAvailListView>
    with TickerProviderStateMixin {
  // late ScrollController _scrollControllerForTime;
  late ScrollController _scrollController;
  bool isTop = true;
  //
  // @override
  // initState() {
  //   super.initState();
  //   widget.scrollController.addListener(() {
  //     if (mounted) {
  //
  //     }
  //       setState(() {
  //         if (widget.scrollController.offset > 0) {
  //           isTop = false;
  //         } else {
  //           isTop = true;
  //         }
  //       });
  //     });
  // }
  //
  // @override
  // void dispose() {
  //   widget.scrollController.dispose();
  //   print('fd');
  //   super.dispose();
  // }

  @override
  void initState() {
    super.initState();
    // scrollController가 null이 아니면 widget의 scrollController를 사용하고, null이면 새로운 ScrollController를 생성
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(() {
      setState(() {
        if (_scrollController.offset > 0) {
          isTop = false;
        } else {
          isTop = true;
        }
      });
    });
  }

  @override
  void dispose() {
    // widget의 scrollController가 null이면 생성한 ScrollController를 dispose
    if (widget.scrollController == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  void scrollToEnd(ScrollController scrollController) {
    if (scrollController.hasClients) {
      final double maxScrollExtent = scrollController.position.maxScrollExtent;
      scrollController.animateTo(maxScrollExtent,
          duration: const Duration(milliseconds: 100), curve: Curves.linear);
    }
  }

  void scrollToStart(ScrollController scrollController) {
    scrollController.animateTo(0,
        duration: const Duration(milliseconds: 100), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
                  "${widget.month}월 ${widget.day}일",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: widget.scrollController,
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
                isTop
                    ? scrollToEnd(widget.scrollController!)
                    : scrollToStart(widget.scrollController!);
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
