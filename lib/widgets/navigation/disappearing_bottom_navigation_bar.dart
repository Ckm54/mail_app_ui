part of navigation;

class DisappearingBottomNavigationBar extends StatelessWidget {
  const DisappearingBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    this.onDestinationSelected,
    required this.barAnimation,
  });

  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;
  final BarAnimation barAnimation;

  @override
  Widget build(BuildContext context) {
    return BottomBarTransition(
      animation: barAnimation,
      backgroundColor: Colors.white,
      child: NavigationBar(
        elevation: 0,
        backgroundColor: Colors.white,
        destinations: destinations
            .map((dest) =>
                NavigationDestination(icon: Icon(dest.icon), label: dest.label))
            .toList(),
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
      ),
    );
  }
}
