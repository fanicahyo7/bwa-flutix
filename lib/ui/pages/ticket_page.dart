part of 'pages.dart';

class TicketPage extends StatefulWidget {
  final bool isExpiredTicket;

  TicketPage({this.isExpiredTicket = false});
  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  bool isExpiredTickets;

  void initState() {
    super.initState();

    isExpiredTickets = widget.isExpiredTicket;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //content
          BlocBuilder<TicketBloc, TicketState>(
            builder: (_, ticketState) => Container(
                margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: TicketViewer(
                  isExpiredTickets
                      ? ticketState.tickets
                          .where(
                              (ticket) => ticket.time.isBefore(DateTime.now()))
                          .toList()
                      : ticketState.tickets
                          .where(
                              (ticket) => !ticket.time.isBefore(DateTime.now()))
                          .toList(),
                )),
          ),
          //note: header
          Container(
            height: 113,
            color: accentColor1,
          ),
          ClipPath(
            clipper: HeaderClipper(),
            child: SafeArea(
                child: Container(
              height: 113,
              color: accentColor1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(left: defaultMargin, bottom: 32),
                      child: Text(
                        "My Tickets",
                        style: whiteTextFont.copyWith(fontSize: 20),
                      )),
                  Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isExpiredTickets = !isExpiredTickets;
                              });
                            },
                            child: Text("Newest",
                                style: whiteTextFont.copyWith(
                                    fontSize: 16,
                                    color: !isExpiredTickets
                                        ? Colors.white
                                        : Color(0xFF6F678E))),
                          ),
                          SizedBox(height: 16),
                          Container(
                            height: 4,
                            width: MediaQuery.of(context).size.width * 0.5,
                            color: !isExpiredTickets
                                ? accentColor2
                                : Colors.transparent,
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isExpiredTickets = !isExpiredTickets;
                              });
                            },
                            child: Text("Oldest",
                                style: whiteTextFont.copyWith(
                                    fontSize: 16,
                                    color: isExpiredTickets
                                        ? Colors.white
                                        : Color(0xFF6F678E))),
                          ),
                          SizedBox(height: 16),
                          Container(
                            height: 4,
                            width: MediaQuery.of(context).size.width * 0.5,
                            color: isExpiredTickets
                                ? accentColor2
                                : Colors.transparent,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )),
          ),
        ],
      ),
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(0, size.height, 20, size.height);
    path.lineTo(size.width - 20, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - 20);
    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TicketViewer extends StatelessWidget {
  final List<Ticket> ticket;

  TicketViewer(this.ticket);
  @override
  Widget build(BuildContext context) {
    var sortedTickets = ticket;
    sortedTickets
        .sort((ticket1, ticket2) => ticket1.time.compareTo(ticket2.time));

    return ListView.builder(
        itemCount: sortedTickets.length,
        itemBuilder: (_, index) => GestureDetector(
              onTap: () {
                context
                    .bloc<PageBloc>()
                    .add(GoToTicketDetailPage(sortedTickets[index]));

                return;
              },
              child: Container(
                margin: EdgeInsets.only(top: index == 0 ? 133 : 20),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 90,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: NetworkImage(imageBaseURL +
                                  'w500' +
                                  sortedTickets[index].movieDetail.posterPath),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          2 * defaultMargin -
                          70 -
                          16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            sortedTickets[index].movieDetail.title,
                            style: blackTextFont.copyWith(fontSize: 18),
                            maxLines: 2,
                            overflow: TextOverflow.clip,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            sortedTickets[index].movieDetail.genreAndLanguage,
                            style: greyTextFont.copyWith(
                                fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            sortedTickets[index].theater.name.toString(),
                            style: greyTextFont.copyWith(
                                fontWeight: FontWeight.w400, fontSize: 12),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
