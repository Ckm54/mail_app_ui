part of widgets;

class EmailContent extends StatefulWidget {
  const EmailContent({
    super.key,
    required this.email,
    required this.isPreview,
    required this.isThreaded,
    required this.isSelected,
  });

  final Email email;
  final bool isPreview;
  final bool isThreaded;
  final bool isSelected;

  @override
  State<EmailContent> createState() => _EmailContentState();
}

class _EmailContentState extends State<EmailContent> {
  late final ColorScheme _colorScheme = Theme.of(context).colorScheme;
  late final TextTheme _textTheme = Theme.of(context).textTheme;

  Widget get contentSpacer => SizedBox(
        height: widget.isThreaded ? 20 : 2,
      );

  // Gets label to indicate when a user was last active
  String get lastActiveLabel {
    final DateTime now = DateTime.now();
    if (widget.email.sender.lastActive.isAfter(now)) throw ArgumentError();
    final Duration elapsedTime =
        widget.email.sender.lastActive.difference(now).abs();
    if (elapsedTime.inSeconds < 60) return '${elapsedTime.inSeconds}s';
    if (elapsedTime.inMinutes < 60) return '${elapsedTime.inMinutes}m';
    if (elapsedTime.inHours < 60) return '${elapsedTime.inHours}h';
    if (elapsedTime.inDays < 365) return '${elapsedTime.inDays}d';
    throw UnimplementedError();
  }

  // Get style to apply to text
  TextStyle? get contentTextStyle {
    if (widget.isThreaded) {
      return _textTheme.bodyLarge;
    }
    if (widget.isSelected) {
      return _textTheme.bodyMedium
          ?.copyWith(color: _colorScheme.onPrimaryContainer);
    }

    return _textTheme.bodyMedium
        ?.copyWith(color: _colorScheme.onSurfaceVariant);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(builder: (context, constraints) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (constraints.maxWidth - 200 > 0) ...[
                  CircleAvatar(
                    backgroundImage: AssetImage(widget.email.sender.avatarUrl),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.0),
                  ),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.email.sender.name.fullName,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        style: widget.isSelected
                            ? _textTheme.labelMedium?.copyWith(
                                color: _colorScheme.onSecondaryContainer,
                              )
                            : _textTheme.labelMedium
                                ?.copyWith(color: _colorScheme.onSurface),
                      ),
                      Text(
                        lastActiveLabel,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        style: widget.isSelected
                            ? _textTheme.labelMedium?.copyWith(
                                color: _colorScheme.onSecondaryContainer,
                              )
                            : _textTheme.labelMedium?.copyWith(
                                color: _colorScheme.onSurfaceVariant,
                              ),
                      ),
                    ],
                  ),
                ),
                if (constraints.maxWidth - 200 > 0) ...[
                  ///// todo: Add star button here
                  const StarButton(),
                ],
              ],
            );
          }),
          const SizedBox(
            width: 8.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.isPreview) ...[
                Text(
                  widget.email.subject,
                  style: const TextStyle(fontSize: 18)
                      .copyWith(color: _colorScheme.onSurface),
                )
              ],
              if (widget.isThreaded) ...[
                contentSpacer,
                Text(
                  "To ${widget.email.recipients.map((recepient) => recepient.name.first).join(", ")}",
                  style: _textTheme.bodyMedium,
                )
              ],
              contentSpacer,
              Text(
                widget.email.content,
                maxLines: widget.isPreview ? 2 : 100,
                overflow: TextOverflow.ellipsis,
                style: contentTextStyle,
              ),
            ],
          ),
          const SizedBox(
            width: 12,
          ),
          widget.email.attachments.isNotEmpty
              ? Container(
                  height: 96,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage(widget.email.attachments.first.url),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          if (!widget.isPreview) ...[
            /////// todo: Display email reply options here
            const EmailReplyOptions(),
          ]
        ],
      ),
    );
  }
}
