part of widgets;

class EmailListView extends StatelessWidget {
  const EmailListView({
    super.key,
    this.selectedIndex,
    this.onSelected,
    required this.currentUser,
  });

  final int? selectedIndex;
  final ValueChanged<int>? onSelected;
  final User currentUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        children: [
          const SizedBox(
            height: 8,
          ),

          // Search bar

          const SizedBox(
            height: 8,
          ),
          ...List.generate(data.emails.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),

              // Email widget as child
              child: ListView(
                children: [
                  const SizedBox(
                    height: 8.0,
                  ),
                  // todo: display search bar here
                  const SizedBox(
                    height: 8.0,
                  ),
                  ...List.generate(data.emails.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: EmailWidget(
                        emial: data.emails[index],
                        onSelected: onSelected != null
                            ? () {
                                onSelected!(index);
                              }
                            : null,
                        isSelected: selectedIndex == index,
                      ),
                    );
                  })
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}
