part of navigation;

class DisappearingNavigationRail extends StatelessWidget {
  const DisappearingNavigationRail({
    super.key,
    required this.backgroundColor,
    required this.selectedIndex,
    this.onDestinationSelected,
    required this.railAnimation,
    required this.railFabAnimation,
  });

  final Color backgroundColor;
  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;
  final RailAnimation railAnimation;
  final RailFabAnimation railFabAnimation;

  @override
  Widget build(BuildContext context) {
    // final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return NavRailTransition(
      animation: railAnimation,
      backgroundColor: backgroundColor,
      child: NavigationRail(
          backgroundColor: backgroundColor,
          onDestinationSelected: onDestinationSelected,
          leading: Column(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.menu),
              ),
              const SizedBox(
                height: 8.0,
              ),
              AnimatedFloatingActionButton(
                animation: railFabAnimation,
                onPressed: () {},
                elevation: 0,
                // backgroundColor: colorScheme.tertiaryContainer,
                // foregroundColor: colorScheme.onTertiaryContainer,
                child: const Icon(Icons.add),
              )
            ],
          ),
          groupAlignment: -0.85,
          destinations: destinations
              .map(
                (dest) => NavigationRailDestination(
                    icon: Icon(dest.icon), label: Text(dest.label)),
              )
              .toList(),
          selectedIndex: selectedIndex),
    );
  }
}
