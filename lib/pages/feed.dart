part of pages;

class Feed extends StatefulWidget {
  const Feed({
    super.key,
    required this.currentUser,
  });

  final User currentUser;

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  late final ColorScheme _colorScheme = Theme.of(context).colorScheme;
  late final Color _backgroundColor = Color.alphaBlend(
      _colorScheme.primary.withOpacity(0.14), _colorScheme.surface);

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: _backgroundColor,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: EmailListView(
            currentUser: widget.currentUser,
            selectedIndex: selectedIndex,
            onSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: _colorScheme.tertiaryContainer,
        foregroundColor: _colorScheme.onTertiaryContainer,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        elevation: 0,
        backgroundColor: Colors.white,
        destinations: destinations.map<NavigationDestination>((dest) {
          return NavigationDestination(
            icon: Icon(dest.icon),
            label: dest.label,
          );
        }).toList(),
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
